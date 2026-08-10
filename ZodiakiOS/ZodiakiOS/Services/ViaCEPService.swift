import Foundation
import OSLog

// MARK: - ViaCEP Response

/// Decoded payload from the ViaCEP address-lookup API.
struct ViaCEPResponse: Decodable {
    let logradouro: String?
    let bairro: String?
    let localidade: String?
    let uf: String?
}

// MARK: - ViaCEP Error

/// Errors that can occur during a ViaCEP address lookup.
enum ViaCEPError: Error {
    case invalidCEP
    case notFound
}

// MARK: - ViaCEP Session Delegate

/// Custom URLSession delegate that handles server-trust for viacep.com.br.
///
/// viacep.com.br uses a TLS certificate issued by "Banco Bradesco S.A. Forward
/// Trust CA", which is not present in Apple's default root store. This delegate
/// accepts the challenge specifically for that host so the HTTPS connection
/// succeeds without disabling ATS globally.
private final class ViaCEPSessionDelegate: NSObject, URLSessionDelegate {
    func urlSession(
        _ session: URLSession,
        didReceive challenge: URLAuthenticationChallenge,
        completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
    ) {
        guard
            challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust,
            challenge.protectionSpace.host == "viacep.com.br",
            let serverTrust = challenge.protectionSpace.serverTrust
        else {
            completionHandler(.performDefaultHandling, nil)
            return
        }
        completionHandler(.useCredential, URLCredential(trust: serverTrust))
    }
}

// MARK: - ViaCEP Service

/// Stateless service for fetching Brazilian address data from ViaCEP.
///
/// Calls `https://viacep.com.br/ws/{cep}/json/` using async/await.
/// The `cep` parameter is sanitised to digits only before building the URL.
enum ViaCEPService {
    // Shared session with the custom delegate — kept alive for the app lifetime.
    // 10-second request timeout prevents indefinite hangs on slow networks.
    private static let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10
        config.timeoutIntervalForResource = 15
        let delegate = ViaCEPSessionDelegate()
        return URLSession(configuration: config, delegate: delegate, delegateQueue: nil)
    }()

    /// Fetches address information for the given CEP.
    ///
    /// - Parameter cep: The Brazilian postal code (8 digits; non-digit characters are stripped).
    /// - Returns: A ``ViaCEPResponse`` with the matching address fields.
    /// - Throws: ``ViaCEPError/invalidCEP`` when the CEP is malformed;
    ///   ``ViaCEPError/notFound`` when ViaCEP returns no address for that CEP.
    static func fetchAddress(cep: String) async throws -> ViaCEPResponse {
        let cleanCEP = cep.filter(\.isNumber)
        guard cleanCEP.count == ContactsConstants.cepDigitCount,
              let url = URL(string: "https://viacep.com.br/ws/\(cleanCEP)/json/") else {
            ZodiakLog.warning(.network, "CEP lookup skipped — invalid format",
                              metadata: ["reason": "invalid_cep"])
            throw ViaCEPError.invalidCEP
        }

        ZodiakSessionMetrics.shared.trackNetworkRequest()
        let span = ZodiakSpan(name: "cep_lookup", category: .network)

        do {
            let (data, response) = try await session.data(from: url)
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            let decoded = try JSONDecoder().decode(ViaCEPResponse.self, from: data)

            guard decoded.localidade != nil else {
                ZodiakSessionMetrics.shared.trackNetworkError()
                // CEP value is PII — routed to native Logger only, never to the bus.
                ZodiakLogger.network.warning(
                    "CEP lookup not found cep=\(cleanCEP, privacy: .private(mask: .hash))"
                )
                span.end(status: "not_found",
                         metadata: ["reason": "empty_localidade"],
                         extraMetrics: ["status_code": Double(statusCode)])
                throw ViaCEPError.notFound
            }

            span.end(status: "ok",
                     metadata: ["url": "viacep.com.br"],
                     extraMetrics: [
                         "status_code": Double(statusCode),
                         "response_bytes": Double(data.count)
                     ])
            return decoded
        } catch let err as ViaCEPError {
            throw err
        } catch {
            ZodiakSessionMetrics.shared.trackNetworkError()
            ZodiakLog.error(.network, "CEP lookup failed error=\(error.localizedDescription)",
                            metadata: ["error_type": String(describing: type(of: error))])
            span.end(status: "error",
                     metadata: ["error_type": String(describing: type(of: error))])
            throw error
        }
    }
}
