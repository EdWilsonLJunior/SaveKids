# Tabs

> **Categoria**: Atom · **Prioridade**: P0 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Sim

## Contexto
Componente de navegação de abas — alterna entre conteúdos relacionados na mesma tela. Suporta variantes `fixed` (largura igual) e `scrollable`, light/dark.

## História de usuário
Como **usuário**, quero **alternar entre abas** para **acessar conteúdos relacionados sem trocar de tela**.

## Critérios de aceite

### Cenário 1 — Variantes
**Dado** Supernova [`Overview - Tabs.md`](../../ZodiakiOS/docs/zodiak-pdf/Overview%20-%20Tabs.md)
**Então** suporta `fixed` e `scrollable`, com ou sem ícone.

### Cenário 2 — Seleção
**Dado** aba selecionada
**Então** indicador (barra inferior) e cor de label corretos; outras abas em estado default.

### Cenário 3 — Light/Dark
**Dado** dark mode
**Então** Supernova [`Overview - Tabs darkmode.md`](../../ZodiakiOS/docs/zodiak-pdf/Overview%20-%20Tabs%20darkmode.md) aplica.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** anuncia "Aba <título>, <i> de <n>, selecionado/não selecionado"; swipe horizontal navega; double-tap seleciona.

### Cenário 5 — Swipe entre conteúdos
**Dado** swipe horizontal no conteúdo
**Então** muda aba (quando `swipeable: true`).

## Spec técnica

### APIs públicas
- `ZodiakTabs(selection: Binding<Int>, items: [ZodiakTabItem], variant: ZodiakTabsVariant = ZodiakTabsVariant.fixed)` + `ZodiakTabsContent { ... }`.

### Tokens
- Tipografia: `typography.labelLarge`.
- Cor label: `textPrimary` (selecionado), `textSecondary` (não selecionado).
- Indicador: `colors.actionPrimary`; espessura via [borders](../00-foundations/borders.md).

## Boas práticas — iOS
- **Assinatura concreta**: `ZodiakTabs(selection: Binding<Int>, items: [ZodiakTabItem], variant: ZodiakTabsVariant = .fixed)` + `ZodiakTabsContent { ... }`.

- SwiftUI: `TabView` para navegação raiz; para tabs in-page, custom com `HStack + indicator`.
- HIG: [Tab bars](https://developer.apple.com/design/human-interface-guidelines/tab-bars).
- `.accessibilityRotor` para navegação entre tabs.

## Boas práticas — Android
- **Assinatura concreta**: `@Composable fun ZodiakTabs(selectedIndex: Int, onSelect: (Int) -> Unit, items: List<ZodiakTabItem>, variant: ZodiakTabsVariant = Fixed)` + companion content.

- Material 3: `TabRow` (fixed) e `ScrollableTabRow`.
- `Tab(selected, onClick, text = { Text(...) }, icon = { Icon(...) })`.
- Pager + tabs: `HorizontalPager(state) + TabRow(state.currentPage)`.

## Acessibilidade
- Papel `tab` / `tablist`.
- Indicador de aba selecionada anunciado.
- Hit-target de cada tab ≥ `Zodiak.hitTarget.minimum`.

## Referências
- [iOS `Atoms/Tabs/ZodiakTabs.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Atoms/Tabs/ZodiakTabs.swift)
- [Supernova: Overview](../../ZodiakiOS/docs/zodiak-pdf/Overview%20-%20Tabs.md)
- [Supernova: Dark](../../ZodiakiOS/docs/zodiak-pdf/Overview%20-%20Tabs%20darkmode.md)
- [Supernova: Guidelines](../../ZodiakiOS/docs/zodiak-pdf/Guidelines%20-%20Tabs.md)
- [Supernova: Specs](../../ZodiakiOS/docs/zodiak-pdf/Specs%20-%20Tabs.md)

## Gaps & dúvidas para o time de Design
- [ ] Suporte oficial a **badge em tab**?
- [ ] Tabs verticais (rail-style) para tablet?

## DoD
- [ ] Fixed + scrollable.
- [ ] Sincronização com pager.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Importação
```tsx
import { Tabs } from '@cg-groupit/zodiak-design-system';
import type { TabItem } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `tabs` | `TabItem[]` | — | Definições de abas (máx. 7, obrigatório) |
| `onTabChange` | `(index: number) => void` | — | Callback ao trocar de aba |
| `centerAlign` | `boolean` | `false` | Centraliza o strip de abas em tablet+ |
| `panelClassName` | `string` | — | Classe extra no painel de conteúdo |

### Acessibilidade
- Padrão ARIA `role="tablist"` / `role="tab"` / `role="tabpanel"` com navegação por seta.
- Cada `TabItem` deve ter `label` descritivo.

### Storybook
- `AllOptions`: variações de quantidade de abas e alinhamento
- `Playground`: controles interativos com conteúdo de painel configurável
