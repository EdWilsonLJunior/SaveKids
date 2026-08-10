import SwiftUI

// MARK: - Person Manager Screen
struct PersonManagerScreen: View {
    @StateObject private var viewModel: PersonManagerViewModel = PersonManagerViewModel()
    @Environment(\.horizontalSizeClass) private var sizeClass

    private var hPadding: CGFloat { sizeClass == .regular ? ZodiakSpacing.s32 : ZodiakSpacing.s16 }
    private var maxWidth: CGFloat? { sizeClass == .regular ? 1024 : nil }

    var body: some View {
        ZStack {
            ZodiakColors.background
                .ignoresSafeArea()

            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: ZodiakSpacing.s16) {
                    ZodiakHeadlineSection(
                        title: "catalog.examples.person_manager.name",
                        eyebrow: "feature.person_manager.eyebrow",
                        intro: "feature.person_manager.intro",
                        style: .plainWithIntro
                    )

                    ZodiakFormWrapper {
                        ZodiakLabelledField(
                            label: "shared.label.name",
                            placeholder: "shared.placeholder.enter_name",
                            text: $viewModel.nameInput
                        )

                        ZodiakLabelledField(
                            label: "shared.label.age",
                            placeholder: "shared.placeholder.enter_age",
                            text: $viewModel.ageInput,
                            keyboardType: .numberPad,
                            onSubmit: viewModel.addPerson
                        )
                    }

                    ZodiakButtonPrimary(title: "feature.person_manager.add_action", action: viewModel.addPerson)

                    if let error: LocalizedStringKey = viewModel.errorMessage {
                        ZodiakAlert(
                            title: error,
                            variant: .error,
                            isDismissible: true
                        )
                    }
                }
                .padding(hPadding)
                .frame(maxWidth: maxWidth)
                .frame(maxWidth: .infinity)

                if viewModel.persons.isEmpty {
                    ZodiakEmptyState(
                        icon: PersonManagerConstants.emptyStateIcon,
                        title: "feature.person_manager.empty_title",
                        description: "feature.person_manager.empty_desc"
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        ForEach(viewModel.persons) { person in
                            PersonListItemRow(person: person, onDelete: {
                                viewModel.removePerson(person)
                            })
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                            .listRowBackground(ZodiakColors.surface)
                        }
                    }
                    .listStyle(.plain)
                }
            }
        }
        .accessibilityIdentifier("screen.07.person_manager")
    }
}

#Preview {
    PersonManagerScreen()
}
