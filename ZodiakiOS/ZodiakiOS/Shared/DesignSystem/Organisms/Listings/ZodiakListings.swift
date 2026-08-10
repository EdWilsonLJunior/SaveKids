import SwiftUI

// MARK: - Zodiak Listings
// Família de listas editoriais inspiradas nas páginas "Listings" do Zodiak.

struct ZodiakListingItem: Identifiable {
    let id = UUID()
    let eyebrow: String?
    let title: String
    let summary: String?
    let meta: String?
    var imageSystemName: String?
    var action: (() -> Void)?
}

struct ZodiakListingRow: View {
    let item: ZodiakListingItem

    var body: some View {
        Button {
            item.action?()
        } label: {
            HStack(alignment: .top, spacing: ZodiakSpacing.s8) {
                if let imageSystemName = item.imageSystemName {
                    ZStack {
                        RoundedRectangle(cornerRadius: ZodiakRadii.s)
                            .fill(ZodiakColors.surfaceSmoke)
                            .frame(width: 88, height: 88)
                        Image(systemName: imageSystemName)
                            .font(.system(size: 28, weight: .light))
                            .foregroundColor(ZodiakColors.actionPrimary.opacity(0.6))
                    }
                }

                VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                    if let eyebrow = item.eyebrow {
                        ZodiakEyebrow(text: eyebrow, size: .small, background: .onLite)
                    }

                    Text(LocalizedStringKey(item.title))
                        .font(ZodiakTypography.labelLarge)
                        .foregroundColor(ZodiakColors.textPrimary)
                        .fixedSize(horizontal: false, vertical: true)

                    if let summary = item.summary {
                        Text(LocalizedStringKey(summary))
                            .font(ZodiakTypography.bodySmall)
                            .foregroundColor(ZodiakColors.textSecondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }

                    if let meta = item.meta {
                        Text(LocalizedStringKey(meta))
                            .font(ZodiakTypography.captionLarge)
                            .foregroundColor(ZodiakColors.textSecondary)
                    }
                }

                Spacer(minLength: 0)

                Image(systemName: "chevron.right")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(ZodiakColors.textSecondary)
                    .padding(.top, ZodiakSpacing.s4)
            }
            .padding(ZodiakSpacing.s8)
            .background(ZodiakColors.surface)
            .clipShape(RoundedRectangle(cornerRadius: ZodiakRadii.s, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: ZodiakRadii.s, style: .continuous)
                    .stroke(ZodiakColors.borderSecondary, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

struct ZodiakListingGroup: View {
    let title: String?
    let items: [ZodiakListingItem]
    var initialCount: Int = 3

    var body: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            if let title {
                ZodiakText(title, style: .title2)
            }

            ZodiakShowMore(items: items, initialCount: initialCount) { item in
                ZodiakListingRow(item: item)
                    .padding(.bottom, ZodiakSpacing.s4)
            }
        }
    }
}

struct ZodiakDownloadItem: Identifiable {
    let id = UUID()
    let title: String
    let format: String
    let size: String
    let action: () -> Void
}

struct ZodiakDownloadList: View {
    let title: String?
    let items: [ZodiakDownloadItem]

    var body: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            if let title {
                ZodiakText(title, style: .title2)
            }

            VStack(spacing: ZodiakSpacing.s4) {
                ForEach(items) { item in
                    HStack(spacing: ZodiakSpacing.s8) {
                        VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                            Text(LocalizedStringKey(item.title))
                                .font(ZodiakTypography.bodySmall)
                                .foregroundColor(ZodiakColors.textPrimary)
                            Text(verbatim: "\(item.format) · \(item.size)")
                                .font(ZodiakTypography.captionLarge)
                                .foregroundColor(ZodiakColors.textSecondary)
                        }

                        Spacer(minLength: 0)

                        ZodiakSystemButton(title: "Baixar", action: item.action, icon: "arrow.down", style: .outlined)
                    }
                    .padding(ZodiakSpacing.s8)
                    .background(ZodiakColors.surface)
                    .clipShape(RoundedRectangle(cornerRadius: ZodiakRadii.s, style: .continuous))
                }
            }
        }
    }
}

struct ZodiakFAQItem: Identifiable {
    let id = UUID()
    let question: String
    let answer: String
}

struct ZodiakFAQList: View {
    let title: String?
    let items: [ZodiakFAQItem]

    var body: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            if let title {
                ZodiakText(title, style: .title2)
            }

            VStack(spacing: ZodiakSpacing.s4) {
                ForEach(items) { item in
                    ZodiakAccordion(title: LocalizedStringKey(item.question)) {
                        Text(LocalizedStringKey(item.answer))
                            .font(ZodiakTypography.bodyMedium)
                            .foregroundColor(ZodiakColors.textSecondary)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
        }
    }
}

#Preview("Listings") {
    let listingItems = [
        ZodiakListingItem(
            eyebrow: "Research",
            title: "How design systems reduce delivery friction.",
            summary: "A short editorial summary that explains the article angle and why it matters.",
            meta: "5 min read",
            imageSystemName: "doc.text.image",
            action: {}
        ),
        ZodiakListingItem(
            eyebrow: "Engineering",
            title: "Shipping SwiftUI components with stable semantics.",
            summary: "Patterns for keeping tokens and components aligned between Figma and code.",
            meta: "8 min read",
            imageSystemName: "swift",
            action: {}
        ),
        ZodiakListingItem(
            eyebrow: "Design",
            title: "From hero to listings: compositional layers in Zodiak.",
            summary: "How larger content blocks build on top of the same atomic foundation.",
            meta: "6 min read",
            imageSystemName: "rectangle.3.group",
            action: {}
        ),
        ZodiakListingItem(
            eyebrow: "Case Study",
            title: "Scaling an iPad-first experience.",
            summary: "Learn how adaptive layouts preserve the brand without cloning screens.",
            meta: "11 min read",
            imageSystemName: "ipad.landscape",
            action: {}
        )
    ]

    let faqItems = [
        ZodiakFAQItem(
            question: "Os componentes suportam iPhone e iPad?",
            answer: "Sim. As novas composições usam adaptação por largura disponível e tokens comuns do design system."
        ),
        ZodiakFAQItem(
            question: "Preciso de assets externos para usar o hero?",
            answer: "Não. O hero funciona só com texto e SF Symbols, embora possa receber mídia do projeto futuramente."
        ),
        ZodiakFAQItem(
            question: "As listagens já suportam expansão progressiva?",
            answer: "Sim. O grupo de listagem reaproveita o componente ZodiakShowMore para isso."
        )
    ]

    let downloads = [
        ZodiakDownloadItem(title: "Brand Guidelines", format: "catalog.spec.format_pdf", size: "2.4 MB", action: {}),
        ZodiakDownloadItem(title: "Icon Set", format: "ZIP", size: "4.8 MB", action: {}),
        ZodiakDownloadItem(title: "Voice & Tone", format: "DOCX", size: "380 KB", action: {})
    ]

    return ScrollView {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s32) {
            ZodiakListingGroup(title: "Latest articles", items: listingItems)
            ZodiakDownloadList(title: "Downloads", items: downloads)
            ZodiakFAQList(title: "FAQ", items: faqItems)
        }
        .padding(ZodiakSpacing.s16)
    }
    .background(ZodiakColors.background)
}
