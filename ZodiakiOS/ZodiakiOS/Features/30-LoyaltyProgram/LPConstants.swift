import Foundation

// MARK: - Constants — Épico 30: Programa Fidelidade

enum LPConstants {
    // MARK: - AppStorage Keys
    enum Storage {
        static let isAuthenticated = "lp.isAuthenticated"
        static let points = "lp.points"
        static let statement = "lp.statement"
        static let profile = "lp.profile"
    }

    // MARK: - Default Values
    enum Defaults {
        static let initialPoints = 1_250
    }

    // MARK: - Validation
    enum Validation {
        static let cpfLength = 11
        static let minPasswordLength = 4
        static let minTransferPoints = 10
        static let transferPointsMultiple = 10
        static let mockOwnCPF = "00000000000"
    }

    // MARK: - Membership Tiers
    enum Membership {
        static let pointsToSilver = 5_000
    }

    // MARK: - API
    enum API {
        static let baseURL = "https://zodiak-lp-api.example.com"
        static let promotionsPath = "/promotions"
        static let rewardsPath = "/rewards"
        static let requestTimeout: TimeInterval = 10
        static let resourceTimeout: TimeInterval = 15
    }

    // MARK: - Pagination
    enum Pagination {
        static let statementPageSize = 10
        static let catalogPageSize = 20
    }
}

/*
 DECISÃO DE PERSISTÊNCIA — Épico 30: Programa Fidelidade
 =========================================================

 @AppStorage (UserDefaults)
 Usado para: lp.isAuthenticated, lp.points, lp.statement, lp.profile

 ESCOLHIDO porque:
   • Dados escalares ou pequenos arrays JSON-encoded sem relações entre si
   • Acesso síncrono sem overhead de contexto de persistência
   • Integração reativa nativa com SwiftUI via @AppStorage / @Published + onChange
   • Sem necessidade de queries, índices, migração de schema ou transações ACID

 DESCARTADOS:
   • SwiftData / CoreData — overhead de modelagem sem ganho para <6 chaves simples
   • Keychain — reservado para segredos (tokens OAuth, senhas reais); não adequado
                 para estado de UI ou dados do usuário
   • CloudKit — sem requisito de sincronização entre dispositivos neste épico
   • NSCache — não sobrevive ao encerramento do processo; dados devem persistir
                entre sessões

 -----------------------------------------------------------------------

 In-memory (@Published no ViewModel)
 Usado para: catálogo de promoções ([LPPromotion]), catálogo de recompensas ([LPReward])

 ESCOLHIDO porque:
   • Dados remotos efêmeros — sempre frescos ao abrir a feature
   • Sem requisito de acesso offline nesta versão do épico
   • Recarga trivial via LPAPIService.fetchPromotions() / fetchRewards()

 DESCARTADOS:
   • SwiftData — dados são lidos e exibidos, nunca editados pelo usuário
   • URLCache — sem header Cache-Control no endpoint mock; comportamento imprevisível
   • NSCache — ciclo de vida acoplado ao ViewModel; sem benefício sobre @Published
*/
