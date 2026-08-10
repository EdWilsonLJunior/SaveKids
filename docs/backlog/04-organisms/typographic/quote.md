# Quote

> **Categoria**: Organism (Typographic) · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog

## Contexto
Bloco de citação destacada com texto + autor + (opcional) source.

## Critérios de aceite
- **Composição**: aspas decorativas + texto em `headlineSmall` italic + autor + source.
- **Variantes**: `.inline` (parágrafo) e `.pull` (display centralizado grande).
- **Acessibilidade**: lido como bloco; aspas decorativas (`accessibilityHidden`).
- **Light/Dark**: tokens.

## APIs públicas
- `ZodiakQuote(text: String, author: String? = none, source: String? = none, variant: ZodiakQuoteVariant = ZodiakQuoteVariant.inline)`.

## Boas práticas
- Aspas tipográficas reais (« » / " ") por locale.

## Referências
- [iOS `ZodiakQuote.swift`](../../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/Typographic/ZodiakQuote.swift)

## DoD
- [ ] Variantes.
- [ ] Ver [README família](README.md).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
