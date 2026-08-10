import CoreGraphics
import SwiftUI

// MARK: - Zodiak Spacing Tokens
//
// Escala de espaçamento do Zodiak Design System (Capgemini).
// Todos os paddings, margins e gaps de componentes Zodiak resolvem para um
// destes tokens — zero valores numéricos literais em componentes.
//
// **Unidade base**: 4pt (iOS) = 4dp (Android) — paridade numérica garantida.
//
// **Nomenclatura canônica** (Supernova): `s4`, `s8` … `s176` (14 tokens).
// Aliases semânticos (`componentPad`, `screenPad`…) adicionam intenção de uso.
//
// **RTL**: use `.paddingStart(_:)` / `.paddingEnd(_:)` (extensões abaixo)
// em vez de `.padding(.leading/trailing)` direto para garantir espelhamento
// correto em layouts árabe/hebraico.
//
// Ref: Zodiak DS — Spacing (Supernova, Mai 2026) · Issue #20

// MARK: - ZodiakSpacing

/// Tokens de espaçamento do Zodiak Design System.
///
/// **Camada primitiva** (`sN`) — nomes canônicos mapeados 1-para-1 com Supernova:
/// `s4`·3XS · `s8`·2XS · `s16`·XS · `s24`·S · `s32`·M · `s40`·L · `s48`·XL
/// `s56`·2XL · `s64`·3XL · `s72`·4XL · `s82`·5XL · `s96`·6XL · `s128`·7XL · `s176`·8XL
///
/// **Camada semântica** — aliases de intenção de uso (`componentPad`, `screenPad`, …)
///
/// ```swift
/// // ✅ primitivo
/// .padding(ZodiakSpacing.s16)
///
/// // ✅ semântico
/// .padding(ZodiakSpacing.screenPad)
///
/// // ✅ RTL-safe
/// .paddingStart(ZodiakSpacing.s16)
/// ```
enum ZodiakSpacing {
    // MARK: - Escala canônica (Supernova)

    /// `s4` — 4pt · 3XS · menor unidade de gap (badge, chip, tab)
    static let s4: CGFloat = 4
    /// `s8` — 8pt · 2XS · padding interno compacto (campo, card inner)
    static let s8: CGFloat = 8
    /// `s16` — 16pt · XS · padding de tela padrão, gap entre botões em grupo
    static let s16: CGFloat = 16
    /// `s24` — 24pt · S · espaço entre seções internas de card
    static let s24: CGFloat = 24
    /// `s32` — 32pt · padding de tela em iPad/landscape
    static let s32: CGFloat = 32
    /// `s40` — 40pt · gap entre blocos de conteúdo
    static let s40: CGFloat = 40
    /// `s48` — 48pt · separação entre seções maiores
    static let s48: CGFloat = 48
    /// `s56` — 56pt
    static let s56: CGFloat = 56
    /// `s64` — 64pt · 3XL
    static let s64: CGFloat = 64
    /// `s72` — 72pt · 4XL
    static let s72: CGFloat = 72
    /// `s82` — 82pt · 5XL
    static let s82: CGFloat = 82
    /// `s96` — 96pt · 6XL
    static let s96: CGFloat = 96
    /// `s128` — 128pt · 7XL · espaçamento editorial grande
    static let s128: CGFloat = 128
    /// `s176` — 176pt · 8XL · espaçamento hero/splash
    static let s176: CGFloat = 176

    // MARK: - Aliases semânticos (experimentais)
    //
    // ⚠️  Nenhum alias faz parte do Zodiak DS oficial.
    // Todos foram construídos sobre os tokens primitivos acima seguindo boas práticas de mercado:
    // "Space in Design Systems" (EightShapes), Material 3, Carbon (IBM).
    // Sujeitos a renomeação ou remoção antes de aprovação pelo time de design.

    /// Padding mínimo (ex: badge, chip) — 4pt (`s4`).
    static let componentMin: CGFloat = s4
    /// Padding interno de campo e card — 8pt (`s8`).
    static let componentPad: CGFloat = s8
    /// Padding padrão de tela/seção — 16pt (`s16`).
    static let screenPad: CGFloat = s16
    /// Padding iPad/landscape — 32pt (`s32`).
    static let screenPadLarge: CGFloat = s32
    /// Gap entre botões em grupo — 16pt (`s16`).
    static let buttonGap: CGFloat = s16
    /// Gap vertical entre seções de página — 24pt (`s24`).
    /// Corresponde ao conceito de *stack* (EightShapes) / `spacing-lg` (Carbon).
    static let sectionGap: CGFloat = s24
    /// Gap entre itens de lista ou rows — 8pt (`s8`).
    /// Corresponde ao conceito de *inline* (EightShapes) / `spacing-xs` (Carbon).
    static let itemGap: CGFloat = s8
    /// Gap vertical entre campos de formulário — 16pt (`s16`).
    /// Corresponde ao *stack-form* / `spacing-md` (Carbon).
    static let formFieldGap: CGFloat = s16
    /// Gap horizontal entre elementos inline (ícone + label, chips) — 8pt (`s8`).
    /// Corresponde ao *inline* (EightShapes) / `spacing-xs` (Carbon).
    static let inlineGap: CGFloat = s8

    // MARK: - Inventory (fonte única de verdade para galleries / docs)

    /// Escala canônica completa — usada por SpacingGalleryView e CatalogHomeView.
    static let allTokens: [(name: String, label: String, value: CGFloat)] = [
        ("s4", "3XS", s4),
        ("s8", "2XS", s8),
        ("s16", "XS", s16),
        ("s24", "S", s24),
        ("s32", "M", s32),
        ("s40", "L", s40),
        ("s48", "XL", s48),
        ("s56", "2XL", s56),
        ("s64", "3XL", s64),
        ("s72", "4XL", s72),
        ("s82", "5XL", s82),
        ("s96", "6XL", s96),
        ("s128", "7XL", s128),
        ("s176", "8XL", s176)
    ]

    /// Aliases semânticos experimentais — nenhum é oficial no Zodiak DS.
    /// Usados por SpacingGalleryView (Tab Aliases).
    static let allAliases: [(name: String, value: CGFloat)] = [
        ("componentMin", componentMin),
        ("componentPad", componentPad),
        ("buttonGap", buttonGap),
        ("screenPad", screenPad),
        ("screenPadLarge", screenPadLarge),
        ("sectionGap", sectionGap),
        ("itemGap", itemGap),
        ("formFieldGap", formFieldGap),
        ("inlineGap", inlineGap)
    ]
}

// MARK: - View+RTL Spacing Helpers

extension View {
    /// Aplica padding no lado de início do eixo horizontal.
    ///
    /// Em SwiftUI, `.leading` é a borda de início e já se espelha automaticamente
    /// em locales RTL (árabe, hebraico). Prefira este helper a `.padding(.leading, …)`
    /// para deixar explícita a intenção de inicio-de-linha.
    ///
    /// ```swift
    /// iconView.paddingStart(ZodiakSpacing.s8)
    /// ```
    func paddingStart(_ amount: CGFloat) -> some View {
        padding(.leading, amount)
    }

    /// Aplica padding no lado de fim do eixo horizontal (`trailing` em LTR, `leading` em RTL).
    ///
    /// ```swift
    /// iconView.paddingEnd(ZodiakSpacing.s8)
    /// ```
    func paddingEnd(_ amount: CGFloat) -> some View {
        padding(.trailing, amount)
    }
}
