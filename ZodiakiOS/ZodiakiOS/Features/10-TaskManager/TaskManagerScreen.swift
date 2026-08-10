import SwiftUI

// MARK: - Task Manager Screen
struct TaskManagerScreen: View {
    @StateObject private var viewModel: TaskManagerViewModel = TaskManagerViewModel()
    @Environment(\.horizontalSizeClass) private var sizeClass
    @Environment(\.locale) private var locale

    private var hPadding: CGFloat { sizeClass == .regular ? ZodiakSpacing.s32 : ZodiakSpacing.s16 }
    private var maxWidth: CGFloat? { sizeClass == .regular ? 1024 : nil }

    var body: some View {
        ZStack {
            ZodiakColors.background
                .ignoresSafeArea()

            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: ZodiakSpacing.s16) {
                    ZodiakHeadlineSection(
                        title: "catalog.examples.task_manager.name",
                        eyebrow: "feature.task_manager.eyebrow",
                        intro: "feature.task_manager.intro",
                        style: .plainWithIntro
                    )

                    ZodiakFormWrapper {
                        ZodiakLabelledField(
                            label: "feature.task_manager.new_task",
                            placeholder: "feature.task_manager.placeholder",
                            text: $viewModel.taskInput
                        )
                    }

                    ZodiakButtonPrimary(title: "feature.task_manager.add_action", action: viewModel.addTask)

                    if !viewModel.tasks.isEmpty {
                        ZodiakSearchField(
                            text: $viewModel.searchQuery,
                            placeholder: "feature.task_manager.filter_placeholder"
                        )
                    }
                }
                .padding(hPadding)
                .frame(maxWidth: maxWidth)
                .frame(maxWidth: .infinity)

                if viewModel.tasks.isEmpty {
                    ZodiakEmptyState(
                        icon: TaskManagerConstants.emptyStateIcon,
                        title: "feature.task_manager.empty_title",
                        description: "feature.task_manager.empty_desc"
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if viewModel.filteredTasks.isEmpty {
                    ZodiakEmptyState(
                        icon: "magnifyingglass",
                        title: "feature.task_manager.no_results_title",
                        description: String(
                            format: String(localized: "feature.task_manager.no_tasks_found", locale: locale),
                            viewModel.searchQuery
                        ),
                        action: (label: "feature.task_manager.clear_search", handler: { viewModel.searchQuery = "" })
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        ForEach(viewModel.filteredTasks) { task in
                            TaskListItemRow(
                                task: task,
                                onToggle: { viewModel.toggleTask(task) },
                                onDelete: { viewModel.removeTask(task) }
                            )
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                            .listRowBackground(ZodiakColors.surface)
                        }
                    }
                    .listStyle(.plain)
                }
            }
        }
        .accessibilityIdentifier("screen.10.task_manager")
    }
}

#Preview {
    TaskManagerScreen()
}
