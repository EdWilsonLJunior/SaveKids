import Combine
import SwiftUI

// MARK: - Activity 10: Task Manager

/// ViewModel da Atividade 10 — gerencia uma lista de tarefas com suporte a filtro por texto.
final class TaskManagerViewModel: ObservableObject {
    /// Lista completa de tarefas cadastradas.
    @Published var tasks: [TaskItem] = []
    /// Texto digitado para adicionar uma nova tarefa.
    @Published var taskInput: String = ""
    /// Texto digitado na barra de busca; filtra `filteredTasks` quando não vazio.
    @Published var searchQuery: String = ""

    /// Subconjunto de `tasks` filtrado por `searchQuery` (case-insensitive). Retorna todas quando query vazia.
    var filteredTasks: [TaskItem] {
        if searchQuery.trimmingCharacters(in: .whitespaces).isEmpty {
            return tasks
        }
        return tasks.filter { $0.title.localizedCaseInsensitiveContains(searchQuery) }
    }

    /// Adiciona nova tarefa com o texto de `taskInput`. Ignora input vazio ou apenas espaços.
    func addTask() {
        let trimmed: String = taskInput.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return }

        let task: TaskItem = TaskItem(title: trimmed)
        tasks.append(task)
        taskInput = ""
    }

    /// Alterna o estado de conclusão (`isCompleted`) da tarefa especificada.
    ///
    /// - Parameter task: Tarefa a ter o estado alternado.
    func toggleTask(_ task: TaskItem) {
        if let index: Int = tasks.firstIndex(where: { currentTask in currentTask.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }

    /// Remove a tarefa especificada da lista, identificada pelo seu `id`.
    ///
    /// - Parameter task: Tarefa a ser removida.
    func removeTask(_ task: TaskItem) {
        tasks.removeAll { currentTask in currentTask.id == task.id }
    }
}
