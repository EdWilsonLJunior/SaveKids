import SwiftUI

// MARK: - Zodiak Extensions
// Extensões utilitárias — mantém funcionalidade existente, tokens atualizados

extension String {
    /// Remove espaços, acentos e converte para minúsculas
    var normalized: String {
        self.lowercased()
            .folding(options: .diacriticInsensitive, locale: .current)
            .filter { !$0.isWhitespace && $0.isLetter }
    }

    /// Remove espaços, pontuação e acentos (para palíndromo)
    var cleanedForPalindrome: String {
        self.lowercased()
            .folding(options: .diacriticInsensitive, locale: .current)
            .filter { $0.isLetter || $0.isNumber }
    }
}

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Color {
    /// Retorna a cor primária do action Zodiak
    static func zodiakAdaptiveForeground() -> Color {
        ZodiakColors.actionPrimary
    }
}
