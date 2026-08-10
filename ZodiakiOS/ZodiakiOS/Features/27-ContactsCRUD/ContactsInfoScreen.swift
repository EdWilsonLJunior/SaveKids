import SwiftUI

// MARK: - Contacts Info Screen

/// Read-only screen documenting all technical decisions made in the ContactsCRUD example.
struct ContactsInfoScreen: View {
    var body: some View {
        ZodiakActivityTemplate(
            title: String(localized: "contacts.info.title"),
            eyebrow: String(localized: "contacts.eyebrow"),
            intro: String(localized: "contacts.info.intro")
        ) {
            VStack(spacing: ZodiakSpacing.s8) {
                ContactsInfoArchSection()
                ContactsInfoWizardSection()
                ContactsInfoCompletenessSection()
                ContactsInfoFieldsSection()
                ContactsInfoListSection()
                ContactsInfoDestructiveSection()
                ContactsInfoLocalizationSection()
            }
        }
        .settingsToolbar()
        .accessibilityIdentifier("screen.27.contacts_info")
    }
}

// MARK: - Architecture Section

private struct ContactsInfoArchSection: View {
    var body: some View {
        ZodiakAccordion(title: "contacts.info.section.architecture", leadingIcon: "building.columns") {
            VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                ZodiakInfoRow(
                    label: String(localized: "contacts.info.arch.r1_label"),
                    value: String(localized: "contacts.info.arch.r1_value")
                )
                ZodiakInfoRow(
                    label: String(localized: "contacts.info.arch.r2_label"),
                    value: String(localized: "contacts.info.arch.r2_value")
                )
                ZodiakInfoRow(
                    label: String(localized: "contacts.info.arch.r3_label"),
                    value: String(localized: "contacts.info.arch.r3_value")
                )
                ZodiakInfoRow(
                    label: String(localized: "contacts.info.arch.r4_label"),
                    value: String(localized: "contacts.info.arch.r4_value")
                )
                ZodiakInfoRow(
                    label: String(localized: "contacts.info.arch.r5_label"),
                    value: String(localized: "contacts.info.arch.r5_value")
                )
                ZodiakDivider(hierarchy: .secondary)
                ZodiakText(
                    verbatim: String(localized: "contacts.info.arch.note"),
                    style: .bodySmall(color: .secondary)
                )
            }
        }
    }
}

// MARK: - Wizard Section

private struct ContactsInfoWizardSection: View {
    var body: some View {
        ZodiakAccordion(title: "contacts.info.section.wizard", leadingIcon: "list.bullet.rectangle") {
            VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                ZodiakInfoRow(
                    label: String(localized: "contacts.info.wizard.r1_label"),
                    value: String(localized: "contacts.info.wizard.r1_value")
                )
                ZodiakInfoRow(
                    label: String(localized: "contacts.info.wizard.r2_label"),
                    value: String(localized: "contacts.info.wizard.r2_value")
                )
                ZodiakInfoRow(
                    label: String(localized: "contacts.info.wizard.r3_label"),
                    value: String(localized: "contacts.info.wizard.r3_value")
                )
                ZodiakInfoRow(
                    label: String(localized: "contacts.info.wizard.r4_label"),
                    value: String(localized: "contacts.info.wizard.r4_value")
                )
                ZodiakInfoRow(
                    label: String(localized: "contacts.info.wizard.r5_label"),
                    value: String(localized: "contacts.info.wizard.r5_value")
                )
                ZodiakInfoRow(
                    label: String(localized: "contacts.info.wizard.r6_label"),
                    value: String(localized: "contacts.info.wizard.r6_value")
                )
                ZodiakDivider(hierarchy: .secondary)
                ZodiakText(
                    verbatim: String(localized: "contacts.info.wizard.note"),
                    style: .bodySmall(color: .secondary)
                )
            }
        }
    }
}

// MARK: - Completeness Section

private struct ContactsInfoCompletenessSection: View {
    var body: some View {
        // swiftlint:disable:next line_length
        ZodiakAccordion(title: "contacts.info.section.completeness", leadingIcon: "person.crop.circle.badge.checkmark") {
            VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                legendRow(color: ZodiakColors.statusOnline,
                          label: String(localized: "contacts.info.status.complete"),
                          detail: String(localized: "contacts.info.status.complete_desc"))
                legendRow(color: ZodiakColors.statusAway,
                          label: String(localized: "contacts.info.status.partial"),
                          detail: String(localized: "contacts.info.status.partial_desc"))
                legendRow(color: ZodiakColors.statusOffline,
                          label: String(localized: "contacts.info.status.minimal"),
                          detail: String(localized: "contacts.info.status.minimal_desc"))
                ZodiakDivider(hierarchy: .secondary)
                ZodiakText(
                    verbatim: String(localized: "contacts.info.completeness.note"),
                    style: .bodySmall(color: .secondary)
                )
            }
        }
    }

    @ViewBuilder
    private func legendRow(color: Color, label: String, detail: String) -> some View {
        HStack(alignment: .top, spacing: ZodiakSpacing.s8) {
            Circle().fill(color).frame(width: 10, height: 10).padding(.top, 4)
            VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                ZodiakText(verbatim: label, style: .bodySmall())
                ZodiakText(verbatim: detail, style: .caption())
            }
        }
    }
}

// MARK: - Fields Section

private struct ContactsInfoFieldsSection: View {
    var body: some View {
        ZodiakAccordion(title: "contacts.info.section.fields", leadingIcon: "keyboard") {
            VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                ZodiakInfoRow(
                    label: String(localized: "contacts.info.fields.r1_label"),
                    value: String(localized: "contacts.info.fields.r1_value")
                )
                ZodiakInfoRow(
                    label: String(localized: "contacts.info.fields.r2_label"),
                    value: String(localized: "contacts.info.fields.r2_value")
                )
                ZodiakInfoRow(
                    label: String(localized: "contacts.info.fields.r3_label"),
                    value: String(localized: "contacts.info.fields.r3_value")
                )
                ZodiakInfoRow(
                    label: String(localized: "contacts.info.fields.r4_label"),
                    value: String(localized: "contacts.info.fields.r4_value")
                )
                ZodiakInfoRow(
                    label: String(localized: "contacts.info.fields.r5_label"),
                    value: String(localized: "contacts.info.fields.r5_value")
                )
                ZodiakDivider(hierarchy: .secondary)
                ZodiakText(
                    verbatim: String(localized: "contacts.info.fields.note"),
                    style: .bodySmall(color: .secondary)
                )
            }
        }
    }
}

// MARK: - List Section

private struct ContactsInfoListSection: View {
    var body: some View {
        ZodiakAccordion(title: "contacts.info.section.list", leadingIcon: "list.bullet") {
            VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                ZodiakInfoRow(
                    label: String(localized: "contacts.info.list.r1_label"),
                    value: String(localized: "contacts.info.list.r1_value")
                )
                ZodiakInfoRow(
                    label: String(localized: "contacts.info.list.r2_label"),
                    value: String(localized: "contacts.info.list.r2_value")
                )
                ZodiakInfoRow(
                    label: String(localized: "contacts.info.list.r3_label"),
                    value: String(localized: "contacts.info.list.r3_value")
                )
                ZodiakInfoRow(
                    label: String(localized: "contacts.info.list.r4_label"),
                    value: String(localized: "contacts.info.list.r4_value")
                )
                ZodiakInfoRow(
                    label: String(localized: "contacts.info.list.r5_label"),
                    value: String(localized: "contacts.info.list.r5_value")
                )
                ZodiakDivider(hierarchy: .secondary)
                ZodiakText(
                    verbatim: String(localized: "contacts.info.list.note"),
                    style: .bodySmall(color: .secondary)
                )
            }
        }
    }
}

// MARK: - Destructive Section

private struct ContactsInfoDestructiveSection: View {
    var body: some View {
        ZodiakAccordion(title: "contacts.info.section.destructive", leadingIcon: "trash") {
            VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                ZodiakInfoRow(
                    label: String(localized: "contacts.info.destructive.r1_label"),
                    value: String(localized: "contacts.info.destructive.r1_value")
                )
                ZodiakInfoRow(
                    label: String(localized: "contacts.info.destructive.r2_label"),
                    value: String(localized: "contacts.info.destructive.r2_value")
                )
                ZodiakInfoRow(
                    label: String(localized: "contacts.info.destructive.r3_label"),
                    value: String(localized: "contacts.info.destructive.r3_value")
                )
                ZodiakInfoRow(
                    label: String(localized: "contacts.info.destructive.r4_label"),
                    value: String(localized: "contacts.info.destructive.r4_value")
                )
                ZodiakInfoRow(
                    label: String(localized: "contacts.info.destructive.r5_label"),
                    value: String(localized: "contacts.info.destructive.r5_value")
                )
                ZodiakDivider(hierarchy: .secondary)
                ZodiakText(
                    verbatim: String(localized: "contacts.info.destructive.note"),
                    style: .bodySmall(color: .secondary)
                )
            }
        }
    }
}

// MARK: - Localization Section

private struct ContactsInfoLocalizationSection: View {
    var body: some View {
        ZodiakAccordion(title: "contacts.info.section.localization", leadingIcon: "globe") {
            VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                ZodiakInfoRow(
                    label: String(localized: "contacts.info.localization.r1_label"),
                    value: String(localized: "contacts.info.localization.r1_value")
                )
                ZodiakInfoRow(
                    label: String(localized: "contacts.info.localization.r2_label"),
                    value: String(localized: "contacts.info.localization.r2_value")
                )
                ZodiakInfoRow(
                    label: String(localized: "contacts.info.localization.r3_label"),
                    value: String(localized: "contacts.info.localization.r3_value")
                )
                ZodiakInfoRow(
                    label: String(localized: "contacts.info.localization.r4_label"),
                    value: String(localized: "contacts.info.localization.r4_value")
                )
                ZodiakInfoRow(
                    label: String(localized: "contacts.info.localization.r5_label"),
                    value: String(localized: "contacts.info.localization.r5_value")
                )
                ZodiakDivider(hierarchy: .secondary)
                ZodiakText(
                    verbatim: String(localized: "contacts.info.localization.note"),
                    style: .bodySmall(color: .secondary)
                )
            }
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        ContactsInfoScreen()
    }
}
