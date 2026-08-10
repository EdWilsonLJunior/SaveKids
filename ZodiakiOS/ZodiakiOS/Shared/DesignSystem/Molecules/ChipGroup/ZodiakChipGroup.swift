import SwiftUI

// MARK: - Zodiak Chip Group
// Figma: "Chips group" + "Chips for input"
// Wrapping flow layout of ZodiakChip atoms.
// Supports single-select, multi-select, and optional max selection cap.

struct ZodiakChipGroup: View {
    let options: [String]
    @Binding var selectedOptions: Set<String>
    var allowsMultipleSelection: Bool = true
    var maxSelection: Int?   // nil = unlimited
    private let labelText: Text?

    /// Localizable init — use para chaves estáticas de xcstrings.
    init(
        options: [String],
        selectedOptions: Binding<Set<String>>,
        allowsMultipleSelection: Bool = true,
        maxSelection: Int? = nil,
        label: LocalizedStringKey? = nil
    ) {
        self.options = options
        self._selectedOptions = selectedOptions
        self.allowsMultipleSelection = allowsMultipleSelection
        self.maxSelection = maxSelection
        self.labelText = label.map { Text($0) }
    }

    /// Verbatim init — use para labels dinâmicos (contagens, dados do servidor).
    init(
        options: [String],
        selectedOptions: Binding<Set<String>>,
        allowsMultipleSelection: Bool = true,
        maxSelection: Int? = nil,
        label: String? = nil
    ) {
        self.options = options
        self._selectedOptions = selectedOptions
        self.allowsMultipleSelection = allowsMultipleSelection
        self.maxSelection = maxSelection
        self.labelText = label.map { Text(verbatim: $0) }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
            if let labelText {
                labelText
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textPrimary)
            }

            ZodiakFlowLayout(spacing: ZodiakSpacing.s4) {
                ForEach(options, id: \.self) { option in
                    ZodiakChip(
                        verbatim: option,
                        isActive: selectedOptions.contains(option),
                        onTap: { toggle(option) }
                    )
                    .zodiakA11yID("chip", context: option)
                }
            }
        }
    }

    private func toggle(_ option: String) {
        if selectedOptions.contains(option) {
            selectedOptions.remove(option)
        } else {
            if !allowsMultipleSelection {
                // Atomic replace — avoids double binding mutation that
                // causes intermediate state evaluation between removeAll() + insert()
                selectedOptions = [option]
                return
            }
            if let max = maxSelection, selectedOptions.count >= max { return }
            selectedOptions.insert(option)
        }
    }
}

// MARK: - Flow Layout
// Custom SwiftUI Layout for multi-line wrapping chip rows.

struct ZodiakFlowLayout: Layout {
    var spacing: CGFloat = ZodiakSpacing.s4

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) -> CGSize {
        let maxWidth = proposal.width ?? .infinity
        var x: CGFloat = 0
        var y: CGFloat = 0
        var lineHeight: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if x + size.width > maxWidth, x > 0 {
                x = 0
                y += lineHeight + spacing
                lineHeight = 0
            }
            x += size.width + spacing
            lineHeight = max(lineHeight, size.height)
        }

        return CGSize(width: maxWidth, height: y + lineHeight)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) {
        var x: CGFloat = bounds.minX
        var y: CGFloat = bounds.minY
        var lineHeight: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if x + size.width > bounds.maxX, x > bounds.minX {
                x = bounds.minX
                y += lineHeight + spacing
                lineHeight = 0
            }
            subview.place(at: CGPoint(x: x, y: y), proposal: ProposedViewSize(size))
            x += size.width + spacing
            lineHeight = max(lineHeight, size.height)
        }
    }
}

// MARK: - Preview
#Preview {
    VStack(alignment: .leading, spacing: ZodiakSpacing.s32) {
        ZodiakChipGroup(
            options: [
                "Design", "Desenvolvimento", "UX Research",
                "shared.label.product", "iOS", "Android", "Web", "Backend"
            ],
            selectedOptions: .constant(["Design", "iOS"]),
            label: "Áreas de interesse"
        )

        ZodiakChipGroup(
            options: ["P", "M", "G", "GG", "XGG"],
            selectedOptions: .constant(["M"]),
            allowsMultipleSelection: false,
            label: "Tamanho (seleção única)"
        )

        ZodiakChipGroup(
            options: ["Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado", "Domingo"],
            selectedOptions: .constant(["Segunda", "Quarta", "Sexta"]),
            maxSelection: 3,
            label: "Dias disponíveis (máx. 3)"
        )
    }
    .padding()
    .background(ZodiakColors.background)
}
