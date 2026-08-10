import SwiftUI

// MARK: - Zodiak Semantic Color Tokens
//
// Tokens semânticos de cor do Zodiak Design System (Capgemini).
// Light/Dark mode automático via Color Sets em Assets.xcassets.
//
// **Regra**: todo componente consome **apenas semânticos** (`ZodiakColors.*`).
// Primitivos (`ZodiakPrimitives.*`) só aparecem dentro dos tokens semânticos.
//
// **Cobertura**: 54 tokens verificados contra Supernova (Mai 2026) +
// 10 tokens iOS-only (sem equivalente Supernova — aguardam sign-off de design).
//
// **High Contrast**: slots presentes em Assets.xcassets; hex values aguardam
// design — não bloqueia merge (acessibilidade AA garantida pelos valores light/dark).
//
// Ref: Zodiak DS — Colors (Supernova, Mai 2026) · Issue #7

/// Tokens semânticos de cor do Zodiak Design System.
///
/// Use `ZodiakColors.*` em vez de hex literals ou `Color(hex:)` em componentes.
/// Para overrides em testes e previews, use `@Environment(\.zodiakColors)`:
///
/// ```swift
/// Text("Olá").foregroundStyle(ZodiakColors.textPrimary)
/// surface.background(ZodiakColors.surface)
/// button.tint(ZodiakColors.actionPrimary)
/// ```
enum ZodiakColors {
    // MARK: - Brand
    /// Capgemini Blue #0058ab — igual em light e dark
    static let brand = Color("zodiak-brand")
    /// Brand Orange #f9a464 — igual em light e dark
    static let brandOrange = Color("zodiak-brand-orange")

    // MARK: - Surfaces
    /// Page Background — light: #ffffff | dark: #12151d
    static let background = Color("zodiak-background")
    /// Surface (cards, modals) — light: #ffffff | dark: #12151d
    static let surface = Color("zodiak-surface")
    /// Surface Smoke Lite — light: #f8fafc | dark: #272b33
    static let surfaceSmoke = Color("zodiak-surface-smoke")
    /// Surface Fog Lite — light: #f8fafc | dark: #1b1f27
    static let surfaceFog = Color("zodiak-surface-fog")
    /// Surface Caribbean Lite — light: #00d5d0 | dark: #29656f
    static let surfaceCaribbean = Color("zodiak-surface-caribbean")
    /// Surface Caribbean Lite Inverse — light: #29656f | dark: #00d5d0
    static let surfaceCaribbeanInverse = Color("zodiak-surface-caribbean-inverse")
    /// Surface Ink Heavy — #121a38 (equal in both modes)
    static let surfaceInk = Color("zodiak-surface-ink")
    /// Surface Marine Heavy — light: #1c4076 | dark: #1d365a
    static let surfaceMarine = Color("zodiak-surface-marine")
    /// Surface Azur Heavy — light: #0058ab | dark: #1d365a
    static let surfaceAzur = Color("zodiak-surface-azur")
    /// Surface Always White — #ffffff in both modes
    static let surfaceAlwaysWhite = Color(hex: "#ffffff")
    /// Surface Always Black — #000000 in both modes
    static let surfaceAlwaysBlack = Color(hex: "#000000")
    /// Surface Positive — light: #eff7f5 | dark: #0f2e22
    static let surfacePositive = Color("zodiak-surface-positive")
    /// Surface Negative — light: #fbf2f3 | dark: #5d051a
    static let surfaceNegative = Color("zodiak-surface-negative")
    /// Surface Decorative Brand Blue — #0058ab fixed (⚠️ decorative only, no text on top)
    static let surfaceDecorativeBrand = brand
    /// Surface Decorative Brand Orange — #f9a464 fixed (⚠️ decorative only, no text on top)
    static let surfaceDecorativeOrange = brandOrange

    // MARK: - Text / Content
    /// Text Primary — light: #171a22 | dark: #f8fafc
    static let textPrimary = Color("zodiak-text-primary")
    /// Text Secondary — light: #595e6a | dark: #f1f4f7
    static let textSecondary = Color("zodiak-text-secondary")
    /// Text Inverse — light: #ffffff | dark: #171a22
    static let textInverse = Color("zodiak-text-inverse")
    /// Text Disabled — light: #a6acb5 | dark: #888f9a
    static let textDisabled = Color("zodiak-text-disabled")
    /// Text Always White — #ffffff in both modes
    static let textAlwaysWhite = Color(hex: "#ffffff")
    /// Text Always Black — #171a22 in both modes (Neutral.shade950)
    static let textAlwaysBlack = Color(hex: "#171a22")
    /// Text Link — light: #1d365a | dark: #ffffff
    static let textLink = Color("zodiak-text-link")
    /// Text Link Hover — light: #121a38 | dark: #f4f6f9
    static let textLinkHover = Color("zodiak-text-link-hover")
    /// Text Link Pressed — light: #070a16 | dark: #e9edf3
    static let textLinkPressed = Color("zodiak-text-link-pressed")
    /// Text Link Inverse — light: #ffffff | dark: #1d365a (links on heavy/dark surfaces)
    static let textLinkInverse = Color("zodiak-text-link-inverse")
    /// Text Negative onLite — light: #9e0029 | dark: #ffa7a9
    static let textNegative = Color("zodiak-text-negative")
    /// Text Negative onHeavy — #ffa7a9 in both modes (Red.shade200)
    static let textNegativeOnHeavy = Color(hex: "#ffa7a9")
    /// Text Positive (success icons/text) — #21b87d
    static let textPositive = Color(hex: "#21b87d")

    // MARK: - Status (avatar, presence, indicators)
    // Nota de implementação: estes tokens são usados como fill de dot indicator (30% do diâmetro do avatar).
    // O spec Supernova define também cores de badge (bg + fg + ring) para uma implementação futura mais rica.
    // Dot fill usa tons saturados para garantir visibilidade; badge bg usa os tokens surface* correspondentes.
    /// Online — dot indicator verde. Spec badge bg: `surfacePositive` (#eff7f5 light).
    static let statusOnline = textPositive
    /// Away — dot indicator vermelho médio. Spec badge bg: `surfaceNegative` (#fbf2f3 light).
    /// Zodiak define Away como família vermelha (não âmbar convencional).
    static let statusAway = ZodiakPrimitives.Red.shade400
    /// Do Not Disturb — dot indicator vermelho escuro. Spec: `textNegativeOnLite` = Red.shade800.
    static let statusDoNotDisturb = textNegative
    /// Offline — dot indicator cinza neutro. Spec badge bg: `surfaceCloudLite` (#eff0f4 light).
    static let statusOffline = ZodiakPrimitives.Neutral.shade400

    // MARK: - Warning tints (alert, toast)
    /// Warning tint — ícone/borda de alerta. Alias de `actionWarning` (Red.shade500 = #f64059 light / #ffffff dark).
    static let actionWarningTint = actionWarning
    /// Warning surface — fundo pálido de alerta inline. Alias de `surfaceNegative` (Red.shade50 = #fbf2f3 light / #5d051a dark).
    static let surfaceWarningTint = surfaceNegative

    // MARK: - Banner backgrounds (always-dark, non-adaptive)
    /// Banner success background — verde escuro Zodiak. Green.shade900 = #0f2e22.
    static let bannerSuccess = ZodiakPrimitives.Green.shade900
    /// Banner warning background — vermelho vivo. Red.shade600 = #dd1d46. Menos severo que bannerError.
    static let bannerWarning = ZodiakPrimitives.Red.shade600
    /// Banner error background — vermelho escuro. Red.shade800 = #9e0029.
    static let bannerError   = ZodiakPrimitives.Red.shade800

    // MARK: - Actions
    /// Action Primary Default onLite — light: #1d365a | dark: #ffffff
    static let actionPrimary = Color("zodiak-action-primary")
    /// Action Primary Hover onLite — light: #121a38 | dark: #c7ccd3
    static let actionHover = Color("zodiak-action-hover")
    /// Action Primary Pressed onLite — light: #070a16 | dark: #e9edf3
    static let actionPressed = Color("zodiak-action-pressed")
    /// Action Disabled — light: #a6acb5 | dark: #3c414a
    static let actionDisabled = Color("zodiak-action-disabled")
    /// Action Disabled Content — light: #d9dde3 | dark: #a6acb5
    static let actionDisabledContent = Color("zodiak-action-disabled-content")
    /// Action Active — #3573c0 (equal in both modes)
    static let actionActive = Color("zodiak-action-active")
    /// Action Warning Primary Default — light: #f64059 | dark: #ffffff
    static let actionWarning = Color("zodiak-action-warning")
    /// Action Warning Content (icon/text on top of warning surface) — light: #171a22 | dark: #9e0029
    static let actionWarningContent = Color("zodiak-action-warning-content")
    /// Action Warning Hover — light: #ff6270 | dark: #c7ccd3
    static let actionWarningHover = Color("zodiak-action-warning-hover")
    /// Action Warning Hover Outline (border on hover for outlined warning buttons) — light: #f64059 | dark: #c7ccd3
    static let actionWarningHoverOutline = Color("zodiak-action-warning-hover-outline")
    /// Action Warning Pressed — light: #dd1d46 | dark: #e9edf3
    static let actionWarningPressed = Color("zodiak-action-warning-pressed")
    /// Action Warning Pressed Outline (border on pressed for outlined warning buttons) — light: #dd1d46 | dark: #e9edf3
    static let actionWarningPressedOutline = Color("zodiak-action-warning-pressed-outline")
    /// Action Warning Secondary Default — light: #9e0029 | dark: #ff848b
    static let actionWarningSecondary = Color("zodiak-action-warning-secondary")
    /// Action Warning Secondary Hover — light: #c00036 | dark: #ffa7a9
    static let actionWarningSecondaryHover = Color("zodiak-action-warning-secondary-hover")
    /// Action Focus onLite — light: #2e323a | dark: #ffffff (focus ring on lite surfaces)
    static let actionFocus = Color("zodiak-action-focus")
    /// Action Focus onHeavy — #ffffff in both modes (focus ring on heavy/dark surfaces)
    static let actionFocusOnHeavy = Color(hex: "#ffffff")
    /// Action Primary onPhoto — rgba(0,0,0,0) transparent in both modes (per Zodiak spec)
    /// Used for transparent/ghost buttons placed over photographic backgrounds.
    static let actionPrimaryOnPhoto = Color.clear

    // MARK: - Actions onHeavy (for use on dark/heavy surfaces — Hero, Banner, surfaceInk/surfaceMarine)
    /// Action Primary Default onHeavy — #ffffff in both modes
    static let actionPrimaryOnHeavy = Color("zodiak-action-primary-on-heavy")
    /// Action Primary Hover onHeavy — light: #f4f6f9 | dark: #c7ccd3
    static let actionHoverOnHeavy = Color("zodiak-action-hover-on-heavy")
    /// Action Primary Pressed onHeavy — #e9edf3 in both modes
    static let actionPressedOnHeavy = Color("zodiak-action-pressed-on-heavy")

    // MARK: - Borders
    /// Border Primary — light: #c7ccd3 | dark: #3c414a
    static let borderPrimary = Color("zodiak-border-primary")
    /// Border Secondary — light: #eff0f4 | dark: #2e323a
    static let borderSecondary = Color("zodiak-border-secondary")

    // MARK: - Photo / Hero Overlays (spec: Color > Overlay)
    /// Page Overlay (photographic backgrounds) — rgba(23,26,34, 0.40) fixed both modes
    /// Apply over `Image` BEFORE drawing typography to ensure WCAG contrast.
    static let pageOverlay = Color(red: 23 / 255, green: 26 / 255, blue: 34 / 255).opacity(0.4)
    /// Hero Photographic Overlay — rgba(0,0,0, 0.55) fixed both modes
    /// Stronger overlay used in `ZodiakHero` photographic style for max readability.
    static let heroPhotographic = Color.black.opacity(0.55)
}
