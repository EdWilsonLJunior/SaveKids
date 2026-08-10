import SwiftUI

// MARK: - Zodiak Accordion
// Figma: "catalog.component_name.accordion" — expandable/collapsible content with animated chevron

public struct ZodiakAccordion<Content: View>: View {
    private let titleLabel: Text
    private let subtitleLabel: Text?
    let leadingIcon: String?
    let initiallyExpanded: Bool
    @ViewBuilder let content: () -> Content

    @State private var isExpanded: Bool
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    /// Localizable init — use for static string keys from xcstrings.
    /// String literals are implicitly converted to LocalizedStringKey.
    public init(
        title: LocalizedStringKey,
        subtitle: String? = nil,
        leadingIcon: String? = nil,
        initiallyExpanded: Bool = false,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.titleLabel = Text(title)
        self.subtitleLabel = subtitle.map { Text(LocalizedStringKey($0)) }
        self.leadingIcon = leadingIcon
        self.initiallyExpanded = initiallyExpanded
        self._isExpanded = State(initialValue: initiallyExpanded)
        self.content = content
    }

    /// Verbatim init — use for dynamic/non-localizable strings (server data, user input, enum values).
    public init(
        verbatim title: String,
        subtitle: String? = nil,
        leadingIcon: String? = nil,
        initiallyExpanded: Bool = false,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.titleLabel = Text(verbatim: title)
        self.subtitleLabel = subtitle.map { Text(verbatim: $0) }
        self.leadingIcon = leadingIcon
        self.initiallyExpanded = initiallyExpanded
        self._isExpanded = State(initialValue: initiallyExpanded)
        self.content = content
    }

    public var body: some View {
        VStack(spacing: 0) {
            // Header row
            Button {
                withAnimation(
                    reduceMotion
                        ? .easeInOut(duration: 0.15)
                        : .spring(response: 0.3, dampingFraction: 0.85)
                ) {
                    isExpanded.toggle()
                }
            } label: {
                HStack(spacing: ZodiakSpacing.s8) {
                    if let icon = leadingIcon {
                        Image(systemName: icon)
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(ZodiakColors.actionPrimary)
                            .frame(width: 20)
                    }

                    VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                        titleLabel
                            .font(ZodiakTypography.bodySmall)
                            .foregroundColor(ZodiakColors.textPrimary)
                        if let subtitleLabel {
                            subtitleLabel
                                .font(ZodiakTypography.captionLarge)
                                .foregroundColor(ZodiakColors.textSecondary)
                        }
                    }

                    Spacer()

                    Image(systemName: "chevron.down")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(ZodiakColors.textSecondary)
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                        .zodiakAnimation(.spring(response: 0.3, dampingFraction: 0.85), value: isExpanded)
                }
                .contentShape(Rectangle())
                .padding(.horizontal, ZodiakSpacing.s8 + ZodiakSpacing.s4)
                .padding(.vertical, ZodiakSpacing.s8 + ZodiakSpacing.s4)
            }
            .buttonStyle(.plain)
            .accessibilityAddTraits(isExpanded ? [.isSelected] : [])
            .zodiakA11yID("accordion")

            if isExpanded {
                Divider()
                    .padding(.horizontal, ZodiakSpacing.s8 + ZodiakSpacing.s4)

                content()
                    .padding(ZodiakSpacing.s8 + ZodiakSpacing.s4)
                    .transition(reduceMotion ? .opacity : .opacity.combined(with: .move(edge: .top)))
            }
        }
        .background(ZodiakColors.surface)
        .clipShape(RoundedRectangle(cornerRadius: ZodiakRadii.s, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: ZodiakRadii.s, style: .continuous)
                .stroke(ZodiakColors.borderPrimary, lineWidth: 1)
        )
    }
}

// MARK: ZodiakAccordionGroup

public struct ZodiakAccordionGroup<Content: View>: View {
    let items: [(title: LocalizedStringKey, content: () -> Content)]

    public var body: some View {
        VStack(spacing: ZodiakSpacing.s4) {
            ForEach(Array(items.enumerated()), id: \.offset) { _, item in
                ZodiakAccordion(title: item.title, content: item.content)
            }
        }
    }
}
