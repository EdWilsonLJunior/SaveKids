import SwiftUI

// MARK: - Zodiak Breadcrumb
// Figma: "catalog.spec.breadcrumb" — navigation trail showing current location in hierarchy

/// Item individual de um breadcrumb com título e ação opcional ao toque.
public struct ZodiakBreadcrumbItem {
    /// Texto exibido no item.
    public let title: String
    /// Ação executada ao tocar no item; `nil` quando o item não é clicável.
    public let action: (() -> Void)?

    /// Cria um item de breadcrumb.
    /// - Parameters:
    ///   - title: Texto exibido no item.
    ///   - action: Ação ao tocar; `nil` desabilita a interação.
    public init(title: String, action: (() -> Void)? = nil) {
        self.title = title
        self.action = action
    }
}

public struct ZodiakBreadcrumb: View {
    let items: [ZodiakBreadcrumbItem]

    public init(items: [ZodiakBreadcrumbItem]) {
        self.items = items
    }

    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: ZodiakSpacing.s4) {
                ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                    HStack(spacing: ZodiakSpacing.s4) {
                        if index > 0 {
                            Image(systemName: "chevron.right")
                                .font(.system(size: 10, weight: .medium))
                                .foregroundColor(ZodiakColors.textDisabled)
                        }

                        let isLast = index == items.count - 1

                        if let action = item.action, !isLast {
                            Button(item.title, action: action)
                                .font(ZodiakTypography.captionLarge)
                                .foregroundColor(ZodiakColors.textLink)
                                .zodiakA11yID("breadcrumb")
                        } else {
                            Text(item.title)
                                .font(ZodiakTypography.captionLarge)
                                .foregroundColor(isLast ? ZodiakColors.textPrimary : ZodiakColors.textSecondary)
                                .fontWeight(isLast ? .semibold : .regular)
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Zodiak Pagination
// Figma: "catalog.spec.pagination" — page navigation control with prev/next and page numbers

public struct ZodiakPagination: View {
    @Binding var currentPage: Int
    let totalPages: Int
    let maxVisible: Int

    public init(currentPage: Binding<Int>, totalPages: Int, maxVisible: Int = 5) {
        self._currentPage = currentPage
        self.totalPages = totalPages
        self.maxVisible = maxVisible
    }

    private var visiblePages: [Int?] {
        guard totalPages > maxVisible else {
            return (1...totalPages).map { Optional($0) }
        }

        var pages: [Int?] = []
        let half = maxVisible / 2
        var start = currentPage - half
        var end = currentPage + half

        if start < 1 { start = 1; end = maxVisible }
        if end > totalPages { end = totalPages; start = totalPages - maxVisible + 1 }

        if start > 1 {
            pages.append(1)
            if start > 2 { pages.append(nil) } // ellipsis
        }

        for p in start...end { pages.append(p) }

        if end < totalPages {
            if end < totalPages - 1 { pages.append(nil) } // ellipsis
            pages.append(totalPages)
        }

        return pages
    }

    public var body: some View {
        HStack(spacing: ZodiakSpacing.s4) {
            // Previous
            pageArrow("chevron.left", enabled: currentPage > 1) {
                if currentPage > 1 { currentPage -= 1 }
            }

            // Page numbers
            ForEach(Array(visiblePages.enumerated()), id: \.offset) { _, page in
                if let p = page {
                    pageButton(p)
                } else {
                    Text("shared.label.ellipsis")
                        .font(ZodiakTypography.captionLarge)
                        .foregroundColor(ZodiakColors.textDisabled)
                        .frame(width: 32, height: 32)
                }
            }

            // Next
            pageArrow("chevron.right", enabled: currentPage < totalPages) {
                if currentPage < totalPages { currentPage += 1 }
            }
        }
    }

    private func pageButton(_ page: Int) -> some View {
        let isActive = page == currentPage
        return Button {
            withAnimation(.spring(response: 0.2)) { currentPage = page }
        } label: {
            Text(verbatim: "\(page)")
                .font(ZodiakTypography.captionLarge.weight(isActive ? .semibold : .regular))
                .foregroundColor(isActive ? ZodiakColors.textInverse : ZodiakColors.textPrimary)
                .frame(width: ZodiakSizing.Icon.l, height: ZodiakSizing.Icon.l)
                .background(
                    Circle()
                        .fill(isActive ? ZodiakColors.actionPrimary : Color.clear)
                )
        }
        .buttonStyle(.plain)
        .zodiakA11yID("breadcrumb")
    }

    private func pageArrow(_ icon: String, enabled: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(enabled ? ZodiakColors.actionPrimary : ZodiakColors.textDisabled)
                .frame(width: ZodiakSizing.Icon.l, height: ZodiakSizing.Icon.l)
                .background(
                    Circle()
                        .stroke(enabled ? ZodiakColors.borderPrimary : ZodiakColors.borderSecondary, lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
        .disabled(!enabled)
    }
}
