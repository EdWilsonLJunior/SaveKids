import SwiftUI

// MARK: - Zodiak Avatar
// Figma: "catalog.component_name.avatar" — user profile picture with initials fallback and optional status indicator

/// Tamanhos predefinidos do avatar; controla diâmetro, fonte e status indicator.
public enum ZodiakAvatarSize {
    /// Tamanhos em ordem crescente: XS (24pt), S (32pt), M (40pt), L (56pt), XL (72pt).
    case xs, s, m, l, xl

    var diameter: CGFloat {
        switch self {
        case .xs: return 24
        case .s:  return 32
        case .m:  return 40
        case .l:  return 56
        case .xl: return 72
        }
    }

    var fontSize: CGFloat {
        switch self {
        case .xs: return 9
        case .s:  return 12
        case .m:  return 15
        case .l:  return 20
        case .xl: return 26
        }
    }

    var statusDiameter: CGFloat { diameter * 0.30 }
    var statusOffset: CGFloat { diameter * 0.35 }
}

/// Estado de presença exibido no indicador colorido do avatar.
public enum ZodiakAvatarStatus {
    /// Estados disponíveis: online (verde), ausente (amarelo), não perturbe (vermelho) e offline (cinza).
    case online, away, doNotDisturb, offline
    var color: Color {
        switch self {
        case .online:       return ZodiakColors.statusOnline
        case .away:         return ZodiakColors.statusAway
        case .doNotDisturb: return ZodiakColors.statusDoNotDisturb
        case .offline:      return ZodiakColors.statusOffline
        }
    }
}

// MARK: ZodiakAvatar

public struct ZodiakAvatar: View {
    let initials: String?
    let systemImage: String?
    let size: ZodiakAvatarSize
    let status: ZodiakAvatarStatus?
    let backgroundColor: Color?

    public init(
        initials: String? = nil,
        systemImage: String? = nil,
        size: ZodiakAvatarSize = .m,
        status: ZodiakAvatarStatus? = nil,
        backgroundColor: Color? = nil
    ) {
        self.initials = initials
        self.systemImage = systemImage
        self.size = size
        self.status = status
        self.backgroundColor = backgroundColor
    }

    public var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Circle()
                .fill(backgroundColor ?? ZodiakColors.surfaceInk)
                .overlay(
                    Group {
                        if let icon = systemImage {
                            Image(systemName: icon)
                                .resizable()
                                .scaledToFit()
                                .padding(size.diameter * 0.22)
                                .foregroundColor(ZodiakColors.textAlwaysWhite)
                        } else if let initials {
                            Text(initials.prefix(2).uppercased())
                                .font(.system(size: size.fontSize, weight: .semibold, design: .default))
                                .foregroundColor(ZodiakColors.textAlwaysWhite)
                        } else {
                            Image(systemName: "person.fill")
                                .resizable()
                                .scaledToFit()
                                .padding(size.diameter * 0.22)
                                .foregroundColor(ZodiakColors.textAlwaysWhite)
                        }
                    }
                )
                .overlay(Circle().stroke(ZodiakColors.borderPrimary, lineWidth: 1))
                .frame(width: size.diameter, height: size.diameter)

            if let status {
                Circle()
                    .fill(status.color)
                    .overlay(Circle().stroke(ZodiakColors.surface, lineWidth: 1.5))
                    .frame(width: size.statusDiameter, height: size.statusDiameter)
                    .offset(x: 2, y: 2)
            }
        }
    }
}

// MARK: ZodiakAvatarGroup

public struct ZodiakAvatarGroup: View {
    let items: [String]     // initials or icons
    let max: Int
    let size: ZodiakAvatarSize

    public init(items: [String], max: Int = 4, size: ZodiakAvatarSize = .s) {
        self.items = items
        self.max = max
        self.size = size
    }

    var visible: [String] { Array(items.prefix(max)) }
    var overflow: Int { Swift.max(0, items.count - max) }

    public var body: some View {
        HStack(spacing: -(size.diameter * 0.25)) {
            ForEach(Array(visible.enumerated()), id: \.offset) { _, initial in
                ZodiakAvatar(initials: initial, size: size)
                    .overlay(Circle().stroke(ZodiakColors.surface, lineWidth: 1.5))
            }
            if overflow > 0 {
                Circle()
                    .fill(ZodiakColors.borderPrimary)
                    .overlay(
                        Text(verbatim: "+\(overflow)")
                            .font(.system(size: size.fontSize, weight: .semibold))
                            .foregroundColor(ZodiakColors.textSecondary)
                    )
                    .overlay(Circle().stroke(ZodiakColors.surface, lineWidth: 1.5))
                    .frame(width: size.diameter, height: size.diameter)
            }
        }
    }
}
