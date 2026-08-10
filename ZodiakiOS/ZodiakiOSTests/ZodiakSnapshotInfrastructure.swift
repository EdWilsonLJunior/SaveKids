//
//  ZodiakSnapshotInfrastructure.swift
//  ZodiakiOSTests
//
//  Lightweight snapshot scaffolding using SwiftUI's ImageRenderer (iOS 16+).
//  No external dependencies. Provides a `renderPNG(_:size:scale:)` helper that
//  serializes any `View` to PNG `Data`, plus a tiny SHA-256-based hash so future
//  tests can assert pixel-stable output (ex.: regression baselines).
//
//  This is intentionally minimal — committing PNG baselines is left to the
//  follow-up PR that picks specific components/states to lock down.
//

import CryptoKit
import SwiftUI
import UIKit
@testable import ZodiakiOS

enum ZodiakSnapshot {
    /// Renders a SwiftUI view to PNG `Data` at the given logical size and scale.
    /// Returns `nil` if the renderer cannot produce an image (e.g. zero-size view).
    ///
    /// Uses `UIHostingController` + `UIGraphicsImageRenderer` instead of
    /// `ImageRenderer` so that SwiftUI property wrappers like `@FocusState`
    /// are initialised inside a proper view hierarchy and do not trigger the
    /// "Accessing FocusState's value outside of the body of a View" assertion.
    @MainActor
    static func renderPNG<V: View>(
        _ view: V,
        size: CGSize = CGSize(width: 320, height: 64),
        scale: CGFloat = 2.0,
        colorScheme: ColorScheme = .light
    ) -> Data? {
        let rootView = view
            .frame(width: size.width, height: size.height)
            .environment(\.colorScheme, colorScheme)

        let host = UIHostingController(rootView: AnyView(rootView))
        host.view.frame = CGRect(origin: .zero, size: size)
        host.view.backgroundColor = .clear
        host.view.setNeedsLayout()
        host.view.layoutIfNeeded()

        let format = UIGraphicsImageRendererFormat()
        format.scale = scale
        format.opaque = false
        let uiRenderer = UIGraphicsImageRenderer(size: size, format: format)
        let image = uiRenderer.image { context in
            host.view.layer.render(in: context.cgContext)
        }
        return image.pngData()
    }

    /// Returns a SHA-256 hex digest of arbitrary `Data`. Useful for baseline
    /// hash comparisons without storing full PNGs in source control.
    static func sha256Hex(_ data: Data) -> String {
        let digest = SHA256.hash(data: data)
        return digest.map { String(format: "%02x", $0) }.joined()
    }
}
