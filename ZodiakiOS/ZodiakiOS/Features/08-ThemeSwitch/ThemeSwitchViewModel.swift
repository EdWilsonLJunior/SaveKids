import Combine
import SwiftUI

// MARK: - Activity 08: Theme Toggle

/// ViewModel da Atividade 08 — gerencia o estado do tema visual (claro/escuro).
final class ThemeSwitchViewModel: ObservableObject {
    /// `true` quando o tema escuro está ativo.
    @Published var isDarkMode: Bool = ThemeSwitchConstants.darkModeDefault
}
