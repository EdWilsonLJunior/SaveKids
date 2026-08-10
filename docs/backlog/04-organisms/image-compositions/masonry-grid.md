# MasonryGrid

> **Categoria**: Organism (Image Compositions) · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog

## Contexto
Grid estilo Pinterest com colunas de alturas variáveis.

## Critérios de aceite
- **Colunas**: 2 mobile, 3 tablet (adaptativo).
- **Altura**: cada tile mantém aspect ratio da imagem original.
- **Spacing**: `spacing.s8` entre tiles.
- **Acessibilidade**: ordem de leitura linear top-to-bottom.
- **Light/Dark**: tokens.

## APIs públicas
- `ZodiakMasonryGrid(items: [ZodiakImageTile], columns: Int? = none, onSelect: ((ZodiakImageTile) -> Void)? = none)`.

## Boas práticas
- **iOS**: implementação custom com `Layout` protocol (iOS 16+) ou `VStack`/`HStack` distribuído.
- **Android**: `LazyVerticalStaggeredGrid(columns = StaggeredGridCells.Fixed(2))`.

## Referências
- [iOS `ZodiakImageCompositions.swift` (ZodiakMasonryGrid)](../../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/ImageCompositions/ZodiakImageCompositions.swift)

## DoD
- [ ] Layout staggered.
- [ ] Ver [README família](README.md) e [ARCHITECTURE.md § 8](../../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
