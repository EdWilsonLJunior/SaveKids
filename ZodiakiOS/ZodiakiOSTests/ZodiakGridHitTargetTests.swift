import Testing
@testable import ZodiakiOS

// MARK: - ZodiakGrid Tests

@Suite("ZodiakGrid")
struct ZodiakGridTests {
    @Test("compact tem 4 colunas")
    func compactColumns() {
        #expect(ZodiakGrid.compact.columns == 4)
    }

    @Test("compactWide tem 6 colunas")
    func compactWideColumns() {
        #expect(ZodiakGrid.compactWide.columns == 6)
    }

    @Test("medium tem 8 colunas")
    func mediumColumns() {
        #expect(ZodiakGrid.medium.columns == 8)
    }

    @Test("expanded tem 12 colunas")
    func expandedColumns() {
        #expect(ZodiakGrid.expanded.columns == 12)
    }

    @Test("compact gutter é 16pt")
    func compactGutter() {
        #expect(ZodiakGrid.compact.gutter == 16)
    }

    @Test("medium gutter é 24pt")
    func mediumGutter() {
        #expect(ZodiakGrid.medium.gutter == 24)
    }

    @Test("compact margin é 16pt")
    func compactMargin() {
        #expect(ZodiakGrid.compact.margin == 16)
    }

    @Test("medium margin é 32pt")
    func mediumMargin() {
        #expect(ZodiakGrid.medium.margin == 32)
    }

    @Test("from(size:) width 375 resolve para compact")
    func resolvesCompactAt375() {
        let grid = ZodiakGrid.from(size: CGSize(width: 375, height: 812))
        #expect(grid.columns == 4)
    }

    @Test("from(size:) width 768 resolve para medium")
    func resolvesMediumAt768() {
        let grid = ZodiakGrid.from(size: CGSize(width: 768, height: 1024))
        #expect(grid.columns == 8)
    }

    @Test("from(size:) width 1024 resolve para expanded")
    func resolvesExpandedAt1024() {
        let grid = ZodiakGrid.from(size: CGSize(width: 1024, height: 768))
        #expect(grid.columns == 12)
    }
}

// MARK: - ZodiakHitTarget Tests

@Suite("ZodiakHitTarget")
struct ZodiakHitTargetTests {
    @Test("minimum é 44pt (WCAG 2.5.5 AAA + HIG)")
    func minimumValue() {
        #expect(ZodiakHitTarget.minimum == 44)
    }

    @Test("comfortable é 48pt")
    func comfortableValue() {
        #expect(ZodiakHitTarget.comfortable == 48)
    }

    @Test("minimum <= comfortable")
    func orderingIsCorrect() {
        #expect(ZodiakHitTarget.minimum <= ZodiakHitTarget.comfortable)
    }
}
