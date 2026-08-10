import Testing
@testable import ZodiakiOS

// MARK: - ZodiakModal Tests

@Suite("ZodiakModal")
struct ZodiakModalTests {
    @Test("onDismiss defaults to nil")
    func defaultOnDismissNil() {
        let modal = ZodiakModal(isPresented: .constant(true)) {
            Text("Content")
        }
        #expect(modal.onDismiss == nil)
    }

    @Test("onDismiss callback is stored and callable")
    func onDismissStored() {
        var called = false
        let modal = ZodiakModal(
            isPresented: .constant(true),
            onDismiss: { called = true },
            content: { Text("Content") }
        )
        modal.onDismiss?()
        #expect(called)
    }

    @Test("showCloseButton defaults to true")
    func defaultShowCloseButton() {
        let modal = ZodiakModal(isPresented: .constant(true)) {
            Text("Content")
        }
        #expect(modal.showCloseButton == true)
    }

    @Test("title defaults to nil")
    func defaultTitleNil() {
        let modal = ZodiakModal(isPresented: .constant(true)) {
            Text("Content")
        }
        #expect(modal.title == nil)
    }

    @Test("title is stored when provided")
    func titleStored() {
        let modal = ZodiakModal(isPresented: .constant(true), title: "Confirm") {
            Text("Content")
        }
        #expect(modal.title == "Confirm")
    }
}
