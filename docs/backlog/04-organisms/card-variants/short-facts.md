# ShortFactsCard

> **Categoria**: Organism (Card Variants) · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog

## Contexto
Card com lista compacta de fatos (label + value pairs).

## Critérios de aceite
- **Composição**: title + lista de `ZodiakInfoRow` compactos.
- **Acessibilidade**: cada fato é lido como par.
- **Light/Dark**: tokens.

## APIs públicas
- `ZodiakShortFactsCard(title: String? = none, facts: [(label: String, value: String)])`.

## Referências
- [iOS `ZodiakShortFactsCard.swift`](../../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/CardVariants/ZodiakShortFactsCard.swift)

## DoD
- [ ] Ver [README família](README.md).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
