# ImageBlock

> **Categoria**: Organism (Image Compositions) · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog

## Contexto
Imagem única com legenda opcional. Suporta aspect ratio configurável, lazy-load.

## Critérios de aceite
- **Aspect ratio**: `16/9` default, configurável.
- **Caption**: opcional, abaixo da imagem com `typography.bodySmall`.
- **Loading**: skeleton enquanto carrega.
- **Acessibilidade**: caption como descrição; imagem com `accessibilityLabel`.
- **Light/Dark**: caption usa `textSecondary`.

## APIs públicas
- `ZodiakImageBlock(source: ZodiakImageSource, caption: String? = none, aspectRatio: Length = Zodiak.aspectRatios.video16x9, accessibilityLabel: String? = none)`.

## Boas práticas — iOS
- `AsyncImage` + `.aspectRatio(...,contentMode: .fill)` + `.clipped()`.

## Boas práticas — Android
- `AsyncImage` (Coil) + `Modifier.aspectRatio(...)`.

## Referências
- [iOS `ZodiakImageCompositions.swift` (ZodiakImageBlock)](../../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/ImageCompositions/ZodiakImageCompositions.swift)

## DoD
- [ ] Aspect ratio + caption.
- [ ] Ver [README família](README.md) e [ARCHITECTURE.md § 8](../../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
