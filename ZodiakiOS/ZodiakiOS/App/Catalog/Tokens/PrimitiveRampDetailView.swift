import SwiftUI
import UIKit

// MARK: - Primitive Ramp Detail View

struct PrimitiveRampDetailView: View {
    let ramp: PrimitiveRamp

    var body: some View {
        ZodiakGalleryShell {
            heroSection
            shadesSection
        }
        .zodiakPage(title: LocalizedStringKey(ramp.nameKey))
    }

    // MARK: - Hero

    private var heroSection: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s16) {
            ZodiakEyebrow(text: "catalog.color.category_primitive")
            ZodiakText(verbatim: ramp.shortName, style: .headline)
                .fontDesign(.monospaced)
            LinearGradient(
                colors: ramp.entries.map { $0.color },
                startPoint: .leading,
                endPoint: .trailing
            )
            .frame(height: 72)
            .clipShape(RoundedRectangle(cornerRadius: ZodiakRadii.s))
        }
        .padding(.horizontal, ZodiakSpacing.screenPad)
    }

    // MARK: - Shades List

    private var shadesSection: some View {
        VStack(spacing: 0) {
            ForEach(Array(ramp.entries.enumerated()), id: \.offset) { _, entry in
                shadeRow(entry: entry)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: ZodiakRadii.s))
        .padding(.horizontal, ZodiakSpacing.screenPad)
    }

    private func shadeRow(entry: RampEntry) -> some View {
        HStack {
            ZodiakText(
                verbatim: "\(ramp.shortName).\(entry.label)",
                style: .body(bold: true)
            )
            Spacer()
            ZodiakText(
                verbatim: hexString(entry.color),
                style: .caption()
            )
            .opacity(0.7)
            .fontDesign(.monospaced)
        }
        .padding(.horizontal, ZodiakSpacing.s16)
        .padding(.vertical, ZodiakSpacing.s8)
        .background(entry.color)
        .environment(\.colorScheme, isDark(entry.color) ? .dark : .light)
    }

    // MARK: - Helpers

    private func hexString(_ color: Color) -> String {
        let uiColor = UIColor(color).resolvedColor(
            with: UITraitCollection(userInterfaceStyle: .light)
        )
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: nil)
        return String(
            format: "#%02X%02X%02X",
            Int((red * 255).rounded()),
            Int((green * 255).rounded()),
            Int((blue * 255).rounded())
        )
    }

    /// Returns true if the colour is perceived as dark (white text needed).
    private func isDark(_ color: Color) -> Bool {
        let uiColor = UIColor(color).resolvedColor(
            with: UITraitCollection(userInterfaceStyle: .light)
        )
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: nil)
        return 0.299 * red + 0.587 * green + 0.114 * blue <= 0.5
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        PrimitiveRampDetailView(
            ramp: PrimitiveRamp(
                nameKey: "catalog.color.primitive_blue",
                entries: [
                    ("25", ZodiakPrimitives.Blue.shade25),
                    ("100", ZodiakPrimitives.Blue.shade100),
                    ("200", ZodiakPrimitives.Blue.shade200),
                    ("300", ZodiakPrimitives.Blue.shade300),
                    ("400", ZodiakPrimitives.Blue.shade400),
                    ("500", ZodiakPrimitives.Blue.shade500),
                    ("600", ZodiakPrimitives.Blue.shade600),
                    ("700", ZodiakPrimitives.Blue.shade700),
                    ("800", ZodiakPrimitives.Blue.shade800),
                    ("900", ZodiakPrimitives.Blue.shade900),
                    ("950", ZodiakPrimitives.Blue.shade950),
                    ("1000", ZodiakPrimitives.Blue.shade1000)
                ]
            )
        )
    }
}
