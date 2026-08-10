import SwiftUI

// MARK: - Zodiak Action Compositions
// Figma: 10 ▪️ ACTIONS — Link ribbon, Professional contact, Share story

// ─────────────────────────────────────────────
// MARK: - ZodiakLinkRibbon
// A horizontal (or vertical on compact) strip of navigation links.
// Used in footers, section dividers and quick-navigation areas.
// ─────────────────────────────────────────────

struct ZodiakLinkRibbonItem: Identifiable {
    let id: UUID
    let label: String
    let icon: String?
    var action: () -> Void

    init(id: UUID = UUID(), label: String, icon: String? = nil, action: @escaping () -> Void) {
        self.id = id
        self.label = label
        self.icon = icon
        self.action = action
    }
}

struct ZodiakLinkRibbon: View {
    let title: String?
    let links: [ZodiakLinkRibbonItem]
    var dividerStyle: ZodiakDividerStyle = .thin
    var background: Color = ZodiakColors.surface

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let title {
                Text(LocalizedStringKey(title))
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.textSecondary)
                    .padding(.horizontal, ZodiakSpacing.s32)
                    .padding(.top, ZodiakSpacing.s24)
                    .padding(.bottom, ZodiakSpacing.s4)
            }

            ZodiakDivider(hierarchy: .primary, style: dividerStyle)

            ForEach(Array(links.enumerated()), id: \.element.id) { index, link in
                Button {
                    link.action()
                } label: {
                    HStack(spacing: ZodiakSpacing.s4) {
                        if let icon = link.icon {
                            Image(systemName: icon)
                                .font(.system(size: 16, weight: .light))
                                .foregroundColor(ZodiakColors.actionPrimary)
                                .frame(width: 24)
                        }
                        Text(LocalizedStringKey(link.label))
                            .font(ZodiakTypography.bodySmall)
                            .foregroundColor(ZodiakColors.textLink)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.system(size: 12, weight: .light))
                            .foregroundColor(ZodiakColors.textSecondary)
                    }
                    .padding(.horizontal, ZodiakSpacing.s32)
                    .padding(.vertical, ZodiakSpacing.s8)
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)

                if index < links.count - 1 {
                    ZodiakDivider(hierarchy: .secondary, style: .thin)
                        .padding(
                            .leading,
                            link.icon != nil ? ZodiakSpacing.s32 + 24 + ZodiakSpacing.s4 : ZodiakSpacing.s32
                        )
                }
            }

            ZodiakDivider(hierarchy: .primary, style: dividerStyle)
        }
        .background(background)
    }
}

// ─────────────────────────────────────────────
// MARK: - ZodiakProfessionalContact
// Contact card: avatar, name, role, company, email, phone, LinkedIn.
// ─────────────────────────────────────────────

struct ZodiakContactItem {
    let name: String
    let role: String?
    let company: String?
    let email: String?
    let phone: String?
    let linkedIn: String?
    let avatarSystemImage: String

    init(
        name: String,
        role: String? = nil,
        company: String? = nil,
        email: String? = nil,
        phone: String? = nil,
        linkedIn: String? = nil,
        avatarSystemImage: String = "person.fill"
    ) {
        self.name = name
        self.role = role
        self.company = company
        self.email = email
        self.phone = phone
        self.linkedIn = linkedIn
        self.avatarSystemImage = avatarSystemImage
    }
}

struct ZodiakProfessionalContact: View {
    let contact: ZodiakContactItem
    var onEmailTap: (() -> Void)?
    var onPhoneTap: (() -> Void)?
    var onLinkedInTap: (() -> Void)?

    var body: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s16) {
            // Header: avatar + identity
            HStack(alignment: .top, spacing: ZodiakSpacing.s8) {
                ZStack {
                    Circle()
                        .fill(ZodiakColors.surfaceSmoke)
                        .frame(width: 64, height: 64)
                    Image(systemName: contact.avatarSystemImage)
                        .font(.system(size: 28, weight: .light))
                        .foregroundColor(ZodiakColors.textSecondary)
                }

                VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                    Text(contact.name)
                        .font(ZodiakTypography.titleSmall)
                        .foregroundColor(ZodiakColors.textPrimary)
                    if let role = contact.role {
                        Text(role)
                            .font(ZodiakTypography.bodySmall)
                            .foregroundColor(ZodiakColors.textSecondary)
                    }
                    if let company = contact.company {
                        Text(company)
                            .font(ZodiakTypography.captionLarge)
                            .foregroundColor(ZodiakColors.textSecondary)
                    }
                }
            }

            // Contact actions
            VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                if let email = contact.email {
                    contactRow(icon: "envelope", label: email, action: onEmailTap)
                }
                if let phone = contact.phone {
                    contactRow(icon: "phone", label: phone, action: onPhoneTap)
                }
                if let linkedIn = contact.linkedIn {
                    contactRow(icon: "link", label: linkedIn, action: onLinkedInTap)
                }
            }
        }
        .padding(ZodiakSpacing.s8)
        .background(ZodiakColors.surface)
        .cornerRadius(ZodiakRadii.s)
        .overlay(
            RoundedRectangle(cornerRadius: ZodiakRadii.s)
                .stroke(ZodiakColors.borderSecondary, lineWidth: 1)
        )
    }

    @ViewBuilder
    private func contactRow(icon: String, label: String, action: (() -> Void)?) -> some View {
        Button {
            action?()
        } label: {
            HStack(spacing: ZodiakSpacing.s4) {
                Image(systemName: icon)
                    .font(.system(size: 14, weight: .light))
                    .foregroundColor(ZodiakColors.actionPrimary)
                    .frame(width: 20)
                Text(label)
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(action != nil ? ZodiakColors.textLink : ZodiakColors.textSecondary)
                    .lineLimit(1)
            }
        }
        .buttonStyle(.plain)
        .disabled(action == nil)
    }
}

// ─────────────────────────────────────────────
// MARK: - ZodiakShareStory
// Promote / share a story: image, title, description, share actions.
// ─────────────────────────────────────────────

struct ZodiakShareStoryItem {
    let eyebrow: String?
    let title: String
    let summary: String?
    let artworkSystemName: String
    let shareLabel: String
    var shareAction: () -> Void
    var readMoreLabel: String?
    var readMoreAction: (() -> Void)?

    init(
        eyebrow: String? = nil,
        title: String,
        summary: String? = nil,
        artworkSystemName: String = "square.and.arrow.up",
        shareLabel: String = "shared.action.share",
        shareAction: @escaping () -> Void = {},
        readMoreLabel: String? = nil,
        readMoreAction: (() -> Void)? = nil
    ) {
        self.eyebrow = eyebrow
        self.title = title
        self.summary = summary
        self.artworkSystemName = artworkSystemName
        self.shareLabel = shareLabel
        self.shareAction = shareAction
        self.readMoreLabel = readMoreLabel
        self.readMoreAction = readMoreAction
    }
}

struct ZodiakShareStory: View {
    let item: ZodiakShareStoryItem

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Artwork
            ZStack(alignment: .bottomLeading) {
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [ZodiakColors.surfaceMarine, ZodiakColors.brand],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 180)

                Image(systemName: item.artworkSystemName)
                    .font(.system(size: 56, weight: .ultraLight))
                    .foregroundColor(.white.opacity(0.2))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                // Gradient overlay
                LinearGradient(
                    colors: [.clear, Color.black.opacity(0.55)],
                    startPoint: .center,
                    endPoint: .bottom
                )
            }
            .frame(height: 180)

            // Content
            VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                if let eyebrow = item.eyebrow {
                    ZodiakEyebrow(text: eyebrow, background: .onLite)
                }
                Text(LocalizedStringKey(item.title))
                    .font(ZodiakTypography.labelLarge)
                    .foregroundColor(ZodiakColors.textPrimary)
                    .fixedSize(horizontal: false, vertical: true)
                if let summary = item.summary {
                    Text(LocalizedStringKey(summary))
                        .font(ZodiakTypography.bodySmall)
                        .foregroundColor(ZodiakColors.textSecondary)
                        .lineLimit(3)
                }
            }
            .padding(ZodiakSpacing.s8)

            // Actions
            HStack(spacing: ZodiakSpacing.s4) {
                Button {
                    item.shareAction()
                } label: {
                    Label(LocalizedStringKey(item.shareLabel), systemImage: "square.and.arrow.up")
                        .font(ZodiakTypography.bodySmall)
                }
                .buttonStyle(.borderedProminent)
                .tint(ZodiakColors.actionPrimary)

                if let readMoreLabel = item.readMoreLabel {
                    Button {
                        item.readMoreAction?()
                    } label: {
                        Text(LocalizedStringKey(readMoreLabel))
                            .font(ZodiakTypography.bodySmall)
                    }
                    .buttonStyle(.bordered)
                    .tint(ZodiakColors.actionPrimary)
                }
            }
            .padding(.horizontal, ZodiakSpacing.s8)
            .padding(.bottom, ZodiakSpacing.s8)
        }
        .background(ZodiakColors.surface)
        .cornerRadius(ZodiakRadii.s)
        .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 2)
        .clipped()
    }
}

// MARK: - Previews

#Preview("Link Ribbon") {
    ZodiakLinkRibbon(
        title: "LINKS RÁPIDOS",
        links: [
            ZodiakLinkRibbonItem(label: "shared.nav.home", icon: "house", action: {}),
            ZodiakLinkRibbonItem(label: "shared.nav.about", icon: "info.circle", action: {}),
            ZodiakLinkRibbonItem(label: "shared.nav.services", icon: "briefcase", action: {}),
            ZodiakLinkRibbonItem(label: "shared.nav.contact", icon: "envelope", action: {})
        ]
    )
    .padding()
}

#Preview("Professional Contact") {
    ZodiakProfessionalContact(
        contact: .init(
            name: "Marie Dupont",
            role: "Lead UX Designer",
            company: "Capgemini",
            email: "marie.dupont@capgemini.com",
            phone: "+33 6 12 34 56 78",
            linkedIn: "linkedin.com/in/marie-dupont"
        ),
        onEmailTap: {},
        onPhoneTap: {}
    )
    .padding()
}

#Preview("Share Story") {
    ZodiakShareStory(
        item: .init(
            eyebrow: "shared.content.news",
            title: "Design systems reduce delivery friction by 40%",
            // swiftlint:disable:next line_length
            summary: "A new study by Capgemini Research Institute shows that unified design languages save teams thousands of hours annually.",
            artworkSystemName: "newspaper.fill",
            shareLabel: "shared.action.share",
            shareAction: {},
            readMoreLabel: "shared.action.read_more",
            readMoreAction: {}
        )
    )
    .padding()
}
