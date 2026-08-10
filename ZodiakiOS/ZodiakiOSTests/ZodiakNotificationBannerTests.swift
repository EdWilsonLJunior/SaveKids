import Testing
@testable import ZodiakiOS

// MARK: - ZodiakNotificationBanner Tests

@Suite("ZodiakNotificationBanner")
struct ZodiakNotificationBannerTests {
    @Test("onDismiss defaults to nil")
    func defaultOnDismissNil() {
        let banner = ZodiakNotificationBanner(title: "Hello")
        #expect(banner.onDismiss == nil)
    }

    @Test("onDismiss callback is stored and callable")
    func onDismissStored() {
        var called = false
        let banner = ZodiakNotificationBanner(title: "Hello", onDismiss: { called = true })
        banner.onDismiss?()
        #expect(called)
    }

    @Test("isDismissible defaults to true")
    func defaultIsDismissible() {
        let banner = ZodiakNotificationBanner(title: "Hello")
        #expect(banner.isDismissible == true)
    }

    @Test("variant defaults to information")
    func defaultVariantInformation() {
        let banner = ZodiakNotificationBanner(title: "Hello")
        #expect(banner.variant == .information)
    }

    @Test("warning variant icon")
    func warningIcon() {
        #expect(ZodiakNotificationVariant.warning.icon == "exclamationmark.triangle.fill")
    }

    @Test("positive variant icon")
    func positiveIcon() {
        #expect(ZodiakNotificationVariant.positive.icon == "checkmark.circle.fill")
    }

    @Test("information variant icon")
    func informationIcon() {
        #expect(ZodiakNotificationVariant.information.icon == "info.circle.fill")
    }
}
