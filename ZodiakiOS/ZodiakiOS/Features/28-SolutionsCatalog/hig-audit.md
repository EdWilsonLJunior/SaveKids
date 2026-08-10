# HIG Audit: 28-SolutionsCatalog

**Generated**: 2026-05-25
**Project**: /Users/mrocha/Developer/Zodiak/ZodiakiOS/ZodiakiOS/Features/28-SolutionsCatalog
**Frameworks detected**: swiftui
**Files scanned**: 6 code, 0 style, 0 config

**Quick stats**: 1 potential concerns, 1 positive patterns, 8 component usages detected across 6 HIG categories

## Instructions for AI Evaluator

You are reviewing a project for Apple Human Interface Guidelines compliance.
The HIG principles (accessibility, color systems, typography, responsive layout, motion) apply to all surfaces — native, web, and cross-platform.
For each category below, evaluate the code excerpts against the HIG reference material.

**Scoring**: Rate each category 1-10:
- **9-10**: Excellent HIG compliance, follows best practices
- **7-8**: Good compliance with minor improvements possible
- **5-6**: Partial compliance, several areas need attention
- **3-4**: Significant HIG violations
- **1-2**: Major violations or missing fundamental practices

**Output**: For each category, provide:
1. Score (1-10)
2. What's done well (cite specific code)
3. What needs improvement (cite specific file:line)
4. Specific fix recommendations

## Category: Menus & Actions

*2 detections across 2 file(s) — 0 concern(s), 0 positive(s)*

### Code Excerpts

**SolutionsCatalogScreen.swift**
```swift
L24: .toolbar {
```

**Components/SolutionFilterSheet.swift**
```swift
L50: .toolbar {
```

### HIG Reference

1. **Menus should be contextual and predictable.** Standard items in standard locations. Follow platform conventions for ordering and grouping.

2. **Use standard button styles.** System-defined styles communicate affordance and maintain visual consistency. Prefer them over custom designs.

3. **Toolbars for frequent actions.** Most commonly used commands in the toolbar. Rarely used actions belong in menus.

4. **Menu bar is the primary command interface on macOS.** Every command reachable from the menu bar. Toolbars and context menus supplement, not replace.

5. **Context menus for secondary actions.** Right-click or long-press, relevant to the item under the pointer. Never put a command only in a context menu.

6. **Pop-up buttons for mutually exclusive choices.** Select exactly one option from a set.

7. **Pull-down buttons for action lists.** No current selection; they offer a set of commands.

8. **Action buttons consolidate related actions** behind a single icon in toolbars or title bars.

9. **Disclosure controls for progressive disclosure.** Show or hide additional content.

10. **Dock menus: short and focused** on the most useful actions when the app is running.

### Evaluate

- Context menus provide relevant actions
- Menu organization follows HIG grouping conventions

## Category: Controls

*2 detections across 2 file(s) — 0 concern(s), 0 positive(s)*

### Code Excerpts

**SolutionsCatalogScreen.swift**
```swift
L74: Button {
```

**Components/SolutionFilterSheet.swift**
```swift
L52: Button(String(localized: "shared.action.clear")) {
```

### HIG Reference

1. **Clear current state.** Users must always see what is selected. Toggles show on/off, segmented controls highlight the active segment, pickers display the current selection.

2. **Prefer standard system controls.** Built-in controls provide consistency and accessibility. Custom controls introduce a learning curve and may break assistive features.

3. **Toggles for binary states.** On or off. In Settings-style screens, changes take effect immediately. In modal forms, changes commit on confirmation.

4. **Segmented controls for mutually exclusive options.** 2-5 items, roughly equal importance, short labels.

5. **Sliders for continuous values.** When precise numeric input is not critical. Provide min/max labels or icons for range endpoints.

6. **Pickers for long option lists.** Too many options for a segmented control. Works well for dates, times, structured data.

7. **Steppers for small, precise adjustments.** Increment/decrement in fixed steps. Display current value next to the stepper with reasonable min/max bounds.

8. **Text fields for short, single-line input.** Text views for multi-line. Configure keyboard type to match expected input (email, URL, number).

9. **Combo boxes: text input + selection list.** macOS. Type a value or choose from a predefined list when custom values are valid.

10. **Token fields: discrete values as visual tokens.** macOS. For email recipients, tags, or collections of discrete items.

11. **Gauges and rating indicators display values.** Gauges show a value within a range. Rating indicators show ratings (often stars). Display-only; use interactive variants for input.

### Evaluate

- Standard control usage (Button, Toggle, Picker, etc.)
- Proper button styles and roles
- Clear action labels and consistent interaction patterns

## Category: Foundations

*2 detections across 2 file(s) — 1 concern(s), 1 positive(s)*

### Code Excerpts

**SolutionsCatalogScreen.swift**
```swift
L86: .accessibilityLabel(String(localized: "feature.solutions_catalog.filter_button_label")) // ✓ good
```

**Components/SolutionFilterSheet.swift**
```swift
L22: ZodiakColors.background.ignoresSafeArea() // ⚠ concern
```

### HIG Reference

1. **Prioritize content over chrome.** Reduce visual clutter. Use system-provided materials and subtle separators rather than heavy borders and backgrounds.

2. **Build in accessibility from the start.** Design for VoiceOver, Dynamic Type, Reduce Motion, Increase Contrast, and Switch Control from day one. Every interactive element needs an accessible label.

3. **Use system colors and materials.** System colors adapt to light/dark mode, increased contrast, and vibrancy. Prefer semantic colors (`label`, `secondaryLabel`, `systemBackground`) over hard-coded values.

4. **Use platform fonts and icons.** SF Pro, SF Compact, SF Mono by default. New York for serif. Follow the type hierarchy at recommended sizes. Use SF Symbols for iconography.

5. **Match platform conventions.** Align look and behavior with system standards. Provide direct, responsive manipulation and clear feedback for every action.

6. **Respect privacy.** Request permissions only when needed, explain why clearly, provide value before asking for data. Design for minimal data collection.

7. **Support internationalization.** Accommodate text expansion, right-to-left scripts, and varying date/number formats. Use Auto Layout for dynamic content sizing.

8. **Use motion purposefully.** Animation should communicate meaning and spatial relationships. Honor Reduce Motion by providing crossfade alternatives.

### Evaluate

- Color usage: system semantic colors vs hardcoded values
- Typography: Dynamic Type text styles vs fixed font sizes
- Accessibility: labels, hints, traits on interactive elements
- Dark mode: proper color adaptation, no hardcoded light/dark values
- Motion: Reduce Motion support for animations

## Category: Layout & Navigation

*2 detections across 1 file(s) — 0 concern(s), 0 positive(s)*

### Code Excerpts

**Components/SolutionFilterSheet.swift**
```swift
L20: NavigationStack {
L23: ScrollView {
```

### HIG Reference

1. **Organize hierarchically.** Structure information from broad categories to specific details. Sidebars for top-level sections, lists for browsable items, detail views for individual content.

2. **Use standard navigation patterns.** Tab bars for flat navigation between peer sections (iPhone). Sidebars for deep hierarchical navigation (iPad, Mac). Match the pattern to the information architecture and platform.

3. **Adapt to screen size.** Three-column on iPad collapses to single-column on iPhone. Use size classes and adaptive APIs (NavigationSplitView) for automatic adaptation.

4. **Support multitasking on iPad.** Respond gracefully to Split View, Slide Over, and Stage Manager. Test at every split ratio and size class transition.

5. **Maintain spatial consistency on visionOS.** Windows, volumes, and ornaments in shared space. Position predictably. Use ornaments for toolbars and controls without occluding content.

6. **Use scroll views for overflow content.** Enable paging for discrete content units. Support pull-to-refresh where appropriate. Respect safe areas.

7. **Keep navigation predictable.** Users should always know where they are, how they got there, and how to go back. Use back buttons, breadcrumbs, and clear section titles.

8. **Prefer system components.** UINavigationController, UISplitViewController, NavigationSplitView, and TabView provide built-in adaptivity, accessibility, and state restoration.

### Evaluate

- Navigation pattern matches app structure (tabs for flat, sidebar for deep)
- Adaptive layout: responds to size classes, multitasking
- Standard navigation components (NavigationSplitView, not deprecated NavigationView)
- Consistent back navigation and spatial hierarchy

## Category: Search & Navigation

*1 detections across 1 file(s) — 0 concern(s), 0 positive(s)*

### Code Excerpts

**SolutionsCatalogScreen.swift**
```swift
L20: .searchable(
```

### HIG Reference

1. **Search: discoverable with instant feedback.** Place search fields where users expect them (top of list, toolbar/navigation bar). Show results as the user types.

2. **Page controls: position in a flat page sequence.** For discrete, equally weighted pages (onboarding, photo gallery). Show current page and total count.

3. **Path controls: file hierarchy navigation.** macOS path controls display location within a directory structure and allow jumping to any ancestor.

4. **Search scopes narrow large result sets.** Provide scope buttons so users can filter without complex queries.

5. **Clear empty states for search.** Helpful message suggesting corrections or alternatives, not a blank screen.

6. **Page controls are not for hierarchical navigation.** Flat, linear sequences only. Use navigation controllers, tab bars, or sidebars for hierarchy.

7. **Keep path controls concise.** Show meaningful segments only. Users can click any segment to navigate directly.

8. **Support keyboard for search.** Command-F and system search shortcuts should activate search.

### Evaluate

- Searchable modifier used for filterable content
- Search suggestions and scopes where appropriate

## Category: Dialogs & Presentations

*1 detections across 1 file(s) — 0 concern(s), 0 positive(s)*

### Code Excerpts

**SolutionsCatalogScreen.swift**
```swift
L29: .sheet(isPresented: $viewModel.isShowingFilter) {
```

### HIG Reference

1. **Alerts: sparingly, for critical situations.** Errors needing attention, destructive action confirmations, or information requiring acknowledgment. They interrupt flow and demand a response.

2. **Sheets: focused tasks that maintain context.** Slides in from the edge (or attaches to a window on macOS). Use for creating items, editing settings, multi-step forms.

3. **Popovers: non-modal on iPad and Mac.** Appear next to the trigger element, dismissed by tapping outside. For additional information, options, or controls without taking over the screen.

4. **Action sheets: choosing among actions.** Present when picking from multiple actions, especially if one is destructive. iPhone: slide up from bottom. iPad: appear as popovers.

5. **Minimize interruptions.** Before reaching for a modal, consider inline presentation or making the action undoable instead.

6. **Concise, actionable alert text.** Short descriptive title. Brief message body if needed. Button labels should be specific verbs ("Delete", "Save"), not "OK".

7. **Mark destructive actions clearly.** Destructive button style (red text). Place destructive buttons where users are less likely to tap reflexively.

8. **Provide a cancel option** for alerts and action sheets with multiple actions. On action sheets, cancel appears at the bottom, separated.

9. **Digit entry: focused and accessible.** Appropriately sized input fields, automatic advancement between digits, support for paste and autofill.

10. **Adapt presentation to platform.** The same interaction may use different components on iPhone, iPad, Mac, and visionOS.

### Evaluate

- Alerts used sparingly for important decisions
- Sheets for focused tasks, popovers for contextual info
- Confirmation dialogs for destructive actions

## Scoring Summary

| Category | Score (1-10) | Key Findings |
|----------|-------------|-------------|
| Menus & Actions | | |
| Controls | | |
| Foundations | | |
| Layout & Navigation | | |
| Search & Navigation | | |
| Dialogs & Presentations | | |
| **Overall** | **/10** | |
