# Spacing (tokens)

> **Categoria**: Foundation · **Prioridade**: P0 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Sim

## Contexto
Escala de espaçamento — paddings, margins, gaps. Toda medida de layout em componente Zodiak resolve para um destes tokens. Garante ritmo visual consistente.

## História de usuário
Como **desenvolvedor**, quero **espaçar elementos via tokens nomeados** para que **layouts sigam o ritmo 4/8pt sem números mágicos**.

## Critérios de aceite

### Cenário 1 — Escala
**Dado** [`ZodiakSpacing.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakSpacing.swift) e Supernova [`Spacing.md`](../../ZodiakiOS/docs/zodiak-pdf/Spacing.md)
**Então** todos os steps da escala (4, 8, 12, 16, 24, 32, 40, 48, 56, 64, 80…) existem como tokens nomeados.

### Cenário 2 — Nomenclatura semântica
**Dado** tokens (`s0`, `s4`, `s8`… ou `xs`, `sm`, `md`…)
**Então** o nome é o mesmo nas duas plataformas.

### Cenário 3 — Densidade
**Dado** density classes `default`/`comfortable`/`compact`
**Quando** o tema é trocado
**Então** o token resolve para múltiplos proporcionais (opcional — discutir com Design).

### Cenário 4 — RTL
**Dado** layouts com `paddingStart`/`paddingEnd`
**Então** funcionam corretamente em RTL.

### Cenário 5 — Paridade
**Dado** o mesmo token
**Então** pt (iOS) = dp (Android) numericamente.

## Spec técnica

### APIs públicas
- **iOS**: `Zodiak.spacing.<token>` → `CGFloat`.
- **Android**: `ZodiakTheme.spacing.<token>` → `androidx.compose.ui.unit.Dp`.

### Tokens (lista canônica em Swift)
- `Zodiak.spacing.s0`
- `Zodiak.spacing.s2`
- `Zodiak.spacing.s4`
- `Zodiak.spacing.s8`
- `Zodiak.spacing.s12`
- `Zodiak.spacing.s16`
- `Zodiak.spacing.s20`
- `Zodiak.spacing.s24`
- `Zodiak.spacing.s32`
- `Zodiak.spacing.s40`
- `Zodiak.spacing.s48`
- `Zodiak.spacing.s56`
- `Zodiak.spacing.s64`
- `Zodiak.spacing.s80`
- `Zodiak.spacing.s96`
- `Zodiak.spacing.s128`

> O sufixo numérico **é** o nome do token (não um valor). O valor resolvido vive em [`Tokens/ZodiakSpacing.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakSpacing.swift). Histórias e código consumidor **nunca** referenciam o valor diretamente.

## Boas práticas — iOS
- **SwiftUI**: usar `.padding(Zodiak.spacing.s16)`, `Spacer().frame(width: Zodiak.spacing.s8)`, `VStack(spacing: Zodiak.spacing.s12)`.
- Suportar RTL com `.environment(\.layoutDirection, .rightToLeft)` em previews; `.leading`/`.trailing` são automáticos.
- **HIG Layout**: https://developer.apple.com/design/human-interface-guidelines/layout

## Boas práticas — Android
- **Compose**: `Modifier.padding(ZodiakTheme.spacing.s16)`, `Spacer(Modifier.height(ZodiakTheme.spacing.s12))`, `Arrangement.spacedBy(ZodiakTheme.spacing.s8)`.
- Usar `padding(start = …, end = …)` (não `paddingLeft/Right`) para RTL.
- **Material 3 Layout**: https://m3.material.io/foundations/layout/understanding-layout/spacing

## Acessibilidade
- Espaços não substituem hit-target — uso de `s4`/`s8` em torno de botão **não** dispensa o mínimo de 44pt/48dp.
- Em FontScale alto, certos espaços (ex.: gap entre label e input) podem precisar escalar — discutir Design.

## Referências
- [iOS `ZodiakSpacing.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakSpacing.swift)
- [Supernova: Spacing](../../ZodiakiOS/docs/zodiak-pdf/Spacing.md)

## Gaps & dúvidas para o time de Design
- [ ] Definir se haverá density classes (compact/comfortable) ou escala única.
- [ ] Tokens "negativos" (overlap) — não documentados.
- [ ] Mapping de spacing → FontScale (alguns gaps verticais deveriam escalar com texto).

## DoD
- [ ] Tokens expostos em iOS/Android com mesma nomenclatura.
- [ ] Snapshot test da spacing sheet.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Disponibilidade
Tokens disponibilizados como **CSS Custom Properties** via `ThemeProvider`. Não há componente React dedicado — os valores são resolvidos automaticamente pela classe de tema no elemento raiz.
> **Nota:** Use múltiplos de 4 px via tokens `--zodiak-spacing-4`, `--zodiak-spacing-8`, `--zodiak-spacing-16`, etc.


### Uso
```tsx
import { ThemeProvider } from '@cg-groupit/zodiak-design-system';

<ThemeProvider defaultTheme="light">
  {/* --zodiak-spacing-16 fica disponível em todo o subárvore */}
  <div style={{ padding: 'var(--zodiak-spacing-16)' }} />
</ThemeProvider>
```

### Acessibilidade
- Use sempre tokens semânticos (ex.: `--zodiak-action-primary-default`) em vez de valores primitivos ou hardcoded.
