import Combine
import SwiftUI

// MARK: - Tab Filter
enum LPStatementTab: Int, CaseIterable {
    case all = 0
    case earned = 1
    case spent = 2
}

// MARK: - US-30.05 Statement ViewModel
final class LPStatementViewModel: ObservableObject {
    @AppStorage(LPConstants.Storage.statement) var statementData: Data = Data() {
        didSet { reloadTransactions() }
    }

    @Published private(set) var allTransactions: [LPPointTransaction] = []
    @Published var selectedTab: Int = LPStatementTab.all.rawValue

    init() { reloadTransactions() }

    private func reloadTransactions() {
        if statementData.isEmpty {
            allTransactions = []
        } else {
            do {
                allTransactions = try JSONDecoder().decode([LPPointTransaction].self, from: statementData)
            } catch {
                ZodiakLog.warning(.service, "LP statement transactions decode failed",
                                  metadata: ["feature": "LoyaltyProgram",
                                              "exception.type": String(describing: type(of: error))])
                allTransactions = []
            }
        }
        ZodiakLog.info(
            .viewModel,
            "LP statement reloaded count=\(allTransactions.count)",
            metadata: ["feature": "LoyaltyProgram"],
            metrics: ["transaction_count": Double(allTransactions.count)]
        )
    }

    var filteredTransactions: [LPPointTransaction] {
        switch LPStatementTab(rawValue: selectedTab) {
        case .earned:
            return allTransactions.filter { $0.points > 0 }

        case .spent:
            return allTransactions.filter { $0.points < 0 }

        default:
            return allTransactions
        }
    }

    func reset() {
        selectedTab = 0
    }

    // MARK: - Formatting helpers

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        formatter.locale = Locale.current
        return formatter
    }()

    func formattedDate(_ date: Date) -> String {
        Self.dateFormatter.string(from: date)
    }

    func formattedPoints(_ points: Int) -> String {
        let prefix = points > 0 ? "+" : ""
        return "\(prefix)\(points) pts"
    }

    func typeLabel(for transaction: LPPointTransaction) -> String {
        switch transaction.type {
        case .earned:   return String(localized: "lp.statement.type_earned")
        case .redeemed: return String(localized: "lp.statement.type_redeemed")
        case .sent:     return String(localized: "lp.statement.type_sent")
        case .received: return String(localized: "lp.statement.type_received")
        }
    }

    var tabTitles: [String] {
        [
            String(localized: "lp.statement.tab_all"),
            String(localized: "lp.statement.tab_earned"),
            String(localized: "lp.statement.tab_spent")
        ]
    }
}
