import SwiftUI

// MARK: - Zodiak Modal
// Figma: "catalog.component_name.modal" component
// Full-screen dimmed overlay presenting a centered card with optional title,
// close button, body content and action buttons.
// For iOS bottom-sheet usage, use .sheet() or ZodiakBottomSheet instead.

struct ZodiakModal<Content: View>: View {
    @Binding var isPresented: Bool
    var title: String?
    var showCloseButton: Bool = true
    /// Called when the modal is dismissed (backdrop tap or close button).
    var onDismiss: (() -> Void)?
    @ViewBuilder let content: () -> Content
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    private func dismiss() {
        isPresented = false
        onDismiss?()
    }

    var body: some View {
        ZStack {
            // Backdrop
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture { dismiss() }

            // Card
            VStack(alignment: .leading, spacing: 0) {
                // Header
                if title != nil || showCloseButton {
                    HStack(alignment: .top) {
                        if let title {
                            Text(LocalizedStringKey(title))
                                .font(ZodiakTypography.titleSmall)
                                .foregroundColor(ZodiakColors.textPrimary)
                        }
                        Spacer()
                        if showCloseButton {
                            ZodiakCloseButton { dismiss() }
                        }
                    }
                    .padding(.horizontal, ZodiakSpacing.s16)
                    .padding(.top, ZodiakSpacing.s16)
                    .padding(.bottom, title != nil ? ZodiakSpacing.s8 : 0)
                }

                // Body
                content()
                    .padding(.horizontal, ZodiakSpacing.s16)
                    .padding(.vertical, ZodiakSpacing.s16)
            }
            .background(ZodiakColors.surface)
            .cornerRadius(ZodiakRadii.m)
            .frame(maxWidth: 480)
            .padding(.horizontal, ZodiakSpacing.s16)
            .shadow(
                color: Color.black.opacity(0.18),
                radius: 24,
                x: 0,
                y: 8
            )
            .zodiakA11yID("modal")
            .transition(
                reduceMotion
                    ? AnyTransition.opacity
                    : AnyTransition.scale(scale: 0.94).combined(with: AnyTransition.opacity)
            )
        }
        .zodiakAnimation(.spring(response: 0.3, dampingFraction: 0.8), value: isPresented)
    }
}

// MARK: - Modal ViewModifier
// Usage: .zodiakModal(isPresented: $show) { ... }

struct ZodiakModalModifier<ModalContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    var title: String?
    var showCloseButton: Bool
    var onDismiss: (() -> Void)?
    @ViewBuilder let modalContent: () -> ModalContent

    func body(content: Content) -> some View {
        ZStack {
            content
            if isPresented {
                ZodiakModal(
                    isPresented: $isPresented,
                    title: title,
                    showCloseButton: showCloseButton,
                    onDismiss: onDismiss,
                    content: modalContent
                )
                .zIndex(999)
            }
        }
    }
}

extension View {
    func zodiakModal<C: View>(
        isPresented: Binding<Bool>,
        title: String? = nil,
        showCloseButton: Bool = true,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> C
    ) -> some View {
        modifier(ZodiakModalModifier(
            isPresented: isPresented,
            title: title,
            showCloseButton: showCloseButton,
            onDismiss: onDismiss,
            modalContent: content
        ))
    }
}

// MARK: - Zodiak Bottom Sheet
// iOS adaptation of Figma "Form in drawer" (slides from bottom on mobile)
// Wraps system .sheet() with Zodiak styling and a drag indicator.

struct ZodiakBottomSheet<Content: View>: View {
    @Binding var isPresented: Bool
    var title: String?
    var detents: Set<PresentationDetent> = [.medium, .large]
    @ViewBuilder let content: () -> Content

    var body: some View {
        Color.clear
            .sheet(isPresented: $isPresented) {
                NavigationStack {
                    VStack(alignment: .leading, spacing: 0) {
                        content()
                    }
                    .navigationTitle(Text(LocalizedStringKey(title ?? "")))
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        if title != nil || true {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("shared.action.close") { isPresented = false }
                                    .foregroundColor(ZodiakColors.actionPrimary)
                            }
                        }
                    }
                }
                .presentationDetents(detents)
                .presentationDragIndicator(.visible)
            }
    }
}

// MARK: - Previews
#Preview("Modal") {
    ZStack {
        ZodiakColors.background.ignoresSafeArea()

        VStack(spacing: ZodiakSpacing.s16) {
            Text("Conteúdo da tela")
                .font(ZodiakTypography.bodyMedium)
                .foregroundColor(ZodiakColors.textPrimary)
        }
    }
    .zodiakModal(isPresented: .constant(true), title: "Confirmar ação") {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s16) {
            Text("Tem certeza que deseja prosseguir? Esta ação não pode ser desfeita.")
                .font(ZodiakTypography.bodyMedium)
                .foregroundColor(ZodiakColors.textSecondary)

            HStack(spacing: ZodiakSpacing.s8) {
                ZodiakButtonSecondary(title: "shared.action.cancel", action: {})
                ZodiakButtonPrimary(title: "shared.action.confirm", action: {})
            }
        }
    }
}
