import SwiftUI

// MARK: - ZodiakFormContainer
/// Container adaptativo para formulários — responde a iPhone/iPad

struct ZodiakFormContainer<Content: View>: View {
    let content: Content

    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    private var isRegularWidth: Bool { horizontalSizeClass == .regular }
    private var padding: CGFloat { isRegularWidth ? ZodiakSpacing.s32 : ZodiakSpacing.s16 }
    private var spacing: CGFloat { isRegularWidth ? ZodiakSpacing.s16 : ZodiakSpacing.s8 }

    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            content
        }
        .padding(padding)
        .background(ZodiakColors.surface)
        .cornerRadius(ZodiakRadii.s)
    }
}

#Preview {
    ZodiakFormContainer {
        ZodiakText("Campo 1", style: .body())
        ZodiakText("Campo 2", style: .body())
    }
    .padding(ZodiakSpacing.s16)
    .background(ZodiakColors.background)
}
