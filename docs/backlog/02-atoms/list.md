# List (atom)

> **Categoria**: Atom · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Sim

## Contexto
`ZodiakList` é o atom estrutural para listas verticais simples — não confundir com `ZodiakListings` (organism para listagens complexas com filtros). Cobre o padrão "row com leading icon + label + supporting text + trailing accessory + divider".

## História de usuário
Como **desenvolvedor**, quero **exibir uma lista de itens com `ZodiakList`** para que **layout, divider, leading/trailing e acessibilidade sigam o DS**.

## Critérios de aceite

### Cenário 1 — Variantes
**Dado** `ZodiakList` com itens com `leading`, `trailing`, `subtitle`, `disclosure indicator`
**Então** renderiza conforme Supernova [`Overview - List.md`](../../ZodiakiOS/docs/zodiak-pdf/Overview%20-%20List.md).

### Cenário 2 — Estados
**Dado** item `selected`, `disabled`, `pressed`
**Então** estados visuais corretos via tokens.

### Cenário 3 — Light/Dark
**Dado** dark
**Então** tokens resolvem; divider entre itens visível.

### Cenário 4 — Acessibilidade
**Dado** TalkBack/VoiceOver
**Então** cada row é um elemento; trailing chevron não é falado; selecionado anuncia "selecionado".

### Cenário 5 — Performance
**Dado** 1000 itens
**Então** virtualização nativa por plataforma sem queda de fps.

## Spec técnica

### APIs públicas
- `ZodiakList { ForEach(items) { ZodiakListRow(...) } }`. `ZodiakListRow(leading: Slot, title: String, subtitle: String? = none, trailing: Slot, isSelected: Bool = false, action: Action)`.

### Tokens
- Padding: `spacing.s16` horizontal, `spacing.s12` vertical.
- Tipografia: title = `bodyLarge`, subtitle = `bodyMedium`/`labelMedium`.
- Cor: title `textPrimary`, subtitle `textSecondary`.
- Divider: ver [divider](divider.md).

## Boas práticas — iOS
- **Assinatura concreta**: `ZodiakList { ForEach(items) { ZodiakListRow(...) } }`. `ZodiakListRow(leading: Slot, title: String, subtitle: String? = none, trailing: Slot, isSelected: Bool = false, action: Action)`.

- SwiftUI nativo: `List`/`LazyVStack`. Para conteúdo customizado, `LazyVStack` (sem chrome do List).
- HIG: [Lists and tables](https://developer.apple.com/design/human-interface-guidelines/lists-and-tables).
- `.swipeActions` para ações deslizar (quando necessário).
- `.listRowSeparator(.hidden)` quando divider for via DS.

## Boas práticas — Android
- **Assinatura concreta**: `LazyColumn { items(...) { ZodiakListRow(...) } }`. Composable equivalente.

- Material 3: `ListItem` é o composable de referência (`ListItem(headlineContent, supportingContent, leadingContent, trailingContent)`).
- `LazyColumn(state: LazyListState)` para virtualização.
- `Modifier.combinedClickable` para click + long-press.

## Acessibilidade
- Cada row é um elemento único de a11y (filhos mesclados no nó pai).
- `traversalIndex` para ordem de foco quando layout complexo.
- Hit-target row ≥ `Zodiak.hitTarget.minimum`.

## Referências
- [iOS `Atoms/List/ZodiakList.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Atoms/List/ZodiakList.swift)
- [Supernova: Overview](../../ZodiakiOS/docs/zodiak-pdf/Overview%20-%20List.md)
- [Supernova: Guidelines](../../ZodiakiOS/docs/zodiak-pdf/Guidelines%20-%20List.md)
- [Supernova: Specs](../../ZodiakiOS/docs/zodiak-pdf/Specs%20-%20List.md)

## Gaps & dúvidas para o time de Design
- [ ] Variante "três linhas" (title + supporting + meta) — está documentada?
- [ ] Swipe actions oficiais (delete, archive)?

## DoD
- [ ] `ZodiakList` + `ZodiakListRow` exportados.
- [ ] Virtualização verificada com 1000+ itens.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
