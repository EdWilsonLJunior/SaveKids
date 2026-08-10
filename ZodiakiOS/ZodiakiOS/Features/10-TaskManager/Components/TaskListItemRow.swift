import SwiftUI

// MARK: - Task List Item Component
struct TaskListItemRow: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.locale) private var locale
    let task: TaskItem
    let onToggle: () -> Void
    let onDelete: () -> Void

    var body: some View {
        HStack(spacing: ZodiakSpacing.s16) {
            Button(action: onToggle) {
                // swiftlint:disable:next line_length
                let iconName: String = task.isCompleted ? TaskManagerConstants.completedIcon : TaskManagerConstants.incompleteIcon
                let iconColor: Color = task.isCompleted ? ZodiakColors.surfacePositive : ZodiakColors.borderPrimary

                Image(systemName: iconName)
                    .imageScale(.large)
                    .font(ZodiakTypography.bodyLarge)
                    .foregroundColor(iconColor)
            }
            .accessibilityLabel(
                task.isCompleted
                    ? Text("feature.task_manager.mark_pending")
                    : Text("feature.task_manager.mark_done"))

            VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                ZodiakText(task.title, style: .body(bold: true))
                if task.isCompleted {
                    ZodiakText(
                        String(
                            format: String(localized: "feature.task_manager.task_completed", locale: locale),
                            TaskManagerConstants.completedSymbol
                        ),
                        style: .caption()
                    )
                }
            }
            .strikethrough(task.isCompleted)
            .opacity(task.isCompleted ? ZodiakOpacity.completed : 1.0)

            Spacer()

            Button(action: onDelete) {
                Image(systemName: TaskManagerConstants.deleteIcon)
                    .imageScale(.medium)
                    .font(ZodiakTypography.bodyMedium)
                    .foregroundColor(ZodiakColors.textNegative)
            }
            .accessibilityLabel(Text("feature.task_manager.remove_action"))
        }
        .padding(ZodiakSpacing.s8)
        .background(ZodiakColors.surface)
        .cornerRadius(ZodiakRadii.s)
    }
}

#Preview {
    TaskListItemRow(
        task: TaskItem(title: "Exemplo de Tarefa"),
        onToggle: {},
        onDelete: {}
    )
}
