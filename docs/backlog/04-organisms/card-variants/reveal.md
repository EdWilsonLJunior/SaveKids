# RevealCard

> **Categoria**: Organism (Card Variants) · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog

## Contexto
Card com conteúdo extra revelado por hover/tap (flip ou expand).

## Critérios de aceite
- **Estados**: collapsed / revealed.
- **Trigger**: tap mobile / hover desktop iPad com pointer.
- **Reduce Motion**: troca instantânea.
- **Acessibilidade**: ambos conteúdos acessíveis; estado "expanded/collapsed" anunciado.
- **Light/Dark**: tokens.

## APIs públicas
- `ZodiakRevealCard(front: Slot, back: Slot, isRevealed: Binding<Bool>)`.

## Referências
- [iOS `ZodiakRevealCard.swift`](../../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/CardVariants/ZodiakRevealCard.swift)

## DoD
- [ ] Reduce motion.
- [ ] Ver [README família](README.md).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
