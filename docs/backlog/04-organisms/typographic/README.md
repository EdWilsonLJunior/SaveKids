# Typographic Blocks (família)

> **Categoria**: Organism (família) · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Visão geral
Família de organisms tipográficos editoriais — blocos de texto com tratamento visual elaborado. **Sub-stories partilham primitivo interno `ZodiakTypographicBlockImpl`** (ver ARCHITECTURE).

## Sub-stories
- [quote.md](quote.md) — `ZodiakQuote` (citação destacada).
- [text-block.md](text-block.md) — `ZodiakTextBlock` (bloco de texto com estilo editorial).
- [preamble.md](preamble.md) — `ZodiakPreamble` (parágrafo de abertura, lead).
- [key-figures.md](key-figures.md) — `ZodiakKeyFigures` + `ZodiakKeyFigureCard` (estatísticas).
- [headline-section.md](headline-section.md) — `ZodiakHeadlineSection` (cabeçalho de seção).

## Primitivo compartilhado
- `internal ZodiakTypographicBlockImpl(kind, ...)` — consumido pelas sub-stories quando layout é semelhante.

## DoD do umbrella
- [ ] Todas sub-stories implementadas com APIs públicas dedicadas.
- [ ] Primitivo interno não exposto.
- [ ] Ver [ARCHITECTURE.md § 2](../../ARCHITECTURE.md#2-padrão-arquitetural-primitivo-interno--apis-dedicadas-públicas) e [§ 8](../../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).

## Referências
- [iOS `Organisms/Typographic/`](../../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/Typographic/)
