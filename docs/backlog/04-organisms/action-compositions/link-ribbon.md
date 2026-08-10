# LinkRibbon

> **Categoria**: Organism (Action Compositions) · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog

## Contexto
Lista horizontal de links rápidos (com ícone + label), tipicamente em rodapés ou seções de "veja também".

## Critérios de aceite
- **Itens**: ícone + label; rolagem horizontal.
- **Estados**: pressed/disabled.
- **Acessibilidade**: cada item é botão/link com label semântico.
- **Light/Dark**: tokens.
- **Hit-target**: ≥ `Zodiak.hitTarget.minimum`.

## APIs públicas
- `ZodiakLinkRibbon(items: [ZodiakLinkRibbonItem], surface: ZodiakSurface = ZodiakSurface.onLite)`.

## Boas práticas
- **iOS**: `ScrollView(.horizontal) { HStack { ... } }`.
- **Android**: `LazyRow { items(items) { ... } }`.

## Referências
- [iOS `ZodiakActionCompositions.swift` (ZodiakLinkRibbon)](../../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/ActionCompositions/ZodiakActionCompositions.swift)

## DoD
- [ ] Scroll horizontal + hit-target.
- [ ] Ver [README família](README.md) e [ARCHITECTURE.md § 8](../../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
