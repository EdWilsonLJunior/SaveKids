import Foundation

// MARK: - Injectable type aliases (enables testing without URLSession mocking)
typealias LPPromotionsFetcher = () async -> [LPPromotion]
typealias LPRewardsFetcher = () async -> [LPReward]

// MARK: - LPAPIService
enum LPAPIService {
    private static let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = LPConstants.API.requestTimeout
        config.timeoutIntervalForResource = LPConstants.API.resourceTimeout
        return URLSession(configuration: config)
    }()

    private static let decoder: JSONDecoder = {
        let dec = JSONDecoder()
        dec.dateDecodingStrategy = .iso8601
        return dec
    }()

    // MARK: - Promotions

    static func fetchPromotions() async -> [LPPromotion] {
        ZodiakSessionMetrics.shared.trackNetworkRequest()
        let span = ZodiakSpan(name: "fetch_promotions", category: .network)

        do {
            guard let url = URL(string: LPConstants.API.baseURL + LPConstants.API.promotionsPath) else {
                span.end(status: "bundled_fallback", metadata: ["reason": "invalid_url"])
                return loadBundled(name: localizedMockName("promotions_mock"), as: [LPPromotion].self)
            }
            let (data, response) = try await session.data(from: url)
            guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
                let code = (response as? HTTPURLResponse)?.statusCode ?? 0
                span.end(status: "bundled_fallback",
                         metadata: ["reason": "non_2xx"],
                         extraMetrics: ["status_code": Double(code)])
                return loadBundled(name: localizedMockName("promotions_mock"), as: [LPPromotion].self)
            }
            let promotions = try decoder.decode([LPPromotion].self, from: data)
            span.end(status: "ok",
                     extraMetrics: [
                         "status_code": Double(http.statusCode),
                         "response_bytes": Double(data.count),
                         "items_count": Double(promotions.count)
                     ])
            return promotions
        } catch {
            ZodiakSessionMetrics.shared.trackNetworkError()
            ZodiakLog.error(.network, "fetch_promotions failed error_code=\((error as NSError).code)",
                            metadata: [
                                "feature": "LoyaltyProgram",
                                "exception.type": String(describing: type(of: error))
                            ])
            span.end(status: "error",
                     metadata: ["feature": "LoyaltyProgram", "exception.type": String(describing: type(of: error))])
            return loadBundled(name: localizedMockName("promotions_mock"), as: [LPPromotion].self)
        }
    }

    // MARK: - Rewards

    static func fetchRewards() async -> [LPReward] {
        ZodiakSessionMetrics.shared.trackNetworkRequest()
        let span = ZodiakSpan(name: "fetch_rewards", category: .network)

        do {
            guard let url = URL(string: LPConstants.API.baseURL + LPConstants.API.rewardsPath) else {
                span.end(status: "bundled_fallback", metadata: ["reason": "invalid_url"])
                return loadBundled(name: localizedMockName("rewards_mock"), as: [LPReward].self)
            }
            let (data, response) = try await session.data(from: url)
            guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
                let code = (response as? HTTPURLResponse)?.statusCode ?? 0
                span.end(status: "bundled_fallback",
                         metadata: ["reason": "non_2xx"],
                         extraMetrics: ["status_code": Double(code)])
                return loadBundled(name: localizedMockName("rewards_mock"), as: [LPReward].self)
            }
            let rewards = try decoder.decode([LPReward].self, from: data)
            span.end(status: "ok",
                     extraMetrics: [
                         "status_code": Double(http.statusCode),
                         "response_bytes": Double(data.count),
                         "items_count": Double(rewards.count)
                     ])
            return rewards
        } catch {
            ZodiakSessionMetrics.shared.trackNetworkError()
            ZodiakLog.error(.network, "fetch_rewards failed error_code=\((error as NSError).code)",
                            metadata: [
                                "feature": "LoyaltyProgram",
                                "exception.type": String(describing: type(of: error))
                            ])
            span.end(status: "error",
                     metadata: ["feature": "LoyaltyProgram", "exception.type": String(describing: type(of: error))])
            return loadBundled(name: localizedMockName("rewards_mock"), as: [LPReward].self)
        }
    }

    static func fetchReward(id: String?) async -> LPReward? {
        guard let id else { return nil }
        return await fetchRewards().first { $0.id == id }
    }

    // MARK: - Bundle fallback

    private static func localizedMockName(_ base: String) -> String {
        let lang = Locale.current.language.languageCode?.identifier ?? "pt"
        return lang == "en" ? "\(base)_en" : base
    }

    private static func loadBundled<T: Decodable>(name: String, as type: T.Type) -> T
        where T: ExpressibleByArrayLiteral {
        guard
            let url = Bundle.main.url(forResource: name, withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let decoded = try? decoder.decode(type, from: data)
        else { return [] }
        return decoded
    }
}
