> **Platform**: iOS

# Navigation Atoms — `Shared/DesignSystem/Atoms/Navigation/`

```swift
// Breadcrumb
struct ZodiakBreadcrumbItem {
    let title: String
    let action: (() -> Void)?
    init(title: String, action: (() -> Void)? = nil)
}
ZodiakBreadcrumb(items: [ZodiakBreadcrumbItem])

// Pagination
ZodiakPagination(currentPage: Binding<Int>, totalPages: Int, maxVisible: Int = 5)

// Mini context menu
struct ZodiakMiniMenuItem {
    let id: String; let label: String; let icon: String?
    let isDestructive: Bool; let isDisabled: Bool
    let action: () -> Void
    init(id: String, label: String, icon: String? = nil,
         isDestructive: Bool = false, isDisabled: Bool = false,
         action: @escaping () -> Void)
}
ZodiakMiniMenu(items: [ZodiakMiniMenuItem], showDividers: Bool = true)

// Carousel dot counter
ZodiakSliderCounter(totalItems: Int, currentIndex: Binding<Int>, showCounter: Bool = true)
```

---
