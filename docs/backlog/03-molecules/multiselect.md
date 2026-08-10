# Multiselect

> **Categoria**: Molecule · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Campo que permite selecionar **vários** itens de uma lista, exibindo seleção como chips inline ou contador (ex.: "3 selecionados").

## História de usuário
Como **usuário**, quero **selecionar múltiplas opções** em um único campo **com visualização clara dos itens escolhidos**.

## Critérios de aceite

### Cenário 1 — Seleção múltipla
**Dado** lista de itens
**Quando** seleciono 3
**Então** campo mostra 3 chips ou "3 selecionados".

### Cenário 2 — Remoção inline
**Dado** chip exibido no campo
**Quando** toco no × do chip
**Então** item desseleciona; foco mantém-se.

### Cenário 3 — Estados
**Dado** `default/focused/error/disabled`
**Então** corretos.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** anuncia "Multiseleção, 3 selecionados, toque para abrir"; lista anuncia seleção.

### Cenário 5 — Light/Dark
**Dado** dark
**Então** tokens resolvem.

## Spec técnica

### APIs públicas
- `ZodiakMultiselect<T>(values: Binding<Set<T>>, items: [T], itemLabel: (T) -> String, label: String, helper/error..., displayMode: ZodiakMultiselectDisplay = ZodiakMultiselectDisplay.chips)`.
- `ZodiakMultiselectDisplay { chips, count }`.

### Tokens
- Herda text-field.
- Chips inline: ver [chip-group](chip-group.md).

## Boas práticas — iOS
- SwiftUI: `Sheet` ou `List` com `selection: Set<T>`.

## Boas práticas — Android
- `ExposedDropdownMenu` com `DropdownMenuItem(trailingIcon = Checkbox)`; ou `ModalBottomSheet` com lista de checkboxes.

## Acessibilidade
- Anúncio de contagem após cada toggle.
- Chips dentro do campo são focáveis para remoção.

## Referências
- [iOS `Molecules/Multiselect/ZodiakMultiselect.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Molecules/Multiselect/ZodiakMultiselect.swift)

## Gaps & dúvidas para o time de Design
- [ ] Limite de chips exibidos antes de colapsar para "+3"?
- [ ] Comportamento de overflow no campo?

## DoD
- [ ] Chips inline + count mode.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Implementação parcial em React.** O componente está em progresso no pacote `@cg-groupit/zodiak-design-system`.
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar completamente, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
