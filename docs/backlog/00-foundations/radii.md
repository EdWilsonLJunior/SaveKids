# Radii (tokens)

> **Categoria**: Foundation · **Prioridade**: P0 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Sim

## Contexto
Tokens de raio de borda — define a "linguagem de cantos" (mais arredondado = mais expressivo / Material 3 Expressive). Usado em botões, cards, campos, modais, chips, avatares.

## História de usuário
Como **desenvolvedor**, quero **aplicar raios via tokens** para que **todos os cantos sigam a escala oficial (`none`, `xs`, `sm`, `md`, `lg`, `xl`, `full`)**.

## Critérios de aceite

### Cenário 1 — Escala
**Dado** [`ZodiakRadii.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakRadii.swift) e Supernova [`Radius.md`](../../ZodiakiOS/docs/zodiak-pdf/Radius.md)
**Então** existem `none` (0), `xs` (4), `sm` (8), `md` (12), `lg` (16), `xl` (24), `full` (9999).

### Cenário 2 — Componentes
**Dado** botão, chip, card, modal
**Então** cada um consome um token específico (não inline).

### Cenário 3 — Continuidade (iOS)
**Dado** uma View com `cornerRadius` Zodiak
**Então** usa `RoundedRectangle(cornerRadius:, style: .continuous)` para shape "squircle" do iOS.

### Cenário 4 — RTL
**Dado** raios com cantos top-start/end
**Então** invertem corretamente em RTL.

### Cenário 5 — Paridade
**Dado** o mesmo token
**Então** o valor pt = dp.

## Spec técnica

### APIs públicas
- **iOS**: `Zodiak.radii.<token>` → `CGFloat` (+ helper `ZodiakTheme.shape(_:)` que retorna `RoundedRectangle` continuous).
- **Android**: `ZodiakTheme.radii.<token>` → `Dp`. Material 3 `Shapes`: `extraSmall`/`small`/`medium`/`large`/`extraLarge` mapeados para tokens Zodiak.

### Tokens
- `Zodiak.radii.none`
- `Zodiak.radii.xs`
- `Zodiak.radii.sm`
- `Zodiak.radii.md`
- `Zodiak.radii.lg`
- `Zodiak.radii.xl`
- `Zodiak.radii.full` (pill / capsule)

> Valores resolvidos vivem apenas em [`Tokens/ZodiakRadii.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakRadii.swift). Histórias e código consumidor referenciam por **nome**, nunca por número.

## Boas práticas — iOS
- HIG: corner radius "continuous" no iOS para o efeito de squircle (Apple usa por padrão em todos os componentes nativos).
- `Path` customizado deve usar `style: .continuous` para consistência.

## Boas práticas — Android
- Material 3: `Shapes` no `MaterialTheme`. Componentes M3 usam shape role por componente (Button = `full`, Card = `medium`). Mapear cada role do M3 para um token Zodiak.
- `RoundedCornerShape` ou `AbsoluteRoundedCornerShape`; preferir `RoundedCornerShape` para RTL.

## Acessibilidade
- Sem impacto direto; raios muito grandes podem reduzir área visível de hit-target — manter consistência com hit-target token.

## Referências
- [iOS `ZodiakRadii.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakRadii.swift)
- [Supernova: Radius](../../ZodiakiOS/docs/zodiak-pdf/Radius.md)

## Gaps & dúvidas para o time de Design
- [ ] Confirmar uso de `.continuous` (squircle) no iOS — performance vs estética em listas grandes.
- [ ] Mapping de Material 3 shape roles para tokens Zodiak.

## DoD
- [ ] Tokens expostos.
- [ ] Snapshot da radii sheet.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Disponibilidade
Tokens disponibilizados como **CSS Custom Properties** via `ThemeProvider`. Não há componente React dedicado — os valores são resolvidos automaticamente pela classe de tema no elemento raiz.

### Uso
```tsx
import { ThemeProvider } from '@cg-groupit/zodiak-design-system';

<ThemeProvider defaultTheme="light">
  {/* --zodiak-radius-md fica disponível em todo o subárvore */}
  <div style={{ border-radius: 'var(--zodiak-radius-md)' }} />
</ThemeProvider>
```

### Acessibilidade
- Use sempre tokens semânticos (ex.: `--zodiak-action-primary-default`) em vez de valores primitivos ou hardcoded.
