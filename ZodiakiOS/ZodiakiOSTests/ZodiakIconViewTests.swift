import Testing
@testable import ZodiakiOS

// MARK: - ZodiakIconView Tests

@Suite("ZodiakIconView")
struct ZodiakIconViewTests {
    @Test("default size is medium")
    func defaultSizeIsMedium() {
        let view = ZodiakIconView(.star)
        #expect(view.size == .medium)
    }

    @Test("default color is textPrimary")
    func defaultColorIsTextPrimary() {
        let view = ZodiakIconView(.star)
        #expect(view.color == ZodiakColors.textPrimary)
    }

    @Test("default isDecorative is false")
    func defaultIsDecorativeFalse() {
        let view = ZodiakIconView(.star)
        #expect(view.isDecorative == false)
    }

    @Test("isDecorative can be set to true")
    func isDecorativeCanBeTrue() {
        let view = ZodiakIconView(.star, isDecorative: true)
        #expect(view.isDecorative == true)
    }

    @Test("icon is stored correctly")
    func iconIsStoredCorrectly() {
        let view = ZodiakIconView(.bell)
        #expect(view.icon == .bell)
    }

    @Test("custom size is stored")
    func customSizeIsStored() {
        let view = ZodiakIconView(.user, size: .large)
        #expect(view.size == .large)
    }

    @Test("small icon dimension is 16pt")
    func smallIconIs16pt() {
        let view = ZodiakIconView(.user, size: .small)
        #expect(view.size.dimension == 16)
    }

    @Test("large icon dimension is 32pt")
    func largeIconIs32pt() {
        let view = ZodiakIconView(.user, size: .large)
        #expect(view.size.dimension == 32)
    }
}
