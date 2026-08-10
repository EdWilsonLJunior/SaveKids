import SwiftUI

// MARK: - Zodiak Primitive Tokens
// ⚠️ Referência interna apenas. NÃO usar diretamente em views.
// Use sempre os tokens semânticos de ZodiakColors.
// Fonte: Zodiak Design System – Capgemini (doc-zodiak.capgemini.com)

enum ZodiakPrimitives {
    // MARK: - CapgeminiBlue Ramp
    enum Blue {
        static let shade25  = Color(hex: "#fcfcfc")
        static let shade50  = Color(hex: "#eff0f4")
        static let shade100 = Color(hex: "#dfe1eb")
        static let shade200 = Color(hex: "#8ea6d5")
        static let shade300 = Color(hex: "#5685c6")
        static let shade400 = Color(hex: "#3573c0")
        /// Brand Blue — cor primária Capgemini
        static let shade500 = Color(hex: "#0058ab")
        /// CapgeminiBlue at 6% opacity — rgba(0, 88, 171, 0.06) — hover/focus tint over brand surfaces
        static let brand6   = shade500.opacity(0.06)
        static let shade600 = Color(hex: "#264f96")
        static let shade700 = Color(hex: "#1c4076")
        /// Dark Blue — cor secundária Capgemini
        static let shade800 = Color(hex: "#1d365a")
        static let shade900 = Color(hex: "#121a38")
        static let shade950 = Color(hex: "#070a16")
        static let shade1000 = Color(hex: "#010204")
    }

    // MARK: - Teal Ramp
    enum Teal {
        static let shade600 = Color(hex: "#00d5d0")
        static let shade900 = Color(hex: "#29656f")
    }

    // MARK: - Neutral Ramp
    enum Neutral {
        static let shade50   = Color(hex: "#f8fafc")
        static let shade100  = Color(hex: "#f4f6f9")
        static let shade150  = Color(hex: "#f1f4f7")
        static let shade200  = Color(hex: "#e9edf3")
        static let shade250  = Color(hex: "#e6e9ed")
        static let shade300  = Color(hex: "#d9dde3")
        static let shade350  = Color(hex: "#c7ccd3")
        static let shade400  = Color(hex: "#a6acb5")
        static let shade450  = Color(hex: "#888f9a")
        static let shade500  = Color(hex: "#6e7480")
        static let shade550  = Color(hex: "#595e6a")
        static let shade600  = Color(hex: "#474c56")
        static let shade650  = Color(hex: "#3c414a")
        static let shade700  = Color(hex: "#343840")
        static let shade750  = Color(hex: "#2e323a")
        static let shade800  = Color(hex: "#272b33")
        static let shade850  = Color(hex: "#21252d")
        static let shade900  = Color(hex: "#1b1f27")
        static let shade950  = Color(hex: "#171a22")
        static let shade1000 = Color(hex: "#12151d")
    }

    // MARK: - Green Ramp (Accent — não é brand)
    enum Green {
        static let shade50  = Color(hex: "#eff7f5")
        static let shade100 = Color(hex: "#e7f6eb")
        static let shade200 = Color(hex: "#cdedd5")
        static let shade300 = Color(hex: "#afe3bd")
        static let shade400 = Color(hex: "#8ad9a2")
        static let shade500 = Color(hex: "#57cf80")
        static let shade600 = Color(hex: "#4eb972")
        static let shade700 = Color(hex: "#43a063")
        static let shade800 = Color(hex: "#1e5631")
        static let shade900 = Color(hex: "#0f2e22")
    }

    // MARK: - Red Ramp (Accent — não é brand)
    enum Red {
        static let shade50  = Color(hex: "#fbf2f3")
        static let shade100 = Color(hex: "#ffcaca")
        static let shade200 = Color(hex: "#ffa7a9")
        static let shade300 = Color(hex: "#ff848b")
        static let shade400 = Color(hex: "#ff6270")
        static let shade500 = Color(hex: "#f64059")
        static let shade600 = Color(hex: "#dd1d46")
        static let shade700 = Color(hex: "#c00036")
        static let shade800 = Color(hex: "#9e0029")
        static let shade900 = Color(hex: "#5d051a")
    }

    // MARK: - Yellow Ramp (Accent — não é brand)
    enum Yellow {
        static let shade50  = Color(hex: "#fffcf5")
        static let shade100 = Color(hex: "#fff8eb")
        static let shade200 = Color(hex: "#fff1d5")
        static let shade300 = Color(hex: "#ffeabd")
        static let shade400 = Color(hex: "#ffe2a2")
        static let shade500 = Color(hex: "#ffda80")
        static let shade600 = Color(hex: "#e4c372")
        static let shade700 = Color(hex: "#c6a963")
        static let shade800 = Color(hex: "#a18a51")
        static let shade900 = Color(hex: "#726139")
    }

    // MARK: - Orange Ramp (Brand Accent)
    enum Orange {
        static let shade50  = Color(hex: "#fffcfa")
        static let shade100 = Color(hex: "#ffe5d3")
        static let shade200 = Color(hex: "#fecfad")
        static let shade300 = Color(hex: "#fcb988")
        /// Brand Orange
        static let shade400 = Color(hex: "#f9a464")
        static let shade500 = Color(hex: "#f68f40")
        static let shade600 = Color(hex: "#f17817")
        static let shade700 = Color(hex: "#cc640f")
        static let shade800 = Color(hex: "#9f500d")
        static let shade900 = Color(hex: "#743c0b")
    }

    // MARK: - B/W Overlay Primitives (spec: Color > Primitive > Basics)
    /// Black/White overlays for scrims, hover states, and translucent surfaces.
    /// ⚠️ Reference only. Prefer semantic tokens (heroPhotographic, pageOverlay) when applicable.
    enum Overlay {
        /// rgba(0,0,0, 0)
        static let blackTransparent = Color.black.opacity(0)
        /// rgba(0,0,0, 0.05)
        static let black5  = Color.black.opacity(0.05)
        /// rgba(0,0,0, 0.06)
        static let black6  = Color.black.opacity(0.06)
        /// rgba(0,0,0, 0.08)
        static let black8  = Color.black.opacity(0.08)
        /// rgba(0,0,0, 0.10)
        static let black10 = Color.black.opacity(0.10)
        /// rgba(0,0,0, 0.15)
        static let black15 = Color.black.opacity(0.15)
        /// rgba(0,0,0, 0.55)
        static let black55 = Color.black.opacity(0.55)
        /// rgba(0,0,0, 0.75)
        static let black75 = Color.black.opacity(0.75)
        /// #000000
        static let black   = Color.black
        /// rgba(255,255,255, 0)
        static let whiteTransparent = Color.white.opacity(0)
        /// rgba(255,255,255, 0.05)
        static let white5  = Color.white.opacity(0.05)
        /// rgba(255,255,255, 0.50)
        static let white50 = Color.white.opacity(0.50)
        /// #ffffff
        static let white   = Color.white
    }
}

// MARK: - Hex Color Init Helper
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8) & 0xFF) / 255
        let b = Double(int & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}
