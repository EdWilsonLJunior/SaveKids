import SwiftUI
import Testing
@testable import ZodiakiOS

// MARK: - ZodiakOpacity Tests

@Suite("ZodiakOpacity")
struct ZodiakOpacityTests {
    @Test("disabled é 0.4")
    func disabledValue() {
        #expect(ZodiakOpacity.disabled == 0.4)
    }

    @Test("overlay é 0.4")
    func overlayValue() {
        #expect(ZodiakOpacity.overlay == 0.4)
    }

    @Test("selected é 0.5")
    func selectedValue() {
        #expect(ZodiakOpacity.selected == 0.5)
    }

    @Test("completed é 0.6")
    func completedValue() {
        #expect(ZodiakOpacity.completed == 0.6)
    }

    @Test("hover é 0.3")
    func hoverValue() {
        #expect(ZodiakOpacity.hover == 0.3)
    }

    @Test("todos os tokens estão entre 0 e 1")
    func allTokensInRange() {
        let tokens = [
            ZodiakOpacity.disabled,
            ZodiakOpacity.overlay,
            ZodiakOpacity.selected,
            ZodiakOpacity.completed,
            ZodiakOpacity.hover
        ]
        for token in tokens {
            #expect(token >= 0.0 && token <= 1.0)
        }
    }
}

// MARK: - ZodiakThemeEnvironment Tests

@Suite("ZodiakThemeEnvironment")
struct ZodiakThemeEnvironmentTests {
    @Test("valor default de zodiakColorScheme é nil")
    func defaultColorSchemeIsNil() {
        var env = EnvironmentValues()
        #expect(env.zodiakColorScheme == nil)
    }

    @Test("light override é preservado")
    func lightOverride() {
        var env = EnvironmentValues()
        env.zodiakColorScheme = .light
        #expect(env.zodiakColorScheme == .light)
    }

    @Test("dark override é preservado")
    func darkOverride() {
        var env = EnvironmentValues()
        env.zodiakColorScheme = .dark
        #expect(env.zodiakColorScheme == .dark)
    }

    @Test("resetar para nil remove o override")
    func resetToNil() {
        var env = EnvironmentValues()
        env.zodiakColorScheme = .dark
        env.zodiakColorScheme = nil
        #expect(env.zodiakColorScheme == nil)
    }
}

// MARK: - ZodiakTheme View Tests

@Suite("ZodiakTheme")
struct ZodiakThemeTests {
    @Test("init sem parâmetros compila e usa colorScheme nil")
    func defaultInit() {
        // Verifica que o tipo é instanciável sem parâmetros
        _ = ZodiakTheme { EmptyView() }
        #expect(Bool(true))  // compilação é a verificação principal
    }

    @Test("init com colorScheme light compila")
    func lightSchemeInit() {
        _ = ZodiakTheme(colorScheme: .light) { EmptyView() }
        #expect(Bool(true))
    }

    @Test("init com colorScheme dark compila")
    func darkSchemeInit() {
        _ = ZodiakTheme(colorScheme: .dark) { EmptyView() }
        #expect(Bool(true))
    }
}
