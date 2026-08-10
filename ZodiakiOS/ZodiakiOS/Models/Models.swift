import Foundation
import SwiftData
import SwiftUI

// MARK: - Grade Model

/// Representa o resultado de avaliação de um aluno com três notas individuais.
struct Grade {
    /// Nome completo do aluno.
    let name: String
    /// Primeira nota, no intervalo 0–10.
    let grade1: Double
    /// Segunda nota, no intervalo 0–10.
    let grade2: Double
    /// Terceira nota, no intervalo 0–10.
    let grade3: Double

    /// Média aritmética das três notas.
    var average: Double {
        (grade1 + grade2 + grade3) / 3.0
    }

    /// `true` quando a média é maior ou igual a 7,0.
    var isPassing: Bool {
        average >= 7.0
    }
}

// MARK: - Person Model

/// Representa uma pessoa registrada no gerenciador de pessoas.
struct Person: Identifiable {
    /// Identificador único gerado automaticamente.
    let id = UUID()
    /// Nome completo da pessoa.
    let name: String
    /// Idade em anos completos.
    let age: Int
}

// MARK: - Task Model

/// Representa uma tarefa no gerenciador de tarefas.
struct TaskItem: Identifiable {
    /// Identificador único gerado automaticamente.
    let id = UUID()
    /// Descrição da tarefa.
    let title: String
    /// `true` quando a tarefa foi marcada como concluída.
    var isCompleted: Bool = false
}

// MARK: - Candidate Model

/// Representa um candidato em uma eleição com contagem de votos.
struct Candidate: Identifiable {
    /// Identificador único gerado automaticamente.
    let id = UUID()
    /// Nome do candidato.
    let name: String
    /// Total de votos recebidos pelo candidato.
    var votes: Int = 0
}

// MARK: - Quiz Theme

/// Categorias temáticas disponíveis no quiz.
enum QuizTheme: String, CaseIterable, Identifiable {
    /// Perguntas sobre a linguagem Swift.
    case swift
    /// Perguntas sobre filmes.
    case filmes
    /// Perguntas sobre história.
    case historia
    /// Perguntas sobre geografia.
    case geografia

    /// Identificador baseado no `rawValue`.
    var id: String { rawValue }

    /// Nome de exibição localizado do tema.
    var displayName: String {
        switch self {
        case .swift: return "feature.quiz_game.theme_swift"
        case .filmes: return "feature.quiz_game.theme_movies"
        case .historia: return "feature.quiz_game.theme_history"
        case .geografia: return "feature.quiz_game.theme_geography"
        }
    }

    /// Nome do SF Symbol associado ao tema.
    var icon: String {
        switch self {
        case .swift: return "swift"
        case .filmes: return "film"
        case .historia: return "clock.arrow.circlepath"
        case .geografia: return "globe.americas"
        }
    }
}

// MARK: - Question Model

/// Representa uma pergunta do quiz com múltiplas opções de resposta.
struct Question: Identifiable {
    /// Identificador único gerado automaticamente.
    let id = UUID()
    /// Texto da pergunta exibido ao usuário.
    let text: String
    /// Lista ordenada de opções de resposta.
    let options: [String]
    /// Índice (0-based) da resposta correta dentro de `options`.
    let correctIndex: Int
}

// MARK: - Quiz Answer Model

/// Registra a resposta do usuário a uma pergunta específica do quiz.
struct QuizAnswer: Identifiable {
    /// Identificador único gerado automaticamente.
    let id = UUID()
    /// Pergunta à qual esta resposta se refere.
    let question: Question
    /// Índice da opção selecionada pelo usuário.
    let selectedIndex: Int
    /// `true` quando o índice selecionado corresponde ao `correctIndex`.
    let isCorrect: Bool
}

// MARK: - Error Types

/// Erros de validação de entrada do usuário, lançados por `ValidationService`.
enum ValidationError: Error {
    /// O campo obrigatório está vazio após trimming. O parâmetro é o nome do campo.
    case emptyField(String)
    /// O valor não pôde ser convertido para número válido. O parâmetro é o nome do campo.
    case invalidNumber(String)
    /// O valor está fora do intervalo permitido.
    /// - Parameters:
    ///   - 0: Nome do campo.
    ///   - min: Limite inferior (inclusivo).
    ///   - max: Limite superior (inclusivo).
    case outOfRange(String, min: Double, max: Double)
    /// A idade fornecida é inválida (deve ser um inteiro entre 1 e 149).
    case invalidAge
    /// A nota fornecida é inválida (deve estar no intervalo 0–10).
    case invalidGrade

    /// `LocalizedStringKey` para uso direto em `Text`/`ZodiakAlert` com o locale do ambiente.
    var localizedKey: LocalizedStringKey {
        switch self {
        case .emptyField(let field):
            let msg = String(format: String(localized: "shared.validation.field_empty"), field)
            return LocalizedStringKey(msg)

        case .invalidNumber(let field):
            let msg = String(format: String(localized: "shared.validation.field_invalid_number"), field)
            return LocalizedStringKey(msg)

        case .outOfRange(let field, let min, let max):
            let minStr = String(Int(min))
            let maxStr = String(Int(max))
            let msg = String(format: String(localized: "shared.validation.field_between"), field, minStr, maxStr)
            return LocalizedStringKey(msg)

        case .invalidAge:
            return "shared.validation.age_positive"

        case .invalidGrade:
            return "shared.validation.grade_range"
        }
    }
}

// MARK: - Subject Model (Feature 12 — StudentGrades)

/// Representa uma matéria com nota associada a um aluno.
struct Subject: Identifiable {
    let id = UUID()
    let name: String
    let grade: Double
}

// MARK: - Student Model (Feature 12 — StudentGrades)

/// Representa um aluno com dados acadêmicos e de contato.
struct Student: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let absences: Int
    let address: String
    let phone: String
    let subjects: [Subject]

    var average: Double {
        guard !subjects.isEmpty else { return 0 }
        return subjects.map(\.grade).reduce(0, +) / Double(subjects.count)
    }

    var isPassing: Bool { average >= 7.0 }
    var hasCriticalAbsences: Bool { absences >= 15 }

    func hash(into hasher: inout Hasher) { hasher.combine(id) }
    static func == (lhs: Self, rhs: Self) -> Bool { lhs.id == rhs.id }
}

// MARK: - ProductSegment (Feature 13 — ProductManager)

/// Segmento de um produto no gerenciador de estoque.
enum ProductSegment: String, CaseIterable, Identifiable {
    case food        = "feature.product_manager.segment_food"
    case electronics = "feature.product_manager.segment_electronics"
    case home        = "feature.product_manager.segment_home"

    var id: String { rawValue }
}

// MARK: - Product Model (Feature 13 — ProductManager)

/// Representa um produto no sistema de gerenciamento de estoque.
struct Product: Identifiable {
    let id = UUID()
    var name: String
    var brand: String
    var segment: ProductSegment
    var price: Double
}

// MARK: - CardTheme (Feature 14 — CardManager)

/// Temas de cores disponíveis para cartões de crédito.
enum CardTheme: String, CaseIterable, Identifiable {
    case ocean    = "feature.card_manager.theme_ocean"
    case midnight = "feature.card_manager.theme_midnight"
    case slate    = "feature.card_manager.theme_slate"
    case amber    = "feature.card_manager.theme_amber"
    case forest   = "feature.card_manager.theme_forest"
    case crimson  = "feature.card_manager.theme_crimson"

    var id: String { rawValue }

    var background: [Double] {
        switch self {
        case .ocean:    return [0.11, 0.44, 0.73]
        case .midnight: return [0.08, 0.08, 0.20]
        case .slate:    return [0.25, 0.32, 0.40]
        case .amber:    return [0.58, 0.33, 0.05]
        case .forest:   return [0.10, 0.35, 0.20]
        case .crimson:  return [0.55, 0.09, 0.12]
        }
    }
}

// MARK: - CreditCard Model (Feature 14 — CardManager)

/// Representa um cartão de crédito com dados exibidos em modal.
struct CreditCard: Identifiable {
    let id = UUID()
    let bankName: String
    let brand: String
    let lastDigits: String
    let theme: CardTheme
    let limit: Double
    let dueDate: Date
}

// MARK: - ShopCategory (Feature 15 — ShopMaster)

/// Categoria de produto no catálogo da loja.
enum ShopCategory: String, CaseIterable, Identifiable {
    case electronics = "feature.shop_master.category_electronics"
    case food        = "feature.shop_master.category_food"
    case home        = "feature.shop_master.category_home"

    var id: String { rawValue }
}

// MARK: - ShopProduct (Feature 15 — ShopMaster)

/// Produto disponível no catálogo da loja.
struct ShopProduct: Identifiable {
    let id = UUID()
    let name: String
    let category: ShopCategory
    let price: Double
    let icon: String
}

// MARK: - CartItem (Feature 15 — ShopMaster)

/// Item no carrinho de compras com quantidade e subtotal calculado.
struct CartItem: Identifiable {
    let id: UUID
    let product: ShopProduct
    var quantity: Int

    var subtotal: Double { product.price * Double(quantity) }

    init(product: ShopProduct, quantity: Int = 1) {
        self.id = product.id
        self.product = product
        self.quantity = quantity
    }
}

// MARK: - ExpenseCategory (Feature 18 — ExpenseManager)

/// Categorias de despesas domésticas.
enum ExpenseCategory: String, CaseIterable, Identifiable {
    case energia, internet, agua, assinaturas, aluguel, mercado, cursos, lazer

    var id: String { rawValue }

    var localizedKey: String { "feature.expense_manager.category.\(rawValue)" }

    var icon: String {
        switch self {
        case .energia: return "bolt.fill"
        case .internet: return "wifi"
        case .agua: return "drop.fill"
        case .assinaturas: return "star.fill"
        case .aluguel: return "house.fill"
        case .mercado: return "cart.fill"
        case .cursos: return "book.fill"
        case .lazer: return "gamecontroller.fill"
        }
    }
}

// MARK: - ExpenseMonth (Feature 18 — ExpenseManager)

/// Meses suportados pelo gerenciador de despesas (Jan–Mai).
enum ExpenseMonth: Int, CaseIterable, Identifiable {
    case janeiro = 1, fevereiro, marco, abril, maio

    var id: Int { rawValue }

    var localizedKey: String {
        switch self {
        case .janeiro: return "feature.expense_manager.month.janeiro"
        case .fevereiro: return "feature.expense_manager.month.fevereiro"
        case .marco: return "feature.expense_manager.month.marco"
        case .abril: return "feature.expense_manager.month.abril"
        case .maio: return "feature.expense_manager.month.maio"
        }
    }
}

// MARK: - ExpenseEntry (Feature 18 — ExpenseManager)

/// Registro persistido de uma despesa doméstica (SwiftData model).
@Model
final class ExpenseEntry {
    var categoryRaw: String
    var amount: Double
    var monthRaw: Int
    var year: Int
    var notes: String
    var createdAt: Date

    /// Categoria derivada do valor armazenado.
    var category: ExpenseCategory {
        ExpenseCategory(rawValue: categoryRaw) ?? .mercado
    }

    /// Mês derivado do valor armazenado.
    var month: ExpenseMonth {
        ExpenseMonth(rawValue: monthRaw) ?? .janeiro
    }

    init(
        category: ExpenseCategory,
        amount: Double,
        month: ExpenseMonth,
        year: Int,
        notes: String = ""
    ) {
        categoryRaw = category.rawValue
        self.amount = amount
        monthRaw = month.rawValue
        self.year = year
        self.notes = notes
        createdAt = Date()
    }
}

// MARK: - ContactEntry (Feature 27 — ContactsCRUD)

/// Persistent contact record stored via SwiftData.
@Model
final class ContactEntry {
    var name: String
    var email: String
    var phone: String
    var birthDate: Date?
    var cep: String
    var neighborhood: String
    var street: String
    var number: String
    var state: String
    var city: String
    var createdAt: Date

    /// Returns up to two initials (uppercased) for use in an avatar.
    var initials: String {
        let parts = name.components(separatedBy: " ")
        let first = parts.first?.prefix(1) ?? ""
        let last = parts.dropFirst().first?.prefix(1) ?? ""
        return last.isEmpty ? String(first).uppercased() : "\(first)\(last)".uppercased()
    }

    /// Completeness status for the avatar indicator.
    /// - `.online`  (green)  — all major fields present
    /// - `.away`    (yellow) — some optional fields filled
    /// - `.offline` (gray)   — only required fields (name + e-mail)
    var completenessStatus: ZodiakAvatarStatus {
        let hasAddress = !street.isEmpty || !cep.isEmpty
        let hasPhone   = !phone.isEmpty
        let hasBday    = birthDate != nil
        let optionalCount = [hasAddress, hasPhone, hasBday].filter { $0 }.count
        switch optionalCount {
        case 3: return .online
        case 1, 2: return .away
        default: return .offline
        }
    }

    init(
        name: String,
        email: String,
        phone: String = "",
        birthDate: Date? = nil,
        cep: String = "",
        neighborhood: String = "",
        street: String = "",
        number: String = "",
        state: String = "",
        city: String = ""
    ) {
        self.name = name
        self.email = email
        self.phone = phone
        self.birthDate = birthDate
        self.cep = cep
        self.neighborhood = neighborhood
        self.street = street
        self.number = number
        self.state = state
        self.city = city
        createdAt = Date()
    }
}
