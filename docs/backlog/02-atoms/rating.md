# Rating

> **Categoria**: Atom · **Prioridade**: P2 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Indicador de avaliação por estrelas (ou outro símbolo). Suporta modo readonly (exibição) e interactive (input).

## História de usuário
Como **usuário**, quero **ver e atribuir uma avaliação por estrelas** para **expressar minha satisfação**.

## Critérios de aceite

### Cenário 1 — Readonly
**Dado** `ZodiakRating(value: 3.5, interactive: false)`
**Então** mostra 3 estrelas cheias + 1 meia + 1 vazia.

### Cenário 2 — Interactive
**Dado** `interactive: true`
**Quando** toco na 4ª estrela
**Então** value muda para 4.0.

### Cenário 3 — Light/Dark
**Dado** dark
**Então** estrelas usam token correto (`statusWarning` ou amarelo brand).

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** modo readonly anuncia "Avaliação 3,5 de 5"; interactive anuncia "Avaliação, 4 de 5, ajustar com setas".

### Cenário 5 — Ajuste por gesto/teclado
**Dado** modo interactive
**Quando** uso Arrow Left/Right (teclado) ou adjust gestures (VoiceOver)
**Então** value muda em incrementos de 0.5 ou 1.0.

## Spec técnica

### APIs públicas
- `ZodiakRating(value: Float, maxValue: Int = Zodiak.defaults.rating.maxValue, step: Float = Zodiak.defaults.rating.step, interactive: Bool = false, onChange: ((Float) -> Void)? = none, size: ZodiakSize = ZodiakSize.md)`.

### Tokens
- Cor: estrela cheia = `statusWarning` (amarelo); vazia = `borderDefault`.
- Tamanho: `sizing.iconSm/Md/Lg`.

## Boas práticas — iOS
- SwiftUI: `HStack { ForEach(0..<5) { Image(systemName: ...) } }` com SF Symbols `star.fill`/`star.leadinghalf.filled`/`star`.
- `.accessibilityValue("3,5 de 5")` + `.accessibilityAdjustableAction { ... }`.

## Boas práticas — Android
- Material 3: não há `Rating` nativo; usar `Row` de `Icon(Icons.Filled.Star)`.
- `Modifier.semantics { stateDescription = "3,5 de 5"; setProgress { ... } }` para a11y de slider-like.

## Acessibilidade
- Papel adjustable (`accessibilityAdjustableAction` / `semantics { setProgress }`).
- Valor anunciado em PT-BR com vírgula decimal.

## Referências
- [iOS `Atoms/Rating/ZodiakRating.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Atoms/Rating/ZodiakRating.swift)

## Gaps & dúvidas para o time de Design
- [ ] Step oficial: 0.5 ou 1.0?
- [ ] Símbolo (estrela, coração, polegar) — apenas estrela?

## DoD
- [ ] Modo readonly + interactive.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
