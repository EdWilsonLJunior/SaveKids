import CoreGraphics

// MARK: - Zodiak Sizing Tokens
//
// Tokens de tamanho fixo do Zodiak Design System (Capgemini).
// Distintos de spacing por intenção: medem **componentes** (altura de botão,
// ícone, diâmetro de avatar, hit-target), não gaps.
//
// "Most Zodiak components have predefined sizes which should not be changed,
// but in certain cases these tokens can be used to define the width and height of a component."
// Base unit: 8pt = 8dp
//
// Ref: Zodiak DS — Sizing (Supernova, Mai 2026) · Issue #19

/// Tokens de tamanho fixo do Zodiak Design System.
///
/// Use os sub-namespaces para acesso semântico:
/// ```swift
/// .frame(width: ZodiakSizing.Icon.md, height: ZodiakSizing.Icon.md)
/// .frame(width: ZodiakSizing.Avatar.lg, height: ZodiakSizing.Avatar.lg)
/// .frame(minWidth: ZodiakSizing.HitTarget.minimum, minHeight: ZodiakSizing.HitTarget.minimum)
/// ```
enum ZodiakSizing {
    // MARK: - Primitive Tokens (base 8px)

    /// 2XS — 8pt
    static let twoXSmall: CGFloat = 8

    /// XS — 16pt
    static let xs: CGFloat = 16

    /// S — 24pt
    static let s: CGFloat = 24

    /// M — 32pt
    static let m: CGFloat = 32

    /// L — 48pt
    static let l: CGFloat = 48

    /// XL — 56pt
    static let xl: CGFloat = 56

    /// 2XL — 72pt
    static let twoXLarge: CGFloat = 72

    /// 3XL — 128pt
    static let threeXLarge: CGFloat = 128

    /// 4XL — 160pt
    static let fourXLarge: CGFloat = 160

    /// 5XL — 200pt
    static let fiveXLarge: CGFloat = 200

    /// 6XL — 320pt
    static let sixXLarge: CGFloat = 320

    /// 7XL — 480pt
    static let sevenXLarge: CGFloat = 480

    /// 8XL — 640pt
    static let eightXLarge: CGFloat = 640

    /// 9XL — 720pt
    static let nineXLarge: CGFloat = 720

    /// 10XL — 880pt
    static let tenXLarge: CGFloat = 880

    /// 11XL — 960pt
    static let elevenXLarge: CGFloat = 960

    /// 12XL — 1040pt
    static let twelveXLarge: CGFloat = 1040

    // MARK: - Icon Sizes

    /// Tamanhos de ícone do Zodiak Design System.
    enum Icon {
        /// XS — 16pt
        static let xs: CGFloat = 16

        /// S — 20pt
        static let sm: CGFloat = 20

        /// M — 24pt (padrão)
        static let md: CGFloat = 24

        /// L — 32pt
        static let lg: CGFloat = 32

        /// XL — 40pt
        static let xl: CGFloat = 40

        // MARK: - Backward-compat aliases

        /// Alias de `sm` — 20pt.
        static let s: CGFloat = sm

        /// Alias de `md` — 24pt.
        static let m: CGFloat = md

        /// Alias de `lg` — 32pt.
        static let l: CGFloat = lg
    }

    // MARK: - Avatar Sizes

    /// Diâmetros de avatar do Zodiak Design System.
    ///
    /// Alinhados com `ZodiakAvatarSize.diameter` — qualquer mudança aqui
    /// deve ser refletida em `ZodiakAvatar.swift`.
    ///
    /// ```swift
    /// Image(uiImage: photo)
    ///     .resizable().scaledToFill()
    ///     .frame(width: ZodiakSizing.Avatar.md, height: ZodiakSizing.Avatar.md)
    ///     .clipShape(Circle())
    /// ```
    enum Avatar {
        /// XS — 24pt
        static let xs: CGFloat = 24

        /// S — 32pt
        static let sm: CGFloat = 32

        /// M — 40pt (padrão em listas)
        static let md: CGFloat = 40

        /// L — 56pt (destaque de autor)
        static let lg: CGFloat = 56

        /// XL — 72pt (página de perfil)
        static let xl: CGFloat = 72

        /// XXL — 120pt (hero de perfil)
        static let xxl: CGFloat = 120

        // MARK: - Backward-compat aliases

        /// Alias de `sm`.
        static let s: CGFloat = sm

        /// Alias de `md`.
        static let m: CGFloat = md

        /// Alias de `lg`.
        static let l: CGFloat = lg
    }

    // MARK: - Hit Target

    /// Tokens de hit-target (área mínima de toque).
    ///
    /// Use sempre estes valores — nunca hardcode 44 ou 48.
    enum HitTarget {
        /// Mínimo absoluto conforme HIG — 44pt.
        ///
        /// Toda ação interativa deve atingir este valor ou maior.
        static let minimum: CGFloat = 44

        /// Confortável — 48pt.
        ///
        /// Recomendado para botões e controles primários.
        /// Paridade com Material Design (Android 48dp).
        static let comfortable: CGFloat = 48
    }

    // MARK: - Buttons

    /// Alturas canônicas de botão por tamanho.
    enum Button {
        /// Small — 38pt
        static let small: CGFloat = 38

        /// Medium — 48pt (padrão)
        static let medium: CGFloat = 48

        /// Large — 56pt
        static let large: CGFloat = 56
    }

    // MARK: - Fields & Controls

    /// Altura canônica de campo de texto — 48pt.
    static let fieldHeight: CGFloat = 48

    /// Altura canônica de chip/tag — 32pt.
    static let chipHeight: CGFloat = 32

    /// Espessura canônica de divisor — 1pt.
    static let dividerThickness: CGFloat = 1

    // MARK: - Component Heights / Backward-compat aliases

    /// Deprecated: use `ZodiakSizing.HitTarget.minimum` instead.
    @available(*, deprecated, renamed: "ZodiakSizing.HitTarget.minimum")
    static let minTouchTarget: CGFloat = HitTarget.minimum

    /// Alias legado de `Button.small`. Prefira `ZodiakSizing.Button.small`.
    static let buttonHeightSmall: CGFloat = Button.small

    /// Alias legado de `Button.medium`. Prefira `ZodiakSizing.Button.medium`.
    static let buttonHeightMedium: CGFloat = Button.medium

    /// Alias legado de `Button.large`. Prefira `ZodiakSizing.Button.large`.
    static let buttonHeightLarge: CGFloat = Button.large

    /// Alias legado de `fieldHeight`. Prefira `ZodiakSizing.fieldHeight`.
    static let textFieldHeight: CGFloat = fieldHeight

    // MARK: - Layout Widths

    /// Largura máxima de um card em layout single-column — 480pt.
    /// Use o modifier `.zodiakCardWidth()` para aplicar o padrão cap + expand.
    static let cardMaxWidth: CGFloat = 480

    /// Largura máxima de conteúdo centrado em iPad — 1024pt.
    /// Usado por `ZodiakAdaptiveTemplate` e `ZodiakActivityTemplate(maxContentWidth:)`.
    static let contentMaxWidth: CGFloat = 1024
}
