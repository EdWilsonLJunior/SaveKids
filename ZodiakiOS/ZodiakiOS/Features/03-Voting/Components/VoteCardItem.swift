import SwiftUI

// MARK: - Vote Card Item Component
struct VoteCardItem: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.locale) private var locale
    let candidate: Candidate
    let onVote: () -> Void

    var body: some View {
        HStack(spacing: ZodiakSpacing.s16) {
            ZodiakAvatar(
                initials: String(candidate.name.prefix(2)).uppercased(),
                size: .m
            )

            VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                ZodiakText(candidate.name, style: .body(bold: true))
                ZodiakText(
                    String(format: String(localized: "shared.format.vote_count", locale: locale), candidate.votes),
                    style: .caption()
                )
            }

            Spacer()

            ZodiakIconButton(icon: "plus", action: onVote, size: .large, style: .primary)
        }
        .padding(ZodiakSpacing.s8)
        .background(ZodiakColors.surface.opacity(ZodiakOpacity.hover))
        .cornerRadius(ZodiakRadii.s)
    }
}

#Preview {
    VoteCardItem(
        candidate: Candidate(name: "feature.voting.candidate_a"),
        onVote: {}
    )
}
