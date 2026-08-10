# Gradients (tokens)

> **Categoria**: Foundation · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não — Swift é fonte primária

## Contexto
Tokens de gradient — backgrounds decorativos, hero overlays, badges premium, photo overlays.

## História de usuário
Como **desenvolvedor**, quero **aplicar gradients via tokens nomeados** para que **brand gradients sejam consistentes (mesmas stops, mesmos ângulos)**.

## Critérios de aceite

### Cenário 1 — Catálogo
**Dado** [`ZodiakGradients.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakGradients.swift)
**Então** existem ao menos `brandPrimary`, `heroOverlay`, `photoOverlay`, `cardElevation` (consultar Swift).

### Cenário 2 — Direção
**Dado** um gradient
**Então** define `start`/`end` ou ângulo, com paridade entre plataformas.

### Cenário 3 — Light/Dark
**Dado** gradient com variantes
**Então** muda automaticamente conforme ColorScheme.

### Cenário 4 — RTL
**Dado** gradient direcional (left-to-right)
**Quando** RTL ativo
**Então** se espelha quando carregar significado direcional.

### Cenário 5 — Performance
**Dado** scroll com 50 cards com gradient
**Então** mantém 60fps.

## Spec técnica

### APIs públicas
- **iOS**: `Zodiak.gradients.<token>` → `LinearGradient` / `RadialGradient`. Modifier `.zodiakGradientBackground(_:)`.
- **Android**: `ZodiakTheme.gradients.<token>` → `Brush`. Modifier `Modifier.background(brush = ...)`.

### Tokens
- `brandPrimary`, `heroOverlay`, `photoOverlay` (top-to-bottom para legibilidade de texto), `cardElevation` (sutil), `premium` (consultar Swift).

## Boas práticas — iOS
- `LinearGradient(stops:, startPoint:, endPoint:)`.
- Para overlays sobre foto, usar `.gradient` em `Color` ou `LinearGradient` com stops `[.black.opacity(0.6), .clear]`.

## Boas práticas — Android
- `Brush.linearGradient(colorStops = ..., start = ..., end = ...)`.
- `Brush.verticalGradient` / `horizontalGradient` para casos comuns.

## Acessibilidade
- Texto sobre gradient: garantir contraste AA com a porção mais clara do gradient.
- **Reduce Transparency**: substituir gradient por cor sólida equivalente em opacidade média.

## Referências
- [iOS `ZodiakGradients.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakGradients.swift)

## Gaps & dúvidas para o time de Design
- [ ] Sem doc Supernova — pedir catálogo oficial.
- [ ] Política de Reduce Transparency.

## DoD
- [ ] Tokens expostos.
- [ ] Snapshot.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Disponibilidade
Tokens disponibilizados como **CSS Custom Properties** via `ThemeProvider`. Não há componente React dedicado — os valores são resolvidos automaticamente pela classe de tema no elemento raiz.

### Uso
```tsx
import { ThemeProvider } from '@cg-groupit/zodiak-design-system';

<ThemeProvider defaultTheme="light">
  {/* --zodiak-gradient-hero fica disponível em todo o subárvore */}
  <div style={{ background: 'var(--zodiak-gradient-hero)' }} />
</ThemeProvider>
```

### Acessibilidade
- Use sempre tokens semânticos (ex.: `--zodiak-action-primary-default`) em vez de valores primitivos ou hardcoded.
