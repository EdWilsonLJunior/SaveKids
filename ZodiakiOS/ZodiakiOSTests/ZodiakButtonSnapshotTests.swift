//
//  ZodiakButtonSnapshotTests.swift
//  ZodiakiOSTests
//
//  Smoke-level snapshot tests that verify the rendering pipeline works for
//  key ZodiakButton variants in both color schemes. These tests do NOT assert
//  pixel hashes against committed baselines — they prove the infrastructure
//  produces non-empty PNG output, which is the foundation for full snapshot
//  regression suites.
//
//  When a follow-up PR locks down baselines, replace the `data.count > 0`
//  assertions with `ZodiakSnapshot.sha256Hex(data) == "<recorded hash>"`.
//

import SwiftUI
import Testing
@testable import ZodiakiOS

@Suite("ZodiakButton Snapshots")
@MainActor
struct ZodiakButtonSnapshotTests {
    private let renderSize = CGSize(width: 320, height: 64)

    @Test("Primary button renders in light mode")
    func primaryLight() {
        let view = ZodiakButtonPrimary(title: "shared.action.confirm", action: {})
            .zodiakPrimaryButtonStyle()
            .padding()
        let data = ZodiakSnapshot.renderPNG(view, size: renderSize, colorScheme: .light)
        #expect(data != nil)
        #expect((data?.count ?? 0) > 0)
    }

    @Test("Primary button renders in dark mode")
    func primaryDark() {
        let view = ZodiakButtonPrimary(title: "shared.action.confirm", action: {})
            .zodiakPrimaryButtonStyle()
            .padding()
        let data = ZodiakSnapshot.renderPNG(view, size: renderSize, colorScheme: .dark)
        #expect(data != nil)
        #expect((data?.count ?? 0) > 0)
    }

    @Test("Secondary button renders in light mode")
    func secondaryLight() {
        let view = ZodiakButtonPrimary(title: "shared.action.cancel", action: {})
            .zodiakSecondaryButtonStyle()
            .padding()
        let data = ZodiakSnapshot.renderPNG(view, size: renderSize, colorScheme: .light)
        #expect(data != nil)
    }

    @Test("Danger button renders in dark mode")
    func dangerDark() {
        let view = ZodiakButtonPrimary(title: "shared.action.cancel", action: {})
            .zodiakDangerButtonStyle()
            .padding()
        let data = ZodiakSnapshot.renderPNG(view, size: renderSize, colorScheme: .dark)
        #expect(data != nil)
    }

    @Test("Same input produces stable hash across renders")
    func deterministicHash() {
        let view = ZodiakButtonPrimary(title: "shared.action.confirm", action: {})
            .zodiakPrimaryButtonStyle()
            .padding()
        let dataA = ZodiakSnapshot.renderPNG(view, size: renderSize, colorScheme: .light)
        let dataB = ZodiakSnapshot.renderPNG(view, size: renderSize, colorScheme: .light)
        guard let dataA, let dataB else {
            Issue.record("ImageRenderer returned nil")
            return
        }
        #expect(ZodiakSnapshot.sha256Hex(dataA) == ZodiakSnapshot.sha256Hex(dataB))
    }
}
