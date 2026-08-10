import SwiftUI

// MARK: - IconsGalleryView

struct IconsGalleryView: View {
    @StateObject private var viewModel = IconsGalleryViewModel()
    @Environment(\.horizontalSizeClass) private var hSizeClass
    @Environment(\.verticalSizeClass) private var vSizeClass
    @Environment(\.locale) private var locale

    private var isLandscape: Bool { vSizeClass == .compact && hSizeClass == .compact }

    // Resolves the correct .lproj bundle for the injected locale (respects in-app switcher).
    private var localizedBundle: Bundle {
        let localeId = locale.identifier.replacingOccurrences(of: "_", with: "-")
        let langCode = String(localeId.prefix(2))
        for code in [localeId, langCode] {
            if let path = Bundle.main.path(forResource: code, ofType: "lproj"),
               let bundle = Bundle(path: path) { return bundle }
        }
        return Bundle.main
    }

    private var categoryTabLabels: [String] {
        let bundle = localizedBundle
        return IconCategory.allCases.map { category in
            let label = bundle.localizedString(forKey: category.tabKey, value: category.tabKey, table: "Localizable")
            guard category != .all else { return label }
            let count = IconsGalleryViewModel.categoryCounts[category] ?? 0
            return "\(label) (\(count))"
        }
    }

    private var iconSubtitle: String {
        // String(localized:locale:) only affects value formatting, not table lookup.
        // Load the .lproj bundle explicitly to respect the in-app locale switcher.
        let bundle = localizedBundle
        let format = bundle.localizedString(
            forKey: "catalog.home.icons_subtitle",
            value: nil,
            table: "Localizable"
        )
        return String(format: format, ZodiakIcon.allCases.count)
    }

    var body: some View {
        ZodiakGalleryShell(spacing: ZodiakSpacing.s24) {
            galleryHeader(
                title: "catalog.home.icons",
                subtitleText: Text(verbatim: iconSubtitle),
                figmaRef: "40000103:1838"
            )

            specSection

            ZodiakTabs(
                tabs: categoryTabLabels,
                selectedIndex: $viewModel.selectedCategoryIndex,
                size: .small
            )
            .padding(.horizontal, ZodiakSpacing.screenPad)

            ZodiakSearchField(text: $viewModel.searchText, placeholder: "catalog.home.search_icon_placeholder")
                .padding(.horizontal, ZodiakSpacing.screenPad)

            Group {
                if viewModel.filteredIcons.isEmpty {
                    ZodiakEmptyState(
                        icon: "magnifyingglass",
                        title: "catalog.home.no_icons_found",
                        description: "catalog.home.no_icons_description"
                    )
                    .transition(.opacity)
                } else {
                    iconGrid
                        .transition(.opacity)
                }
            }
            .animation(.spring(response: 0.25, dampingFraction: 0.85), value: viewModel.filteredIcons.count)
            .animation(.spring(response: 0.25, dampingFraction: 0.85), value: viewModel.selectedCategoryIndex)
            .animation(.spring(response: 0.35, dampingFraction: 0.8), value: viewModel.selectedSize.dimension)
        }
        .zodiakPage(title: "catalog.home.icons")
        .zodiakContentBlur(isActive: viewModel.selectedIcon != nil)
        .overlay {
            if viewModel.selectedIcon != nil {
                iconDetailOverlay
            }
        }
        .animation(.spring(response: 0.3, dampingFraction: 0.85), value: viewModel.selectedIcon != nil)
    }

    @ViewBuilder
    private var iconDetailOverlay: some View {
        GeometryReader { geo in
            ZStack {
                ZodiakBlur.pageOverlay
                    .ignoresSafeArea()
                    .overlay(ZodiakBlur.colorOverlay)
                    .onTapGesture { withAnimation { viewModel.selectedIcon = nil } }

                if let icon = viewModel.selectedIcon {
                    VStack(spacing: 0) {
                        HStack {
                            Spacer()
                            ZodiakCloseButton { withAnimation { viewModel.selectedIcon = nil } }
                        }
                        .padding([.top, .horizontal], ZodiakSpacing.s8)

                        IconDetailSheet(icon: icon)
                    }
                    .background(ZodiakColors.surface.opacity(0.85))
                    .cornerRadius(ZodiakRadii.m)
                    .shadow(
                        color: ZodiakShadows.color,
                        radius: ZodiakShadows.radius,
                        x: ZodiakShadows.x,
                        y: ZodiakShadows.y
                    )
                    .frame(
                        maxWidth: (hSizeClass == .regular || isLandscape) ? 560 : .infinity,
                        maxHeight: isLandscape ? geo.size.height - ZodiakSpacing.s48 : .infinity
                    )
                    .padding(ZodiakSpacing.s16)
                    .transition(.scale(scale: 0.95).combined(with: .opacity))
                }
            }
        }
        .transition(.opacity)
    }

    // MARK: - Spec section

    private var specSection: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            ZodiakText("catalog.section.configuracao", style: .title2)

            ZodiakFormWrapper {
                // Size row
                HStack(alignment: .center, spacing: ZodiakSpacing.s8) {
                    ZodiakText("catalog.spec.lbl.size", style: .caption(color: .secondary))
                        .frame(width: 60, alignment: .leading)
                    HStack(spacing: ZodiakSpacing.s4) {
                        ForEach(IconsGalleryViewModel.allSizes, id: \.dimension) { size in
                            ZodiakChip(
                                verbatim: "\(Int(size.dimension))pt",
                                isActive: size.dimension == viewModel.selectedSize.dimension,
                                onTap: { withAnimation(.easeInOut(duration: 0.2)) { viewModel.selectedSize = size } }
                            )
                        }
                    }
                    Spacer()
                }

                ZodiakDivider(hierarchy: .secondary)

                // Color row
                HStack(alignment: .center, spacing: ZodiakSpacing.s8) {
                    ZodiakText("catalog.spec.lbl.cor", style: .caption(color: .secondary))
                        .frame(width: 60, alignment: .leading)
                    HStack(spacing: ZodiakSpacing.s16) {
                        ForEach(IconsGalleryViewModel.colorVariants.indices, id: \.self) { index in
                            let isSelected = index == viewModel.selectedColorIndex
                            Button {
                                withAnimation(.easeInOut(duration: 0.2)) { viewModel.selectedColorIndex = index }
                            } label: {
                                Circle()
                                    .fill(IconsGalleryViewModel.colorVariants[index].color)
                                    .frame(width: 24, height: 24)
                                    .overlay(Circle().strokeBorder(
                                        ZodiakColors.borderPrimary.opacity(0.4), lineWidth: 0.5
                                    ))
                                    .padding(2)
                                    .overlay(
                                        Circle()
                                            .strokeBorder(
                                                isSelected ? ZodiakColors.actionPrimary : Color.clear,
                                                lineWidth: 2
                                            )
                                    )
                            }
                            .buttonStyle(.plain)
                            .accessibilityLabel(Text(verbatim: IconsGalleryViewModel.colorVariants[index].label))
                            .accessibilityAddTraits(isSelected ? .isSelected : [])
                        }
                    }
                    Spacer()
                }

                ZodiakDivider(hierarchy: .secondary)

                // Spec info
                VStack(spacing: ZodiakSpacing.s4) {
                    ZodiakInfoRow(
                        label: "catalog.spec.lbl.size",
                        value: "\(Int(viewModel.selectedSize.dimension))×\(Int(viewModel.selectedSize.dimension))pt",
                        style: .spec()
                    )
                    ZodiakInfoRow(
                        label: "catalog.spec.lbl.stroke",
                        value: String(format: "%.1f", viewModel.selectedSize.strokeWidth) + "pt",
                        style: .spec()
                    )
                    ZodiakInfoRow(
                        label: "catalog.spec.lbl.color",
                        value: viewModel.previewColorLabel,
                        style: .spec()
                    )
                }
                .id("\(viewModel.selectedSize.dimension)-\(viewModel.selectedColorIndex)")
                .transition(.opacity)
            }
        }
        .padding(.horizontal, ZodiakSpacing.screenPad)
    }

    // MARK: - Icon grid

    private var iconGrid: some View {
        ZodiakLayoutGrid(
            columns: isLandscape ? viewModel.selectedSize.preferredGridColumnsLandscape
                                 : viewModel.selectedSize.preferredGridColumns,
            horizontalSpacing: ZodiakSpacing.s8,
            verticalSpacing: ZodiakSpacing.s8
        ) {
            ForEach(viewModel.filteredIcons, id: \.rawValue) { icon in
                iconCell(icon)
            }
        }
    }

    private func iconCell(_ icon: ZodiakIcon) -> some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                viewModel.selectedIcon = icon
            }
        } label: {
            VStack(spacing: ZodiakSpacing.s4) {
                Spacer(minLength: 0)
                ZodiakIconView(icon, size: viewModel.selectedSize, color: viewModel.previewColor)
                    .animation(.spring(response: 0.3, dampingFraction: 0.75), value: viewModel.selectedSize.dimension)
                    .animation(.easeInOut(duration: 0.2), value: viewModel.selectedColorIndex)
                ZodiakText(verbatim: icon.accessibilityLabel, style: viewModel.selectedSize.preferredLabelStyle)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .frame(maxWidth: .infinity)
                    .animation(.easeInOut(duration: 0.2), value: viewModel.selectedSize.dimension)
                Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(ZodiakSpacing.s8)
            .background(ZodiakColors.surface)
            .cornerRadius(ZodiakRadii.s)
            .aspectRatio(1.0, contentMode: .fill)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .hoverEffect(.lift)
        .accessibilityLabel(icon.accessibilityLabel)
        .accessibilityHint(Text("catalog.home.icon_cell_hint"))
    }
}

// MARK: - ZodiakIconSize + Gallery

private extension ZodiakIconSize {
    /// Estilo tipográfico do label dos cards de ícone, escala com o tamanho selecionado.
    var preferredLabelStyle: ZodiakTextViewStyle {
        switch self {
        case .small, .medium, .large: return .caption(color: .secondary)
        case .xLarge:                 return .bodySmall(color: .secondary)
        }
    }

    /// Número de colunas da grid adaptado ao tamanho do ícone.
    /// Colunas menores = ícones menores → mais colunas (mais densidade).
    /// Colunas maiores = ícones maiores → menos colunas (mais respiro).
    var preferredGridColumns: Int {
        switch self {
        case .small:  return 5
        case .medium: return 4
        case .large:  return 4
        case .xLarge: return 3
        }
    }

    /// Colunas em landscape iPhone — viewport mais largo, mais densidade.
    var preferredGridColumnsLandscape: Int {
        switch self {
        case .small:  return 8
        case .medium: return 6
        case .large:  return 5
        case .xLarge: return 4
        }
    }
}

#Preview {
    NavigationStack {
        IconsGalleryView()
            .environmentObject(CatalogViewModel())
    }
}
