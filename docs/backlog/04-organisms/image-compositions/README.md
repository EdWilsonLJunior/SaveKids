# Image Compositions (família)

> **Categoria**: Organism (família) · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Visão geral
Família de organisms para apresentação visual de imagens em diferentes layouts (galeria, masonry, carousel, image+texto). Todos partilham contratos comuns de `ZodiakImageTile`.

## Sub-stories
- [image-block.md](image-block.md) — `ZodiakImageBlock` (single image full-bleed + legenda).
- [carousel.md](carousel.md) — `ZodiakCarousel` (slider horizontal com paginação).
- [masonry-grid.md](masonry-grid.md) — `ZodiakMasonryGrid` (grid Pinterest-style).
- [image-text-symmetrical.md](image-text-symmetrical.md) — `ZodiakImageTextSymmetrical` (imagem + texto lado a lado, simétrico).

## Contratos compartilhados
- `ZodiakImageTile(id: String, source: ZodiakImageSource, caption: String? = none, accessibilityLabel: String? = none)`.
- `ZodiakImageSource { url(URL), asset(name), system(name) }`.

## DoD do umbrella
- [ ] Todas as sub-stories implementadas.
- [ ] Contratos compartilhados não duplicados em cada sub.
- [ ] Ver [ARCHITECTURE.md § 8](../../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).

## Referências
- [iOS `Organisms/ImageCompositions/`](../../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/ImageCompositions/)
