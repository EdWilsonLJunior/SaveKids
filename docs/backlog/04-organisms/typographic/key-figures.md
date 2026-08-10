# KeyFigures

> **Categoria**: Organism (Typographic) · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog

## Contexto
Coleção de estatísticas destacadas: número grande + descrição curta. Layout em row/grid.

## Critérios de aceite
- **Cards**: `ZodiakKeyFigureCard(value, label, supporting?)`.
- **Layout**: row (mobile) ou grid 3-col (tablet).
- **Acessibilidade**: cada card é elemento com label completo ("3.5 milhões, clientes ativos").
- **Light/Dark**: tokens.

## APIs públicas
- `ZodiakKeyFigureCard(value: String, label: String, supporting: String? = none)`.
- `ZodiakKeyFigures(items: [ZodiakKeyFigureCard])`.

## Boas práticas
- Números localizados (`NumberFormatter` / `NumberFormat`).

## Referências
- [iOS `ZodiakKeyFigures.swift`](../../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/Typographic/ZodiakKeyFigures.swift)

## DoD
- [ ] Layout adaptativo + a11y.
- [ ] Ver [README família](README.md).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
