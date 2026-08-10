import SwiftUI

// MARK: - FlagsGalleryView

struct FlagsGalleryView: View {
    @State private var searchText = ""
    @State private var selectedSize: ZodiakFlagSize = .small

    private var filteredCountries: [ZodiakFlagCountry] {
        guard !searchText.isEmpty else { return ZodiakFlagCountry.allCases }
        return ZodiakFlagCountry.allCases.filter {
            $0.displayName.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        ZodiakGalleryShell(spacing: ZodiakSpacing.s24) {
            galleryHeader(
                title: "catalog.home.flags",
                // swiftlint:disable:next line_length
                subtitle: "\(ZodiakFlagCountry.allCases.count) países. Uma bandeira deve sempre ser acompanhada de um rótulo de texto.",
                figmaRef: "40006001:13620"
            )

            specSection

            ZodiakSearchField(
                text: $searchText,
                placeholder: "catalog.home.search_country_placeholder"
            )

            if filteredCountries.isEmpty {
                ZodiakEmptyState(
                    icon: "magnifyingglass",
                    title: "catalog.home.no_country_found",
                    description: "Tente outro nome."
                )
            } else {
                flagList
            }
        }
        .zodiakPage(title: "catalog.home.flags")
    }

    // MARK: - Spec section

    private var specSection: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            ZodiakText("catalog.section.sizes", style: .title2)
            HStack(spacing: ZodiakSpacing.s4) {
                ForEach([ZodiakFlagSize.xSmall, .small, .medium, .large], id: \.flagDimension) { size in
                    Button {
                        selectedSize = size
                    } label: {
                        Text("\(Int(size.flagDimension))pt")
                            .font(ZodiakTypography.captionLarge)
                            .foregroundStyle(selectedSize.flagDimension == size.flagDimension
                                ? ZodiakColors.actionPrimary
                                : ZodiakColors.textSecondary)
                            .padding(.horizontal, ZodiakSpacing.s8)
                            .padding(.vertical, ZodiakSpacing.s4)
                            .background(
                                selectedSize.flagDimension == size.flagDimension
                                    ? ZodiakColors.actionPrimary.opacity(0.1)
                                    : ZodiakColors.background
                            )
                            .cornerRadius(ZodiakRadii.l)
                    }
                    .buttonStyle(.plain)
                }
                Spacer()
            }
        }
    }

    // MARK: - Flag list

    private var flagList: some View {
        LazyVStack(alignment: .leading, spacing: 0) {
            ForEach(filteredCountries, id: \.imageName) { country in
                ZodiakFlagView(country, size: selectedSize, label: country.displayName)
                    .padding(.horizontal, ZodiakSpacing.s8)
                    .padding(.vertical, ZodiakSpacing.s4)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(ZodiakColors.surface)

                ZodiakDivider(hierarchy: .secondary)
            }
        }
        .cornerRadius(ZodiakRadii.s)
    }
}

#Preview {
    NavigationStack {
        FlagsGalleryView()
            .environmentObject(CatalogViewModel())
    }
}
