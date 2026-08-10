# TallCard

> **Categoria**: Organism (Card Variants) · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog

## Contexto
Card vertical alto: imagem grande no topo (2/3 da altura) + conteúdo embaixo. Comum em feeds.

## Critérios de aceite
- **Composição**: imagem (aspect 4:5 ou similar) + eyebrow + title + meta.
- **Tap**: card inteiro.
- **Acessibilidade**: bloco coeso.
- **Light/Dark**: tokens.

## APIs públicas
- `ZodiakTallCard(image: ZodiakImageSource, eyebrow: String? = none, title: String, meta: String? = none, onTap: Action? = none)`.

## Referências
- [iOS `ZodiakTallCard.swift`](../../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/CardVariants/ZodiakTallCard.swift)

## DoD
- [ ] Ver [README família](README.md).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
