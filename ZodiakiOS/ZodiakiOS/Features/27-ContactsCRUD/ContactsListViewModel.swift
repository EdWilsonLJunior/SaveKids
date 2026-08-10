import Combine
import SwiftUI

// MARK: - Activity 27: ContactsCRUD — List ViewModel

/// Manages navigation state for the contacts list screen.
final class ContactsListViewModel: ObservableObject {
    // MARK: - Navigation State

    /// `true` while the add-contact form is being presented.
    @Published var isAddingContact: Bool = false
    /// `true` while the edit-contact form is being presented.
    @Published var isEditingContact: Bool = false
    /// The contact currently being edited; set before presenting the edit form.
    @Published var editingContact: ContactEntry?

    // MARK: - Delete Confirmation State

    /// Contact pending destructive confirmation. Non-nil while the delete modal is shown.
    @Published var contactPendingDelete: ContactEntry?

    var isConfirmingDelete: Bool { contactPendingDelete != nil }

    // MARK: - Actions

    /// Opens the add-contact form.
    func startAdding() {
        isAddingContact = true
    }

    /// Opens the edit-contact form for the given contact.
    func edit(_ contact: ContactEntry) {
        editingContact = contact
        isEditingContact = true
    }

    /// Stages a contact for deletion — shows the confirmation modal.
    func requestDelete(_ contact: ContactEntry) {
        contactPendingDelete = contact
    }

    /// Cancels the pending deletion and dismisses the confirmation modal.
    func cancelDelete() {
        contactPendingDelete = nil
    }
}
