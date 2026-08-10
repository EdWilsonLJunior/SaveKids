# TypographicCard

> **Categoria**: Organism (Card Variants) · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog

## Contexto
Card com foco tipográfico — sem imagem grande, ênfase em headline + body + eyebrow.

## Critérios de aceite
- **Composição**: eyebrow + headline `titleLarge` + body + footer (meta).
- **Acessibilidade**: heading + bloco.
- **Light/Dark**: tokens.

## APIs públicas
- `ZodiakTypographicCard(eyebrow: String? = none, title: String, body: String? = none, footer: Slot? = none, onTap: Action? = none)`.

## Referências
- [iOS `ZodiakTypographicCard.swift`](../../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/CardVariants/ZodiakTypographicCard.swift)

## DoD
- [ ] Ver [README família](README.md).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
