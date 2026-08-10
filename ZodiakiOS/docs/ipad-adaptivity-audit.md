# iPad / Adaptive UI Audit — ZodiakiOS

> **Última auditoria:** 2026-04-30 · **Plataformas:** iPhone (iOS 16+), iPad (iPadOS 16+), Stage Manager (iPadOS 16+).
> **Fonte de verdade:** Zodiak [Overview _ Layout grid.pdf](zodiak-pdf/Overview%20_%20Layout%20grid%20_%20Made%20with%20Supernova.pdf), [Text layout _ Layout grid.pdf](zodiak-pdf/Text%20layout%20_%20Layout%20grid%20_%20Made%20with%20Supernova.pdf).

---

## 📊 Sumário Executivo

| Vetor | Status | Notas |
|---|---|---|
| `NavigationSplitView` em iPad | ✅ usado | `MainTabView` raiz com `.navigationSplitViewStyle(.balanced)` |
| Layout grid Zodiak (5 viewports) | ⚠️ parcial | Impl iOS usa **device idiom**, não largura — divergente do PDF |
| `horizontalSizeClass` | ⚠️ pouco uso | 1 ocorrência (preview) — não dirige layout das features |
| Hover effect (trackpad/Magic Mouse) | ❌ ausente | 0 hits de `.hoverEffect` ou `.onHover` |
| Focus ring (keyboard) | ✅ implementado | `zodiakFocusRing` + `ZodiakColors.actionFocus` |
| Stage Manager / multi-window | ⚠️ não testado | App suporta passivamente via SwiftUI; sem ajuste explícito |
| Drag and drop | ❌ ausente | 0 hits |
| Keyboard shortcuts (`Command+Q`, etc.) | ❌ ausente | 0 `.keyboardShortcut` |
| `contentMaxWidth` para legibilidade | ✅ implementado | `ZodiakSizing.contentMaxWidth = 1024`, `cardMaxWidth = 480` |

---

## 🔍 5 Viewports do PDF Zodiak

O PDF Layout grid define 5 breakpoints **por largura de tela** (não device class):

| Viewport | Largura | Colunas | Margem | Gutter |
|---|---|---|---|---|
| Desktop large | 1920–2400px | 12 | (a confirmar) | (a confirmar) |
| Desktop small | 1280–1919px | 12 | — | — |
| Tablet large | 992–1279px | 6 | — | — |
| Tablet | 768–991px | 6 | — | — |
| Mobile | 320–767px | 4 | — | — |

> Os PDFs precisam ser re-extraídos com `pdftotext -layout` para capturar margens e gutters exatos. Ver `scripts/extract_zodiak_pdfs.sh` (Phase 1 deliverable).

### Mapeamento iOS atual → Zodiak

| Largura iOS típica | Device | Idiom (impl atual) | Viewport Zodiak | Status |
|---|---|---|---|---|
| 320–375pt | iPhone SE | iPhone | Mobile (4 col) | ✅ alinhado |
| 393pt | iPhone std (15) | iPhone | Mobile (4 col) | ✅ alinhado |
| 430pt | iPhone Pro Max | iPhone | Mobile (4 col) | ✅ alinhado |
| 744pt | iPad mini portrait | iPad | Tablet (6 col) | ⚠️ **iOS reporta 4col em portrait** |
| 820pt | iPad 10.9" portrait | iPad | Tablet (6 col) | ⚠️ idem |
| 1024pt | iPad 12.9" portrait | iPad | Tablet large (6 col) | ⚠️ alinhado em count, mas grid difere |
| 1180pt+ | iPad Pro landscape | iPad | Desktop small (12 col) | ⚠️ **iOS reporta 6-8col** |

**Divergência:** o `ZodiakLayoutGrid` atual usa `UIDevice.current.userInterfaceIdiom` + `verticalSizeClass` para escolher **count de coluna** — método estável mas **não responsivo a Stage Manager / split view** (onde a largura efetiva pode ser menor que o device).

---

## 🏗️ Inventário de uso atual

### A. `NavigationSplitView` & navegação iPad
- [MainTabView.swift](../ZodiakiOS/App/MainTabView.swift#L11): `@State columnVisibility: NavigationSplitViewVisibility = .automatic`
- [MainTabView.swift](../ZodiakiOS/App/MainTabView.swift#L39): root `NavigationSplitView` com sidebar (`CatalogSidebarView`) + detail (`CatalogDetailRouter`).
- Estilo: `.balanced` (sidebar e detail proporcionais em iPad). Em iPhone, colapsa para `NavigationStack` automaticamente.

### B. Layout grid
- [ZodiakLayoutGrid.swift](../ZodiakiOS/Shared/DesignSystem/Templates/ZodiakLayoutGrid.swift#L83): detecta iPad via `UIDevice.current.userInterfaceIdiom == .pad`.
- L84: detecta landscape via `verticalSizeClass == .compact`.
- Counts:
  - iPhone SE: 3 (portrait) / 4 (landscape)
  - iPhone std: 4 / 6
  - iPhone Pro Max: 4 / 6
  - iPad mini: 4 / 7
  - iPad Air 11": 5 / 7
  - iPad Pro 13": 6 / 8
- Spacing: `xs` (iPhone) / `s` (iPad) horizontal e vertical.

### C. `horizontalSizeClass`
- [ZodiakAdaptiveTemplate.swift](../ZodiakiOS/Shared/DesignSystem/Templates/ZodiakAdaptiveTemplate.swift#L40): preview macro que injeta `.regular` para simular iPad.
- **Não usado em features para escolher layout.**

### D. `.frame(maxWidth:)` em features (containers responsivos manuais)
- 2 ocorrências encontradas (uso correto via `ZodiakActivityTemplate(maxContentWidth:)` + style global em buttons).
- Features individuais **não definem** `maxWidth` — delegam ao template.

### E. Hover / Focus
- **Hover:** 0 hits.
- **Focus:** `zodiakFocusRing(cornerRadius:)` aplicado em ZodiakButton, ZodiakIconButton, ZodiakArrowButton (focus ring quando navegação por teclado/Tab está ativa). ✅ trackpad+keyboard parcialmente cobertos.

### F. Stage Manager
- App **não trata explicitamente** Stage Manager. SwiftUI funciona, mas o `ZodiakLayoutGrid` baseado em device idiom **não recalcula** quando a janela é redimensionada para uma fração da tela (ex: 50% em Stage Manager).
- **Bug potencial:** em Stage Manager com janela estreita, layout permanece "iPad" (6 colunas) mesmo se a largura efetiva for ~600pt (deveria virar Tablet ou Mobile do PDF).

### G. Multi-window / Scenes
- `ZodiakiOSApp.swift` provavelmente usa `WindowGroup` padrão. Não verificado se há `.windowResizability(.contentSize)` ou ajustes específicos.
- **Recomendação:** usar `.windowResizability(.contentSize)` em macOS / Catalyst se o app for multi-platform.

### H. Keyboard shortcuts
- 0 ocorrências de `.keyboardShortcut`.
- Em iPadOS, ações comuns (close modal = `Esc`, submit form = `Cmd+Enter`, undo = `Cmd+Z`) **não funcionam**.

---

## 🎯 Gaps & Roadmap (Phase 3)

### P0 — Blocking
1. **Layout grid responsivo por largura.** Refatorar [ZodiakLayoutGrid.swift](../ZodiakiOS/Shared/DesignSystem/Templates/ZodiakLayoutGrid.swift) para usar `GeometryReader` + lookup pelos 5 breakpoints do PDF, não device idiom. Resolve Stage Manager + iPhone Plus em landscape.
2. **Hover effect em buttons.** Adicionar `.hoverEffect(.lift)` e `.onHover { ... }` em ZodiakButton/IconButton/ArrowButton/Tabs para experiência iPad+trackpad e Mac Catalyst. PDF Zodiak define hover state explicitamente em todos os specs de button.

### P1
3. **Keyboard shortcuts.** `.keyboardShortcut(.escape)` em modais; `.keyboardShortcut(.return, modifiers: .command)` em submit primary buttons; `.keyboardShortcut(.tab)` para navegação.
4. **Stage Manager smoke test.** UI test: redimensionar janela em Stage Manager e verificar layout adapta.
5. **Conferir `cardMaxWidth=480` e `contentMaxWidth=1024`** contra "Text layout" PDF. Atualmente são valores derivados — validar com diff vs PDF.
6. **Sidebar collapse customizada.** Hoje `MainTabView` usa `.automatic`. Considerar `.detailOnly` em telas full-bleed (Hero, Banner, Modal).

### P2
7. **Drag and drop.** Listas em `07-PersonManager`, `10-TaskManager`, `13-ProductManager` poderiam suportar reorder via drag.
8. **Pointer interactions.** `.contentShape(.hoverEffect, ...)` para ajustar área de hover em cards.
9. **Multiple windows / Scenes.** Configurar `WindowGroup(for: ...)` para abrir feature em janela separada (iPad multitarefa).
10. **`@FocusedValue` / commands.** Menu de barra (Mac Catalyst) usando `.focusedValue` para passar contexto.

### P3
11. **Scroll-to-top toolbar tap** em iPad (já é default em iOS, validar funcionando).
12. **Picture-in-picture** se houver vídeo (não há atualmente).

---

## 📐 Tabela de matching device → viewport (proposta)

> Refatoração proposta para `ZodiakLayoutGrid`:

```swift
enum ZodiakViewport {
    case mobile        // < 768pt
    case tablet        // 768-991
    case tabletLarge   // 992-1279
    case desktopSmall  // 1280-1919
    case desktopLarge  // 1920+

    static func current(for size: CGSize) -> Self {
        switch size.width {
        case ..<768:    return .mobile
        case ..<992:    return .tablet
        case ..<1280:   return .tabletLarge
        case ..<1920:   return .desktopSmall
        default:        return .desktopLarge
        }
    }

    var columnCount: Int {
        switch self {
        case .mobile:                return 4
        case .tablet, .tabletLarge:  return 6
        case .desktopSmall, .desktopLarge: return 12
        }
    }
}
```

Uso:
```swift
GeometryReader { geo in
    let viewport = ZodiakViewport.current(for: geo.size)
    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: viewport.columnCount)) {
        // ...
    }
}
```

**Vantagens:**
- Funciona em Stage Manager.
- Funciona em Mac Catalyst (largura arbitrária).
- Alinha com PDF Zodiak.

**Trade-offs:**
- Recalcula a cada layout pass (custo aceitável para grids).
- Quebra contratos de teste existentes que dependem do `idiom`.

---

## 🛠️ Métricas para acompanhar

- Tempo médio de render em Stage Manager 50/50 — meta < 16ms (60 fps).
- % de features testadas em iPad Pro 13" portrait + landscape — meta 100%.
- % de features com hover state validado — meta 100% das interactivas.
- UI tests em iPad Air 11" — meta 100% das features passando.

---

*Documento canônico de adaptividade. Atualizar quando refatoração de viewport for executada.*
