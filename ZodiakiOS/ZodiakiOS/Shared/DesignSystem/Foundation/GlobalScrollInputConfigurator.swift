import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

/// Configura suporte de entrada de rolagem para mouse/trackpad em toda a app.
enum GlobalScrollInputConfigurator {
    private static var hasConfigured = false

    static func configure() {
#if canImport(UIKit)
        guard !hasConfigured else { return }
        hasConfigured = true

        let scrollViewAppearance = UIScrollView.appearance()
        scrollViewAppearance.isDirectionalLockEnabled = false
        scrollViewAppearance.delaysContentTouches = false
        // Nota: allowedScrollTypesMask não é suportado via UIAppearance proxy;
        // o iOS 13.4+ já habilita scroll contínuo/discreto por padrão em novos dispositivos.
#endif
    }
}
