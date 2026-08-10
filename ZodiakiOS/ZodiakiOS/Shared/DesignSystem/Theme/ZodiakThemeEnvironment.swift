import SwiftUI

// MARK: - ZodiakTheme Environment Key
//
// EnvironmentKey que propaga o override de ColorScheme injetado por ZodiakTheme.
// Use `@Environment(\.zodiakColorScheme)` em componentes que precisam
// reagir ao override programático (ex.: forçar dark num hero sobre foto).
//
// Ref: Zodiak DS — ZodiakTheme (Supernova, Mai 2026) · Issue #22

// MARK: - EnvironmentValues extension

public extension EnvironmentValues {
    /// Override de `ColorScheme` injetado por `ZodiakTheme`.
    ///
    /// `nil` significa "seguir o sistema" (sem override).
    ///
    /// ```swift
    /// struct MyComponent: View {
    ///     @Environment(\.zodiakColorScheme) private var zodiakColorScheme
    ///
    ///     var body: some View {
    ///         // Reage ao override programático, se houver
    ///         Text("Hello").foregroundColor(
    ///             zodiakColorScheme == .dark ? .white : .black
    ///         )
    ///     }
    /// }
    /// ```
    @Entry var zodiakColorScheme: ColorScheme?
}
