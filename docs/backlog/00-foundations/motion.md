# Motion (tokens)

> **Categoria**: Foundation · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não (gap)

## Contexto
Durações e curvas (easings) padrão para todas as animações do DS — micro-interactions, transitions, sheets, skeleton shimmer. Substitui literais `200ms`, `300ms`, `.easeInOut` em componentes.

## História de usuário
Como **desenvolvedor**, quero **durações e easings por token** para que **animações sigam a cadência oficial e respeitem Reduce Motion**.

## Critérios de aceite

### Cenário 1 — Duração
**Dado** `Zodiak.motion.duration.*`
**Então** existem ao menos: `instant`, `short`, `medium`, `long`, `extraLong`.

### Cenário 2 — Easing
**Dado** `Zodiak.motion.easing.*`
**Então** existem ao menos: `standard`, `emphasized`, `decelerated`, `accelerated`, `linear`.

### Cenário 3 — Reduce Motion
**Dado** preferência ativa
**Então** durações resolvem para `instant` (animação suprimida) ou variante `reducedMotion` do token.

### Cenário 4 — Acessibilidade
**Dado** anúncios de mudança
**Então** disparam após animação concluir.

### Cenário 5 — Light/Dark
**Sem impacto.**

## Spec técnica

### APIs públicas
- **iOS**: `Zodiak.motion.duration.<token>` → `Duration` (ou `TimeInterval`). `Zodiak.motion.easing.<token>` → `Animation`.
- **Android**: `ZodiakTheme.motion.duration.<token>` → `Int` (ms). `ZodiakTheme.motion.easing.<token>` → `Easing`.

### Tokens
- Duração: `Zodiak.motion.duration.instant/short/medium/long/extraLong`.
- Easing: `Zodiak.motion.easing.standard/emphasized/decelerated/accelerated/linear`.

> Valores em `Tokens/ZodiakMotion.swift` (a criar).

## Boas práticas — iOS
- `.animation(Zodiak.motion.easing.standard.duration(Zodiak.motion.duration.medium), value: state)`.
- Respeitar `@Environment(\.accessibilityReduceMotion)`.
- iOS 17+: `phaseAnimator`/`keyframeAnimator` com tokens.

## Boas práticas — Android
- `animateFloatAsState(targetValue, animationSpec = tween(ZodiakTheme.motion.duration.medium, easing = ZodiakTheme.motion.easing.standard))`.
- Material 3: `MotionTokens` oficial — mapear 1:1 para tokens Zodiak.
- `LocalAccessibilityManager.current.isReduceMotionEnabled` para respeitar preferência.

## Acessibilidade
- Reduce Motion respeitado globalmente via helper que retorna `instant` quando ativo.

## Referências
- Sem fonte iOS hoje — gap G-059.
- Consumidores: [skeleton-loader](../04-organisms/skeleton-loader.md), [modal](../04-organisms/modal.md), [toast](../04-organisms/toast.md), [accordion](../03-molecules/accordion.md), [slide-to-submit](../03-molecules/slide-to-submit.md).

## Gaps & dúvidas para o time de Design
- [ ] G-059 — Tokens de motion não existem hoje; criar `ZodiakMotion.swift` alinhado a Material 3 MotionTokens.

## DoD
- [ ] Tokens expostos.
- [ ] Reduce Motion respeitado em todos componentes animados.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Disponibilidade
Tokens disponibilizados como **CSS Custom Properties** via `ThemeProvider`. Não há componente React dedicado — os valores são resolvidos automaticamente pela classe de tema no elemento raiz.
> **Nota:** Use `prefers-reduced-motion` para desabilitar animações quando o usuário solicitar.


### Uso
```tsx
import { ThemeProvider } from '@cg-groupit/zodiak-design-system';

<ThemeProvider defaultTheme="light">
  {/* --zodiak-motion-duration-fast fica disponível em todo o subárvore */}
  <div style={{ transition: 'var(--zodiak-motion-duration-fast)' }} />
</ThemeProvider>
```

### Acessibilidade
- Use sempre tokens semânticos (ex.: `--zodiak-action-primary-default`) em vez de valores primitivos ou hardcoded.
