import Testing
@testable import ZodiakiOS

// MARK: - TaskManagerViewModel Tests

@Suite("TaskManagerViewModel")
struct TaskManagerViewModelTests {
    @Test("Adicionar tarefa válida aparece na lista")
    func addValidTask() {
        let vm = TaskManagerViewModel()
        vm.taskInput = "Comprar leite"
        vm.addTask()
        #expect(vm.tasks.count == 1)
        #expect(vm.tasks.first?.title == "Comprar leite")
        #expect(vm.tasks.first?.isCompleted == false)
    }

    @Test("Tarefa com espaços em branco não é adicionada")
    func addBlankTask() {
        let vm = TaskManagerViewModel()
        vm.taskInput = "   "
        vm.addTask()
        #expect(vm.tasks.isEmpty)
    }

    @Test("Toggle alterna estado de conclusão")
    func toggleTask() throws {
        let vm = TaskManagerViewModel()
        vm.taskInput = "Estudar SwiftUI"
        vm.addTask()
        let task = try #require(vm.tasks.first)
        vm.toggleTask(task)
        #expect(vm.tasks.first?.isCompleted == true)
        vm.toggleTask(try #require(vm.tasks.first))
        #expect(vm.tasks.first?.isCompleted == false)
    }

    @Test("Remover tarefa limpa a lista")
    func removeTask() throws {
        let vm = TaskManagerViewModel()
        vm.taskInput = "Tarefa para deletar"
        vm.addTask()
        vm.removeTask(try #require(vm.tasks.first))
        #expect(vm.tasks.isEmpty)
    }

    @Test("filteredTasks retorna tudo quando searchQuery está vazio")
    func filteredTasksEmptyQuery() {
        let vm = TaskManagerViewModel()
        vm.taskInput = "Tarefa A"
        vm.addTask()
        vm.taskInput = "Tarefa B"
        vm.addTask()
        vm.searchQuery = ""
        #expect(vm.filteredTasks.count == 2)
    }

    @Test("filteredTasks filtra por correspondência parcial case-insensitive")
    func filteredTasksCaseInsensitive() {
        let vm = TaskManagerViewModel()
        vm.taskInput = "Comprar pão"
        vm.addTask()
        vm.taskInput = "Estudar Swift"
        vm.addTask()
        vm.searchQuery = "comprar"
        #expect(vm.filteredTasks.count == 1)
        #expect(vm.filteredTasks.first?.title == "Comprar pão")
    }

    @Test("filteredTasks retorna vazio quando sem correspondência")
    func filteredTasksNoMatch() {
        let vm = TaskManagerViewModel()
        vm.taskInput = "Tarefa qualquer"
        vm.addTask()
        vm.searchQuery = "xyzabc"
        #expect(vm.filteredTasks.isEmpty)
    }
}
