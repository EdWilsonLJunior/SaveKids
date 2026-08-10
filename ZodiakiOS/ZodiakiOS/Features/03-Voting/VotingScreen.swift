import SwiftUI

// MARK: - Voting Screen
struct VotingScreen: View {
    @StateObject private var viewModel: VotingViewModel = VotingViewModel()
    @Environment(\.locale) private var locale

    var body: some View {
        ZodiakActivityTemplate(
            title: "catalog.examples.voting.name",
            eyebrow: "feature.voting.eyebrow",
            intro: "feature.voting.intro"
        ) {
            if !viewModel.votingFinished {
                ZodiakFormWrapper {
                    ForEach(viewModel.candidates) { candidate in
                        VoteCardItem(
                            candidate: candidate,
                            onVote: {
                                viewModel.vote(for: candidate.id)
                            }
                        )
                    }
                }

                ZodiakButtonPrimary(title: "feature.voting.finish_action", action: viewModel.finishVoting)
            } else {
                if let runoff = viewModel.runoffCandidates {
                    ZodiakWarningBadge(text: "feature.voting.runoff_warning")

                    let names = runoff.map { $0.name }.joined(separator: ", ")
                    ZodiakResultCard(
                        title: "feature.voting.result",
                        value: String(
                            format: String(localized: "feature.voting.runoff_between", locale: locale),
                            names),
                        subtitle: nil
                    )
                } else if let winner = viewModel.leadingCandidate {
                    ZodiakSuccessBadge(text: "feature.voting.finished_badge")

                    ZodiakResultCard(
                        title: "feature.voting.result",
                        value: String(
                            format: String(localized: "feature.voting.winner_name", locale: locale),
                            winner.name),
                        subtitle: String(
                            format: String(localized: "shared.format.vote_count", locale: locale),
                            winner.votes)
                    )
                }

                VStack(spacing: ZodiakSpacing.s8) {
                    ZodiakText("feature.voting.final_votes", style: .title3)
                    ForEach(viewModel.candidates) { candidate in
                        ZodiakInfoRow(
                            label: candidate.name,
                            value: String(
                                format: String(localized: "shared.format.vote_count", locale: locale),
                                candidate.votes)
                        )
                    }
                }

                ZodiakButtonSecondary(title: "feature.voting.new_action", action: viewModel.reset)
            }
        }
        .accessibilityIdentifier("screen.03.voting")
    }
}

#Preview {
    VotingScreen()
}
