# HorizontalCard

> **Categoria**: Organism (Card Variants) · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog

## Contexto
Card horizontal: imagem (leading) + conteúdo (eyebrow + título + body + ação) à direita.

## Critérios de aceite
- **Layout**: imagem 1/3, texto 2/3 (configurável).
- **Estados**: pressed/disabled.
- **Acessibilidade**: bloco coeso; toque é botão único.
- **Light/Dark**: tokens.

## APIs públicas
- `ZodiakHorizontalCard(image: ZodiakImageSource, eyebrow: String? = none, title: String, body: String? = none, action: ZodiakAlertAction? = none, onTap: Action? = none)`.

## Referências
- [iOS `ZodiakHorizontalCard.swift`](../../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/CardVariants/ZodiakHorizontalCard.swift)

## DoD
- [ ] Layout fixo + responsivo.
- [ ] Ver [README família](README.md).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
