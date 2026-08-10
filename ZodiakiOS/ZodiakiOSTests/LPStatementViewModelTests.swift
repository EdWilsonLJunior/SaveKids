import Foundation
import Testing
@testable import ZodiakiOS

@Suite("LPStatementViewModel")
struct LPStatementViewModelTests {
    private func makeTransaction(type: LPTransactionType, points: Int) -> LPPointTransaction {
        LPPointTransaction(id: UUID().uuidString, type: type,
                           description: "test", date: .now, points: points)
    }

    private func encode(_ transactions: [LPPointTransaction]) -> Data {
        (try? JSONEncoder().encode(transactions)) ?? Data()
    }

    @Test("estado inicial tem tab 0 e lista vazia")
    func initialState() {
        let vm = LPStatementViewModel()
        #expect(vm.selectedTab == 0)
        #expect(vm.filteredTransactions.isEmpty)
    }

    @Test("filteredTransactions tab earned mostra apenas positivos")
    func filterEarnedShowsPositive() {
        let vm = LPStatementViewModel()
        let txs = [makeTransaction(type: .earned, points: 100),
                   makeTransaction(type: .redeemed, points: -500)]
        vm.statementData = encode(txs)
        vm.selectedTab = LPStatementTab.earned.rawValue
        #expect(vm.filteredTransactions.count == 1)
        #expect(vm.filteredTransactions.first?.points == 100)
    }

    @Test("filteredTransactions tab spent mostra apenas negativos")
    func filterSpentShowsNegative() {
        let vm = LPStatementViewModel()
        let txs = [makeTransaction(type: .earned, points: 100),
                   makeTransaction(type: .sent, points: -200)]
        vm.statementData = encode(txs)
        vm.selectedTab = LPStatementTab.spent.rawValue
        #expect(vm.filteredTransactions.count == 1)
        #expect(vm.filteredTransactions.first?.points == -200)
    }

    @Test("formattedPoints com positivo mostra sinal +")
    func formattedPointsPositive() {
        let vm = LPStatementViewModel()
        #expect(vm.formattedPoints(100).hasPrefix("+"))
    }

    @Test("formattedPoints com negativo não mostra sinal +")
    func formattedPointsNegative() {
        let vm = LPStatementViewModel()
        #expect(!vm.formattedPoints(-100).hasPrefix("+"))
    }

    @Test("reset volta para tab 0")
    func resetRestoresDefaults() {
        let vm = LPStatementViewModel()
        vm.selectedTab = 2
        vm.reset()
        #expect(vm.selectedTab == 0)
    }
}
