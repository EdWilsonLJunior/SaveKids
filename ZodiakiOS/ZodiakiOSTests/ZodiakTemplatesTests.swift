import Testing
@testable import ZodiakiOS

// MARK: - ZodiakAdaptiveTemplate Tests

@Suite("ZodiakAdaptiveTemplate")
struct ZodiakAdaptiveTemplateTests {
    @Test("title is stored")
    func titleStored() {
        let template = ZodiakAdaptiveTemplate(title: "My Activity") {
            Text("Content")
        }
        #expect(template.title == "My Activity")
    }

    @Test("eyebrow defaults to nil")
    func eyebrowDefaultNil() {
        let template = ZodiakAdaptiveTemplate(title: "Test") {
            Text("Content")
        }
        #expect(template.eyebrow == nil)
    }

    @Test("intro defaults to nil")
    func introDefaultNil() {
        let template = ZodiakAdaptiveTemplate(title: "Test") {
            Text("Content")
        }
        #expect(template.intro == nil)
    }

    @Test("eyebrow and intro stored when provided")
    func eyebrowIntroStored() {
        let template = ZodiakAdaptiveTemplate(
            title: "Test",
            eyebrow: "Category",
            intro: "Intro text"
        ) { Text("Content") }
        #expect(template.eyebrow == "Category")
        #expect(template.intro == "Intro text")
    }
}

// MARK: - ZodiakLayoutGrid Tests

@Suite("ZodiakLayoutGrid")
struct ZodiakLayoutGridTests {
    @Test("columns param defaults to nil (adaptive)")
    func defaultColumnsNil() {
        let grid = ZodiakLayoutGrid { Text("Item") }
        #expect(grid.columns == nil)
    }

    @Test("explicit columns stored")
    func explicitColumnsStored() {
        let grid = ZodiakLayoutGrid(columns: 3) { Text("Item") }
        #expect(grid.columns == 3)
    }

    @Test("applyScreenPadding defaults to true")
    func defaultApplyScreenPadding() {
        let grid = ZodiakLayoutGrid { Text("Item") }
        #expect(grid.applyScreenPadding == true)
    }

    @Test("horizontalSpacing defaults to nil")
    func defaultHorizontalSpacingNil() {
        let grid = ZodiakLayoutGrid { Text("Item") }
        #expect(grid.horizontalSpacing == nil)
    }
}
