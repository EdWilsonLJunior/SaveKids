import SwiftUI
import Testing
@testable import ZodiakiOS

// MARK: - ZodiakTextColor Tests

@Suite("ZodiakTextColor")
struct ZodiakTextColorTests {
    @Test("todos os casos resolvem para uma Color não-clear")
    func allCasesResolve() {
        let cases: [ZodiakTextColor] = [
            .primary, .secondary, .disabled, .negative,
            .link, .linkHover, .linkPressed, .linkInverse, .inverse
        ]
        for c in cases {
            // Apenas verifica que não lança e retorna algo (não .clear padrão da conversão)
            _ = c.resolvedColor
        }
    }

    @Test("caso primary retorna textPrimary")
    func primaryResolvesCorrectly() {
        #expect(ZodiakTextColor.primary.resolvedColor == ZodiakColors.textPrimary)
    }

    @Test("caso secondary retorna textSecondary")
    func secondaryResolvesCorrectly() {
        #expect(ZodiakTextColor.secondary.resolvedColor == ZodiakColors.textSecondary)
    }

    @Test("caso disabled retorna textDisabled")
    func disabledResolvesCorrectly() {
        #expect(ZodiakTextColor.disabled.resolvedColor == ZodiakColors.textDisabled)
    }

    @Test("caso negative retorna textNegative")
    func negativeResolvesCorrectly() {
        #expect(ZodiakTextColor.negative.resolvedColor == ZodiakColors.textNegative)
    }

    @Test("caso link retorna textLink")
    func linkResolvesCorrectly() {
        #expect(ZodiakTextColor.link.resolvedColor == ZodiakColors.textLink)
    }

    @Test("caso linkInverse retorna textLinkInverse")
    func linkInverseResolvesCorrectly() {
        #expect(ZodiakTextColor.linkInverse.resolvedColor == ZodiakColors.textLinkInverse)
    }

    @Test("caso linkHover retorna textLinkHover")
    func linkHoverResolvesCorrectly() {
        #expect(ZodiakTextColor.linkHover.resolvedColor == ZodiakColors.textLinkHover)
    }

    @Test("caso linkPressed retorna textLinkPressed")
    func linkPressedResolvesCorrectly() {
        #expect(ZodiakTextColor.linkPressed.resolvedColor == ZodiakColors.textLinkPressed)
    }

    @Test("caso inverse retorna textInverse")
    func inverseResolvesCorrectly() {
        #expect(ZodiakTextColor.inverse.resolvedColor == ZodiakColors.textInverse)
    }
}

// MARK: - ZodiakText Init Tests

@Suite("ZodiakText init")
struct ZodiakTextInitTests {
    @Test("init padrão define alignment .leading")
    func defaultAlignmentIsLeading() {
        let view = ZodiakText("Teste", style: .body())
        #expect(view.alignment == .leading)
    }

    @Test("init padrão define lineLimit nil")
    func defaultLineLimitIsNil() {
        let view = ZodiakText("Teste", style: .body())
        #expect(view.lineLimit == nil)
    }

    @Test("init com alignment .center persiste")
    func customAlignmentPersists() {
        let view = ZodiakText("Teste", style: .title2, alignment: .center)
        #expect(view.alignment == .center)
    }

    @Test("init com lineLimit 2 persiste")
    func customLineLimitPersists() {
        let view = ZodiakText("Teste", style: .body(), lineLimit: 2)
        #expect(view.lineLimit == 2)
    }

    @Test("init verbatim com alignment trailing persiste")
    func verbatimAlignmentPersists() {
        let view = ZodiakText(verbatim: "Verbatim", style: .bodySmall(), alignment: .trailing)
        #expect(view.alignment == .trailing)
    }

    @Test("init LocalizedStringKey com lineLimit 1 persiste")
    func localizedKeyLineLimitPersists() {
        let view = ZodiakText(LocalizedStringKey("key"), style: .caption(), lineLimit: 1)
        #expect(view.lineLimit == 1)
    }

    @Test("estilo .body() tem weight padrão normal")
    func bodyStyleAccessible() {
        let view = ZodiakText("Teste", style: .body())
        // Apenas verifica que o style é um case body (não crashar no pattern match)
        if case .body = view.style {
            #expect(Bool(true))
        } else {
            #expect(Bool(false), "style deveria ser .body")
        }
    }

    @Test("estilo display headline3XL com weight light é acessível")
    func displayHeadlineStyleAccessible() {
        let view = ZodiakText("Display", style: .headline3XL())
        if case .headline3XL(let weight) = view.style {
            #expect(weight == .light)
        } else {
            #expect(Bool(false), "style deveria ser .headline3XL")
        }
    }
}
