import SwiftUI

// MARK: - Zodiak Input Wizard
// Figma: Input > Input wizard
// Multi-step form with a persistent header progress bar and per-step navigation.

// MARK: - Wizard Step Model

struct ZodiakWizardStep: Identifiable {
    let id: UUID
    let title: LocalizedStringKey
    let subtitle: LocalizedStringKey?
    /// When `false`, the Next button is disabled — blocks forward navigation until the step is valid.
    var canProceed: Bool
    @ViewBuilder var content: () -> AnyView

    init<Content: View>(
        id: UUID = UUID(),
        title: LocalizedStringKey,
        subtitle: LocalizedStringKey? = nil,
        canProceed: Bool = true,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.canProceed = canProceed
        self.content = { AnyView(content()) }
    }
}

// MARK: - ZodiakInputWizard

struct ZodiakInputWizard: View {
    let title: LocalizedStringKey
    let steps: [ZodiakWizardStep]
    var onComplete: (() -> Void)?
    var onCancel: (() -> Void)?

    var submitLabel: LocalizedStringKey = "shared.action.finish"
    var nextLabel: LocalizedStringKey = "shared.action.next"
    var backLabel: LocalizedStringKey = "shared.action.back"

    @State private var currentIndex: Int = 0
    @State private var completedIndices: Set<Int> = []
    @State private var showSuccess = false
    @State private var iconScale: Double = 0.3
    @Environment(\.locale) private var locale
    @Environment(\.horizontalSizeClass) private var sizeClass

    /// Dot diameter: 24pt on compact (iPhone), 32pt on regular (iPad).
    private var dotSize: CGFloat { sizeClass == .regular ? 32 : 24 }
    private var dotFontSize: CGFloat { sizeClass == .regular ? 14 : 12 }

    private var progress: Double {
        if showSuccess { return 1.0 }
        guard !steps.isEmpty else { return 0 }
        return Double(currentIndex) / Double(steps.count)
    }

    private var currentStep: ZodiakWizardStep { steps[currentIndex] }
    private var isFirst: Bool { currentIndex == 0 }
    private var isLast: Bool { currentIndex == steps.count - 1 }

    var body: some View {
        VStack(spacing: 0) {
            // ── Header ──────────────────────────────────────
            VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                HStack {
                    VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                        ZodiakText(title, style: .title3)
                        ZodiakText(
                            verbatim: String(
                                format: String(localized: "shared.format.step_progress", locale: locale),
                                currentIndex + 1,
                                steps.count
                            ),
                            style: .caption()
                        )
                    }
                    Spacer()
                    if let onCancel {
                        ZodiakIconButton(
                            icon: "xmark",
                            action: onCancel,
                            size: .small,
                            style: .tertiary,
                            accessibilityLabel: String(localized: "shared.action.cancel")
                        )
                    }
                }

                // Step dots + progress bar
                VStack(spacing: ZodiakSpacing.s4) {
                    // Step indicator dots (tappable to navigate back)
                    HStack(spacing: ZodiakSpacing.s4) {
                        ForEach(Array(steps.enumerated()), id: \.offset) { index, _ in
                            stepDot(index: index)
                        }
                        Spacer()
                    }

                    // Progress bar
                    ZodiakProgressBar(
                        progress: progress,
                        color: showSuccess ? ZodiakColors.textPositive : nil
                    )
                }
            }
            .padding(.horizontal, ZodiakSpacing.s32)
            .padding(.top, ZodiakSpacing.s8)
            .safeAreaPadding(.top)
            .padding(.bottom, ZodiakSpacing.s4)
            .background(ZodiakColors.surface.ignoresSafeArea(.container, edges: .top))

            ZodiakDivider(hierarchy: .primary)

            if showSuccess {
                // ── Success overlay ──────────────────────────
                VStack(spacing: ZodiakSpacing.s24) {
                    Spacer()
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 64, weight: .light))
                        .foregroundColor(ZodiakColors.textPositive)
                        .scaleEffect(iconScale)
                        .animation(
                            .spring(response: 0.5, dampingFraction: 0.55),
                            value: iconScale
                        )
                    ZodiakText("shared.state.success_label", style: .title2)
                        .opacity(iconScale > 0.8 ? 1 : 0)
                        .animation(.easeIn(duration: 0.2), value: iconScale)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(ZodiakSpacing.s32)
                .transition(.opacity)
            } else {
                // ── Step content ────────────────────────────────
                ScrollView {
                    VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                        ZodiakText(currentStep.title, style: .title2)
                        if let subtitle = currentStep.subtitle {
                            ZodiakText(subtitle, style: .bodySmall(color: .secondary))
                        }
                        currentStep.content()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(ZodiakSpacing.s32)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing).combined(with: .opacity),
                    removal: .move(edge: .leading).combined(with: .opacity)
                ))
                .id(currentIndex)

                // ── Footer navigation ────────────────────────────
                ZodiakDivider(hierarchy: .primary)

                HStack(spacing: ZodiakSpacing.s8) {
                    // Back
                    if !isFirst {
                        ZodiakButtonSecondary(
                            title: backLabel,
                            action: {
                                withAnimation(.easeInOut(duration: 0.25)) {
                                    currentIndex -= 1
                                }
                            },
                            size: .small,
                            icon: "chevron.left"
                        )
                    }

                    Spacer()

                    // Next / Submit
                    ZodiakButtonPrimary(
                        title: isLast ? submitLabel : nextLabel,
                        action: {
                            if isLast {
                                withAnimation(.easeInOut(duration: 0.4)) {
                                    completedIndices.insert(currentIndex)
                                    showSuccess = true
                                }
                                withAnimation(
                                    .spring(response: 0.55, dampingFraction: 0.55)
                                    .delay(0.35)
                                ) {
                                    iconScale = 1.0
                                }
                                Task {
                                    try? await Task.sleep(for: .seconds(1.4))
                                    onComplete?()
                                }
                            } else {
                                withAnimation(.easeInOut(duration: 0.25)) {
                                    completedIndices.insert(currentIndex)
                                    currentIndex += 1
                                }
                            }
                        },
                        size: .small,
                        icon: isLast ? "checkmark" : "chevron.right",
                        iconPlacement: .trailing,
                        isEnabled: isLast || currentStep.canProceed
                    )
                }
                .padding(.horizontal, ZodiakSpacing.s32)
                .padding(.top, ZodiakSpacing.s16)
                .padding(.bottom, ZodiakSpacing.s16)
                .safeAreaPadding(.bottom)
                .background(ZodiakColors.surface.ignoresSafeArea(.container, edges: .bottom))
            }
        }
        .background(ZodiakColors.background)
        .cornerRadius(ZodiakRadii.s)
        .shadow(color: ZodiakShadows.color, radius: ZodiakShadows.radius, x: ZodiakShadows.x, y: ZodiakShadows.y)
    }

    // Step dot helper — tappable for completed steps to navigate back
    @ViewBuilder
    private func stepDot(index: Int) -> some View {
        let isCompleted = completedIndices.contains(index)
        let isCurrent = index == currentIndex
        let isNavigable = isCompleted && !isCurrent

        ZStack {
            Circle()
                .fill(isCurrent ? ZodiakColors.actionPrimary
                      : isCompleted ? ZodiakColors.surfacePositive
                      : ZodiakColors.borderSecondary)
                .frame(width: dotSize, height: dotSize)
            if isCompleted {
                Image(systemName: "checkmark")
                    .font(.system(size: dotFontSize - 1, weight: .bold)).foregroundColor(.white)
            } else {
                Text("\(index + 1)")
                    .font(.system(size: dotFontSize, weight: .semibold))
                    .foregroundColor(isCurrent ? .white : ZodiakColors.textSecondary)
            }
        }
        .contentShape(Rectangle().size(CGSize(width: 44, height: 44)))
        .animation(.easeInOut(duration: 0.2), value: isCurrent)
        .animation(.easeInOut(duration: 0.2), value: isCompleted)
        .onTapGesture {
            guard isNavigable else { return }
            withAnimation(.easeInOut(duration: 0.25)) { currentIndex = index }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityAddTraits(isNavigable ? [.isButton] : [])
        .accessibilityLabel(Text(verbatim: stepDotLabel(index: index, isCurrent: isCurrent, isCompleted: isCompleted)))
        .accessibilityHint(isNavigable ? Text("shared.accessibility.step_tap_hint") : Text(verbatim: ""))
    }

    private func stepDotLabel(index: Int, isCurrent: Bool, isCompleted: Bool) -> String {
        let state = isCurrent
            ? String(localized: "shared.accessibility.step_current", locale: locale)
            : isCompleted
            ? String(localized: "shared.accessibility.step_completed", locale: locale)
            : ""
        return String(format: String(localized: "shared.format.step_with_state", locale: locale), index + 1, state)
    }
}

// MARK: - Preview

#Preview("Input Wizard") {
    NavigationStack {
        ScrollView {
            ZodiakInputWizard(
                title: "catalog.spec.new_project",
                steps: [
                    ZodiakWizardStep(
                        title: "catalog.spec.basic_info",
                        subtitle: "catalog.spec.fill_name_desc_hint"
                    ) {
                        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                            ZodiakLabelledField(
                                label: "Nome do projeto",
                                placeholder: "shared.placeholder.ex_project_name",
                                text: .constant("")
                            )
                            ZodiakLabelledField(
                                label: "Descrição",
                                placeholder: "shared.placeholder.project_summary",
                                text: .constant("")
                            )
                        }
                    },
                    ZodiakWizardStep(
                        title: "catalog.spec.label_team",
                        subtitle: "catalog.spec.add_owners_hint"
                    ) {
                        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                            ZodiakLabelledField(
                                label: "Líder técnico",
                                placeholder: "shared.label.name",
                                text: .constant(""))
                            ZodiakLabelledField(
                                label: "Designer responsável",
                                placeholder: "shared.label.name",
                                text: .constant(""))
                        }
                    },
                    ZodiakWizardStep(
                        title: "app.settings.title",
                        subtitle: "Defina as preferências do projeto."
                    ) {
                        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                            ZodiakLabelledField(
                                label: "Prazo",
                                placeholder: "shared.placeholder.date",
                                text: .constant(""))
                            ZodiakLabelledField(
                                label: "Plataformas",
                                placeholder: "shared.placeholder.platforms",
                                text: .constant("")
                            )
                        }
                    }
                ],
                onComplete: {},
                onCancel: {}
            )
            .padding()
        }
        .navigationTitle("Wizard")
    }
}
