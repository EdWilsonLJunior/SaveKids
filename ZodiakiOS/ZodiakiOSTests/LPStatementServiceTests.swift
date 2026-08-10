import Testing
import Foundation
@testable import ZodiakiOS

@Suite("LPStatementService Tests")
struct LPStatementServiceTests {
    private func makeTransaction(points: Int = 100, type: LPTransactionType = .earned) -> LPPointTransaction {
        LPPointTransaction(
            id: UUID().uuidString,
            type: type,
            description: "Test transaction",
            date: Date(),
            points: points
        )
    }

    @Test("decodeTransactions com Data vazia retorna array vazio")
    func decodeEmptyDataReturnsEmptyArray() {
        let result = LPStatementService.decodeTransactions(from: Data())
        #expect(result.isEmpty)
    }

    @Test("decodeTransactions com Data corrompida retorna array vazio")
    func decodeCorruptDataReturnsEmptyArray() {
        let corrupt = Data("not valid json".utf8)
        let result = LPStatementService.decodeTransactions(from: corrupt)
        #expect(result.isEmpty)
    }

    @Test("appendTransaction insere na posição 0 (mais recente primeiro)")
    func appendTransactionInsertsAtIndexZero() {
        var data = Data()
        let tx = makeTransaction(points: 50)
        LPStatementService.appendTransaction(tx, to: &data)
        let result = LPStatementService.decodeTransactions(from: data)
        #expect(result.count == 1)
        #expect(result[0].id == tx.id)
    }

    @Test("appendTransaction + decodeTransactions: 3 transações preservadas corretamente")
    func roundTripThreeTransactions() {
        var data = Data()
        let tx1 = makeTransaction(points: 100)
        let tx2 = makeTransaction(points: 200)
        let tx3 = makeTransaction(points: 300)
        LPStatementService.appendTransaction(tx1, to: &data)
        LPStatementService.appendTransaction(tx2, to: &data)
        LPStatementService.appendTransaction(tx3, to: &data)
        let result = LPStatementService.decodeTransactions(from: data)
        #expect(result.count == 3)
        #expect(result[0].id == tx3.id)
        #expect(result[1].id == tx2.id)
        #expect(result[2].id == tx1.id)
    }

    @Test("appendTransaction duas vezes: lista tem 2 entradas na ordem correta")
    func appendTwiceProducesCorrectOrder() {
        var data = Data()
        let first = makeTransaction(points: 10)
        let second = makeTransaction(points: 20)
        LPStatementService.appendTransaction(first, to: &data)
        LPStatementService.appendTransaction(second, to: &data)
        let result = LPStatementService.decodeTransactions(from: data)
        #expect(result.count == 2)
        #expect(result[0].points == 20)
        #expect(result[1].points == 10)
    }
}
