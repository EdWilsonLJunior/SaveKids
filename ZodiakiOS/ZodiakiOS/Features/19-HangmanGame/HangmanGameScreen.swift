import SwiftUI

// MARK: - Hangman Game Screen

struct HangmanGameScreen: View {
    @StateObject private var viewModel: HangmanGameViewModel = HangmanGameViewModel()
    @Environment(\.locale) private var locale

    var body: some View {
        ZodiakActivityTemplate(
            title: "feature.hangman.short_title",
            eyebrow: "feature.hangman.eyebrow",
            intro: "feature.hangman.intro"
        ) {
            switch viewModel.phase {
            case .playing:
                gameView

            case .won, .lost:
                resultView
            }
        }
        .accessibilityIdentifier("screen.19.hangman_game")
    }

    // MARK: - Game View

    @ViewBuilder
    private var gameView: some View {
        VStack(spacing: ZodiakSpacing.s24) {
            HangmanDrawingView(wrongAttempts: viewModel.wrongAttempts)
                .frame(height: 180)
                .padding(.vertical, ZodiakSpacing.s8)

            wordDisplayView

            ZodiakText(
                String(
                    format: String(localized: "feature.hangman.attempts_remaining", locale: locale),
                    viewModel.remainingAttempts
                ),
                style: .caption(color: viewModel.remainingAttempts <= 2 ? .negative : .secondary)
            )
            .animation(.easeInOut(duration: 0.2), value: viewModel.remainingAttempts)

            letterKeyboardView
        }
    }

    // MARK: - Word Display

    private var wordDisplayView: some View {
        HStack(spacing: ZodiakSpacing.s8) {
            ForEach(Array(viewModel.currentWord.enumerated()), id: \.offset) { _, char in
                let revealed = viewModel.guessedLetters.contains(char)
                VStack(spacing: ZodiakSpacing.s4) {
                    ZodiakText(
                        verbatim: revealed ? String(char) : " ",
                        style: .title1
                    )
                    .frame(minWidth: 24)
                    .contentTransition(.opacity)
                    .animation(.spring(response: 0.35, dampingFraction: 0.7), value: revealed)

                    Rectangle()
                        .fill(ZodiakColors.textPrimary)
                        .frame(height: 2)
                        .frame(minWidth: 24)
                }
            }
        }
        .padding(.vertical, ZodiakSpacing.s8)
    }

    // MARK: - Letter Keyboard

    private var letterKeyboardView: some View {
        ZodiakLayoutGrid(applyScreenPadding: false) {
            ForEach(HangmanGameConstants.alphabet, id: \.self) { letter in
                let used = viewModel.isLetterUsed(letter)
                let correct = viewModel.isLetterCorrect(letter)
                LetterButton(
                    letter: letter,
                    isUsed: used,
                    isCorrect: correct && used
                ) {
                    viewModel.guessLetter(letter)
                }
            }
        }
    }

    // MARK: - Result View

    @ViewBuilder
    private var resultView: some View {
        let won = viewModel.phase == .won
        ZodiakResultCard(
            title: String(localized: won ? "feature.hangman.you_won" : "feature.hangman.you_lost"),
            value: won
                ? viewModel.currentWord
                : String(
                    format: String(localized: "feature.hangman.the_word_was", locale: locale),
                    viewModel.currentWord
                ),
            subtitle: nil
        )
        .transition(.opacity.combined(with: .scale(scale: 0.94, anchor: .top)))
        .animation(.spring(response: 0.4, dampingFraction: 0.72), value: viewModel.phase)

        ZodiakButtonPrimary(title: "shared.action.play_again", action: viewModel.restart)
    }
}

// MARK: - Hangman Drawing View

/// Desenho progressivo da forca via SwiftUI Canvas.
/// Cada estágio adiciona uma parte do corpo (6 estágios ao total).
private struct HangmanDrawingView: View {
    let wrongAttempts: Int

    var body: some View {
        Canvas { context, size in
            let shading = GraphicsContext.Shading.color(ZodiakColors.textPrimary)
            let stroke = StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round)

            let w = size.width
            let h = size.height
            let cx = w * 0.55  // coluna central do boneco
            let headR: CGFloat = h * 0.12
            let headY: CGFloat = h * 0.18  // centro da cabeça

            // Forca (estática — sempre visível)
            // Base
            var base = Path()
            base.move(to: CGPoint(x: w * 0.1, y: h * 0.95))
            base.addLine(to: CGPoint(x: w * 0.9, y: h * 0.95))
            context.stroke(base, with: shading, style: stroke)

            // Poste vertical
            var pole = Path()
            pole.move(to: CGPoint(x: w * 0.25, y: h * 0.95))
            pole.addLine(to: CGPoint(x: w * 0.25, y: h * 0.05))
            context.stroke(pole, with: shading, style: stroke)

            // Trave horizontal
            var beam = Path()
            beam.move(to: CGPoint(x: w * 0.25, y: h * 0.05))
            beam.addLine(to: CGPoint(x: cx, y: h * 0.05))
            context.stroke(beam, with: shading, style: stroke)

            // Corda
            var rope = Path()
            rope.move(to: CGPoint(x: cx, y: h * 0.05))
            rope.addLine(to: CGPoint(x: cx, y: headY - headR))
            context.stroke(rope, with: shading, style: stroke)

            guard wrongAttempts > 0 else { return }

            // Estágio 1 — Cabeça
            var head = Path()
            head.addEllipse(in: CGRect(
                x: cx - headR,
                y: headY - headR,
                width: headR * 2,
                height: headR * 2
            ))
            context.stroke(head, with: shading, style: stroke)

            guard wrongAttempts > 1 else { return }

            // Estágio 2 — Tronco
            let bodyTop = headY + headR
            let bodyBot = h * 0.65
            var body = Path()
            body.move(to: CGPoint(x: cx, y: bodyTop))
            body.addLine(to: CGPoint(x: cx, y: bodyBot))
            context.stroke(body, with: shading, style: stroke)

            guard wrongAttempts > 2 else { return }

            // Estágio 3 — Braço esquerdo
            var leftArm = Path()
            leftArm.move(to: CGPoint(x: cx, y: bodyTop + (bodyBot - bodyTop) * 0.25))
            leftArm.addLine(to: CGPoint(x: cx - w * 0.18, y: bodyTop + (bodyBot - bodyTop) * 0.5))
            context.stroke(leftArm, with: shading, style: stroke)

            guard wrongAttempts > 3 else { return }

            // Estágio 4 — Braço direito
            var rightArm = Path()
            rightArm.move(to: CGPoint(x: cx, y: bodyTop + (bodyBot - bodyTop) * 0.25))
            rightArm.addLine(to: CGPoint(x: cx + w * 0.18, y: bodyTop + (bodyBot - bodyTop) * 0.5))
            context.stroke(rightArm, with: shading, style: stroke)

            guard wrongAttempts > 4 else { return }

            // Estágio 5 — Perna esquerda
            var leftLeg = Path()
            leftLeg.move(to: CGPoint(x: cx, y: bodyBot))
            leftLeg.addLine(to: CGPoint(x: cx - w * 0.18, y: h * 0.88))
            context.stroke(leftLeg, with: shading, style: stroke)

            guard wrongAttempts > 5 else { return }

            // Estágio 6 — Perna direita
            var rightLeg = Path()
            rightLeg.move(to: CGPoint(x: cx, y: bodyBot))
            rightLeg.addLine(to: CGPoint(x: cx + w * 0.18, y: h * 0.88))
            context.stroke(rightLeg, with: shading, style: stroke)
        }
        .animation(.easeInOut(duration: 0.25), value: wrongAttempts)
    }
}

// MARK: - Letter Button

private struct LetterButton: View {
    let letter: Character
    let isUsed: Bool
    let isCorrect: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            ZodiakText(verbatim: String(letter), style: .body(bold: true, color: labelColor))
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .background(backgroundColor)
                .cornerRadius(ZodiakRadii.xs)
                .animation(.easeInOut(duration: 0.15), value: isUsed)
        }
        .disabled(isUsed)
        .accessibilityLabel(Text(verbatim: String(letter)))
        .accessibilityAddTraits(isUsed ? .isStaticText : [])
    }

    private var backgroundColor: Color {
        if !isUsed { return ZodiakColors.surfaceSmoke }
        return isCorrect ? ZodiakColors.surfacePositive : ZodiakColors.surfaceNegative
    }

    private var labelColor: ZodiakTextColor {
        if !isUsed { return .primary }
        return isCorrect ? .primary : .negative
    }
}

// MARK: - Preview

#Preview {
    HangmanGameScreen()
}
