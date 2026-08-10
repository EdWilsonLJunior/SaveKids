# Blurs (tokens)

> **Categoria**: Foundation · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Sim

## Contexto
Tokens de desfoque (gaussian blur) — usados em backdrop de modais, overlays de hero, materials translúcidos.

## História de usuário
Como **desenvolvedor**, quero **aplicar desfoque via tokens** para que **intensidades sigam a escala oficial (`light`, `medium`, `strong`)**.

## Critérios de aceite

### Cenário 1 — Escala
**Dado** [`ZodiakBlur.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakBlur.swift) e [`Blurs.md`](../../ZodiakiOS/docs/zodiak-pdf/Blurs.md)
**Então** existem `light`, `medium`, `strong` (e possivelmente um overlay translúcido vidro).

### Cenário 2 — Reduce Transparency
**Dado** `Reduce Transparency` ativo
**Então** blur vira fundo sólido equivalente em opacidade.

### Cenário 3 — Performance
**Dado** blur sobre conteúdo animado
**Então** mantém 60fps; usar `Material` em vez de `blur` quando possível em iOS.

### Cenário 4 — Paridade
**Dado** o mesmo token
**Então** a percepção visual é equivalente (radius em iOS pt ↔ Android dp).

### Cenário 5 — Combinação com cor
**Dado** blur + overlay translúcido
**Então** combinação previsível (Material thin/regular/thick).

## Spec técnica

### APIs públicas
- **iOS**: `Zodiak.blurs.<token>` → `CGFloat` (radius). Helper `.zodiakBlur(_:)`. Preferir `.background(.regularMaterial)` quando o efeito for "vidro fosco".
- **Android**: `ZodiakTheme.blurs.<token>` → `Dp`. Modifier `Modifier.blur(radius, edgeTreatment)` (API 31+); fallback para overlay opaco em APIs < 31.

### Tokens
- `Zodiak.blurs.light`
- `Zodiak.blurs.medium`
- `Zodiak.blurs.strong`
- (overlay translúcido / material vidro: `Zodiak.blurs.glass` se aplicável)

> Valores numéricos resolvidos **só** em [`Tokens/ZodiakBlur.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakBlur.swift) e equivalente Android. Stories e código consumidor **nunca** referenciam o radius por número.

## Boas práticas — iOS
- HIG: [Materials](https://developer.apple.com/design/human-interface-guidelines/materials). Preferir `ultraThinMaterial`/`thinMaterial`/`regularMaterial`/`thickMaterial`/`ultraThickMaterial` sobre `.blur(radius:)`.
- `.blur(radius:)` quebra hit-testing em iOS — usar para decorativos.

## Boas práticas — Android
- `Modifier.blur(radius)` API 31+. Em APIs anteriores, usar `Surface` com cor translúcida + tone elevation.
- Material 3: `ModalBottomSheet` usa **scrim** ao invés de blur por padrão; blur explícito requer cuidado de performance.

## Acessibilidade
- **Reduce Transparency**: substituir blur por fundo sólido.
- Texto sobre blur deve permanecer AA — testar com matriz Increase Contrast.

## Referências
- [iOS `ZodiakBlur.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakBlur.swift)
- [Supernova: Blurs](../../ZodiakiOS/docs/zodiak-pdf/Blurs.md)

## Gaps & dúvidas para o time de Design
- [ ] Mapping blur ↔ Material `ultraThin/thin/regular/thick/ultraThick` (iOS).
- [ ] Fallback Android < API 31 — comportamento aceitável?

## DoD
- [ ] Tokens expostos.
- [ ] Comportamento testado com Reduce Transparency.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Disponibilidade
Tokens disponibilizados como **CSS Custom Properties** via `ThemeProvider`. Não há componente React dedicado — os valores são resolvidos automaticamente pela classe de tema no elemento raiz.

### Uso
```tsx
import { ThemeProvider } from '@cg-groupit/zodiak-design-system';

<ThemeProvider defaultTheme="light">
  {/* --zodiak-blur-md fica disponível em todo o subárvore */}
  <div style={{ backdrop-filter: 'var(--zodiak-blur-md)' }} />
</ThemeProvider>
```

### Acessibilidade
- Use sempre tokens semânticos (ex.: `--zodiak-action-primary-default`) em vez de valores primitivos ou hardcoded.
