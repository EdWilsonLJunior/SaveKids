// swiftlint:disable file_length
// Reason: Router view with per-item @ViewBuilder sub-functions — single responsibility.
import SwiftUI
import UIKit

// MARK: - Sidebar Storage Keys

private enum SidebarKey {
    static let tokens       = "sidebar.tokens.expanded"
    static let atoms        = "sidebar.atoms.expanded"
    static let molecules    = "sidebar.molecules.expanded"
    static let organisms    = "sidebar.organisms.expanded"
    static let compositions = "sidebar.compositions.expanded"
    static let utilities    = "sidebar.utilities.expanded"
    static let visualAssets = "sidebar.visualAssets.expanded"
    static let examples     = "sidebar.examples.expanded"
}

// MARK: - Main Catalog View (NavigationSplitView)

struct MainTabView: View {
    @StateObject private var catalog = CatalogViewModel()
    @AppStorage("appLanguage") private var appLanguage: String = "system"
    @State private var columnVisibility: NavigationSplitViewVisibility = .automatic

    // MARK: - Color Scheme

    private func applyWindowColorScheme(_ isDark: Bool, animated: Bool) {
        guard let window = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first?.keyWindow else { return }
        let style: UIUserInterfaceStyle = isDark ? .dark : .light
        if animated {
            UIView.transition(with: window, duration: 0.35, options: .transitionCrossDissolve) {
                window.overrideUserInterfaceStyle = style
            }
        } else {
            window.overrideUserInterfaceStyle = style
        }
    }

    private var currentLocale: Locale {        switch appLanguage {
        case "pt-BR":
            return Locale(identifier: "pt-BR")

        case "en":
            return Locale(identifier: "en")

        default:
            return Locale.autoupdatingCurrent
        }
    }

    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            CatalogSidebarView(appLanguage: $appLanguage)
                .environmentObject(catalog)
                .environment(\.hasCatalogToolbar, true)
        } detail: {
            CatalogDetailRouter()
                .environmentObject(catalog)
                .environment(\.hasCatalogToolbar, true)
                .id(appLanguage)
                .transition(.opacity)
        }
        .navigationSplitViewStyle(.balanced)
        .environment(\.locale, currentLocale)
        .onAppear { applyWindowColorScheme(catalog.isDarkMode, animated: false) }
        .onChange(of: catalog.isDarkMode) { _, newValue in applyWindowColorScheme(newValue, animated: true) }
    }
}

// MARK: - Sidebar

private struct CatalogSidebarView: View {
    @EnvironmentObject private var catalog: CatalogViewModel
    @Binding var appLanguage: String
    @Environment(\.locale) private var locale

    // MARK: Disclosure State
    @AppStorage(SidebarKey.tokens)       private var tokensExpanded: Bool = false
    @AppStorage(SidebarKey.atoms)        private var atomsExpanded: Bool = true
    @AppStorage(SidebarKey.molecules)    private var moleculesExpanded: Bool = false
    @AppStorage(SidebarKey.organisms)    private var organismsExpanded: Bool = false
    @AppStorage(SidebarKey.compositions) private var compositionsExpanded: Bool = false
    @AppStorage(SidebarKey.utilities)    private var utilitiesExpanded: Bool = false
    @AppStorage(SidebarKey.visualAssets) private var visualAssetsExpanded: Bool = false
    @AppStorage(SidebarKey.examples)     private var examplesExpanded: Bool = false

    private var languageLabel: String {
        switch appLanguage {
        case "pt-BR": return "app.settings.lang_pt_br"
        case "en": return "app.settings.lang_en"
        default: return "app.settings.follow_system"
        }
    }

    private func isSelected(_ destination: CatalogDestination) -> Bool {
        switch (catalog.selectedItem, destination) {
        case (.none, .home), (.some(.home), .home):
            return true

        case (.some(let selected), let destination):
            return selected == destination

        default:
            return false
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            ZodiakSearchField(
                text: $catalog.searchQuery,
                placeholder: "catalog.home.search_placeholder"
            )
            .padding(.horizontal, ZodiakSpacing.s16)
            .padding(.vertical, ZodiakSpacing.s8)
            .background(ZodiakColors.surface)

            ZodiakDivider(hierarchy: .primary)

            List(selection: $catalog.selectedItem) {
                if !catalog.searchQuery.trimmingCharacters(in: .whitespaces).isEmpty {
                    searchContent(locale: locale)
                } else {
                    browseContent()
                }
            }
            .listStyle(.sidebar)
            .scrollContentBackground(.hidden)
            .background(ZodiakColors.background)
            .animation(.easeInOut(duration: 0.2), value: catalog.searchQuery)
        }
        .background(ZodiakColors.background)
        .navigationTitle("catalog.home.zodiak_ds_short")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(ZodiakColors.background, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .settingsToolbar()
    }
}

// MARK: - Sidebar Helpers

private extension CatalogSidebarView {
    // MARK: Search Content

    @ViewBuilder
    func searchContent(locale: Locale) -> some View {
        if catalog.searchResults.isEmpty {
            let noResultText = String(
                format: String(localized: "catalog.home.no_results", locale: locale),
                catalog.searchQuery
            )
            ZodiakText(verbatim: noResultText, style: .caption(color: .secondary))
                .listRowBackground(Color.clear)
                .accessibilityLabel(Text(verbatim: noResultText))
                .transition(.opacity)
        } else {
            ForEach(catalog.groupedSearchResults, id: \.subsection) { group in
                Section {
                    ForEach(group.items) { item in sidebarRow(item) }
                } header: {
                    CatalogSidebarSectionHeader(title: LocalizedStringKey(group.subsection))
                }
            }
        }
    }

    // MARK: Browse Content

    @ViewBuilder
    func browseContent() -> some View {
        CatalogSidebarRow(
            title: LocalizedStringKey("app.tab.overview"),
            systemImage: "house",
            isSelected: isSelected(.home)
        )
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets())
        .accessibilityLabel(Text("app.tab.overview"))
        .accessibilityHint(Text("catalog.home.nav_home_accessibility"))
        .tag(CatalogDestination.home)

        DisclosureGroup(isExpanded: $tokensExpanded) {
            ForEach(catalog.items(for: .tokens)) { item in sidebarRow(item) }
        } label: {
            SidebarDisclosureLabel(
                icon: "paintpalette",
                title: "catalog.home.tab_tokens",
                count: catalog.items(for: .tokens).count
            )
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets())

        componentDisclosureGroups()
        assetExamplesSections()
    }

    @ViewBuilder
    func componentDisclosureGroups() -> some View {
        DisclosureGroup(isExpanded: $atomsExpanded) {
            ForEach(catalog.atomItems) { item in sidebarRow(item) }
        } label: {
            SidebarDisclosureLabel(
                icon: "atom",
                title: "catalog.section_name.atoms",
                count: catalog.atomItems.count
            )
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets())

        DisclosureGroup(isExpanded: $moleculesExpanded) {
            ForEach(catalog.moleculeItems) { item in sidebarRow(item) }
        } label: {
            SidebarDisclosureLabel(
                icon: "circle.grid.cross",
                title: "catalog.section_name.molecules",
                count: catalog.moleculeItems.count
            )
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets())

        DisclosureGroup(isExpanded: $organismsExpanded) {
            ForEach(catalog.organismItems) { item in sidebarRow(item) }
        } label: {
            SidebarDisclosureLabel(
                icon: "square.stack.3d.up",
                title: "catalog.section_name.organisms",
                count: catalog.organismItems.count
            )
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets())
    }

    @ViewBuilder
    func assetExamplesSections() -> some View {
        utilitiesCompositionsGroups()
        visualAssetsExamplesGroups()
    }

    @ViewBuilder
    func utilitiesCompositionsGroups() -> some View {
        DisclosureGroup(isExpanded: $utilitiesExpanded) {
            ForEach(catalog.utilityItems) { item in sidebarRow(item) }
        } label: {
            SidebarDisclosureLabel(
                icon: "wrench.and.screwdriver",
                title: "catalog.section_name.utilities",
                count: catalog.utilityItems.count
            )
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets())

        DisclosureGroup(isExpanded: $compositionsExpanded) {
            ForEach(catalog.compositionItems) { item in sidebarRow(item) }
        } label: {
            SidebarDisclosureLabel(
                icon: "rectangle.3.group",
                title: "catalog.section.compositions",
                count: catalog.compositionItems.count
            )
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets())
    }

    @ViewBuilder
    func visualAssetsExamplesGroups() -> some View {
        DisclosureGroup(isExpanded: $visualAssetsExpanded) {
            ForEach(catalog.items(for: .visualAssets)) { item in sidebarRow(item) }
        } label: {
            SidebarDisclosureLabel(
                icon: "photo.on.rectangle",
                title: "catalog.section.visual_assets",
                count: catalog.items(for: .visualAssets).count
            )
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets())

        DisclosureGroup(isExpanded: $examplesExpanded) {
            CatalogSidebarRow(
                title: LocalizedStringKey("catalog.home.view_all"),
                systemImage: "iphone",
                isSelected: isSelected(.examples)
            )
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets())
            .tag(CatalogDestination.examples)
        } label: {
            SidebarDisclosureLabel(
                icon: "iphone",
                title: "catalog.home.tab_examples",
                count: ExampleItem.all.count
            )
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets())
    }

    @ViewBuilder
    func sidebarRow(_ item: CatalogItem) -> some View {
        CatalogSidebarRow(
            title: LocalizedStringKey(item.rawValue),
            systemImage: item.icon,
            zodiakIcon: item.zodiakIcon,
            isSelected: isSelected(.item(item))
        )
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets())
        .tag(CatalogDestination.item(item))
    }
}

private struct CatalogSidebarSectionHeader: View {
    let title: LocalizedStringKey

    var body: some View {
        ZodiakText(title, style: .caption(color: .secondary))
            .textCase(.uppercase)
            .padding(.top, ZodiakSpacing.s4)
    }
}

private struct SidebarDisclosureLabel: View {
    let icon: String
    let title: String
    let count: Int

    var body: some View {
        HStack(spacing: ZodiakSpacing.s4) {
            Image(systemName: icon)
                .font(ZodiakTypography.captionLarge)
                .foregroundColor(ZodiakColors.textSecondary)
                .frame(width: 16)

            ZodiakText(LocalizedStringKey(title), style: .caption(color: .secondary))
                .textCase(.uppercase)

            Spacer(minLength: 0)

            Text(verbatim: "\(count)")
                .font(ZodiakTypography.captionLarge)
                .foregroundColor(ZodiakColors.actionPrimary)
                .padding(.horizontal, ZodiakSpacing.s4)
                .padding(.vertical, ZodiakSpacing.s4)
                .background(
                    RoundedRectangle(cornerRadius: ZodiakRadii.l)
                        .fill(ZodiakColors.actionPrimary.opacity(0.12))
                )
        }
        .padding(.top, ZodiakSpacing.s4)
    }
}

private struct CatalogSidebarRow: View {
    let title: LocalizedStringKey
    let systemImage: String
    var zodiakIcon: ZodiakIcon?
    var isSelected: Bool = false

    var body: some View {
        HStack(spacing: ZodiakSpacing.s8) {
            iconView
                .frame(width: 20)

            ZodiakText(title, style: .bodySmall())
                .foregroundColor(isSelected ? ZodiakColors.actionPrimary : ZodiakColors.textPrimary)

            Spacer(minLength: 0)
        }
        .padding(.horizontal, ZodiakSpacing.s8)
        .padding(.vertical, ZodiakSpacing.s8)
        .background(
            RoundedRectangle(cornerRadius: ZodiakRadii.s, style: .continuous)
                .fill(isSelected ? ZodiakColors.actionPrimary.opacity(0.12) : Color.clear)
        )
        .contentShape(Rectangle())
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }

    @ViewBuilder
    private var iconView: some View {
        let color = isSelected ? ZodiakColors.actionPrimary : ZodiakColors.textSecondary
        if let zodiakIcon {
            Image(zodiakIcon.imageName)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .foregroundColor(color)
                .frame(width: 16, height: 16)
        } else {
            Image(systemName: systemImage)
                .font(ZodiakTypography.bodySmall)
                .foregroundColor(color)
        }
    }
}

// MARK: - Detail Router

private struct CatalogDetailRouter: View {
    @EnvironmentObject private var catalog: CatalogViewModel

    var body: some View {
        Group {
            switch catalog.selectedItem {
            case .none, .some(.home):
                CatalogHomeView()

            case .some(.examples):
                NavigationStack { ExamplesListView() }

            case .some(.item(let catalogItem)):
                itemView(for: catalogItem)
            }
        }
        .environmentObject(catalog)
        .settingsToolbar()
    }

    // MARK: - Item View Router

    @ViewBuilder
    private func itemView(for item: CatalogItem) -> some View {
        switch item {
        case .colors, .typography, .spacing, .radii, .shadows, .borders, .blur,
             .accessibility, .sizing, .layoutGrid:
            tokenItemView(for: item)

        case .buttons, .texts, .badges, .textFields, .tabs,
             .iconButtons, .passwordField, .filterButton, .menuButton, .systemButtons,
             .warningButtons, .systemWarningButtons, .arrowButton:
            atomItemViewA(for: item)

        case .avatar, .searchField, .progressIndicator,
             .radioButton, .tooltip, .breadcrumbPagination,
             .rating, .list, .mediaButton, .videoPreviewButton, .sliderCounter, .eyebrow,
             .checkbox, .textLink, .miniMenu, .navButtons:
            atomItemViewB(for: item)

        case .labelledFields, .resultCards, .counter, .toggle, .chip, .phoneInput:
            moleculeItemViewA(for: item)

        case .chipGroup, .slideToSubmit, .inputWizard,
             .combobox, .dropdown, .multiselect, .notice, .quickAccessBar,
             .alert, .accordion, .stepIndicator:
            moleculeItemViewB(for: item)

        case .formContainers, .infoRow, .modal, .showMore,
             .cardGrid, .downloadButton, .toast, .emptyState, .skeletonLoader:
            organismItemViewA(for: item)

        case .banner, .contentCompositions, .actionCompositions,
             .pin, .cardVariants, .share, .formInDrawer, .loginForm, .notificationBanner,
             .authorCard, .horizontalCard, .tallCard,
             .typographicCard, .revealCard, .shortFactsCard:
            organismItemViewB(for: item)

        case .templates, .modifiers:
            utilityItemView(for: item)

        case .icons, .flags, .logos:
            visualAssetView(for: item)

        case .heroCompositions, .typographicCompositions, .cardGridCompositions,
             .imageCompositions, .mediaCompositions, .actionRibbons:
            compositionItemView(for: item)
        }
    }

    // MARK: - Token Views

    // swiftlint:disable cyclomatic_complexity
    // Reason: Exhaustive token routing switch — one case per foundation token gallery.
    @ViewBuilder
    private func tokenItemView(for item: CatalogItem) -> some View {
        switch item {
        case .colors:        NavigationStack { ColorsGalleryView() }
        case .typography:    TypographyGalleryView()
        case .spacing:       SpacingGalleryView()
        case .radii:         RadiiGalleryView()
        case .shadows:       ShadowsGalleryView()
        case .borders:       BordersGalleryView()
        case .blur:          BlurGalleryView()
        case .accessibility: AccessibilityGalleryView()
        case .sizing:        SizingGalleryView()
        case .layoutGrid:    LayoutGridGalleryView()
        default:             RadiiGalleryView()
        }
    }
    // swiftlint:enable cyclomatic_complexity

    // MARK: - Atom Views

    @ViewBuilder
    private func atomItemViewA(for item: CatalogItem) -> some View {
        switch item {
        case .buttons:        ButtonsGalleryView()
        case .texts:          TextsGalleryView()
        case .badges:         BadgesGalleryView()
        case .textFields:     TextFieldsGalleryView()
        case .tabs:           TabsGalleryView()
        case .iconButtons:    IconButtonsGalleryView()
        case .passwordField:  PasswordFieldGalleryView()
        default:              atomItemViewButtons(for: item)
        }
    }

    @ViewBuilder
    private func atomItemViewButtons(for item: CatalogItem) -> some View {
        switch item {
        case .filterButton:   FilterButtonGalleryView()
        case .menuButton:     MenuButtonGalleryView()
        case .systemButtons:  SystemButtonsGalleryView()
        case .warningButtons: WarningButtonsGalleryView()
        case .systemWarningButtons: SystemWarningButtonsGalleryView()
        case .arrowButton:    CardArrowIndicatorGalleryView()
        default:              SystemButtonsGalleryView()
        }
    }

    @ViewBuilder
    private func atomItemViewB(for item: CatalogItem) -> some View {
        switch item {
        case .avatar, .searchField, .progressIndicator,
             .radioButton, .tooltip, .breadcrumbPagination:
            atomItemViewB1(for: item)

        case .checkbox, .textLink, .miniMenu, .navButtons:
            atomItemViewC(for: item)

        default:
            atomItemViewB2(for: item)
        }
    }

    @ViewBuilder
    private func atomItemViewB1(for item: CatalogItem) -> some View {
        switch item {
        case .avatar:                AvatarGalleryView()
        case .searchField:           SearchFieldGalleryView()
        case .progressIndicator:     ProgressIndicatorGalleryView()
        case .radioButton:           RadioButtonGalleryView()
        case .tooltip:               TooltipGalleryView()
        default:                     BreadcrumbPaginationGalleryView()
        }
    }

    @ViewBuilder
    private func atomItemViewB2(for item: CatalogItem) -> some View {
        switch item {
        case .rating:             RatingGalleryView()
        case .list:               ListGalleryView()
        case .mediaButton:        MediaButtonGalleryView()
        case .videoPreviewButton: VideoPreviewButtonGalleryView()
        case .eyebrow:            EyebrowGalleryView()
        default:                  SliderCounterGalleryView()
        }
    }

    @ViewBuilder
    private func atomItemViewC(for item: CatalogItem) -> some View {
        switch item {
        case .checkbox:  CheckboxGalleryView()
        case .textLink:  TextLinkGalleryView()
        case .miniMenu:  MiniMenuGalleryView()
        default:         NavButtonsGalleryView()
        }
    }

    // MARK: - Molecule Views

    @ViewBuilder
    private func moleculeItemViewA(for item: CatalogItem) -> some View {
        switch item {
        case .labelledFields:  LabelledFieldGalleryView()
        case .resultCards:     ResultCardGalleryView()
        case .counter:         CounterGalleryView()
        case .toggle:          SwitchGalleryView()
        case .chip:            ChipGalleryView()
        default:               PhoneInputGalleryView()
        }
    }

    @ViewBuilder
    // Reason: exhaustive routing switch — one case per catalog gallery item
    // swiftlint:disable:next cyclomatic_complexity
    private func moleculeItemViewB(for item: CatalogItem) -> some View {
        switch item {
        case .chipGroup:       ChipGroupGalleryView()
        case .slideToSubmit:   SlideToSubmitGalleryView()
        case .inputWizard:     InputWizardGalleryView()
        case .combobox:        ComboboxGalleryView()
        case .dropdown:        DropdownGalleryView()
        case .multiselect:     MultiselectGalleryView()
        case .notice:          NoticeGalleryView()
        case .quickAccessBar:  QuickAccessBarGalleryView()
        case .alert:           AlertGalleryView()
        case .accordion:       AccordionGalleryView()
        default:               StepIndicatorGalleryView()
        }
    }

    // MARK: - Organism Views

    @ViewBuilder
    private func organismItemViewA(for item: CatalogItem) -> some View {
        switch item {
        case .formContainers:  FormContainerGalleryView()
        case .infoRow:         InfoRowGalleryView()
        case .modal:           ModalGalleryView()
        case .showMore:        ShowMoreGalleryView()
        case .cardGrid:        CardGridGalleryView()
        case .downloadButton:  DownloadButtonGalleryView()
        case .toast:           ToastGalleryView()
        case .emptyState:      EmptyStateGalleryView()
        default:               SkeletonLoaderGalleryView()
        }
    }

    @ViewBuilder
    // Reason: exhaustive routing switch — one case per catalog gallery item
    // swiftlint:disable:next cyclomatic_complexity
    private func organismItemViewB(for item: CatalogItem) -> some View {
        switch item {
        case .banner:               BannerGalleryView()
        case .contentCompositions:  ContentCompositionsGalleryView()
        case .actionCompositions:   ActionCompositionsGalleryView()
        case .pin:                  PinGalleryView()
        case .cardVariants:         CardVariantsGalleryView()
        case .authorCard:           AuthorCardGalleryView()
        case .horizontalCard:       HorizontalCardGalleryView()
        case .tallCard:             TallCardGalleryView()
        case .typographicCard:      TypographicCardGalleryView()
        case .revealCard:           RevealCardGalleryView()
        case .shortFactsCard:       ShortFactsCardGalleryView()
        case .share:                ShareGalleryView()
        case .formInDrawer:         FormInDrawerGalleryView()
        case .notificationBanner:   NotificationBannerGalleryView()
        default:                    LoginFormGalleryView()
        }
    }

    // MARK: - Utility & Visual Asset Views

    @ViewBuilder
    private func utilityItemView(for item: CatalogItem) -> some View {
        switch item {
        case .templates:  TemplatesGalleryView()
        default:          ModifiersGalleryView()
        }
    }

    @ViewBuilder
    private func visualAssetView(for item: CatalogItem) -> some View {
        switch item {
        case .icons:   IconsGalleryView()
        case .flags:   FlagsGalleryView()
        default:       LogosGalleryView()
        }
    }

    // MARK: - Composition Views

    @ViewBuilder
    private func compositionItemView(for item: CatalogItem) -> some View {
        switch item {
        case .heroCompositions:        HeroCompositionsGalleryView()
        case .typographicCompositions: TypographicCompositionsGalleryView()
        case .cardGridCompositions:    CardGridCompositionsGalleryView()
        case .imageCompositions:       ImageCompositionsGalleryView()
        case .mediaCompositions:       MediaCompositionsGalleryView()
        default:                       ActionRibbonsGalleryView()
        }
    }
}

#Preview {
    MainTabView()
}
