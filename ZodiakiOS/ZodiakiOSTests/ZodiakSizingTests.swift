import Testing
@testable import ZodiakiOS

// MARK: - ZodiakSizing Tests
// Issue: #19 — DS Foundation: Sizing
// Verifica famílias de token (primitivos, ícone, avatar, hit-target, botão,
// field/chip/divider) e paridade entre aliases legados e tokens canônicos.

@Suite("ZodiakSizing")
struct ZodiakSizingTests {
    // MARK: - Primitivos

    @Test("Primitives: 2XS = 8")
    func twoXSmall() { #expect(ZodiakSizing.twoXSmall == 8) }

    @Test("Primitives: XS = 16")
    func primitiveXs() { #expect(ZodiakSizing.xs == 16) }

    @Test("Primitives: M = 32")
    func primitiveM() { #expect(ZodiakSizing.m == 32) }

    @Test("Primitives: 12XL = 1040")
    func primitive12XL() { #expect(ZodiakSizing.twelveXLarge == 1040) }

    // MARK: - Icon

    @Test("Icon.xs = 16")
    func iconXs() { #expect(ZodiakSizing.Icon.xs == 16) }

    @Test("Icon.sm = 20")
    func iconSm() { #expect(ZodiakSizing.Icon.sm == 20) }

    @Test("Icon.md = 24")
    func iconMd() { #expect(ZodiakSizing.Icon.md == 24) }

    @Test("Icon.lg = 32")
    func iconLg() { #expect(ZodiakSizing.Icon.lg == 32) }

    @Test("Icon.xl = 40")
    func iconXl() { #expect(ZodiakSizing.Icon.xl == 40) }

    @Test("Icon legacy aliases match canonical")
    func iconLegacyAliases() {
        #expect(ZodiakSizing.Icon.s == ZodiakSizing.Icon.sm)
        #expect(ZodiakSizing.Icon.m == ZodiakSizing.Icon.md)
        #expect(ZodiakSizing.Icon.l == ZodiakSizing.Icon.lg)
    }

    // MARK: - Avatar

    @Test("Avatar: scale is monotonically increasing")
    func avatarScaleMonotonic() {
        let scale: [CGFloat] = [
            ZodiakSizing.Avatar.xs,
            ZodiakSizing.Avatar.sm,
            ZodiakSizing.Avatar.md,
            ZodiakSizing.Avatar.lg,
            ZodiakSizing.Avatar.xl,
            ZodiakSizing.Avatar.xxl
        ]
        for index in 1 ..< scale.count {
            #expect(scale[index] > scale[index - 1])
        }
    }

    @Test("Avatar.xs = 24")
    func avatarXs() { #expect(ZodiakSizing.Avatar.xs == 24) }

    @Test("Avatar.sm = 32")
    func avatarSm() { #expect(ZodiakSizing.Avatar.sm == 32) }

    @Test("Avatar.md = 40")
    func avatarMd() { #expect(ZodiakSizing.Avatar.md == 40) }

    @Test("Avatar.lg = 56 (matches ZodiakAvatarSize.l)")
    func avatarLg() { #expect(ZodiakSizing.Avatar.lg == 56) }

    @Test("Avatar.xl = 72")
    func avatarXl() { #expect(ZodiakSizing.Avatar.xl == 72) }

    @Test("Avatar.xxl = 120")
    func avatarXxl() { #expect(ZodiakSizing.Avatar.xxl == 120) }

    @Test("Avatar legacy single-letter aliases match canonical")
    func avatarLegacyAliases() {
        #expect(ZodiakSizing.Avatar.s == ZodiakSizing.Avatar.sm)
        #expect(ZodiakSizing.Avatar.m == ZodiakSizing.Avatar.md)
        #expect(ZodiakSizing.Avatar.l == ZodiakSizing.Avatar.lg)
    }

    // MARK: - Hit Target

    @Test("HitTarget.minimum = 44 (HIG)")
    func hitTargetMinimum() { #expect(ZodiakSizing.HitTarget.minimum == 44) }

    @Test("HitTarget.comfortable = 48 (Material parity)")
    func hitTargetComfortable() { #expect(ZodiakSizing.HitTarget.comfortable == 48) }

    @Test("Legacy minTouchTarget equals HitTarget.minimum")
    func legacyMinTouchTarget() {
        #expect(ZodiakSizing.minTouchTarget == ZodiakSizing.HitTarget.minimum)
    }

    // MARK: - Buttons

    @Test("Button.small = 38")
    func buttonSmall() { #expect(ZodiakSizing.Button.small == 38) }

    @Test("Button.medium = 48")
    func buttonMedium() { #expect(ZodiakSizing.Button.medium == 48) }

    @Test("Button.large = 56")
    func buttonLarge() { #expect(ZodiakSizing.Button.large == 56) }

    @Test("Legacy buttonHeight aliases match Button enum")
    func legacyButtonAliases() {
        #expect(ZodiakSizing.buttonHeightSmall == ZodiakSizing.Button.small)
        #expect(ZodiakSizing.buttonHeightMedium == ZodiakSizing.Button.medium)
        #expect(ZodiakSizing.buttonHeightLarge == ZodiakSizing.Button.large)
    }

    // MARK: - Fields & Controls

    @Test("fieldHeight = 48")
    func fieldHeight() { #expect(ZodiakSizing.fieldHeight == 48) }

    @Test("chipHeight = 32")
    func chipHeight() { #expect(ZodiakSizing.chipHeight == 32) }

    @Test("dividerThickness = 1")
    func dividerThickness() { #expect(ZodiakSizing.dividerThickness == 1) }

    @Test("Legacy textFieldHeight equals fieldHeight")
    func legacyTextField() {
        #expect(ZodiakSizing.textFieldHeight == ZodiakSizing.fieldHeight)
    }
}
