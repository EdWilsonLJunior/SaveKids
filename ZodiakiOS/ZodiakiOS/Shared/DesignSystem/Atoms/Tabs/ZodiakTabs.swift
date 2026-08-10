import SwiftUI

// MARK: - Tab Size
/// Zodiak Tab sizes: small (S) and medium (L)
enum ZodiakTabSize {
    case small
    case medium
}

// MARK: - ZodiakTabsVariant

/// Layout variant for ``ZodiakTabs``.
enum ZodiakTabsVariant {
    /// Tabs are left-aligned and scroll horizontally when they overflow (default).
    case scrollable

    /// Each tab shares equal width; does not scroll.
    case fixed
}

// MARK: - ZodiakTabItem (data model)

/// A data model representing a single tab in ``ZodiakTabs``.
struct ZodiakTabItem: Identifiable {
    let id: String

    /// Display label for the tab.
    let label: String

    /// Optional icon displayed before the label.
    var icon: ZodiakIcon?

    /// When `true`, the tab cannot be selected.
    var isDisabled: Bool

    init(id: String? = nil, label: String, icon: ZodiakIcon? = nil, isDisabled: Bool = false) {
        self.id = id ?? label
        self.label = label
        self.icon = icon
        self.isDisabled = isDisabled
    }
}

// MARK: - Zodiak Tabs Bar

/// Horizontal tab bar.
/// Specs: doc-zodiak.capgemini.com/design/components/tabs
struct ZodiakTabs: View {
    @Binding var selectedIndex: Int
    let items: [ZodiakTabItem]
    var size: ZodiakTabSize = .small
    var variant: ZodiakTabsVariant = .scrollable

    // MARK: - Legacy init (backwards-compatible)

    /// Deprecated: use `init(selection:items:size:variant:)` instead.
    @available(*, deprecated, message: "Use init(selection:items:size:variant:) with [ZodiakTabItem]")
    init(
        tabs: [String],
        selectedIndex: Binding<Int>,
        size: ZodiakTabSize = .small,
        disabledIndices: Set<Int> = []
    ) {
        self._selectedIndex = selectedIndex
        self.items = tabs.prefix(7).enumerated().map { index, label in
            ZodiakTabItem(label: label, isDisabled: disabledIndices.contains(index))
        }
        self.size = size
        self.variant = .scrollable
    }

    // MARK: - Primary init

    init(
        selection: Binding<Int>,
        items: [ZodiakTabItem],
        size: ZodiakTabSize = .small,
        variant: ZodiakTabsVariant = .scrollable
    ) {
        self._selectedIndex = selection
        self.items = Array(items.prefix(7))
        self.size = size
        self.variant = variant
    }

    var body: some View {
        VStack(spacing: 0) {
            Group {
                if variant == .scrollable {
                    ScrollView(.horizontal, showsIndicators: false) {
                        tabBarContent
                    }
                } else {
                    tabBarContent
                }
            }

            Rectangle()
                .fill(ZodiakColors.borderPrimary)
                .frame(height: 1)
        }
    }

    @ViewBuilder
    private var tabBarContent: some View {
        HStack(spacing: ZodiakSpacing.sectionGap) {
            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                ZodiakTabItemButton(
                    label: item.label,
                    icon: item.icon,
                    isActive: selectedIndex == index,
                    isDisabled: item.isDisabled,
                    size: size,
                    tabIndex: index,
                    totalTabs: items.count,
                    isFixed: variant == .fixed,
                    action: {
                        guard !item.isDisabled else { return }
                        selectedIndex = index
                    }
                )
            }
        }
        .padding(.horizontal, 0)
    }
}

// MARK: - Tab Item (internal button)

private struct ZodiakTabItemButton: View {
    let label: String
    var icon: ZodiakIcon?
    let isActive: Bool
    var isDisabled: Bool = false
    let size: ZodiakTabSize
    let tabIndex: Int
    let totalTabs: Int
    var isFixed: Bool = false
    let action: () -> Void

    @State private var isHovered = false
    @FocusState private var isFocused: Bool

    private var labelColor: Color {
        if isDisabled {
            return ZodiakColors.textDisabled
        }

        return (isActive || isHovered || isFocused)
        ? ZodiakColors.textPrimary
        : ZodiakColors.textSecondary
    }

    private var labelTextColor: ZodiakTextColor {
        if isDisabled {
            return .disabled
        }

        return (isActive || isHovered || isFocused)
        ? .primary
        : .secondary
    }

    private var labelTextStyle: ZodiakTextViewStyle {
        switch size {
            case .small:
                return .bodySmall(
                    bold: isActive || isFocused,
                    color: labelTextColor
                )

            case .medium:
                return .body(
                    bold: isActive || isFocused,
                    color: labelTextColor
                )
        }
    }

    private var indicatorColor: Color {
        if isDisabled {
            return Color.clear
        }

        return (isActive || isFocused)
        ? ZodiakColors.actionActive
        : Color.clear
    }

    private var accessibilityValueKey: LocalizedStringKey {
        isActive ? "shared.state.selected" : ""
    }

    private var accessibilityHintKey: LocalizedStringKey {
        isDisabled ? "shared.state.unavailable" : ""
    }

    var body: some View {
        Button(action: action) {
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: ZodiakSpacing.s8)

                HStack(spacing: ZodiakSpacing.s4) {
                    if let icon {
                        ZodiakIconView(
                            icon,
                            size: .small,
                            color: labelColor,
                            isDecorative: true
                        )
                    }

                    ZodiakText(
                        LocalizedStringKey(label),
                        style: labelTextStyle,
                        lineLimit: 1
                    )
                }
                .padding(.horizontal, ZodiakSpacing.s8)
                .frame(minWidth: 45, maxWidth: isFixed ? .infinity : 220)

                Spacer()
                    .frame(height: ZodiakSpacing.s8)

                Rectangle()
                    .fill(indicatorColor)
                    .frame(height: 2)
            }
            .background(Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: ZodiakRadii.xs)
                    .stroke(
                        isFocused ? ZodiakColors.actionFocus : Color.clear,
                        lineWidth: 1
                    )
                    .padding(.vertical, ZodiakSpacing.s4)
            )
        }
        .buttonStyle(.plain)
        .focused($isFocused)
        .disabled(isDisabled)
        .onContinuousHover { phase in
            if case .active = phase {
                isHovered = true
            } else {
                isHovered = false
            }
        }
        .animation(.easeInOut(duration: 0.15), value: isHovered)
        .animation(.easeInOut(duration: 0.2), value: isActive)
        .animation(.easeInOut(duration: 0.15), value: isFocused)
        .accessibilityAddTraits(isActive ? [.isButton, .isSelected] : [.isButton])
        .accessibilityLabel(LocalizedStringKey(label))
        .accessibilityValue(accessibilityValueKey)
        .accessibilityHint(accessibilityHintKey)
        .zodiakA11yID("tab", context: label)
    }
}

// MARK: - ZodiakTabsContent

/// Convenience container: renders the tab bar + the content for the active tab.
///
/// ## Usage
/// ```swift
/// ZodiakTabsContent(selection: $selected, items: [
///     ZodiakTabItem(label: "Overview"),
///     ZodiakTabItem(label: "Specs"),
/// ]) { index in
///     if index == 0 { OverviewView() }
///     else { SpecsView() }
/// }
/// ```
struct ZodiakTabsContent<Content: View>: View {
    @Binding var selectedIndex: Int
    let items: [ZodiakTabItem]
    var size: ZodiakTabSize = .small
    var variant: ZodiakTabsVariant = .scrollable
    @ViewBuilder let content: (Int) -> Content

    // MARK: - Legacy init (backwards-compatible)

    @available(*, deprecated, message: "Use init(selection:items:size:variant:content:) with [ZodiakTabItem]")
    init(
        tabs: [String],
        selectedIndex: Binding<Int>,
        size: ZodiakTabSize = .small,
        disabledIndices: Set<Int> = [],
        @ViewBuilder content: @escaping (Int) -> Content
    ) {
        self._selectedIndex = selectedIndex
        self.items = tabs.prefix(7).enumerated().map { index, label in
            ZodiakTabItem(label: label, isDisabled: disabledIndices.contains(index))
        }
        self.size = size
        self.variant = .scrollable
        self.content = content
    }

    // MARK: - Primary init

    init(
        selection: Binding<Int>,
        items: [ZodiakTabItem],
        size: ZodiakTabSize = .small,
        variant: ZodiakTabsVariant = .scrollable,
        @ViewBuilder content: @escaping (Int) -> Content
    ) {
        self._selectedIndex = selection
        self.items = Array(items.prefix(7))
        self.size = size
        self.variant = variant
        self.content = content
    }

    var body: some View {
        VStack(spacing: 0) {
            ZodiakTabs(selection: $selectedIndex, items: items, size: size, variant: variant)
            content(selectedIndex)
        }
    }
}

/// Deprecated alias — use `ZodiakTabsContent` instead.
@available(*, deprecated, renamed: "ZodiakTabsContent")
typealias ZodiakTabContainer<Content: View> = ZodiakTabsContent<Content>

// MARK: - Disabled Tab Item (public, for use in lists)

/// Read-only tab item with disabled styling.
struct ZodiakDisabledTabItem: View {
    let label: String
    var size: ZodiakTabSize = .small

    private var labelTextStyle: ZodiakTextViewStyle {
        switch size {
            case .small:
                return .bodySmall(color: .disabled)

            case .medium:
                return .body(color: .disabled)
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: ZodiakSpacing.s8)

            ZodiakText(
                LocalizedStringKey(label),
                style: labelTextStyle,
                lineLimit: 1
            )
            .padding(.horizontal, ZodiakSpacing.s16)
            .frame(minWidth: 45, maxWidth: 220)

            Spacer()
                .frame(height: ZodiakSpacing.s8)

            Rectangle()
                .fill(Color.clear)
                .frame(height: 2)
        }
        .allowsHitTesting(false)
        .accessibilityAddTraits([.isButton])
        .accessibilityLabel(LocalizedStringKey(label))
        .accessibilityHint("shared.state.unavailable")
    }
}
// MARK: - Preview

#Preview("Zodiak Tabs") {
    struct PreviewContainer: View {
        @State var selected = 0

        var body: some View {
            VStack(spacing: ZodiakSpacing.s32) {
                VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                    ZodiakText(
                        "catalog.spec.size_small",
                        style: .caption(color: .secondary)
                    )

                    ZodiakTabs(
                        selection: $selected,
                        items: [
                            ZodiakTabItem(label: "Overview"),
                            ZodiakTabItem(label: "Specs"),
                            ZodiakTabItem(label: "Guidelines")
                        ]
                    )
                }

                VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                    ZodiakText(
                        "catalog.spec.size_medium",
                        style: .caption(color: .secondary)
                    )

                    ZodiakTabs(
                        selection: $selected,
                        items: [
                            ZodiakTabItem(label: "Tab 1"),
                            ZodiakTabItem(label: "Tab 2"),
                            ZodiakTabItem(label: "Tab 3"),
                            ZodiakTabItem(label: "Tab 4")
                        ],
                        size: .medium,
                        variant: .fixed
                    )
                }
            }
            .padding(ZodiakSpacing.s16)
        }
    }

    return PreviewContainer()
}
