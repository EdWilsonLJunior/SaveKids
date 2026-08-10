import Testing
@testable import ZodiakiOS

// MARK: - ZodiakBorders Tests

@Suite("ZodiakBorders")
struct ZodiakBordersTests {
    @Test("hairline é 0.5pt")
    func hairlineValue() {
        #expect(ZodiakBorders.hairline == 0.5)
    }

    @Test("thin é 1pt")
    func thinValue() {
        #expect(ZodiakBorders.thin == 1)
    }

    @Test("medium é 2pt")
    func mediumValue() {
        #expect(ZodiakBorders.medium == 2)
    }

    @Test("thick é 4pt")
    func thickValue() {
        #expect(ZodiakBorders.thick == 4)
    }

    @Test("thin < medium < thick")
    func orderingIsCorrect() {
        #expect(ZodiakBorders.thin < ZodiakBorders.medium)
        #expect(ZodiakBorders.medium < ZodiakBorders.thick)
    }

    @Test("hairline < thin")
    func hairlineSmallerThanThin() {
        #expect(ZodiakBorders.hairline < ZodiakBorders.thin)
    }
}

// MARK: - ZodiakRadii Tests

@Suite("ZodiakRadii")
struct ZodiakRadiiTests {
    @Test("none é 0pt")
    func noneValue() {
        #expect(ZodiakRadii.none == 0)
    }

    @Test("xs é 4pt")
    func xsValue() {
        #expect(ZodiakRadii.xs == 4)
    }

    @Test("s é 16pt")
    func sValue() {
        #expect(ZodiakRadii.s == 16)
    }

    @Test("m é 32pt")
    func mValue() {
        #expect(ZodiakRadii.m == 32)
    }

    @Test("l é 999pt")
    func lValue() {
        #expect(ZodiakRadii.l == 999)
    }

    @Test("full é alias de l")
    func fullAliasesL() {
        #expect(ZodiakRadii.full == ZodiakRadii.l)
    }

    @Test("none < xs < s < m < l")
    func orderingIsCorrect() {
        #expect(ZodiakRadii.none < ZodiakRadii.xs)
        #expect(ZodiakRadii.xs < ZodiakRadii.s)
        #expect(ZodiakRadii.s < ZodiakRadii.m)
        #expect(ZodiakRadii.m < ZodiakRadii.l)
    }

    @Test("shape(_:) retorna RoundedRectangle com cornerRadius correto")
    func shapeHelperCornerRadius() {
        let shape = ZodiakRadii.shape(ZodiakRadii.s)
        #expect(shape.cornerRadius == ZodiakRadii.s)
    }
}
