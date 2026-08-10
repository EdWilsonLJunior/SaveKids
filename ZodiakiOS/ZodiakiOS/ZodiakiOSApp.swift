//
//  ZodiakiOSApp.swift
//  ZodiakiOS
//
//  Created by MARCOS FELIPE SOARES ROCHA on 16/04/26.
//

import SwiftData
import SwiftUI

@main
struct ZodiakiOSApp: App {
    @Environment(\.scenePhase) private var scenePhase

    init() {
        GlobalScrollInputConfigurator.configure()
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "unknown"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "unknown"
        ZodiakLog.notice(.lifecycle, "App launched version=\(version) build=\(build)")
    }

    var body: some Scene {
        WindowGroup {
            ZodiakTheme {
                MainTabView()
            }
        }
        .modelContainer(for: [ExpenseEntry.self, ContactEntry.self])
        .onChange(of: scenePhase) { _, newPhase in
            switch newPhase {
            case .active:
                ZodiakLog.info(.lifecycle, "Scene became active")

            case .inactive:
                ZodiakLog.info(.lifecycle, "Scene became inactive")

            case .background:
                ZodiakLog.info(.lifecycle, "Scene moved to background")
                ZodiakSessionMetrics.shared.emitSummary()

            @unknown default:
                break
            }
        }
    }
}
