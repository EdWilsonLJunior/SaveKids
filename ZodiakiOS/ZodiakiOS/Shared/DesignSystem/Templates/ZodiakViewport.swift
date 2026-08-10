import SwiftUI

// MARK: - ZodiakViewport
/// 5 viewports do Zodiak Design System (PDF "Layout grid").
///
/// Diferente de `UIDevice.userInterfaceIdiom`, este enum é dirigido pela **largura
/// efetiva** da view. Funciona corretamente em:
/// - Stage Manager (janela redimensionável em iPad)
/// - Split View / Slide Over (largura fracionária do iPad)
/// - iPhone Plus em landscape (largura > 700pt)
/// - Mac Catalyst (largura arbitrária)
///
/// Specs PDF Zodiak:
/// | Viewport       | Width range  | Columns | Margin | Gutter |
/// |----------------|--------------|---------|--------|--------|
/// | mobile         | 320–767      | 4       | 24     | 16     |
/// | tablet         | 768–991      | 6       | 56     | 24     |
/// | tabletLarge    | 992–1279     | 6       | 82     | 24     |
/// | desktopSmall   | 1280–1919    | 12      | 100    | 24     |
/// | desktopLarge   | 1920–2400+   | 12      | 120    | 32     |
enum ZodiakViewport: String, CaseIterable, Sendable {
    case mobile
    case tablet
    case tabletLarge
    case desktopSmall
    case desktopLarge

    /// Resolve viewport a partir de uma largura (em pontos).
    static func current(for width: CGFloat) -> Self {
        switch width {
        case ..<768:    return .mobile
        case ..<992:    return .tablet
        case ..<1280:   return .tabletLarge
        case ..<1920:   return .desktopSmall
        default:        return .desktopLarge
        }
    }

    var columnCount: Int {
        switch self {
        case .mobile:        return 4

        case .tablet,
             .tabletLarge:   return 6

        case .desktopSmall,
             .desktopLarge:  return 12
        }
    }

    /// Margem horizontal padrão (px do Zodiak PDF, mapeado para pt em iOS).
    var margin: CGFloat {
        switch self {
        case .mobile:        return 24
        case .tablet:        return 56
        case .tabletLarge:   return 82
        case .desktopSmall:  return 100
        case .desktopLarge:  return 120
        }
    }

    /// Gutter (espaço entre colunas).
    var gutter: CGFloat {
        switch self {
        case .mobile:                  return 16

        case .tablet,
             .tabletLarge,
             .desktopSmall:            return 24

        case .desktopLarge:            return 32
        }
    }
}

// MARK: - Environment value

private struct ZodiakViewportKey: EnvironmentKey {
    static let defaultValue: ZodiakViewport = .mobile
}

extension EnvironmentValues {
    /// Viewport atual injetado por `ZodiakViewportReader` ou via `ZodiakResponsiveGrid`.
    var zodiakViewport: ZodiakViewport {
        get { self[ZodiakViewportKey.self] }
        set { self[ZodiakViewportKey.self] = newValue }
    }
}

// MARK: - ZodiakViewportReader

/// Mede largura via `GeometryReader` e injeta `\.zodiakViewport` no environment.
///
/// Use em wrappers de tela ou root view para que componentes filhos possam
/// adaptar layout via `@Environment(\.zodiakViewport)`.
///
/// ```swift
/// ZodiakViewportReader { viewport in
///     myFeatureContent
/// }
/// ```
struct ZodiakViewportReader<Content: View>: View {
    @ViewBuilder var content: (ZodiakViewport) -> Content

    var body: some View {
        GeometryReader { proxy in
            let viewport = ZodiakViewport.current(for: proxy.size.width)
            content(viewport)
                .environment(\.zodiakViewport, viewport)
        }
    }
}

// MARK: - ZodiakResponsiveGrid

/// Grid responsivo viewport-aware, alinhado ao PDF Zodiak Layout grid.
/// Diferente de `ZodiakLayoutGrid` (idiom-based), este componente recalcula
/// colunas/margens/gutters quando a largura da janela muda.
///
/// ```swift
/// ZodiakResponsiveGrid {
///     ForEach(items) { item in CardView(item) }
/// }
/// ```
struct ZodiakResponsiveGrid<Content: View>: View {
    /// Override do número de colunas (clamped ao máximo do viewport).
    var columns: Int?
    /// Aplica margem horizontal do viewport (default true).
    var applyMargin: Bool
    @ViewBuilder var content: () -> Content

    init(
        columns: Int? = nil,
        applyMargin: Bool = true,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.columns = columns
        self.applyMargin = applyMargin
        self.content = content
    }

    var body: some View {
        GeometryReader { proxy in
            let viewport = ZodiakViewport.current(for: proxy.size.width)
            let count = min(columns ?? viewport.columnCount, viewport.columnCount)
            let items = Array(
                repeating: GridItem(.flexible(), spacing: viewport.gutter),
                count: max(1, count)
            )
            LazyVGrid(columns: items, spacing: viewport.gutter) {
                content()
            }
            .padding(.horizontal, applyMargin ? viewport.margin : 0)
            .environment(\.zodiakViewport, viewport)
        }
    }
}

// MARK: - Preview

#Preview("Viewport detection") {
    ZodiakViewportReader { viewport in
        VStack(spacing: ZodiakSpacing.s24) {
            Text(verbatim: "Viewport: \(viewport.rawValue)")
                .font(ZodiakTypography.titleSmall)
            Text(verbatim: "Columns: \(viewport.columnCount)")
            Text(verbatim: "Margin: \(Int(viewport.margin))pt")
            Text(verbatim: "Gutter: \(Int(viewport.gutter))pt")
        }
        .padding()
    }
}
