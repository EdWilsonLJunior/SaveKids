import Testing
@testable import ZodiakiOS

// MARK: - ZodiakTabItem Tests

@Suite("ZodiakTabItem")
struct ZodiakTabItemTests {
    @Test("label is stored correctly")
    func labelStored() {
        let item = ZodiakTabItem(label: "Overview")
        #expect(item.label == "Overview")
    }

    @Test("default id equals label when not provided")
    func defaultIdEqualsLabel() {
        let item = ZodiakTabItem(label: "Specs")
        #expect(item.id == "Specs")
    }

    @Test("custom id is stored")
    func customIdStored() {
        let item = ZodiakTabItem(id: "specs-tab", label: "Specs")
        #expect(item.id == "specs-tab")
    }

    @Test("default isDisabled is false")
    func defaultIsDisabledFalse() {
        let item = ZodiakTabItem(label: "Tab")
        #expect(item.isDisabled == false)
    }

    @Test("isDisabled can be set to true")
    func isDisabledTrue() {
        let item = ZodiakTabItem(label: "Tab", isDisabled: true)
        #expect(item.isDisabled == true)
    }

    @Test("icon defaults to nil")
    func defaultIconNil() {
        let item = ZodiakTabItem(label: "Tab")
        #expect(item.icon == nil)
    }
}

// MARK: - ZodiakTabsVariant Tests

@Suite("ZodiakTabsVariant")
struct ZodiakTabsVariantTests {
    @Test("scrollable variant enum exists")
    func scrollableVariant() {
        let v: ZodiakTabsVariant = .scrollable
        if case .scrollable = v {
            #expect(true)
        } else {
            Issue.record("Expected .scrollable")
        }
    }

    @Test("fixed variant enum exists")
    func fixedVariant() {
        let v: ZodiakTabsVariant = .fixed
        if case .fixed = v {
            #expect(true)
        } else {
            Issue.record("Expected .fixed")
        }
    }
}

// MARK: - ZodiakTabs Tests

@Suite("ZodiakTabs")
struct ZodiakTabsTests {
    @Test("items are capped at 7")
    func itemsCapAt7() {
        let items = (0..<10).map { ZodiakTabItem(label: "Tab \($0)") }
        var selected = 0
        let tabs = ZodiakTabs(
            selection: .init(get: { selected }, set: { selected = $0 }),
            items: items
        )
        #expect(tabs.items.count == 7)
    }

    @Test("default variant is scrollable")
    func defaultVariantScrollable() {
        var selected = 0
        let tabs = ZodiakTabs(
            selection: .init(get: { selected }, set: { selected = $0 }),
            items: [ZodiakTabItem(label: "A")]
        )
        if case .scrollable = tabs.variant {
            #expect(true)
        } else {
            Issue.record("Expected .scrollable default variant")
        }
    }
}
