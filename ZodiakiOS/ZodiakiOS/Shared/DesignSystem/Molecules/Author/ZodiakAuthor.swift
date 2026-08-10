import SwiftUI

// MARK: - Zodiak Author
// Fonte: Zodiak Design System – Capgemini | Página "Author"
// Specs: Avatar + nome + papel/data opcional — layout horizontal
// Usado em artigos, cards de conteúdo e páginas de detalhe

struct ZodiakAuthor: View {
    let name: String
    var role: String?
    var date: String?
    var avatarImage: Image?
    var avatarInitials: String?
    var onTap: (() -> Void)?

    var body: some View {
        let content = HStack(spacing: ZodiakSpacing.s8) {
            // Avatar
            avatarView

            // Text
            VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                Text(LocalizedStringKey(name))
                    .font(ZodiakTypography.bodySmall.bold())
                    .foregroundColor(ZodiakColors.textPrimary)

                if let role {
                    Text(LocalizedStringKey(role))
                        .font(ZodiakTypography.captionLarge)
                        .foregroundColor(ZodiakColors.textSecondary)
                }

                if let date {
                    Text(date)
                        .font(ZodiakTypography.captionLarge)
                        .foregroundColor(ZodiakColors.textSecondary)
                }
            }

            Spacer(minLength: 0)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(accessibilityDescription)

        if let onTap {
            Button(action: onTap) { content }
                .accessibilityAddTraits(.isButton)
        } else {
            content
        }
    }

    @ViewBuilder
    private var avatarView: some View {
        if let avatarImage {
            avatarImage
                .resizable()
                .scaledToFill()
                .frame(width: ZodiakSizing.Icon.xl, height: ZodiakSizing.Icon.xl)
                .clipShape(Circle())
        } else {
            ZStack {
                Circle()
                    .fill(ZodiakColors.surfaceMarine)
                    .frame(width: ZodiakSizing.Icon.xl, height: ZodiakSizing.Icon.xl)
                Text(initials)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(ZodiakColors.textInverse)
            }
        }
    }

    private var initials: String {
        if let avatarInitials { return String(avatarInitials.prefix(2)).uppercased() }
        let parts = name.split(separator: " ")
        if parts.count >= 2 {
            return "\(parts[0].prefix(1))\(parts[1].prefix(1))".uppercased()
        }
        return String(name.prefix(2)).uppercased()
    }

    private var accessibilityDescription: String {
        var parts = ["Autor: \(name)"]
        if let role { parts.append(role) }
        if let date { parts.append(date) }
        return parts.joined(separator: ", ")
    }
}

// MARK: - Previews

#Preview("Author") {
    VStack(spacing: ZodiakSpacing.s24) {
        ZodiakAuthor(name: "Marie Dupont", role: "Senior Consultant", date: "22 abr 2026")
        ZodiakAuthor(name: "João Silva", role: "Product Designer")
        ZodiakAuthor(name: "Ana", date: "hoje")
        ZodiakAuthor(name: "Carlos Mendes", role: "Engineer", onTap: {})
    }
    .padding(ZodiakSpacing.s16)
    .background(ZodiakColors.background)
}
