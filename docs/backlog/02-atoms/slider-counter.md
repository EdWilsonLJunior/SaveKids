# Slider Counter

> **Categoria**: Atom (Navigation) · **Prioridade**: P2 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Indicador de posição num slider/carousel (ex.: "2 / 8"). Mostra item atual e total; alguns designs incluem botões prev/next inline.

## História de usuário
Como **usuário**, quero **saber onde estou em um carousel** para **antecipar quantos slides faltam**.

## Critérios de aceite

### Cenário 1 — Display
**Dado** `current: 2, total: 8`
**Então** mostra "2 / 8" (ou "02/08" conforme spec).

### Cenário 2 — Variante com controles
**Dado** `showControls: true`
**Então** botões prev/next aparecem ao redor do contador.

### Cenário 3 — Light/Dark + superfícies
**Dado** `surface: ZodiakSurface.onPhoto`
**Então** backdrop translúcido garante AA.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** anuncia "Slide 2 de 8".

### Cenário 5 — Atualização
**Dado** swipe que muda current
**Então** novo valor anunciado (live region).

## Spec técnica

### APIs públicas
- `ZodiakSliderCounter(current: Int, total: Int, showControls: Bool = false, surface: ZodiakSurface = ZodiakSurface.onLite, onPrev: Action? = none, onNext: Action? = none)`.

### Tokens
- Tipografia: `typography.labelMedium`.
- Cor: `textPrimary` (onLite), `textInverse` (onHeavy/onPhoto).

## Boas práticas — iOS
- SwiftUI: combina `Text("\(current) / \(total)")` + 2 `ZodiakIconButton`.
- `.accessibilityElement(children: .combine)`.

## Boas práticas — Android
- Compose: `Row { ZodiakIconButton(prev); Text("$current / $total"); ZodiakIconButton(next) }`.
- `Modifier.semantics(mergeDescendants = true)`.

## Acessibilidade
- LiveRegion para mudanças.
- Botões com labels "Anterior" / "Próximo".

## Referências
- [iOS `Atoms/Navigation/ZodiakSliderCounter.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Atoms/Navigation/ZodiakSliderCounter.swift)

## Gaps & dúvidas para o time de Design
- [ ] Format "2/8" vs "02/08" vs "2 of 8" — qual canônico?
- [ ] Substituível por dots indicator?

## DoD
- [ ] API com controles opcionais.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Importação
```tsx
import { SliderCounter } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `totalSlides` | `number` | — | Total de slides (obrigatório) |
| `initialIndex` | `number` | `0` | Índice inicial |
| `showSlideNumber` | `boolean` | `true` | Exibe "X / Y" |
| `background` | `'onLite' \| 'onHeavy'` | `'onLite'` | Contexto de superfície |
| `onChange` | `(meta) => void` | — | Callback com índice e direção |
| `prevAriaLabel` | `string` | `'Previous slide'` | Rótulo acessível do botão anterior |
| `nextAriaLabel` | `string` | `'Next slide'` | Rótulo acessível do botão próximo |

### Acessibilidade
- Forneça `prevAriaLabel` e `nextAriaLabel` em português para produtos em pt-BR.
- Sincronize o índice do carrossel com `onChange` para manter foco e anúncio corretos.

### Storybook
- `AllOptions`: variações de superfície e contagem de slides
- `Playground`: controles interativos com simulação de navegação
