# Shadows (tokens)

> **Categoria**: Foundation · **Prioridade**: P0 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Sim

## Contexto
Tokens de sombra (elevação). Material 3 usa **tone elevation** (cor) + **shadow elevation** (geometria). iOS usa apenas shadow. O Zodiak define `level0`…`level5`.

## História de usuário
Como **desenvolvedor**, quero **elevar superfícies via tokens** para que **profundidade siga a escala oficial e renderize corretamente em ambas as plataformas**.

## Critérios de aceite

### Cenário 1 — Escala
**Dado** [`ZodiakShadows.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakShadows.swift) e Supernova [`Shadows.md`](../../ZodiakiOS/docs/zodiak-pdf/Shadows.md)
**Então** existem 6 níveis (`level0`…`level5`) com `xOffset`, `yOffset`, `blur`, `spread`, `color`, `opacity`.

### Cenário 2 — Light/Dark
**Dado** dark mode
**Então** sombras são mais discretas (opacidade menor) ou substituídas por **tone elevation** (cor de superfície mais clara) conforme Material 3.

### Cenário 3 — Performance
**Dado** uma lista com 100 cards com sombra
**Então** mantém 60fps (sem soft-shadow custosa em iOS; usar `shouldRasterize` quando estática).

### Cenário 4 — Acessibilidade
**Dado** `Reduce Transparency` ativo (iOS) / equivalente Android
**Então** sombras viram bordas ou tone elevation.

### Cenário 5 — Paridade visual
**Dado** o mesmo level
**Então** o resultado visual é equivalente (compensando diferenças do modelo de cada plataforma).

## Spec técnica

### APIs públicas
- **iOS**: `Zodiak.shadows.<token>` → struct com `color`, `radius` (blur), `x`, `y`. Modifier `.zodiakShadow(_:)`.
- **Android**: `ZodiakTheme.shadows.<token>` → composable modifier `.zodiakShadow(level)` que combina `Modifier.shadow(elevation, shape)` + `Surface(tonalElevation = ...)`.

### Níveis
- `level0` = sem sombra (superfície plana)
- `level1` = elevação mínima (chips, switches focados)
- `level2` = cards, banners
- `level3` = bottom sheets, app bar elevada
- `level4` = modais
- `level5` = menus, dialogs ancorados

## Boas práticas — iOS
- `.shadow(color:, radius:, x:, y:)`. Cor com `opacity` baixa para evitar "pretão".
- HIG: [Materials & Shadows](https://developer.apple.com/design/human-interface-guidelines/materials).
- Considerar `.background(.regularMaterial)` em vez de sombra quando o efeito for "elevação sobre conteúdo" (translúcido).

## Boas práticas — Android
- Material 3 prefere **tone elevation** (cor) sobre shadow para superfícies maiores.
- `Modifier.shadow(elevation, shape, ambientColor, spotColor)` (API 28+ para cores customizadas).
- `Surface(tonalElevation = X.dp)` para tone elevation automático no `ColorScheme`.
- M3: [Elevation](https://m3.material.io/styles/elevation/overview).

## Acessibilidade
- Sombras nunca são o único indicador de elevação/foco — sempre combinar com cor/borda.
- `Reduce Motion` não afeta sombra; `Reduce Transparency` pode trocar por borda em iOS.

## Referências
- [iOS `ZodiakShadows.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakShadows.swift)
- [Supernova: Shadows](../../ZodiakiOS/docs/zodiak-pdf/Shadows.md)

## Gaps & dúvidas para o time de Design
- [ ] Em dark mode, usar sombra ou tone elevation (M3 recomenda tone)?
- [ ] Token de **inner shadow** (estados pressed) — não documentado.

## DoD
- [ ] Tokens expostos com modifier helper.
- [ ] Snapshot light/dark.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Disponibilidade
Tokens disponibilizados como **CSS Custom Properties** via `ThemeProvider`. Não há componente React dedicado — os valores são resolvidos automaticamente pela classe de tema no elemento raiz.

### Uso
```tsx
import { ThemeProvider } from '@cg-groupit/zodiak-design-system';

<ThemeProvider defaultTheme="light">
  {/* --zodiak-shadow-md fica disponível em todo o subárvore */}
  <div style={{ box-shadow: 'var(--zodiak-shadow-md)' }} />
</ThemeProvider>
```

### Acessibilidade
- Use sempre tokens semânticos (ex.: `--zodiak-action-primary-default`) em vez de valores primitivos ou hardcoded.
