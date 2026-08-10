# Button Filter

> **Categoria**: Atom (Button) · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Botão usado para abrir/aplicar filtros — geralmente pílula com ícone (funil) + label. Pode mostrar badge com contagem de filtros ativos.

## História de usuário
Como **usuário**, quero **abrir filtros via botão dedicado** com **indicador de filtros ativos**.

## Critérios de aceite

### Cenário 1 — Sem filtros
**Dado** `activeCount: 0`
**Então** apenas ícone + label "Filtros".

### Cenário 2 — Com filtros ativos
**Dado** `activeCount: 3`
**Então** badge "3" visível; estado visual "ativo" (cor primary).

### Cenário 3 — Estados
**Dado** `default/pressed/disabled`
**Então** estados corretos.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** anuncia "Filtros, 3 ativos, botão".

### Cenário 5 — Hit-target
**Dado** uso em barra horizontal
**Então** ≥ `Zodiak.hitTarget.minimum`.

## Spec técnica

### APIs públicas
- `ZodiakFilterButton(label: String = "Filtros", activeCount: Int = Zodiak.defaults.filter.activeCount, size: ZodiakButtonSize = ZodiakButtonSize.medium, action: Action)`.

### Implementação
- Wrapper sobre `ZodiakButtonImpl` (tertiary) + `ZodiakBadge(count: activeCount)` como trailing.

### Tokens
- Herda regular tertiary.
- Badge: ver [badge](badge.md).

## Boas práticas — iOS
- SF Symbol `line.3.horizontal.decrease.circle` ou `slider.horizontal.3`.
- Combina com `.sheet` ou `.popover` para abrir UI de filtros.

## Boas práticas — Android
- Material Symbols `tune` ou `filter_list`.
- `ModalBottomSheet` para apresentar filtros.

## Acessibilidade
- Contagem anunciada.
- Foco visível.

## Referências
- [iOS `Atoms/Button/ZodiakFilterButton.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Atoms/Button/ZodiakFilterButton.swift)

## Gaps & dúvidas para o time de Design
- [ ] Estado visual "filtros aplicados" — mudar cor ou apenas badge?

## DoD
- [ ] Badge integrado.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
