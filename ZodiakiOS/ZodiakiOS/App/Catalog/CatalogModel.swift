// Reason: Catalog data model with ExampleItem static data — data-only extension.
// swiftlint:disable file_length
import SwiftUI

// MARK: - Catalog Section

enum CatalogSection: String, CaseIterable, Identifiable {
    case tokens       = "catalog.home.tab_tokens"
    case components   = "catalog.home.tab_components"
    case compositions = "catalog.section.compositions"
    case visualAssets = "catalog.section.visual_assets"
    case examples     = "catalog.home.tab_examples"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .tokens:       return "square.3.layers.3d"
        case .components:   return "puzzlepiece.extension"
        case .compositions: return "rectangle.3.group"
        case .visualAssets: return "photo.stack"
        case .examples:     return "iphone"
        }
    }
}

// MARK: - Catalog Item

// swiftlint:disable type_body_length
// Reason: Exhaustive CatalogItem enum — each case maps a catalog entry; cannot be split further.
enum CatalogItem: String, CaseIterable, Identifiable, Hashable {
    // Tokens
    case colors      = "feature.theme_toggle.colors_section"
    case typography  = "catalog.component.typography"
    case spacing     = "catalog.component.spacing"
    case radii       = "catalog.component.radii_shadows"
    case shadows     = "catalog.component.shadows"
    case borders     = "catalog.component.borders"
    case blur        = "catalog.component.blur"

    // Atoms
    case buttons        = "catalog.component.buttons"
    case iconButtons    = "catalog.component.icon_buttons"
    case filterButton   = "catalog.component.filter_button"
    case menuButton     = "catalog.component.menu_button"
    case systemButtons  = "catalog.component.system_buttons"
    case warningButtons = "catalog.component.warning_buttons"
    case systemWarningButtons = "catalog.component.system_warning_buttons"
    case arrowButton    = "catalog.component.arrow_button"
    case mediaButton    = "catalog.component_name.media_button"
    case videoPreviewButton = "catalog.component_name.video_preview_button"
    case texts          = "catalog.component.texts"
    case badges         = "catalog.component_name.badges"
    case textFields     = "catalog.component_name.text_fields"
    case passwordField  = "catalog.component.password_field"
    case tabs           = "catalog.component_name.tabs"
    case avatar             = "catalog.component_name.avatar"
    case searchField        = "catalog.component_name.search_field"
    case progressIndicator  = "catalog.component_name.progress_indicator"
    case radioButton        = "catalog.component_name.radio_button"
    case tooltip            = "catalog.component_name.tooltip"
    case breadcrumbPagination = "catalog.component_name.breadcrumb_pagination"
    case rating             = "catalog.component_name.rating"
    case list               = "catalog.component_name.list"
    case sliderCounter      = "catalog.component_name.slider_counter"
    case eyebrow            = "catalog.component_name.eyebrow"

    // Molecules
    case labelledFields = "catalog.component.labelled_fields"
    case resultCards    = "catalog.component.result_cards"
    case counter        = "catalog.component.counter"
    case toggle         = "catalog.component_name.toggle"
    case chip           = "catalog.component_name.chip"

    // Organisms
    case formContainers = "catalog.section.form_containers"
    case infoRow        = "catalog.component_name.info_row"
    case modal          = "catalog.component_name.modal"
    case showMore       = "catalog.component_name.show_more"

    // Templates
    case templates = "catalog.section_name.templates"

    // Utilities
    case modifiers = "catalog.section.view_modifiers"

    // New atoms (from Figma)
    case phoneInput     = "catalog.component.phone_field"
    case chipGroup      = "catalog.component.chip_group"
    case slideToSubmit  = "catalog.component_name.slide_to_submit"

    // New organisms (from Figma)
    case cardGrid       = "catalog.component_name.card_grid"
    case downloadButton = "catalog.component.download_button"

    // Phase 4 — Atoms
    case alert              = "catalog.component_name.alert"
    case accordion          = "catalog.component_name.accordion"
    case stepIndicator      = "catalog.component_name.step_indicator"

    // Missing atoms — dedicated galleries
    case checkbox           = "catalog.component_name.checkbox"
    case textLink           = "catalog.component_name.text_link"
    case miniMenu           = "catalog.component_name.mini_menu"
    case navButtons         = "catalog.component_name.nav_buttons"

    // Phase 4 — Organisms
    case toast              = "catalog.component_name.toast"
    case emptyState         = "catalog.component_name.empty_state"
    case skeletonLoader     = "catalog.component_name.skeleton_loader"

    // Phase 5 — Atoms
    case banner = "catalog.component_name.banner"

    // Content compositions
    case contentCompositions = "catalog.section.content_compositions"

    // Phase 6 — Organisms
    case actionCompositions = "catalog.composition_name.action_compositions"
    case pin                = "catalog.component_name.pin"
    case cardVariants       = "catalog.composition_name.card_variants"

    // Card Variants — individual
    case authorCard         = "catalog.component_name.author_card"
    case horizontalCard     = "catalog.component_name.horizontal_card"
    case tallCard           = "catalog.component_name.tall_card"
    case typographicCard    = "catalog.component_name.typographic_card"
    case revealCard         = "catalog.component_name.reveal_card"
    case shortFactsCard     = "catalog.component_name.short_facts_card"

    // Phase 6 — Molecules
    case inputWizard = "catalog.composition_name.input_wizard"

    // Content Display — Atoms removed (moved to Atoms block)

    // Phase 7 — Atoms (Buttons) removed (moved to Atoms block)

    // Phase 7 — Atoms (Navigation) removed (moved to Atoms block)

    // Phase 7 — Molecules (Input)
    case combobox            = "catalog.component_name.combobox"
    case dropdown            = "catalog.component_name.dropdown"
    case multiselect         = "catalog.component_name.multiselect"
    case notice              = "catalog.component_name.notice"
    case quickAccessBar      = "catalog.component_name.quick_access_bar"

    // Phase 7 — Organisms (Utilities)
    case share               = "catalog.component_name.share"
    case formInDrawer        = "catalog.component_name.form_in_drawer"
    case loginForm           = "catalog.component_name.login_form"
    case notificationBanner  = "catalog.component_name.notification_banner"

    // Visual Assets
    case icons              = "catalog.home.icons"
    case flags              = "catalog.home.flags"
    case logos              = "catalog.home.logos"

    // Compositions
    case heroCompositions        = "catalog.section.hero_compositions"
    case typographicCompositions = "catalog.section.typographic_compositions"
    case cardGridCompositions    = "catalog.section.card_grid_compositions"
    case imageCompositions       = "catalog.section.image_compositions"
    case mediaCompositions       = "catalog.section.media_compositions"
    case actionRibbons           = "catalog.section.action_ribbons"

    // Foundations (Tokens — ausentes)
    case accessibility = "catalog.section.accessibility"
    case sizing        = "catalog.section.sizing"
    case layoutGrid    = "catalog.section.layout_grid"

    var id: String { rawValue }

    var section: CatalogSection {
        switch self {
        case .colors, .typography, .spacing, .radii, .shadows, .borders, .blur,
             .accessibility, .sizing, .layoutGrid:
            return .tokens

        case .buttons, .texts, .badges, .textFields, .tabs,
             .iconButtons, .passwordField, .filterButton, .menuButton, .systemButtons,
             .warningButtons, .systemWarningButtons, .arrowButton,
             .avatar, .searchField, .progressIndicator,
             .radioButton, .tooltip, .breadcrumbPagination, .rating,
             .list,
             .mediaButton, .videoPreviewButton, .sliderCounter, .eyebrow,
             .labelledFields, .resultCards, .counter, .toggle, .chip,
             .phoneInput, .chipGroup, .slideToSubmit, .inputWizard,
             .combobox, .dropdown, .multiselect, .notice, .quickAccessBar,
             .alert, .accordion, .stepIndicator,
             .checkbox, .textLink, .miniMenu, .navButtons,
             .formContainers, .infoRow, .modal, .showMore, .cardGrid, .downloadButton,
             .toast, .emptyState, .skeletonLoader, .banner, .contentCompositions,
             .actionCompositions, .pin, .cardVariants,
             .authorCard, .horizontalCard, .tallCard,
             .typographicCard, .revealCard, .shortFactsCard,
             .share, .formInDrawer, .loginForm, .notificationBanner,
             .templates, .modifiers:
            return .components

        case .icons, .flags, .logos:
            return .visualAssets

        case .heroCompositions, .typographicCompositions, .cardGridCompositions,
             .imageCompositions, .mediaCompositions, .actionRibbons:
            return .compositions
        }
    }

    var subsection: String? {
        switch self {
        case .colors, .typography, .spacing, .radii, .shadows, .borders, .blur,
             .accessibility, .sizing, .layoutGrid:
            return nil

        case .buttons, .texts, .badges, .textFields, .tabs,
             .iconButtons, .passwordField, .filterButton, .menuButton, .systemButtons,
             .warningButtons, .systemWarningButtons, .arrowButton,
             .avatar, .searchField, .progressIndicator,
             .radioButton, .tooltip, .breadcrumbPagination, .rating,
             .list,
             .mediaButton, .videoPreviewButton, .sliderCounter, .eyebrow,
             .checkbox, .textLink, .miniMenu, .navButtons:
            return "catalog.section_name.atoms"

        case .labelledFields, .resultCards, .counter, .toggle, .chip,
             .phoneInput, .chipGroup, .slideToSubmit, .inputWizard,
             .combobox, .dropdown, .multiselect, .notice, .quickAccessBar,
             .alert, .accordion, .stepIndicator:
            return "catalog.section_name.molecules"

        case .formContainers, .infoRow, .modal, .showMore, .cardGrid, .downloadButton,
             .toast, .emptyState, .skeletonLoader, .banner, .contentCompositions,
             .actionCompositions, .pin, .cardVariants,
             .authorCard, .horizontalCard, .tallCard,
             .typographicCard, .revealCard, .shortFactsCard,
             .share, .formInDrawer, .loginForm, .notificationBanner:
            return "catalog.section_name.organisms"

        case .templates:
            return "catalog.section_name.templates"

        case .modifiers:
            return "catalog.section_name.utilities"

        case .icons, .flags, .logos:
            return nil

        case .heroCompositions, .typographicCompositions, .cardGridCompositions,
             .imageCompositions, .mediaCompositions, .actionRibbons:
            return nil
        }
    }

    /// Ícone Zodiak personalizado — substitui o SF Symbol quando presente.
    var zodiakIcon: ZodiakIcon? {
        switch self {
        case .chip:      return .tag
        case .chipGroup: return .tag
        default:         return nil
        }
    }

    var icon: String {
        switch self {
        case .colors:         return "paintpalette"
        case .typography:     return "textformat"
        case .spacing:        return "ruler"
        case .radii:          return "square.on.square"
        case .shadows:        return "shadow"
        case .borders:        return "rectangle.inset.filled"
        case .blur:           return "aqi.medium"
        case .buttons:        return "hand.tap"
        case .texts:          return "text.alignleft"
        case .badges:         return "tag"
        case .textFields:     return "rectangle.and.pencil.and.ellipsis"
        case .tabs:           return "rectangle.split.3x1"
        case .labelledFields: return "list.bullet.rectangle"
        case .resultCards:    return "rectangle.on.rectangle"
        case .counter:        return "plusminus"
        case .toggle:         return "switch.2"
        case .chip:           return "tag"
        case .chipGroup:      return "tag.fill"
        case .formContainers: return "rectangle.stack"
        case .infoRow:        return "info.circle"
        case .modal:          return "square.on.square.dashed"
        case .showMore:       return "chevron.down.circle"
        case .templates:      return "doc.richtext"
        case .modifiers:      return "wand.and.stars"
        case .iconButtons:    return "circle.grid.2x2"
        case .passwordField:  return "eye.slash"
        case .filterButton:   return "slider.horizontal.3"
        case .menuButton:     return "ellipsis.circle"
        case .systemButtons:  return "cpu"
        case .warningButtons:  return "exclamationmark.triangle"
        case .systemWarningButtons: return "exclamationmark.triangle.fill"
        case .arrowButton:       return "arrow.right"
        case .phoneInput:     return "phone"
        case .slideToSubmit:  return "arrow.right.circle"
        case .cardGrid:          return "square.grid.2x2"
        case .downloadButton:    return "arrow.down.circle"
        case .avatar:            return "person.crop.circle"
        case .searchField:       return "magnifyingglass"
        case .progressIndicator: return "chart.bar"
        case .alert:             return "exclamationmark.triangle"
        case .accordion:         return "chevron.down.square"
        case .stepIndicator:     return "list.number"
        case .checkbox:          return "checkmark.square"
        case .textLink:          return "link"
        case .miniMenu:          return "ellipsis.circle"
        case .navButtons:        return "arrow.right.circle"
        case .toast:             return "rectangle.and.text.magnifyingglass"
        case .emptyState:        return "tray"
        case .skeletonLoader:    return "rectangle.dashed"
        case .radioButton:           return "circle.inset.filled"
        case .tooltip:               return "info.bubble"
        case .breadcrumbPagination:  return "chevron.right.2"
        case .rating:                return "star"
        case .banner:                return "megaphone"
        case .contentCompositions:   return "rectangle.stack.badge.play"
        case .actionCompositions:    return "link"
        case .pin:                   return "mappin.circle"
        case .cardVariants:          return "rectangle.grid.2x2"
        case .authorCard:            return "person.text.rectangle"
        case .horizontalCard:        return "rectangle.leadinghalf.inset.filled"
        case .tallCard:              return "rectangle.portrait.fill"
        case .typographicCard:       return "doc.text"
        case .revealCard:            return "eye.fill"
        case .shortFactsCard:        return "number.square"
        case .inputWizard:           return "list.clipboard"
        case .list:                  return "list.bullet"
        case .mediaButton:           return "play.circle"
        case .videoPreviewButton:    return "video.circle"
        case .sliderCounter:         return "slider.horizontal.below.rectangle"
        case .eyebrow:               return "text.alignleft"
        case .combobox:              return "magnifyingglass.circle"
        case .dropdown:              return "chevron.down.circle"
        case .multiselect:           return "checklist"
        case .notice:                return "exclamationmark.bubble"
        case .quickAccessBar:        return "rectangle.and.hand.point.up.left"
        case .share:                 return "square.and.arrow.up"
        case .formInDrawer:          return "sidebar.right"
        case .loginForm:             return "lock.rectangle"
        case .notificationBanner:    return "bell.badge"
        case .icons:                 return "square.grid.2x2"
        case .flags:                 return "flag"
        case .logos:                 return "building.2"
        case .heroCompositions:        return "rectangle.expand.diagonal"
        case .typographicCompositions: return "text.quote"
        case .cardGridCompositions:    return "rectangle.grid.2x2"
        case .imageCompositions:       return "photo.on.rectangle"
        case .mediaCompositions:       return "play.rectangle.on.rectangle"
        case .actionRibbons:           return "link.badge.plus"
        case .accessibility:           return "accessibility"
        case .sizing:                  return "ruler.fill"
        case .layoutGrid:              return "grid"
        }
    }

    var subtitle: String {
        switch self {
        case .colors:               return "catalog.item.colors.subtitle"
        case .typography:           return "catalog.item.typography.subtitle"
        case .spacing:              return "catalog.item.spacing.subtitle"
        case .radii:                return "catalog.item.radii.subtitle"
        case .shadows:              return "catalog.item.shadows.subtitle"
        case .borders:              return "catalog.item.borders.subtitle"
        case .blur:                 return "catalog.item.blur.subtitle"
        case .buttons:              return "catalog.item.buttons.subtitle"
        case .texts:                return "catalog.item.texts.subtitle"
        case .badges:               return "catalog.item.badges.subtitle"
        case .textFields:           return "catalog.item.text_fields.subtitle"
        case .tabs:                 return "catalog.item.tabs.subtitle"
        case .labelledFields:       return "catalog.item.labelled_fields.subtitle"
        case .resultCards:          return "catalog.item.result_cards.subtitle"
        case .counter:              return "catalog.item.counter.subtitle"
        case .toggle:               return "catalog.item.toggle.subtitle"
        case .chip:                 return "catalog.item.chip.subtitle"
        case .formContainers:       return "catalog.item.form_containers.subtitle"
        case .infoRow:              return "catalog.item.info_row.subtitle"
        case .modal:                return "catalog.item.modal.subtitle"
        case .showMore:             return "catalog.item.show_more.subtitle"
        case .templates:            return "catalog.item.templates.subtitle"
        case .modifiers:            return "catalog.item.modifiers.subtitle"
        case .iconButtons:          return "catalog.item.icon_buttons.subtitle"
        case .passwordField:        return "catalog.item.password_field.subtitle"
        case .filterButton:         return "catalog.item.filter_button.subtitle"
        case .menuButton:           return "catalog.item.menu_button.subtitle"
        case .systemButtons:        return "catalog.item.system_buttons.subtitle"
        case .warningButtons:       return "catalog.item.warning_buttons.subtitle"
        case .systemWarningButtons: return "catalog.item.system_warning_buttons.subtitle"
        case .arrowButton:          return "catalog.item.arrow_button.subtitle"
        case .phoneInput:           return "catalog.item.phone_input.subtitle"
        case .chipGroup:            return "catalog.item.chip_group.subtitle"
        case .slideToSubmit:        return "catalog.item.slide_to_submit.subtitle"
        case .cardGrid:             return "catalog.item.card_grid.subtitle"
        case .downloadButton:       return "catalog.item.download_button.subtitle"
        case .avatar:               return "catalog.item.avatar.subtitle"
        case .searchField:          return "catalog.item.search_field.subtitle"
        case .progressIndicator:    return "catalog.item.progress_indicator.subtitle"
        case .alert:                return "catalog.item.alert.subtitle"
        case .accordion:            return "catalog.item.accordion.subtitle"
        case .stepIndicator:        return "catalog.item.step_indicator.subtitle"
        case .checkbox:             return "catalog.item.checkbox.subtitle"
        case .textLink:             return "catalog.item.text_link.subtitle"
        case .miniMenu:             return "catalog.item.mini_menu.subtitle"
        case .navButtons:           return "catalog.item.nav_buttons.subtitle"
        case .toast:                return "catalog.item.toast.subtitle"
        case .emptyState:           return "catalog.item.empty_state.subtitle"
        case .skeletonLoader:       return "catalog.item.skeleton_loader.subtitle"
        case .radioButton:          return "catalog.item.radio_button.subtitle"
        case .tooltip:              return "catalog.item.tooltip.subtitle"
        case .breadcrumbPagination: return "catalog.item.breadcrumb_pagination.subtitle"
        case .rating:               return "catalog.item.rating.subtitle"
        case .banner:               return "catalog.item.banner.subtitle"
        case .contentCompositions:  return "catalog.item.content_compositions.subtitle"
        case .actionCompositions:   return "catalog.item.action_compositions.subtitle"
        case .pin:                  return "catalog.item.pin.subtitle"
        case .cardVariants:         return "catalog.item.card_variants.subtitle"
        case .inputWizard:          return "catalog.item.input_wizard.subtitle"
        case .list:                 return "catalog.item.list.subtitle"
        case .mediaButton:          return "catalog.item.media_button.subtitle"
        case .videoPreviewButton:   return "catalog.item.video_preview_button.subtitle"
        case .sliderCounter:        return "catalog.item.slider_counter.subtitle"
        case .eyebrow:              return "catalog.item.eyebrow.subtitle"
        case .combobox:             return "catalog.item.combobox.subtitle"
        case .dropdown:             return "catalog.item.dropdown.subtitle"
        case .multiselect:          return "catalog.item.multiselect.subtitle"
        case .notice:               return "catalog.item.notice.subtitle"
        case .quickAccessBar:       return "catalog.item.quick_access_bar.subtitle"
        case .share:                return "catalog.item.share.subtitle"
        case .formInDrawer:         return "catalog.item.form_in_drawer.subtitle"
        case .loginForm:            return "catalog.item.login_form.subtitle"
        case .notificationBanner:   return "catalog.item.notification_banner.subtitle"
        case .authorCard:           return "catalog.item.author_card.subtitle"
        case .horizontalCard:       return "catalog.item.horizontal_card.subtitle"
        case .tallCard:             return "catalog.item.tall_card.subtitle"
        case .typographicCard:      return "catalog.item.typographic_card.subtitle"
        case .revealCard:           return "catalog.item.reveal_card.subtitle"
        case .shortFactsCard:       return "catalog.item.short_facts_card.subtitle"
        case .icons:                return "catalog.item.icons.subtitle"
        case .flags:                return "catalog.item.flags.subtitle"
        case .logos:                return "catalog.item.logos.subtitle"
        case .heroCompositions:        return "catalog.item.hero_compositions.subtitle"
        case .typographicCompositions: return "catalog.item.typographic_compositions.subtitle"
        case .cardGridCompositions:    return "catalog.item.card_grid_compositions.subtitle"
        case .imageCompositions:       return "catalog.item.image_compositions.subtitle"
        case .mediaCompositions:       return "catalog.item.media_compositions.subtitle"
        case .actionRibbons:           return "catalog.item.action_ribbons.subtitle"
        case .accessibility:           return "catalog.item.accessibility.subtitle"
        case .sizing:                  return "catalog.item.sizing.subtitle"
        case .layoutGrid:              return "catalog.item.layout_grid.subtitle"
        }
    }
}
// swiftlint:enable type_body_length

// MARK: - Navigation Destination

enum CatalogDestination: Hashable {
    case home
    case item(CatalogItem)
    case examples
}

// MARK: - Catalog Section Grouping

extension CatalogSection {
    var items: [CatalogItem] {
        CatalogItem.allCases
            .filter { $0.section == self }
            .sorted {
                String(localized: String.LocalizationValue($0.rawValue)) <
                String(localized: String.LocalizationValue($1.rawValue))
            }
    }
}

// MARK: - Example Item

struct ExampleItem: Identifiable {
    let id: Int
    let title: String
    let description: String
    let icon: String
    let zodiakComponents: [String]
}

extension ExampleItem {
    static let all: [ExampleItem] = [
        ExampleItem(
            id: 1,
            title: "catalog.examples.grades.name",
            description: "catalog.examples.grades.desc",
            icon: "graduationcap",
            zodiakComponents: [
                "ZodiakActivityTemplate",
                "ZodiakFormWrapper",
                "ZodiakLabelledField",
                "ZodiakLabelledNumericField",
                "ZodiakButton",
                "ZodiakResultCard",
                "ZodiakSuccessBadge",
                "ZodiakErrorBadge"
            ]
        ),
        ExampleItem(
            id: 2,
            title: "catalog.examples.pix.name",
            description: "catalog.examples.pix.desc",
            icon: "brazilianrealsign.circle",
            zodiakComponents: [
                "ZodiakActivityTemplate",
                "ZodiakSwitch",
                "ZodiakWarningBadge",
                "ZodiakResultCard",
                "ZodiakButton"
            ]
        ),
        ExampleItem(
            id: 3,
            title: "catalog.examples.voting.name",
            description: "catalog.examples.voting.desc",
            icon: "checkmark.seal",
            zodiakComponents: [
                "ZodiakActivityTemplate",
                "ZodiakButton",
                "ZodiakWarningBadge",
                "ZodiakSuccessBadge",
                "ZodiakResultCard",
                "ZodiakInfoRow"
            ]
        ),
        ExampleItem(
            id: 4,
            title: "catalog.examples.palindrome.name",
            description: "catalog.examples.palindrome.desc",
            icon: "arrow.left.arrow.right",
            zodiakComponents: [
                "ZodiakActivityTemplate",
                "ZodiakLabelledField",
                "ZodiakButton",
                "ZodiakResultCardWithBadge",
                "ZodiakInfoRow"
            ]
        ),
        ExampleItem(
            id: 5,
            title: "catalog.examples.guess.name",
            description: "catalog.examples.guess.desc",
            icon: "questionmark.circle",
            zodiakComponents: [
                "ZodiakActivityTemplate",
                "ZodiakCounterControl",
                "ZodiakLabelledField",
                "ZodiakButton",
                "ZodiakResultCard"
            ]
        ),
        ExampleItem(
            id: 6,
            title: "catalog.examples.multiplication.name",
            description: "catalog.examples.multiplication.desc",
            icon: "multiply",
            zodiakComponents: [
                "ZodiakActivityTemplate",
                "ZodiakLabelledNumericField",
                "ZodiakButton",
                "ZodiakInfoRow",
                "ZodiakText"
            ]
        ),
        ExampleItem(
            id: 7,
            title: "catalog.examples.person_manager.name",
            description: "catalog.examples.person_manager.desc",
            icon: "person.2",
            zodiakComponents: ["ZodiakText", "ZodiakFormWrapper", "ZodiakLabelledField", "ZodiakButton", "ZodiakText"]
        ),
        ExampleItem(
            id: 8,
            title: "catalog.examples.temperature.name",
            description: "catalog.examples.temperature.desc",
            icon: "thermometer.medium",
            zodiakComponents: [
                "ZodiakActivityTemplate",
                "ZodiakLabelledNumericField",
                "ZodiakResultCard",
                "ZodiakSecondaryButton"
            ]
        ),
        ExampleItem(
            id: 9,
            title: "catalog.examples.task_manager.name",
            description: "catalog.examples.task_manager.desc",
            icon: "checklist",
            zodiakComponents: [
                "ZodiakText",
                "ZodiakFormWrapper",
                "ZodiakLabelledField",
                "ZodiakButton",
                "ZodiakLabelledCheckbox"
            ]
        ),
        ExampleItem(
            id: 10,
            title: "catalog.examples.quiz_game.name",
            description: "catalog.examples.quiz_game.desc",
            icon: "brain.head.profile",
            zodiakComponents: [
                "ZodiakAdaptiveTemplate",
                "ZodiakFormContainer",
                "ZodiakTabContainer",
                "ZodiakButton",
                "ZodiakText"
            ]
        ),
        ExampleItem(
            id: 11,
            title: "catalog.examples.student_grades.name",
            description: "catalog.examples.student_grades.desc",
            icon: "person.text.rectangle",
            zodiakComponents: [
                "ZodiakActivityTemplate",
                "ZodiakAccordion",
                "ZodiakChip",
                "ZodiakInfoRow",
                "NavigationStack"
            ]
        ),
        ExampleItem(
            id: 12,
            title: "catalog.examples.product_manager.name",
            description: "catalog.examples.product_manager.desc",
            icon: "shippingbox",
            zodiakComponents: [
                "ZodiakActivityTemplate",
                "ZodiakTabs",
                "ZodiakDropdown",
                "ZodiakAccordion",
                "ZodiakInfoRow"
            ]
        ),
        ExampleItem(
            id: 13,
            title: "catalog.examples.card_manager.name",
            description: "catalog.examples.card_manager.desc",
            icon: "creditcard",
            zodiakComponents: [
                "ZodiakActivityTemplate",
                "ZodiakModal",
                "ZodiakInfoRow"
            ]
        ),
        ExampleItem(
            id: 14,
            title: "catalog.examples.shop_master.name",
            description: "catalog.examples.shop_master.desc",
            icon: "cart.badge.plus",
            zodiakComponents: [
                "ZodiakActivityTemplate",
                "ZodiakTabs",
                "ZodiakBadge",
                "ZodiakEmptyState",
                "Combine"
            ]
        ),
        ExampleItem(
            id: 15,
            title: "catalog.examples.userdefaults_login.name",
            description: "catalog.examples.userdefaults_login.desc",
            icon: "person.badge.key",
            zodiakComponents: [
                "ZodiakLoginForm",
                "ZodiakResultCard",
                "@AppStorage"
            ]
        ),
        ExampleItem(
            id: 16,
            title: "catalog.examples.book_reader.name",
            description: "catalog.examples.book_reader.desc",
            icon: "book.pages",
            zodiakComponents: [
                "ZodiakActivityTemplate",
                "ZodiakText",
                "ZodiakSecondaryButton",
                "@AppStorage"
            ]
        ),
        ExampleItem(
            id: 17,
            title: "catalog.examples.currency_converter.name",
            description: "catalog.examples.currency_converter.desc",
            icon: "dollarsign.arrow.circlepath",
            zodiakComponents: [
                "ZodiakActivityTemplate",
                "ZodiakDropdown",
                "ZodiakLabelledNumericField",
                "ZodiakResultCard",
                "ZodiakIconButton",
                "ZodiakSecondaryButton"
            ]
        ),
        ExampleItem(
            id: 18,
            title: "catalog.examples.expense_manager.name",
            description: "catalog.examples.expense_manager.desc",
            icon: "house.and.flag",
            zodiakComponents: [
                "ZodiakActivityTemplate",
                "ZodiakTabs",
                "ZodiakDropdown",
                "ZodiakResultCard",
                "ZodiakInfoRow",
                "SwiftData"
            ]
        ),
        ExampleItem(
            id: 19,
            title: "catalog.examples.hangman.name",
            description: "catalog.examples.hangman.desc",
            icon: "questionmark.circle",
            zodiakComponents: [
                "ZodiakActivityTemplate",
                "ZodiakLayoutGrid",
                "ZodiakResultCard",
                "ZodiakButton",
                "ZodiakText"
            ]
        ),
        ExampleItem(
            id: 20,
            title: "catalog.examples.contacts.name",
            description: "catalog.examples.contacts.desc",
            icon: "person.2",
            zodiakComponents: [
                "ZodiakActivityTemplate",
                "ZodiakFormWrapper",
                "ZodiakLabelledField",
                "ZodiakSwitch",
                "ZodiakAvatar",
                "SwiftData",
                "ViaCEPService"
            ]
        ),
        ExampleItem(
            id: 28,
            title: "catalog.examples.solutions_catalog.name",
            description: "catalog.examples.solutions_catalog.desc",
            icon: "books.vertical",
            zodiakComponents: [
                "ZodiakActivityTemplate",
                "ZodiakHero",
                "ZodiakChipGroup",
                "ZodiakTypographicCardGrid",
                "ZodiakHorizontalCardList",
                "ZodiakKeyFigures",
                "ZodiakList",
                "ZodiakAuthor",
                "Combine"
            ]
        ),
        ExampleItem(
            id: 30,
            title: "catalog.examples.loyaltyprogram.name",
            description: "catalog.examples.loyaltyprogram.desc",
            icon: "star.circle.fill",
            zodiakComponents: [
                "ZodiakKeyFigures",
                "ZodiakTallCard",
                "ZodiakArrowButton",
                "ZodiakSlideToSubmit",
                "ZodiakModal",
                "ZodiakStepIndicator",
                "ZodiakChipGroup",
                "ZodiakMultiselect",
                "ZodiakTabs",
                "ZodiakShowMore",
                "ZodiakEmptyState"
            ]
        )
    ]
}
