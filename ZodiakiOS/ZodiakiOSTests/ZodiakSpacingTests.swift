import CoreGraphics
import Testing
@testable import ZodiakiOS

// MARK: - ZodiakSpacing Tests
// Issue: #20 — DS Foundation: Spacing
// Verifica cobertura da escala canônica Supernova e valores dos aliases semânticos.

@Suite("ZodiakSpacing")
struct ZodiakSpacingTests {
    // MARK: - Escala canônica

    @Test("Canonical scale: values increase monotonically")
    func canonicalScaleIsMonotonic() {
        let scale: [CGFloat] = [
            ZodiakSpacing.s4,
            ZodiakSpacing.s8,
            ZodiakSpacing.s16,
            ZodiakSpacing.s24,
            ZodiakSpacing.s32,
            ZodiakSpacing.s40,
            ZodiakSpacing.s48,
            ZodiakSpacing.s56,
            ZodiakSpacing.s64,
            ZodiakSpacing.s72,
            ZodiakSpacing.s82,
            ZodiakSpacing.s96,
            ZodiakSpacing.s128,
            ZodiakSpacing.s176
        ]
        for index in 1 ..< scale.count {
            #expect(scale[index] > scale[index - 1], "Token at index \(index) should be > token at index \(index - 1)")
        }
    }

    @Test("Canonical scale: all 14 Supernova tokens present in allTokens inventory")
    func allTokensInventoryCoversCanonicalScale() {
        let canonicalNames: Set<String> = [
            "s4", "s8", "s16", "s24",
            "s32", "s40", "s48", "s56", "s64",
            "s72", "s82",
            "s96", "s128", "s176"
        ]
        let inventoryNames = Set(ZodiakSpacing.allTokens.map(\.name))
        let missing = canonicalNames.subtracting(inventoryNames)
        #expect(missing.isEmpty, "Missing from allTokens inventory: \(missing)")
    }

    // MARK: - Aliases semânticos

    @Test("Semantic alias componentMin equals s4")
    func componentMinEqualsS4() {
        #expect(ZodiakSpacing.componentMin == ZodiakSpacing.s4)
    }

    @Test("Semantic alias componentPad equals s8")
    func componentPadEqualsS8() {
        #expect(ZodiakSpacing.componentPad == ZodiakSpacing.s8)
    }

    @Test("Semantic alias screenPad equals s16")
    func screenPadEqualsS16() {
        #expect(ZodiakSpacing.screenPad == ZodiakSpacing.s16)
    }

    @Test("Semantic alias screenPadLarge equals s32")
    func screenPadLargeEqualsS32() {
        #expect(ZodiakSpacing.screenPadLarge == ZodiakSpacing.s32)
    }

    @Test("Semantic alias buttonGap equals s16")
    func buttonGapEqualsS16() {
        #expect(ZodiakSpacing.buttonGap == ZodiakSpacing.s16)
    }

    // MARK: - Valores absolutos (paridade iOS ↔ Android — valores numéricos iguais)

    @Test("Absolute values match Supernova spec")
    func absoluteValuesMatchSpec() {
        #expect(ZodiakSpacing.s4 == 4)
        #expect(ZodiakSpacing.s8 == 8)
        #expect(ZodiakSpacing.s16 == 16)
        #expect(ZodiakSpacing.s24 == 24)
        #expect(ZodiakSpacing.s32 == 32)
        #expect(ZodiakSpacing.s64 == 64)
        #expect(ZodiakSpacing.s96 == 96)
        #expect(ZodiakSpacing.s128 == 128)
        #expect(ZodiakSpacing.s176 == 176)
        #expect(ZodiakSpacing.s72 == 72)
        #expect(ZodiakSpacing.s82 == 82)
    }
}
