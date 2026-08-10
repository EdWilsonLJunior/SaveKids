import SwiftUI

// MARK: - Person List Item Component
struct PersonListItemRow: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.locale) private var locale
    let person: Person
    let onDelete: () -> Void

    var body: some View {
        HStack(spacing: ZodiakSpacing.s16) {
            ZodiakAvatar(
                initials: initials(for: person.name),
                size: .m
            )

            VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                ZodiakText(person.name, style: .body(bold: true))
                ZodiakText(
                    String(
                        format: String(localized: "shared.format.age_years", locale: locale),
                        person.age),
                    style: .caption())
            }

            Spacer()

            ZodiakDangerButton(title: LocalizedStringKey(PersonManagerConstants.deleteButtonTitle), action: onDelete)
                .frame(width: 48, height: 36)
        }
        .padding(ZodiakSpacing.s8)
        .background(ZodiakColors.surface)
        .cornerRadius(ZodiakRadii.s)
    }

    private func initials(for name: String) -> String {
        let parts = name.split(separator: " ")
        if parts.count >= 2 {
            return String(parts[0].prefix(1) + parts[1].prefix(1)).uppercased()
        }
        return String(name.prefix(2)).uppercased()
    }
}

#Preview {
    PersonListItemRow(
        person: Person(name: "João Silva", age: 30),
        onDelete: {}
    )
}
