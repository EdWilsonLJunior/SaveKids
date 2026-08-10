import SwiftUI

// MARK: - Show More Background Variant
/// Background context for ZodiakShowMore button color.
/// - `onLite`: light surfaces — uses `actionPrimary`
/// - `onHeavy`: dark/heavy surfaces — uses `actionPrimaryOnHeavy`
/// - `onPhoto`: photographic backgrounds — uses `actionPrimaryOnHeavy` (tertiary unavailable)
enum ZodiakShowMoreBgVariant {
    case onLite, onHeavy, onPhoto
}

// MARK: - Show More Hierarchy
/// Visual emphasis of the show more toggle button.
/// - `secondary`: `button-text-regular` (16pt) · icon M
/// - `tertiary`: `button-text-small` (14pt) · icon S — default
enum ZodiakShowMoreHierarchy {
    case secondary, tertiary
}

// MARK: - Zodiak Show More
// Figma: "Show more" component
// Reveals a list of items progressively. First N items shown, rest hidden behind
// an expandable "shared.action.show_more" / "shared.action.show_less" toggle.
// Anatomy: 1 — Icon · 2 — Label (spec order).
// Used in listing pages, card grids, and long repeated content.

struct ZodiakShowMore<Item: Identifiable, Row: View>: View {
    let items: [Item]
    var initialCount: Int = 3
    var showLabel: LocalizedStringKey = "shared.action.show_more"
    var hideLabel: LocalizedStringKey = "shared.action.show_less"
    var bgVariant: ZodiakShowMoreBgVariant = .onLite
    var hierarchy: ZodiakShowMoreHierarchy = .tertiary
    @ViewBuilder let row: (Item) -> Row

    @State private var isExpanded: Bool = false

    private var visibleItems: [Item] {
        isExpanded ? items : Array(items.prefix(initialCount))
    }

    private var hasMore: Bool {
        items.count > initialCount
    }

    private var resolvedColor: Color {
        switch bgVariant {
        case .onLite:            return ZodiakColors.actionPrimary
        case .onHeavy, .onPhoto: return ZodiakColors.actionPrimaryOnHeavy
        }
    }

    private var resolvedFont: Font {
        hierarchy == .secondary ? ZodiakTypography.button : ZodiakTypography.bodySmall
    }

    private var resolvedIconSize: CGFloat {
        hierarchy == .secondary ? 14 : 12
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Rows
            ForEach(visibleItems) { item in
                row(item)
            }

            // Toggle button — Anatomy: Icon (1) · Label (2)
            if hasMore {
                Button {
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                        isExpanded.toggle()
                    }
                } label: {
                    HStack(spacing: ZodiakSpacing.s4) {
                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                            .font(.system(size: resolvedIconSize, weight: .semibold))
                        if isExpanded {
                            Text(hideLabel)
                                .font(resolvedFont)
                        } else {
                            Text("\(Text(showLabel)) (\(items.count - initialCount))")
                                .font(resolvedFont)
                        }
                    }
                    .foregroundColor(resolvedColor)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, ZodiakSpacing.s8)
                }
                .buttonStyle(.plain)
                // swiftlint:disable:next line_length
                .accessibilityLabel(isExpanded ? Text(hideLabel) : Text("shared.format.show_more_hidden \(items.count - initialCount)"))
                .accessibilityHint(
                    isExpanded
                        ? Text("shared.action.tap_to_collapse_alt")
                        : Text("shared.action.tap_to_expand"))
                .zodiakA11yID("show-more")
            }
        }
    }
}

// MARK: - Simple String Variant (convenience)
// Usage: ZodiakShowMoreList(items: ["A","B","C",...]) { item in Text(item) }

typealias ZodiakShowMoreList = ZodiakShowMore

// MARK: - Preview

private struct DemoItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
}

#Preview {
    let items = (1...9).map { DemoItem(title: "Item \($0)", subtitle: "Descrição do item \($0)") }

    ScrollView {
        VStack(spacing: 0) {
            ZodiakShowMore(items: items, initialCount: 3) { item in
                HStack {
                    VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                        Text(item.title)
                            .font(ZodiakTypography.bodySmall)
                            .foregroundColor(ZodiakColors.textPrimary)
                        Text(item.subtitle)
                            .font(ZodiakTypography.captionLarge)
                            .foregroundColor(ZodiakColors.textSecondary)
                    }
                    Spacer()
                }
                .padding(ZodiakSpacing.s8)
                .background(ZodiakColors.surface)
                Divider()
            }
        }
        .cardStyle()
        .padding(ZodiakSpacing.s16)
    }
    .background(ZodiakColors.background)
}
