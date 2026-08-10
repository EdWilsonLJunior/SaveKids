import Foundation
import Testing
@testable import ZodiakiOS

@Suite("LPEarnPointsViewModel Tests")
struct LPEarnPointsViewModelTests {
    @Test("initial state has no selected opportunity and no result")
    func initialStateIsEmpty() {
        let vm = LPEarnPointsViewModel()
        vm.statementData = Data()
        vm.points = 0

        #expect(vm.selectedOpportunity == nil)
        #expect(vm.earnedPoints == nil)
        #expect(vm.errorMessageKey == nil)
    }

    @Test("submit with valid opportunity earns points")
    func submitWithValidOpportunity() {
        let vm = LPEarnPointsViewModel()
        vm.statementData = Data()
        vm.points = 500
        vm.selectedOpportunity = vm.opportunities.first

        vm.submit()

        #expect(vm.earnedPoints != nil)
        #expect(vm.errorMessageKey == nil)
        #expect(vm.points > 500)
    }

    @Test("submit without selected opportunity sets error")
    func submitWithoutSelectionSetsError() {
        let vm = LPEarnPointsViewModel()
        vm.statementData = Data()
        vm.points = 500
        vm.selectedOpportunity = nil

        vm.submit()

        #expect(vm.errorMessageKey != nil)
        #expect(vm.earnedPoints == nil)
        #expect(vm.points == 500)
    }

    @Test("reset clears all published properties")
    func resetClearsState() {
        let vm = LPEarnPointsViewModel()
        vm.statementData = Data()
        vm.points = 500
        vm.selectedOpportunity = vm.opportunities.first
        vm.submit()

        vm.reset()

        #expect(vm.selectedOpportunity == nil)
        #expect(vm.earnedPoints == nil)
        #expect(vm.errorMessageKey == nil)
    }
}
