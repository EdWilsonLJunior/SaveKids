import Foundation

// MARK: - SolutionCategory

enum SolutionCategory: String, Codable, CaseIterable, Identifiable, Hashable {
    case historias  = "Histórias"
    case testes     = "Testes"
    case metrificacao = "Metrificação"
    case platform   = "Platform"
    case mainframe  = "Mainframe"
    case frontend   = "Frontend"
    case backend    = "Backend"
    case migracao   = "Migração"
    case copilot    = "Copilot"

    var id: String { rawValue }

    var icon: ZodiakIcon {
        switch self {
        case .historias:    return .bookOpen
        case .testes:       return .listChecklist
        case .metrificacao: return .chartBarVertical
        case .platform:     return .desktopTower
        case .mainframe:    return .monitor
        case .frontend:     return .code
        case .backend:      return .data
        case .migracao:     return .arrowsReload01
        case .copilot:      return .aiBrain
        }
    }

    var heroStyle: ZodiakHeroStyle {
        switch self {
        case .historias:    return .typographic(shape: .v1)
        case .testes:       return .typographic(shape: .v2)
        case .metrificacao: return .typographic(shape: .v3)
        case .platform:     return .typographic(shape: .v4)
        case .mainframe:    return .typographic(shape: .v5)
        case .frontend:     return .typographic(shape: .v1)
        case .backend:      return .typographic(shape: .v2)
        case .migracao:     return .typographic(shape: .v3)
        case .copilot:      return .typographic(shape: .v4)
        }
    }

    var typographicBackground: ZodiakTypographicCardBackground { .page }
}

// MARK: - SolutionMetric

struct SolutionMetric: Codable, Hashable {
    let value: String
    let label: String
}

// MARK: - Solution

struct Solution: Identifiable, Codable, Hashable {
    let id: UUID
    let category: SolutionCategory
    let title: String
    let description: String
    let author: String
    let duration: String
    let stack: String

    // Portfolio detail fields
    let whatItSolves: String
    let expectedResult: String
    let prerequisites: [String]
    let owners: [String]
    let steps: [String]
    let metrics: [SolutionMetric]
    let integrations: [String]
    let useCases: [String]
    let relatedIds: [String]

    static func == (lhs: Self, rhs: Self) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
}
