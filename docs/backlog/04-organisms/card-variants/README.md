# Card Variants (família)

> **Categoria**: Organism (família) · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Visão geral
Família de cards Zodiak com layouts visuais distintos. **Sub-stories partilham primitivo `ZodiakCardImpl`** (ver ARCHITECTURE).

## Sub-stories
- [horizontal.md](horizontal.md) — `ZodiakHorizontalCard` (imagem lateral + conteúdo).
- [typographic.md](typographic.md) — `ZodiakTypographicCard` (foco tipográfico, mínima mídia).
- [author.md](author.md) — `ZodiakAuthorCard` (card de autor com avatar).
- [reveal.md](reveal.md) — `ZodiakRevealCard` (com hover/tap reveal de conteúdo extra).
- [tall.md](tall.md) — `ZodiakTallCard` (vertical alta, imagem grande).
- [short-facts.md](short-facts.md) — `ZodiakShortFactsCard` (fatos rápidos, lista compacta).

## Primitivo compartilhado
- `internal ZodiakCardImpl(layout, mediaSlot, contentSlot, footerSlot, ...)`.

## DoD do umbrella
- [ ] Todas sub-stories com APIs públicas dedicadas.
- [ ] Primitivo interno não exposto.
- [ ] Ver [ARCHITECTURE.md § 2](../../ARCHITECTURE.md#2-padrão-arquitetural-primitivo-interno--apis-dedicadas-públicas) e [§ 8](../../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).

## Referências
- [iOS `Organisms/CardVariants/`](../../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/CardVariants/)
