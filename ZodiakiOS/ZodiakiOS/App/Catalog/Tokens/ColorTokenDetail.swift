// swiftlint:disable file_length type_body_length line_length
// Reason: Exhaustive color token catalog with semantic metadata for all 64 design system tokens.
import SwiftUI

// MARK: - ColorTokenCategory

enum ColorTokenCategory: String {
    case brand              = "Brand"
    case surface            = "Surface"
    case surfaceDecorative  = "Surface Decorative"
    case text               = "Content"
    case status             = "Status"
    case action             = "Action"
    case actionWarning      = "Action Warning"
    case border             = "Border"
    case overlay            = "Overlay"
    case primitive          = "Primitive"

    var titleKey: String {
        switch self {
        case .brand:             return "catalog.color.category_brand"
        case .surface:           return "catalog.color.category_surface"
        case .surfaceDecorative: return "catalog.color.category_surface_decorative"
        case .text:              return "catalog.color.category_text"
        case .status:            return "catalog.color.category_status"
        case .action:            return "catalog.color.category_action"
        case .actionWarning:     return "catalog.color.category_action_warning"
        case .border:            return "catalog.color.category_border"
        case .overlay:           return "catalog.color.category_overlay"
        case .primitive:         return "catalog.color.category_primitive"
        }
    }
}

// MARK: - HIGReference

struct HIGReference: Hashable {
    let sectionKey: String
    let url: String
    let excerptKey: String
}

extension HIGReference {
    static let color = HIGReference(
        sectionKey: "hig.color.section",
        url: "https://developer.apple.com/design/human-interface-guidelines/color",
        excerptKey: "hig.color.excerpt"
    )
    static let accessibilityContrast = HIGReference(
        sectionKey: "hig.accessibility_contrast.section",
        url: "https://developer.apple.com/design/human-interface-guidelines/accessibility",
        excerptKey: "hig.accessibility_contrast.excerpt"
    )
    static let inclusiveColor = HIGReference(
        sectionKey: "hig.inclusive_color.section",
        url: "https://developer.apple.com/design/human-interface-guidelines/color#Inclusive-color",
        excerptKey: "hig.inclusive_color.excerpt"
    )
    static let darkMode = HIGReference(
        sectionKey: "hig.dark_mode.section",
        url: "https://developer.apple.com/design/human-interface-guidelines/dark-mode",
        excerptKey: "hig.dark_mode.excerpt"
    )
    static let materials = HIGReference(
        sectionKey: "hig.materials.section",
        url: "https://developer.apple.com/design/human-interface-guidelines/materials",
        excerptKey: "hig.materials.excerpt"
    )
    static let interactiveColor = HIGReference(
        sectionKey: "hig.interactive_color.section",
        url: "https://developer.apple.com/design/human-interface-guidelines/color",
        excerptKey: "hig.interactive_color.excerpt"
    )
}

// MARK: - ColorTokenDetail

struct ColorTokenDetail: Identifiable, Hashable {
    let id: String
    let name: String
    let color: Color
    let primitiveRef: String
    let isAdaptive: Bool
    let category: ColorTokenCategory
    let intent: String
    let usageKeys: [String]
    let doKeys: [String]
    let dontKeys: [String]
    let hig: HIGReference
    /// Human-readable description key — set from the gallery at navigation time.
    var descriptionKey: String = ""

    static func == (lhs: Self, rhs: Self) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
}

// MARK: - ColorTokenMetadata

enum ColorTokenMetadata {
    static let all: [String: ColorTokenDetail] = allEntries.reduce(into: [:]) { $0[$1.id] = $1 }

    private static let allEntries: [ColorTokenDetail] = [
        // MARK: Brand (2)

        .init(
            id: "brand", name: "Capgemini Logo", color: ZodiakColors.brand,
            primitiveRef: "Blue.shade500 · adaptável",
            isAdaptive: true, category: .brand,
            intent: "Azul Capgemini — identidade visual corporativa primária.",
            usageKeys: ["token.brand.usage_0", "token.brand.usage_1", "token.brand.usage_2", "token.brand.usage_3"],
            doKeys: ["token.brand.do_0", "token.brand.do_1"],
            dontKeys: ["token.brand.dont_0", "token.brand.dont_1"],
            hig: .color
        ),
        .init(
            id: "brandOrange", name: "Brand Orange", color: ZodiakColors.brandOrange,
            primitiveRef: "Orange.shade400 · #f9a464 (fixo)",
            isAdaptive: false, category: .surfaceDecorative,
            intent: "Laranja Capgemini — cor de destaque secundária da marca.",
            usageKeys: ["token.brandOrange.usage_0", "token.brandOrange.usage_1"],
            doKeys: ["token.brandOrange.do_0"],
            dontKeys: ["token.brandOrange.dont_0", "token.brandOrange.dont_1"],
            hig: .color
        ),

        // MARK: Surfaces (15)

        .init(
            id: "background", name: "Cloud Lite", color: ZodiakColors.background,
            primitiveRef: "Neutral.shade50 / Neutral.shade950 · adaptável",
            isAdaptive: true, category: .surface,
            intent: "Cor de fundo de página — camada mais externa da hierarquia de superfícies.",
            usageKeys: ["token.background.usage_0", "token.background.usage_1", "token.background.usage_2"],
            doKeys: ["token.background.do_0", "token.background.do_1"],
            dontKeys: ["token.background.dont_0"],
            hig: .materials
        ),
        .init(
            id: "surface", name: "Page Background", color: ZodiakColors.surface,
            primitiveRef: "White / Neutral.shade850 · adaptável",
            isAdaptive: true, category: .surface,
            intent: "Superfície de cards e painéis — uma camada acima de background.",
            usageKeys: ["token.surface.usage_0", "token.surface.usage_1", "token.surface.usage_2", "token.surface.usage_3"],
            doKeys: ["token.surface.do_0"],
            dontKeys: ["token.surface.dont_0"],
            hig: .materials
        ),
        .init(
            id: "surfaceSmoke", name: "Smoke Lite", color: ZodiakColors.surfaceSmoke,
            primitiveRef: "colorset · adaptável",
            isAdaptive: true, category: .surface,
            intent: "Superfície smoke alternativa — hover de cards e separação sutil entre seções.",
            usageKeys: ["token.surfaceSmoke.usage_0", "token.surfaceSmoke.usage_1"],
            doKeys: ["token.surfaceSmoke.do_0"], dontKeys: ["token.surfaceSmoke.dont_0"],
            hig: .materials
        ),
        .init(
            id: "surfaceFog", name: "Fog Lite", color: ZodiakColors.surfaceFog,
            primitiveRef: "Neutral.shade50 / Neutral.shade900 · adaptável",
            isAdaptive: true, category: .surface,
            intent: "Superfície Fog — variante neutra para seções editoriais sem borda.",
            usageKeys: ["token.surfaceFog.usage_0", "token.surfaceFog.usage_1"],
            doKeys: ["token.surfaceFog.do_0"],
            dontKeys: ["token.surfaceFog.dont_0"],
            hig: .materials
        ),
        .init(
            id: "surfaceCaribbean", name: "Caribbean Lite", color: ZodiakColors.surfaceCaribbean,
            primitiveRef: "colorset · adaptável",
            isAdaptive: true, category: .surface,
            intent: "Azul vibrante para seções de destaque editorial.",
            usageKeys: ["token.surfaceCaribbean.usage_0", "token.surfaceCaribbean.usage_1", "token.surfaceCaribbean.usage_2"],
            doKeys: ["token.surfaceCaribbean.do_0"],
            dontKeys: ["token.surfaceCaribbean.dont_0"],
            hig: .darkMode
        ),
        .init(
            id: "surfaceCaribbeanInverse", name: "Caribbean Lite Inverse", color: ZodiakColors.surfaceCaribbeanInverse,
            primitiveRef: "colorset · adaptável",
            isAdaptive: true, category: .surface,
            intent: "Versão invertida de surfaceCaribbean — para layouts invertidos onHeavy.",
            usageKeys: ["token.surfaceCaribbeanInverse.usage_0"],
            doKeys: ["token.surfaceCaribbeanInverse.do_0"],
            dontKeys: ["token.surfaceCaribbeanInverse.dont_0"],
            hig: .darkMode
        ),
        .init(
            id: "surfaceInk", name: "Ink Heavy", color: ZodiakColors.surfaceInk,
            primitiveRef: "colorset (fixo)",
            isAdaptive: false, category: .surface,
            intent: "Azul profundo onHeavy — superfície de alto contraste para seções invertidas.",
            usageKeys: ["token.surfaceInk.usage_0", "token.surfaceInk.usage_1", "token.surfaceInk.usage_2"],
            doKeys: ["token.surfaceInk.do_0"],
            dontKeys: ["token.surfaceInk.dont_0"],
            hig: .darkMode
        ),
        .init(
            id: "surfaceMarine", name: "Marine Heavy", color: ZodiakColors.surfaceMarine,
            primitiveRef: "colorset · adaptável",
            isAdaptive: true, category: .surface,
            intent: "Azul marinho — superfície onHeavy mais clara que surfaceInk.",
            usageKeys: ["token.surfaceMarine.usage_0", "token.surfaceMarine.usage_1"],
            doKeys: ["token.surfaceMarine.do_0"],
            dontKeys: ["token.surfaceMarine.dont_0"],
            hig: .darkMode
        ),
        .init(
            id: "surfaceAzur", name: "Azur Heavy", color: ZodiakColors.surfaceAzur,
            primitiveRef: "colorset · adaptável",
            isAdaptive: true, category: .surface,
            intent: "Azul Azur vibrante — superfície de destaque de marca.",
            usageKeys: ["token.surfaceAzur.usage_0", "token.surfaceAzur.usage_1"],
            doKeys: ["token.surfaceAzur.do_0"],
            dontKeys: ["token.surfaceAzur.dont_0"],
            hig: .darkMode
        ),
        .init(
            id: "surfaceAlwaysWhite", name: "Always White", color: ZodiakColors.surfaceAlwaysWhite,
            primitiveRef: "White · #ffffff (fixo, não adaptável)",
            isAdaptive: false, category: .surface,
            intent: "Branco absoluto — invariante em light e dark mode. Para elementos que DEVEM ser brancos.",
            usageKeys: ["token.surfaceAlwaysWhite.usage_0", "token.surfaceAlwaysWhite.usage_1"],
            doKeys: ["token.surfaceAlwaysWhite.do_0"],
            dontKeys: ["token.surfaceAlwaysWhite.dont_0"],
            hig: .darkMode
        ),
        .init(
            id: "surfaceAlwaysBlack", name: "Always Black", color: ZodiakColors.surfaceAlwaysBlack,
            primitiveRef: "Black · #000000 (fixo, não adaptável)",
            isAdaptive: false, category: .surface,
            intent: "Preto absoluto — invariante em light e dark mode.",
            usageKeys: ["token.surfaceAlwaysBlack.usage_0"],
            doKeys: ["token.surfaceAlwaysBlack.do_0"],
            dontKeys: ["token.surfaceAlwaysBlack.dont_0"],
            hig: .darkMode
        ),
        .init(
            id: "surfacePositive", name: "Positive", color: ZodiakColors.surfacePositive,
            primitiveRef: "Green.shade50 / Green.shade900 · adaptável",
            isAdaptive: true, category: .surface,
            intent: "Fundo de sucesso — verde pálido para banners, badges e estados de confirmação.",
            usageKeys: ["token.surfacePositive.usage_0", "token.surfacePositive.usage_1", "token.surfacePositive.usage_2"],
            doKeys: ["token.surfacePositive.do_0", "token.surfacePositive.do_1"],
            dontKeys: ["token.surfacePositive.dont_0", "token.surfacePositive.dont_1"],
            hig: .inclusiveColor
        ),
        .init(
            id: "surfaceNegative", name: "Negative", color: ZodiakColors.surfaceNegative,
            primitiveRef: "Red.shade50 / Red.shade900 · adaptável",
            isAdaptive: true, category: .surface,
            intent: "Fundo de erro/aviso — vermelho pálido para mensagens de alerta e campos com erro.",
            usageKeys: ["token.surfaceNegative.usage_0", "token.surfaceNegative.usage_1", "token.surfaceNegative.usage_2"],
            doKeys: ["token.surfaceNegative.do_0", "token.surfaceNegative.do_1"],
            dontKeys: ["token.surfaceNegative.dont_0", "token.surfaceNegative.dont_1"],
            hig: .inclusiveColor
        ),
        .init(
            id: "surfaceDecorativeBrand", name: "Brand Blue", color: ZodiakColors.surfaceDecorativeBrand,
            primitiveRef: "colorset · adaptável",
            isAdaptive: true, category: .surfaceDecorative,
            intent: "Superfície decorativa azul de marca — para elementos editoriais e ilustrativos.",
            usageKeys: ["token.surfaceDecorativeBrand.usage_0", "token.surfaceDecorativeBrand.usage_1"],
            doKeys: ["token.surfaceDecorativeBrand.do_0"],
            dontKeys: ["token.surfaceDecorativeBrand.dont_0"],
            hig: .color
        ),
        .init(
            id: "surfaceDecorativeOrange", name: "Brand Orange", color: ZodiakColors.surfaceDecorativeOrange,
            primitiveRef: "alias: brandOrange · #f9a464 (fixo)",
            isAdaptive: false, category: .surfaceDecorative,
            intent: "Superfície decorativa laranja — destaque editorial em composições de marca.",
            usageKeys: ["token.surfaceDecorativeOrange.usage_0"],
            doKeys: ["token.surfaceDecorativeOrange.do_0"],
            dontKeys: ["token.surfaceDecorativeOrange.dont_0"],
            hig: .color
        ),

        // MARK: Text (13)

        .init(
            id: "textPrimary", name: "Primary", color: ZodiakColors.textPrimary,
            primitiveRef: "Neutral.shade950 / Neutral.shade50 · adaptável",
            isAdaptive: true, category: .text,
            intent: "Texto principal — máxima hierarquia tipográfica para títulos, corpo e labels.",
            usageKeys: ["token.textPrimary.usage_0", "token.textPrimary.usage_1", "token.textPrimary.usage_2"],
            doKeys: ["token.textPrimary.do_0"],
            dontKeys: ["token.textPrimary.dont_0", "token.textPrimary.dont_1"],
            hig: .accessibilityContrast
        ),
        .init(
            id: "textSecondary", name: "Secondary", color: ZodiakColors.textSecondary,
            primitiveRef: "Neutral.shade500 · adaptável",
            isAdaptive: true, category: .text,
            intent: "Texto secundário — hierarquia reduzida para metadados, legendas e descrições de suporte.",
            usageKeys: ["token.textSecondary.usage_0", "token.textSecondary.usage_1", "token.textSecondary.usage_2", "token.textSecondary.usage_3"],
            doKeys: ["token.textSecondary.do_0"],
            dontKeys: ["token.textSecondary.dont_0", "token.textSecondary.dont_1"],
            hig: .accessibilityContrast
        ),
        .init(
            id: "textInverse", name: "Inverse", color: ZodiakColors.textInverse,
            primitiveRef: "Neutral.shade50 / Neutral.shade950 · adaptável",
            isAdaptive: true, category: .text,
            intent: "Texto inverso — par de textPrimary para superfícies escuras onHeavy.",
            usageKeys: ["token.textInverse.usage_0", "token.textInverse.usage_1"],
            doKeys: ["token.textInverse.do_0"],
            dontKeys: ["token.textInverse.dont_0"],
            hig: .darkMode
        ),
        .init(
            id: "textDisabled", name: "Disabled", color: ZodiakColors.textDisabled,
            primitiveRef: "colorset · adaptável",
            isAdaptive: true, category: .text,
            intent: "Texto desabilitado — indica que um elemento não é interativo.",
            usageKeys: ["token.textDisabled.usage_0", "token.textDisabled.usage_1", "token.textDisabled.usage_2"],
            doKeys: ["token.textDisabled.do_0", "token.textDisabled.do_1"],
            dontKeys: ["token.textDisabled.dont_0", "token.textDisabled.dont_1"],
            hig: .accessibilityContrast
        ),
        .init(
            id: "textAlwaysWhite", name: "Always White", color: ZodiakColors.textAlwaysWhite,
            primitiveRef: "White · #ffffff (fixo, não adaptável)",
            isAdaptive: false, category: .text,
            intent: "Texto branco absoluto — invariante. Para textos sobre fundos necessariamente escuros.",
            usageKeys: ["token.textAlwaysWhite.usage_0", "token.textAlwaysWhite.usage_1", "token.textAlwaysWhite.usage_2"],
            doKeys: ["token.textAlwaysWhite.do_0"],
            dontKeys: ["token.textAlwaysWhite.dont_0"],
            hig: .darkMode
        ),
        .init(
            id: "textAlwaysBlack", name: "Always Black", color: ZodiakColors.textAlwaysBlack,
            primitiveRef: "Black · #000000 (fixo, não adaptável)",
            isAdaptive: false, category: .text,
            intent: "Texto preto absoluto — invariante em light e dark mode.",
            usageKeys: ["token.textAlwaysBlack.usage_0", "token.textAlwaysBlack.usage_1"],
            doKeys: ["token.textAlwaysBlack.do_0"],
            dontKeys: ["token.textAlwaysBlack.dont_0"],
            hig: .darkMode
        ),
        .init(
            id: "textLink", name: "Link", color: ZodiakColors.textLink,
            primitiveRef: "colorset · adaptável",
            isAdaptive: true, category: .text,
            intent: "Cor padrão de links inline — estado padrão, indica navegação.",
            usageKeys: ["token.textLink.usage_0", "token.textLink.usage_1"],
            doKeys: ["token.textLink.do_0"],
            dontKeys: ["token.textLink.dont_0", "token.textLink.dont_1"],
            hig: .inclusiveColor
        ),
        .init(
            id: "textLinkHover", name: "Link Hover", color: ZodiakColors.textLinkHover,
            primitiveRef: "colorset · adaptável",
            isAdaptive: true, category: .text,
            intent: "Hover de links — feedback visual ao passar o cursor.",
            usageKeys: ["token.textLinkHover.usage_0"],
            doKeys: ["token.textLinkHover.do_0"],
            dontKeys: ["token.textLinkHover.dont_0"],
            hig: .interactiveColor
        ),
        .init(
            id: "textLinkPressed", name: "Link Pressed", color: ZodiakColors.textLinkPressed,
            primitiveRef: "colorset · adaptável",
            isAdaptive: true, category: .text,
            intent: "Estado pressed dos links — feedback visual de toque.",
            usageKeys: ["token.textLinkPressed.usage_0"],
            doKeys: ["token.textLinkPressed.do_0"],
            dontKeys: ["token.textLinkPressed.dont_0"],
            hig: .interactiveColor
        ),
        .init(
            id: "textLinkInverse", name: "Link Inverse", color: ZodiakColors.textLinkInverse,
            primitiveRef: "colorset · adaptável",
            isAdaptive: true, category: .text,
            intent: "Link em superfícies onHeavy — versão invertida de textLink.",
            usageKeys: ["token.textLinkInverse.usage_0"],
            doKeys: ["token.textLinkInverse.do_0"],
            dontKeys: ["token.textLinkInverse.dont_0"],
            hig: .darkMode
        ),
        .init(
            id: "textNegative", name: "Negative onLite", color: ZodiakColors.textNegative,
            primitiveRef: "Red.shade800 / Red.shade200 · adaptável",
            isAdaptive: true, category: .text,
            intent: "Texto de erro — mensagens de validação e estados de falha.",
            usageKeys: ["token.textNegative.usage_0", "token.textNegative.usage_1", "token.textNegative.usage_2"],
            doKeys: ["token.textNegative.do_0", "token.textNegative.do_1"],
            dontKeys: ["token.textNegative.dont_0", "token.textNegative.dont_1"],
            hig: .inclusiveColor
        ),
        .init(
            id: "textNegativeOnHeavy", name: "Negative onHeavy", color: ZodiakColors.textNegativeOnHeavy,
            primitiveRef: "Red.shade200 · #ffa7a9 (fixo)",
            isAdaptive: false, category: .text,
            intent: "Texto de erro sobre superfícies escuras — rosa-vermelho com contraste adequado onHeavy.",
            usageKeys: ["token.textNegativeOnHeavy.usage_0"],
            doKeys: ["token.textNegativeOnHeavy.do_0"],
            dontKeys: ["token.textNegativeOnHeavy.dont_0"],
            hig: .accessibilityContrast
        ),
        .init(
            id: "textPositive", name: "Positive", color: ZodiakColors.textPositive,
            primitiveRef: "Green · #21b87d (fixo)",
            isAdaptive: false, category: .text,
            intent: "Texto de sucesso — confirmações e estados positivos. Também é alias de statusOnline.",
            usageKeys: ["token.textPositive.usage_0", "token.textPositive.usage_1", "token.textPositive.usage_2"],
            doKeys: ["token.textPositive.do_0", "token.textPositive.do_1"],
            dontKeys: ["token.textPositive.dont_0", "token.textPositive.dont_1"],
            hig: .inclusiveColor
        ),

        // MARK: Status / Warning / Banner (9)

        .init(
            id: "statusOnline", name: "Online", color: ZodiakColors.statusOnline,
            primitiveRef: "alias: textPositive · #21b87d (fixo)",
            isAdaptive: false, category: .status,
            intent: "Indicador de presença online — ponto verde em ZodiakAvatar. Alias de textPositive.",
            usageKeys: ["token.statusOnline.usage_0"],
            doKeys: ["token.statusOnline.do_0"],
            dontKeys: ["token.statusOnline.dont_0"],
            hig: .inclusiveColor
        ),
        .init(
            id: "statusAway", name: "Away", color: ZodiakColors.statusAway,
            primitiveRef: "Red.shade400 · #ff6270 (fixo)",
            isAdaptive: false, category: .status,
            intent: "Indicador de presença ausente — ponto vermelho médio. No Zodiak, Away pertence à família vermelha.",
            usageKeys: ["token.statusAway.usage_0"],
            doKeys: ["token.statusAway.do_0"],
            dontKeys: ["token.statusAway.dont_0"],
            hig: .inclusiveColor
        ),
        .init(
            id: "statusDoNotDisturb", name: "Do Not Disturb", color: ZodiakColors.statusDoNotDisturb,
            primitiveRef: "alias: textNegative · Red.shade800/#9e0029 (adaptável)",
            isAdaptive: true, category: .status,
            intent: "Indicador de não perturbe — ponto vermelho escuro, mais severo que statusAway.",
            usageKeys: ["token.statusDoNotDisturb.usage_0"],
            doKeys: ["token.statusDoNotDisturb.do_0"],
            dontKeys: ["token.statusDoNotDisturb.dont_0"],
            hig: .inclusiveColor
        ),
        .init(
            id: "statusOffline", name: "Offline", color: ZodiakColors.statusOffline,
            primitiveRef: "Neutral.shade400 · #a6acb5 (fixo)",
            isAdaptive: false, category: .status,
            intent: "Indicador de presença offline — ponto cinza neutro, convencional e visível.",
            usageKeys: ["token.statusOffline.usage_0"],
            doKeys: ["token.statusOffline.do_0"],
            dontKeys: ["token.statusOffline.dont_0"],
            hig: .inclusiveColor
        ),
        .init(
            id: "actionWarningTint", name: "Action Warning Tint", color: ZodiakColors.actionWarningTint,
            primitiveRef: "alias: actionWarning · Red.shade500 (adaptável)",
            isAdaptive: true, category: .status,
            intent: "Ícone/borda de alertas inline — alias de actionWarning. Warning no Zodiak é vermelho.",
            usageKeys: ["token.actionWarningTint.usage_0", "token.actionWarningTint.usage_1", "token.actionWarningTint.usage_2"],
            doKeys: ["token.actionWarningTint.do_0"],
            dontKeys: ["token.actionWarningTint.dont_0"],
            hig: .inclusiveColor
        ),
        .init(
            id: "surfaceWarningTint", name: "Surface Warning Tint", color: ZodiakColors.surfaceWarningTint,
            primitiveRef: "alias: surfaceNegative · Red.shade50 (adaptável)",
            isAdaptive: true, category: .status,
            intent: "Fundo de alertas inline — alias de surfaceNegative. Vermelho pálido para contextos de aviso.",
            usageKeys: ["token.surfaceWarningTint.usage_0", "token.surfaceWarningTint.usage_1"],
            doKeys: ["token.surfaceWarningTint.do_0"],
            dontKeys: ["token.surfaceWarningTint.dont_0"],
            hig: .inclusiveColor
        ),
        .init(
            id: "bannerSuccess", name: "Banner Success", color: ZodiakColors.bannerSuccess,
            primitiveRef: "Green.shade900 · #0f2e22 (fixo)",
            isAdaptive: false, category: .status,
            intent: "Fundo de banner de sucesso — verde escuro invariável em ambos os modos.",
            usageKeys: ["token.bannerSuccess.usage_0", "token.bannerSuccess.usage_1"],
            doKeys: ["token.bannerSuccess.do_0"],
            dontKeys: ["token.bannerSuccess.dont_0"],
            hig: .inclusiveColor
        ),
        .init(
            id: "bannerWarning", name: "Banner Warning", color: ZodiakColors.bannerWarning,
            primitiveRef: "Red.shade600 · #dd1d46 (fixo)",
            isAdaptive: false, category: .status,
            intent: "Fundo de banner de aviso — vermelho vivo. Menos severo que bannerError.",
            usageKeys: ["token.bannerWarning.usage_0"],
            doKeys: ["token.bannerWarning.do_0"],
            dontKeys: ["token.bannerWarning.dont_0"],
            hig: .inclusiveColor
        ),
        .init(
            id: "bannerError", name: "Banner Error", color: ZodiakColors.bannerError,
            primitiveRef: "Red.shade800 · #9e0029 (fixo)",
            isAdaptive: false, category: .status,
            intent: "Fundo de banner de erro — vermelho escuro, máxima severidade.",
            usageKeys: ["token.bannerError.usage_0"],
            doKeys: ["token.bannerError.do_0", "token.bannerError.do_1"],
            dontKeys: ["token.bannerError.dont_0"],
            hig: .inclusiveColor
        ),

        // MARK: Actions (19)

        .init(
            id: "actionPrimary", name: "Primary Default onLite", color: ZodiakColors.actionPrimary,
            primitiveRef: "colorset · adaptável",
            isAdaptive: true, category: .action,
            intent: "Cor primária de ação — botões CTA, links e elementos interativos em superfícies claras.",
            usageKeys: ["token.actionPrimary.usage_0", "token.actionPrimary.usage_1", "token.actionPrimary.usage_2"],
            doKeys: ["token.actionPrimary.do_0"],
            dontKeys: ["token.actionPrimary.dont_0"],
            hig: .interactiveColor
        ),
        .init(
            id: "actionHover", name: "Primary Hover onLite", color: ZodiakColors.actionHover,
            primitiveRef: "colorset · adaptável",
            isAdaptive: true, category: .action,
            intent: "Cor de hover das ações — escurece ao passar o cursor.",
            usageKeys: ["token.actionHover.usage_0", "token.actionHover.usage_1"],
            doKeys: ["token.actionHover.do_0"],
            dontKeys: ["token.actionHover.dont_0"],
            hig: .interactiveColor
        ),
        .init(
            id: "actionPressed", name: "Primary Pressed onLite", color: ZodiakColors.actionPressed,
            primitiveRef: "colorset · adaptável",
            isAdaptive: true, category: .action,
            intent: "Cor em estado pressed — feedback visual de toque.",
            usageKeys: ["token.actionPressed.usage_0"],
            doKeys: ["token.actionPressed.do_0"],
            dontKeys: ["token.actionPressed.dont_0"],
            hig: .interactiveColor
        ),
        .init(
            id: "actionDisabled", name: "Disabled", color: ZodiakColors.actionDisabled,
            primitiveRef: "colorset · adaptável",
            isAdaptive: true, category: .action,
            intent: "Fundo de elementos desabilitados — botões e controles inativos.",
            usageKeys: ["token.actionDisabled.usage_0", "token.actionDisabled.usage_1"],
            doKeys: ["token.actionDisabled.do_0"],
            dontKeys: ["token.actionDisabled.dont_0"],
            hig: .accessibilityContrast
        ),
        .init(
            id: "actionDisabledContent", name: "Disabled Content", color: ZodiakColors.actionDisabledContent,
            primitiveRef: "colorset · adaptável",
            isAdaptive: true, category: .action,
            intent: "Conteúdo (ícone/texto) sobre elementos desabilitados.",
            usageKeys: ["token.actionDisabledContent.usage_0", "token.actionDisabledContent.usage_1"],
            doKeys: ["token.actionDisabledContent.do_0"],
            dontKeys: ["token.actionDisabledContent.dont_0"],
            hig: .accessibilityContrast
        ),
        .init(
            id: "actionActive", name: "Active", color: ZodiakColors.actionActive,
            primitiveRef: "colorset (fixo)",
            isAdaptive: false, category: .action,
            intent: "Cor de seleção ativa — tabs, chips e toggles no estado selecionado.",
            usageKeys: ["token.actionActive.usage_0", "token.actionActive.usage_1", "token.actionActive.usage_2"],
            doKeys: ["token.actionActive.do_0"],
            dontKeys: ["token.actionActive.dont_0"],
            hig: .interactiveColor
        ),
        .init(
            id: "actionFocus", name: "Focus onLite", color: ZodiakColors.actionFocus,
            primitiveRef: "colorset · adaptável",
            isAdaptive: true, category: .action,
            intent: "Anel de foco — acessibilidade de teclado e VoiceOver.",
            usageKeys: ["token.actionFocus.usage_0", "token.actionFocus.usage_1", "token.actionFocus.usage_2"],
            doKeys: ["token.actionFocus.do_0", "token.actionFocus.do_1"],
            dontKeys: ["token.actionFocus.dont_0"],
            hig: .accessibilityContrast
        ),
        .init(
            id: "actionFocusOnHeavy", name: "Focus onHeavy", color: ZodiakColors.actionFocusOnHeavy,
            primitiveRef: "colorset · adaptável",
            isAdaptive: true, category: .action,
            intent: "Anel de foco em superfícies onHeavy.",
            usageKeys: ["token.actionFocusOnHeavy.usage_0"],
            doKeys: ["token.actionFocusOnHeavy.do_0"],
            dontKeys: ["token.actionFocusOnHeavy.dont_0"],
            hig: .accessibilityContrast
        ),
        .init(
            id: "actionPrimaryOnPhoto", name: "Primary onPhoto", color: ZodiakColors.actionPrimaryOnPhoto,
            primitiveRef: "White · fixo",
            isAdaptive: false, category: .action,
            intent: "Ação primária sobre imagem fotográfica — branco fixo sobre qualquer foto.",
            usageKeys: ["token.actionPrimaryOnPhoto.usage_0", "token.actionPrimaryOnPhoto.usage_1"],
            doKeys: ["token.actionPrimaryOnPhoto.do_0"],
            dontKeys: ["token.actionPrimaryOnPhoto.dont_0"],
            hig: .interactiveColor
        ),
        .init(
            id: "actionWarning", name: "Warning Default", color: ZodiakColors.actionWarning,
            primitiveRef: "Red.shade500 / White · adaptável",
            isAdaptive: true, category: .actionWarning,
            intent: "Cor primária de ações de aviso — botão warning. Vermelho no Zodiak.",
            usageKeys: ["token.actionWarning.usage_0", "token.actionWarning.usage_1"],
            doKeys: ["token.actionWarning.do_0"],
            dontKeys: ["token.actionWarning.dont_0"],
            hig: .interactiveColor
        ),
        .init(
            id: "actionWarningContent", name: "Warning Content", color: ZodiakColors.actionWarningContent,
            primitiveRef: "colorset · adaptável",
            isAdaptive: true, category: .actionWarning,
            intent: "Texto/ícone sobre fundo de warning — contraste adequado sobre actionWarning.",
            usageKeys: ["token.actionWarningContent.usage_0"],
            doKeys: ["token.actionWarningContent.do_0"],
            dontKeys: [],
            hig: .interactiveColor
        ),
        .init(
            id: "actionWarningHover", name: "Warning Hover", color: ZodiakColors.actionWarningHover,
            primitiveRef: "colorset · adaptável",
            isAdaptive: true, category: .actionWarning,
            intent: "Estado de hover do botão de aviso.",
            usageKeys: ["token.actionWarningHover.usage_0"],
            doKeys: ["token.actionWarningHover.do_0"],
            dontKeys: [],
            hig: .interactiveColor
        ),
        .init(
            id: "actionWarningHoverOutline", name: "Warning Hover Outline", color: ZodiakColors.actionWarningHoverOutline,
            primitiveRef: "colorset · adaptável",
            isAdaptive: true, category: .actionWarning,
            intent: "Borda do botão warning secundário em hover.",
            usageKeys: ["token.actionWarningHoverOutline.usage_0"],
            doKeys: ["token.actionWarningHoverOutline.do_0"],
            dontKeys: [],
            hig: .interactiveColor
        ),
        .init(
            id: "actionWarningPressed", name: "Warning Pressed", color: ZodiakColors.actionWarningPressed,
            primitiveRef: "colorset · adaptável",
            isAdaptive: true, category: .actionWarning,
            intent: "Estado pressionado do botão de aviso.",
            usageKeys: ["token.actionWarningPressed.usage_0"],
            doKeys: ["token.actionWarningPressed.do_0"],
            dontKeys: [],
            hig: .interactiveColor
        ),
        .init(
            id: "actionWarningPressedOutline", name: "Warning Pressed Outline", color: ZodiakColors.actionWarningPressedOutline,
            primitiveRef: "colorset · adaptável",
            isAdaptive: true, category: .actionWarning,
            intent: "Borda do botão warning secundário em pressed.",
            usageKeys: ["token.actionWarningPressedOutline.usage_0"],
            doKeys: ["token.actionWarningPressedOutline.do_0"],
            dontKeys: [],
            hig: .interactiveColor
        ),
        .init(
            id: "actionWarningSecondary", name: "Warning Secondary Default", color: ZodiakColors.actionWarningSecondary,
            primitiveRef: "colorset · adaptável",
            isAdaptive: true, category: .actionWarning,
            intent: "Botão warning secundário (outline) — estado default.",
            usageKeys: ["token.actionWarningSecondary.usage_0"],
            doKeys: ["token.actionWarningSecondary.do_0"],
            dontKeys: [],
            hig: .interactiveColor
        ),
        .init(
            id: "actionWarningSecondaryHover", name: "Warning Secondary Hover", color: ZodiakColors.actionWarningSecondaryHover,
            primitiveRef: "colorset · adaptável",
            isAdaptive: true, category: .actionWarning,
            intent: "Estado de hover do botão de aviso secundário.",
            usageKeys: ["token.actionWarningSecondaryHover.usage_0"],
            doKeys: ["token.actionWarningSecondaryHover.do_0"],
            dontKeys: [],
            hig: .interactiveColor
        ),
        .init(
            id: "actionPrimaryOnHeavy", name: "Primary Default onHeavy", color: ZodiakColors.actionPrimaryOnHeavy,
            primitiveRef: "White · #ffffff (fixo)",
            isAdaptive: false, category: .action,
            intent: "Ação primária em superfícies onHeavy — branco invariante para máximo contraste.",
            usageKeys: ["token.actionPrimaryOnHeavy.usage_0", "token.actionPrimaryOnHeavy.usage_1"],
            doKeys: ["token.actionPrimaryOnHeavy.do_0"],
            dontKeys: ["token.actionPrimaryOnHeavy.dont_0"],
            hig: .interactiveColor
        ),
        .init(
            id: "actionHoverOnHeavy", name: "Primary Hover onHeavy", color: ZodiakColors.actionHoverOnHeavy,
            primitiveRef: "colorset · adaptável",
            isAdaptive: true, category: .action,
            intent: "Estado de hover para ações em superfícies escuras.",
            usageKeys: ["token.actionHoverOnHeavy.usage_0"],
            doKeys: ["token.actionHoverOnHeavy.do_0"],
            dontKeys: [],
            hig: .interactiveColor
        ),
        .init(
            id: "actionPressedOnHeavy", name: "Primary Pressed onHeavy", color: ZodiakColors.actionPressedOnHeavy,
            primitiveRef: "colorset (fixo)",
            isAdaptive: false, category: .action,
            intent: "Estado pressionado de ações em superfícies escuras.",
            usageKeys: ["token.actionPressedOnHeavy.usage_0"],
            doKeys: ["token.actionPressedOnHeavy.do_0"],
            dontKeys: [],
            hig: .interactiveColor
        ),

        // MARK: Borders (2)

        .init(
            id: "borderPrimary", name: "Primary", color: ZodiakColors.borderPrimary,
            primitiveRef: "colorset · adaptável",
            isAdaptive: true, category: .border,
            intent: "Borda padrão — divisores, contornos de cards e campos de formulário.",
            usageKeys: ["token.borderPrimary.usage_0", "token.borderPrimary.usage_1", "token.borderPrimary.usage_2"],
            doKeys: ["token.borderPrimary.do_0"],
            dontKeys: ["token.borderPrimary.dont_0", "token.borderPrimary.dont_1"],
            hig: .materials
        ),
        .init(
            id: "borderSecondary", name: "Secondary", color: ZodiakColors.borderSecondary,
            primitiveRef: "colorset · adaptável",
            isAdaptive: true, category: .border,
            intent: "Borda sutil — separadores de menor hierarquia.",
            usageKeys: ["token.borderSecondary.usage_0", "token.borderSecondary.usage_1"],
            doKeys: ["token.borderSecondary.do_0"],
            dontKeys: ["token.borderSecondary.dont_0"],
            hig: .materials
        ),

        // MARK: Overlays (2)

        .init(
            id: "pageOverlay", name: "Page Overlay", color: ZodiakColors.pageOverlay,
            primitiveRef: "rgba(23, 26, 34, 0.4) · fixo",
            isAdaptive: false, category: .overlay,
            intent: "Scrim semitransparente para modais e gavetas.",
            usageKeys: ["token.pageOverlay.usage_0", "token.pageOverlay.usage_1", "token.pageOverlay.usage_2"],
            doKeys: ["token.pageOverlay.do_0"],
            dontKeys: ["token.pageOverlay.dont_0", "token.pageOverlay.dont_1"],
            hig: .materials
        ),
        .init(
            id: "heroPhotographic", name: "Hero Photographic", color: ZodiakColors.heroPhotographic,
            primitiveRef: "Overlay.black75 · fixo",
            isAdaptive: false, category: .overlay,
            intent: "Overlay fotográfico — gradiente escuro sobre imagens hero para legibilidade do texto.",
            usageKeys: ["token.heroPhotographic.usage_0"],
            doKeys: ["token.heroPhotographic.do_0"],
            dontKeys: ["token.heroPhotographic.dont_0"],
            hig: .materials
        )
    ]
}
// swiftlint:enable file_length type_body_length line_length
