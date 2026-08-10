# ChipGroup

> **Categoria**: Molecule · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Sim (Chip)

## Contexto
Conjunto de chips para seleção (single ou multi). Layout em fluxo (wrap) ou linha rolável. Atom `ZodiakChip` é a unidade.

## História de usuário
Como **usuário**, quero **filtrar/selecionar opções rapidamente** via **chips agrupados**.

## Critérios de aceite

### Cenário 1 — Modo de seleção
**Dado** `selectionMode: .single | .multiple | .none`
**Então** comportamento correto; `none` apenas exibe (ex.: tags).

### Cenário 2 — Layout
**Dado** `layout: .wrap | .horizontalScroll`
**Então** chips quebram linha ou rolam.

### Cenário 3 — Estados
**Dado** chip `default/selected/disabled`
**Então** estados via tokens.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** anuncia grupo + cada chip com estado; `selectableGroup` (Android) / contain (iOS).

### Cenário 5 — Light/Dark
**Dado** dark
**Então** tokens resolvem.

## Spec técnica

### APIs públicas
- `ZodiakChipGroup(items: [ZodiakChipItem], selection: Binding<Set<String>>, selectionMode: ZodiakChipSelectionMode = ZodiakChipSelectionMode.multiple, layout: ZodiakChipLayout = ZodiakChipLayout.wrap)`.
- `ZodiakChip(label: String, isSelected: Bool, leadingIcon: ZodiakIcon? = none, trailingIcon: ZodiakIcon? = none, state: ZodiakChipState = ZodiakChipState.normal, onTap: Action)` — também usável fora do grupo.

### Tokens
- Cores: `colors.surfaceVariant` (default), `actionPrimary` (selected fill ou outline).
- Tipografia: `labelMedium`.
- Raio: `radii.full`. Padding: `spacing.s12` horizontal.
- Hit-target ≥ 32 (chip compact) com padding tap extra.

## Boas práticas — iOS
- HIG: [Pickers](https://developer.apple.com/design/human-interface-guidelines/pickers).
- FlowLayout para wrap (iOS 16+ via `Layout` protocol ou via lib).

## Boas práticas — Android
- Material 3: `FilterChip`, `InputChip`, `AssistChip`, `SuggestionChip`.
- `FlowRow` (`androidx.compose.foundation.layout`) para wrap.
- `ChipDefaults.filterChipColors(...)` para tokens.

## Acessibilidade
- Wrapper group label.
- Cada chip anuncia "selecionado/não selecionado".

## Referências
- [iOS `Molecules/ChipGroup/ZodiakChipGroup.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Molecules/ChipGroup/ZodiakChipGroup.swift)
- [iOS `Molecules/ChipGroup/ZodiakChip.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Molecules/ChipGroup/ZodiakChip.swift)

## Gaps & dúvidas para o time de Design
- [ ] Chip atom é molecule (junto com group) ou atom separado?
- [ ] Variantes Material (input/filter/assist/suggestion) — todas presentes no DS?

## DoD
- [ ] Single + multi + display.
- [ ] FlowLayout.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
