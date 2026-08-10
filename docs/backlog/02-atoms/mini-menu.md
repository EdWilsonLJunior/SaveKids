# Mini Menu

> **Categoria**: Atom (Navigation) · **Prioridade**: P2 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Menu compacto inline (não-popup) — lista horizontal de chips/links que filtram conteúdo na mesma tela. Diferente de `Tabs` por não ter indicador de aba selecionada em barra.

## História de usuário
Como **usuário**, quero **filtrar conteúdo via menu compacto** sem **sair da tela**.

## Critérios de aceite

### Cenário 1 — Itens
**Dado** lista de itens com `selected` em um
**Então** renderiza linha horizontal scrollável; selecionado destacado.

### Cenário 2 — Estados
**Dado** item `disabled`
**Então** opacidade reduzida; não clicável.

### Cenário 3 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** anuncia "menu de filtros, item N de M, selecionado/não".

### Cenário 4 — Light/Dark
**Dado** dark
**Então** tokens resolvem.

### Cenário 5 — Overflow
**Dado** itens não cabem
**Então** rola horizontalmente; primeiro item visível em foco inicial.

## Spec técnica

### APIs públicas
- `ZodiakMiniMenu(items: [ZodiakMiniMenuItem], selected: Binding<String>, surface: ZodiakSurface = ZodiakSurface.onLite)`.

### Tokens
- Tipografia: `typography.labelMedium`.
- Padding item: `spacing.s12` horizontal.
- Cor selected: `colors.actionPrimary` (texto) ou underline.

## Boas práticas — iOS
- `ScrollView(.horizontal) { HStack { ForEach... } }` com `.scrollIndicators(.hidden)`.

## Boas práticas — Android
- `LazyRow { items(items) { ZodiakMiniMenuItem(...) } }`.

## Acessibilidade
- Wrapper `selectableGroup` + role `tab` ou `radio`.
- LiveRegion para confirmar troca.

## Referências
- [iOS `Atoms/Navigation/ZodiakMiniMenu.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Atoms/Navigation/ZodiakMiniMenu.swift)

## Gaps & dúvidas para o time de Design
- [ ] Diferença oficial entre mini menu e chip-group filter?

## DoD
- [ ] Scroll horizontal + selected state.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
