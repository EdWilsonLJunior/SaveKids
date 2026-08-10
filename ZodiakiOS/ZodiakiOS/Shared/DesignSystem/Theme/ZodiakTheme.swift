import SwiftUI

// MARK: - ZodiakTheme
//
// Provider SwiftUI que injeta o esquema de cores Zodiak na árvore de UI.
// Envolva a raiz do app (ou qualquer subárvore) para que todos os componentes
// Zodiak filhos recebam o ColorScheme correto automaticamente.
//
// Ref: Zodiak DS — ZodiakTheme (Supernova, Mai 2026) · Issue #22

/// Provider de tema do Zodiak Design System.
///
/// Envolva a raiz do app para ativar suporte automático a Light/Dark:
/// ```swift
/// @main struct MyApp: App {
///     var body: some Scene {
///         WindowGroup {
///             ZodiakTheme {
///                 MainTabView()
///             }
///         }
///     }
/// }
/// ```
///
/// Para forçar um esquema numa subárvore (ex.: hero sobre foto):
/// ```swift
/// ZodiakTheme(colorScheme: .dark) {
///     HeroSection()
/// }
/// ```
public struct ZodiakTheme<Content: View>: View {
    // MARK: - Properties

    private let colorScheme: ColorScheme?
    private let content: Content

    // MARK: - Init

    /// Cria um provider de tema Zodiak.
    ///
    /// - Parameters:
    ///   - colorScheme: Override de esquema de cores. `nil` segue o sistema.
    ///   - content: Subárvore de views filhas.
    public init(
        colorScheme: ColorScheme? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.colorScheme = colorScheme
        self.content = content()
    }

    // MARK: - Body

    public var body: some View {
        content
            .environment(\.zodiakColorScheme, colorScheme)
            .preferredColorScheme(colorScheme)
    }
}
