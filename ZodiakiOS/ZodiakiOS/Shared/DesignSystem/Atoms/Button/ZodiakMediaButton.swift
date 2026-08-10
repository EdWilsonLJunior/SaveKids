import SwiftUI

// MARK: - Zodiak Media Button
// Figma: "Media button" — specialized icon button for audio/video controls.
// Variants: onLite / onHeavy / onPhoto
// Hierarchy: play/pause/stop = primary (filled); all others = tertiary (ghost/outlined)

enum ZodiakMediaAction {
    case play, pause, stop
    case skipBack, skipForward
    case rewind, forward
    case forward15s, back15s
    case muteOff, maxVolume, minVolume
    case shuffle
    case speed(String)   // e.g. "1×", "1.5×", "2×"
    case close

    var systemIcon: String {
        switch self {
        case .play:         return "play.fill"
        case .pause:        return "pause.fill"
        case .stop:         return "stop.fill"
        case .skipBack:     return "backward.end.fill"
        case .skipForward:  return "forward.end.fill"
        case .rewind:       return "backward.fill"
        case .forward:      return "forward.fill"
        case .forward15s:   return "goforward.15"
        case .back15s:      return "gobackward.15"
        case .muteOff:      return "speaker.slash.fill"
        case .maxVolume:    return "speaker.wave.3.fill"
        case .minVolume:    return "speaker.wave.1.fill"
        case .shuffle:      return "shuffle"
        case .speed:        return "speedometer"
        case .close:        return "xmark"
        }
    }

    var isPrimary: Bool {
        switch self {
        case .play, .pause, .stop: return true
        default: return false
        }
    }

    var accessibilityLabelKey: LocalizedStringKey {
        switch self {
        case .play:             return "shared.action.play"
        case .pause:            return "shared.action.pause"
        case .stop:             return "shared.action.stop"
        case .skipBack:         return "shared.action.previous_track"
        case .skipForward:      return "shared.action.next_track"
        case .rewind:           return "shared.action.rewind"
        case .forward:          return "shared.action.advance"
        case .forward15s:       return "shared.action.forward_15s"
        case .back15s:          return "shared.action.rewind_15s"
        case .muteOff:          return "shared.action.mute"
        case .maxVolume:        return "shared.action.volume_max"
        case .minVolume:        return "shared.action.volume_min"
        case .shuffle:          return "shared.action.shuffle"
        case .speed(let v):     return LocalizedStringKey("shared.format.playback_speed \(v)")
        case .close:            return "shared.action.close_player"
        }
    }
}

enum ZodiakMediaButtonVariant {
    case onLite   // on light backgrounds
    case onHeavy  // on dark/bold backgrounds
    case onPhoto  // over video or image content
}

// MARK: - Media Button Style (pressed feedback)
private struct ZodiakMediaButtonStyle: ButtonStyle {
    let variant: ZodiakMediaButtonVariant
    let isEnabled: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .overlay(Circle().fill(pressedOverlay(configuration.isPressed)))
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }

    private func pressedOverlay(_ isPressed: Bool) -> Color {
        guard isEnabled, isPressed else { return .clear }
        switch variant {
        case .onLite:  return Color.black.opacity(0.12)
        case .onHeavy: return Color.white.opacity(0.15)
        case .onPhoto: return Color.black.opacity(0.10)
        }
    }
}

struct ZodiakMediaButton: View {
    let mediaAction: ZodiakMediaAction
    let action: () -> Void
    var variant: ZodiakMediaButtonVariant = .onLite
    var size: ZodiakIconButtonSize = .large
    var isEnabled: Bool = true

    var body: some View {
        Button(action: action) {
            if case .speed(let label) = mediaAction {
                Text(label)
                    .font(.system(size: size.iconSize - 2, weight: .semibold, design: .monospaced))
                    .foregroundColor(iconColor)
                    .frame(width: size.diameter, height: size.diameter)
                    .background(bgColor)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(borderColor, lineWidth: isPrimary ? 0 : 1))
            } else {
                Image(systemName: mediaAction.systemIcon)
                    .font(.system(size: size.iconSize, weight: .regular))
                    .foregroundColor(iconColor)
                    .frame(width: size.diameter, height: size.diameter)
                    .background(bgColor)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(borderColor, lineWidth: isPrimary ? 0 : 1))
            }
        }
        .buttonStyle(ZodiakMediaButtonStyle(variant: variant, isEnabled: isEnabled))
        .disabled(!isEnabled)
        .zodiakFocusRing(cornerRadius: size.diameter / 2)
        .accessibilityLabel(Text(mediaAction.accessibilityLabelKey))
        .accessibilityAddTraits(.isButton)
        .accessibilityHint(isEnabled ? "" : "shared.state.unavailable")
        .zodiakA11yID("button", role: "media")
    }

    private var isPrimary: Bool { mediaAction.isPrimary }

    private var iconColor: Color {
        guard isEnabled else { return ZodiakColors.actionDisabledContent }
        if isPrimary {
            switch variant {
            case .onLite:  return ZodiakColors.textInverse

            // Circle is white (actionPrimaryOnHeavy) — icon must be always-dark for contrast
            case .onHeavy: return ZodiakColors.textAlwaysBlack

            // Circle is always-white over image — icon must be always-dark for contrast
            case .onPhoto: return ZodiakColors.textAlwaysBlack
            }
        } else {
            switch variant {
            case .onLite:  return ZodiakColors.actionPrimary
            case .onHeavy: return ZodiakColors.textInverse
            case .onPhoto: return ZodiakColors.textInverse
            }
        }
    }

    private var bgColor: Color {
        guard isEnabled else { return ZodiakColors.actionDisabled }
        if isPrimary {
            switch variant {
            case .onLite:  return ZodiakColors.actionPrimary

            // Semantic: DS token for primary action on dark/heavy surfaces
            case .onHeavy: return ZodiakColors.actionPrimaryOnHeavy

            // Semantic: always-white regardless of dark mode — button sits over an image
            case .onPhoto: return ZodiakColors.textAlwaysWhite
            }
        } else {
            switch variant {
            case .onLite:  return ZodiakColors.actionPrimary.opacity(0.08)
            case .onHeavy: return Color.white.opacity(0.12)
            case .onPhoto: return Color.white.opacity(0.12)
            }
        }
    }

    private var borderColor: Color {
        guard !isPrimary else { return .clear }
        guard isEnabled else { return ZodiakColors.actionDisabled }
        switch variant {
        case .onLite:  return ZodiakColors.borderPrimary
        case .onHeavy: return Color.white.opacity(0.35)
        case .onPhoto: return Color.white.opacity(0.35)
        }
    }
}

// MARK: - Preview

#Preview("Media Button") {
    ScrollView {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s32) {
            Text("onLite — Primary vs Tertiary")
                .font(ZodiakTypography.captionLarge).foregroundColor(ZodiakColors.textSecondary)

            HStack(spacing: ZodiakSpacing.s8) {
                ZodiakMediaButton(mediaAction: .play, action: {}, variant: .onLite)
                ZodiakMediaButton(mediaAction: .pause, action: {}, variant: .onLite)
                ZodiakMediaButton(mediaAction: .stop, action: {}, variant: .onLite)
                ZodiakMediaButton(mediaAction: .back15s, action: {}, variant: .onLite)
                ZodiakMediaButton(mediaAction: .forward15s, action: {}, variant: .onLite)
                ZodiakMediaButton(mediaAction: .shuffle, action: {}, variant: .onLite)
            }

            Text("onHeavy")
                .font(ZodiakTypography.captionLarge).foregroundColor(ZodiakColors.textSecondary)

            HStack(spacing: ZodiakSpacing.s8) {
                ZodiakMediaButton(mediaAction: .play, action: {}, variant: .onHeavy)
                ZodiakMediaButton(mediaAction: .pause, action: {}, variant: .onHeavy)
                ZodiakMediaButton(mediaAction: .back15s, action: {}, variant: .onHeavy)
                ZodiakMediaButton(mediaAction: .forward15s, action: {}, variant: .onHeavy)
                ZodiakMediaButton(mediaAction: .speed("1×"), action: {}, variant: .onHeavy)
            }
            .padding(ZodiakSpacing.s8)
            .background(ZodiakColors.actionPrimary)
            .cornerRadius(ZodiakRadii.s)
        }
        .padding()
    }
    .background(ZodiakColors.background)
}
