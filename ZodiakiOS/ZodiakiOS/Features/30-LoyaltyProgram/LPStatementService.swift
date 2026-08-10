import Foundation

// MARK: - LPStatementService
// Stateless service: encode/decode LPPointTransaction arrays from AppStorage Data.
enum LPStatementService {
    /// Prepends `tx` to the existing transaction list stored in `data`.
    /// Silent on codec failure — logs via ZodiakLog.
    static func appendTransaction(_ tx: LPPointTransaction, to data: inout Data) {
        var existing: [LPPointTransaction] = decodeTransactions(from: data)
        existing.insert(tx, at: 0)
        do {
            data = try JSONEncoder().encode(existing)
        } catch {
            ZodiakLog.warning(.service, "LP statement encode failed",
                              metadata: ["feature": "LoyaltyProgram",
                                         "exception.type": String(describing: type(of: error))])
        }
    }

    /// Decodes the transaction list from `data`. Returns `[]` for empty or corrupt data.
    static func decodeTransactions(from data: Data) -> [LPPointTransaction] {
        guard !data.isEmpty else { return [] }
        do {
            return try JSONDecoder().decode([LPPointTransaction].self, from: data)
        } catch {
            ZodiakLog.warning(.service, "LP statement decode failed",
                              metadata: ["feature": "LoyaltyProgram",
                                         "exception.type": String(describing: type(of: error))])
            return []
        }
    }
}
