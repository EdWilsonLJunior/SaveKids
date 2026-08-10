import Testing
@testable import ZodiakiOS

// MARK: - ZodiakNotice Tests

@Suite("ZodiakNotice")
struct ZodiakNoticeTests {
    @Test("category defaults to information")
    func defaultCategory() {
        let notice = ZodiakNotice(title: "Hello")
        #expect(notice.category == .information)
    }

    @Test("isDismissible defaults to false")
    func defaultNotDismissible() {
        let notice = ZodiakNotice(title: "Hello")
        #expect(notice.isDismissible == false)
    }

    @Test("onDismiss defaults to nil")
    func defaultOnDismissNil() {
        let notice = ZodiakNotice(title: "Hello")
        #expect(notice.onDismiss == nil)
    }

    @Test("onDismiss callback is stored")
    func onDismissStored() {
        var called = false
        let notice = ZodiakNotice(title: "Hello", isDismissible: true, onDismiss: { called = true })
        notice.onDismiss?()
        #expect(called)
    }

    @Test("warning category has correct icon")
    func warningIcon() {
        #expect(ZodiakNoticeCategory.warning.icon == "exclamationmark.triangle.fill")
    }

    @Test("success category has correct icon")
    func successIcon() {
        #expect(ZodiakNoticeCategory.success.icon == "checkmark.circle.fill")
    }

    @Test("information category has correct icon")
    func informationIcon() {
        #expect(ZodiakNoticeCategory.information.icon == "info.circle.fill")
    }

    @Test("notice can carry action + actionLabel")
    func actionAndLabel() {
        var tapped = false
        let notice = ZodiakNotice(title: "Info", action: { tapped = true }, actionLabel: "Saiba mais")
        notice.action?()
        #expect(tapped)
        #expect(notice.actionLabel == "Saiba mais")
    }
}
