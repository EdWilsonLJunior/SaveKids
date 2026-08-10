import SwiftData
import SwiftUI

// MARK: - Contacts List Screen

/// Main screen for the ContactsCRUD feature.
/// Displays all saved contacts in alphabetical order with add, edit, and delete actions.
struct ContactsListScreen: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \ContactEntry.name, order: .forward) private var contacts: [ContactEntry]
    @StateObject private var viewModel = ContactsListViewModel()
    @State private var isShowingInfo = false

    // MARK: - Body

    var body: some View {
        ZodiakListTemplate(
            title: "contacts.list.title",
            eyebrow: "contacts.eyebrow",
            intro: "contacts.list.intro",
            emptyStateIcon: ContactsConstants.emptyStateIcon,
            emptyStateTitle: "contacts.list.empty_title",
            emptyStateSubtitle: "contacts.list.empty_desc",
            items: contacts
        ) { contact in
            contactRow(contact)
        }
        .zodiakModal(
            isPresented: Binding(
                get: { viewModel.isConfirmingDelete },
                set: { if !$0 { viewModel.cancelDelete() } }
            ),
            title: "contacts.confirm_delete.title",
            showCloseButton: false
        ) {
            deleteModalContent
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: viewModel.startAdding) {
                    Image(systemName: ContactsConstants.addIcon)
                        .font(ZodiakTypography.bodyMedium)
                        .foregroundStyle(ZodiakColors.actionPrimary)
                }
                .accessibilityLabel(Text("contacts.action.add"))
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button { isShowingInfo = true } label: {
                    Image(systemName: ContactsConstants.infoIcon)
                        .font(ZodiakTypography.bodyMedium)
                        .foregroundStyle(ZodiakColors.actionPrimary)
                }
                .accessibilityLabel(Text("contacts.info.toolbar_label"))
            }
        }
        .settingsToolbar()
        .navigationDestination(isPresented: $viewModel.isAddingContact) {
            ContactFormScreen(contact: nil)
        }
        .navigationDestination(isPresented: $viewModel.isEditingContact) {
            if let contact = viewModel.editingContact {
                ContactFormScreen(contact: contact)
            }
        }
        .navigationDestination(isPresented: $isShowingInfo) {
            ContactsInfoScreen()
        }
        .accessibilityIdentifier("screen.27.contacts_list")
    }

    // MARK: - Contact Row

    private func contactRow(_ contact: ContactEntry) -> some View {
        VStack(spacing: 0) {
            HStack(spacing: ZodiakSpacing.s8) {
                ZodiakAvatar(initials: contact.initials, size: .m, status: contact.completenessStatus)

                VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                    ZodiakText(verbatim: contact.name, style: .title3)
                    ZodiakText(verbatim: contact.email, style: .bodySmall(color: .secondary))
                }

                Spacer(minLength: 0)

                ZodiakIconButton(
                    icon: "pencil",
                    action: { viewModel.edit(contact) },
                    size: .small,
                    style: .tertiary,
                    accessibilityLabel: String(localized: "contacts.action.edit")
                )
            }
            .padding(ZodiakSpacing.s16)

            ZodiakDivider(hierarchy: .secondary)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button(role: .destructive) {
                viewModel.requestDelete(contact)
            } label: {
                Label(String(localized: "contacts.action.delete"), systemImage: "trash")
            }
        }
    }

    // MARK: - Delete Confirmation Modal

    @ViewBuilder
    private var deleteModalContent: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s16) {
            ZodiakText("contacts.confirm_delete.message", style: .body(color: .secondary))

            HStack(spacing: ZodiakSpacing.s8) {
                ZodiakButtonSecondary(
                    title: "shared.action.cancel",
                    action: viewModel.cancelDelete,
                    size: .small
                )
                ZodiakWarningButton(
                    title: "contacts.action.delete",
                    action: {
                        if let contact = viewModel.contactPendingDelete {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                modelContext.delete(contact)
                            }
                        }
                        viewModel.cancelDelete()
                    },
                    size: .small
                )
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        ContactsListScreen()
    }
    .modelContainer(for: ContactEntry.self, inMemory: true)
}
