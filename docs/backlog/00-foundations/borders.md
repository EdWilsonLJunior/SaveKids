# Borders (tokens)

> **Categoria**: Foundation · **Prioridade**: P0 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Sim

## Contexto
Tokens de borda — espessura e cor. Cor da borda referencia tokens semânticos em [colors](colors.md); espessura é seu próprio token.

## História de usuário
Como **desenvolvedor**, quero **definir bordas via tokens** para que **espessuras sigam a escala oficial (`hairline`, `thin`, `default`, `thick`)**.

## Critérios de aceite

### Cenário 1 — Escala
**Dado** [`ZodiakBorders.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakBorders.swift) e Supernova [`Borders.md`](../../ZodiakiOS/docs/zodiak-pdf/Borders.md)
**Então** existem `Zodiak.borders.hairline`, `Zodiak.borders.thin`, `Zodiak.borders.default`, `Zodiak.borders.thick`.

### Cenário 2 — Hairline em telas retina
**Dado** o token `hairline`
**Quando** renderizado em tela 2× ou 3×
**Então** ainda aparece como 1 pixel físico (sem antialiasing borrado).

### Cenário 3 — Cor
**Dado** uma borda
**Então** combina espessura (token de borders) + cor (token de colors `border*`).

### Cenário 4 — Foco
**Dado** o componente focado
**Então** a borda muda para `borderFocus` (cor) em `thick` (espessura), respeitando High Contrast.

### Cenário 5 — Paridade
**Dado** o mesmo token
**Então** pt = dp (exceto `hairline`, que é resolvido por densidade).

## Spec técnica

### APIs públicas
- **iOS**: `Zodiak.borders.<token>` → `CGFloat`. Helper `.zodiakBorder(_:color:)`.
- **Android**: `ZodiakTheme.borders.<token>` → `Dp`. Modifier `.zodiakBorder(token, color, shape)`.

### Tokens
- `Zodiak.borders.hairline`
- `Zodiak.borders.thin`
- `Zodiak.borders.default`
- `Zodiak.borders.thick`

> Resolução numérica em [`Tokens/ZodiakBorders.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakBorders.swift). Hairline em iOS é resolvido via `1.0 / UIScreen.main.scale`; em Compose API 31+ via `0.5.dp`/stroke vetorial. Detalhe de plataforma — histórias não citam valor.

## Boas práticas — iOS
- Hairline: implementação do token usa `1.0 / UIScreen.main.scale` para 1px físico em 2×/3×. Consumidor só chama `Zodiak.borders.hairline`.
- `.overlay(RoundedRectangle(...).stroke(...))` para bordas em superfícies arredondadas.

## Boas práticas — Android
- `Modifier.zodiakBorder(token, color, shape)` envolve `Modifier.border(...)` consumindo o token. Consumidor não chama `1.dp` diretamente.
- Hairline: implementação do token usa stroke vetorial ou `0.5.dp` (API 31+).

## Acessibilidade
- `Increase Contrast` (iOS) / Accessibility Suite (Android) pode requerer `thick` em vez de `thin` — expor como variante automática.

## Referências
- [iOS `ZodiakBorders.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakBorders.swift)
- [Supernova: Borders](../../ZodiakiOS/docs/zodiak-pdf/Borders.md)

## Gaps & dúvidas para o time de Design
- [ ] Definir espessura **focus ring** (atualmente derivado).
- [ ] Política de Increase Contrast: bordas finas viram default?

## DoD
- [ ] Tokens expostos com helper que combina espessura + cor.
- [ ] Snapshot.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Disponibilidade
Tokens disponibilizados como **CSS Custom Properties** via `ThemeProvider`. Não há componente React dedicado — os valores são resolvidos automaticamente pela classe de tema no elemento raiz.

### Uso
```tsx
import { ThemeProvider } from '@cg-groupit/zodiak-design-system';

<ThemeProvider defaultTheme="light">
  {/* --zodiak-border-primary fica disponível em todo o subárvore */}
  <div style={{ border: 'var(--zodiak-border-primary)' }} />
</ThemeProvider>
```

### Acessibilidade
- Use sempre tokens semânticos (ex.: `--zodiak-action-primary-default`) em vez de valores primitivos ou hardcoded.
