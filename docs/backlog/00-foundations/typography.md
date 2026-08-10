# Tipografia (tokens)

> **Categoria**: Foundation · **Prioridade**: P0 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Sim

## Contexto
Tokens de tipografia definem a escala tipográfica do Zodiak — famílias, tamanhos, pesos, line-heights e tracking. Cada estilo tem nome semântico (`displayLarge`, `headlineMedium`, `titleSmall`, `bodyLarge`, `labelLarge`, etc.) e é consumido por `ZodiakText` e blocos tipográficos. Suporta **Dynamic Type** (iOS) / **FontScale** (Android) preservando hierarquia.

## História de usuário
Como **desenvolvedor**, quero **aplicar estilos tipográficos via tokens nomeados** para que **escala, peso e line-height sejam consistentes e respeitem acessibilidade automaticamente**.

## Critérios de aceite

### Cenário 1 — Escala completa
**Dado** [`ZodiakTypography.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakTypography.swift) e Supernova [`Size - Typography.md`](../../ZodiakiOS/docs/zodiak-pdf/Size%20-%20Typography.md)
**Então** todos os níveis estão presentes: `display`, `headline`, `title`, `body`, `label`, `caption` × `large`/`medium`/`small`.

### Cenário 2 — Fontes carregadas
**Dado** as fontes brand do Zodiak (custom)
**Quando** o app inicializa
**Então** as fontes carregam corretamente em ambas as plataformas (Info.plist `UIAppFonts` + asset font; `androidx.compose.ui.text.font.FontFamily(Font(R.font.zodiak_*))`).

### Cenário 3 — Dynamic Type / FontScale
**Dado** o usuário aumenta o tamanho do sistema para acessibilidade
**Quando** um `ZodiakText` renderiza
**Então** o tamanho escala respeitando o `maxScale` definido por token (ex.: `display` clampado em 1.5×, `body` até 2.0×).

### Cenário 4 — Color × Typography
**Dado** tokens de cor de texto (`textPrimary`, `textSecondary`, `textInverse`)
**Então** combinam com estilos tipográficos para formar variantes consumíveis (ex.: `bodyLargeOnLite`).

### Cenário 5 — Paridade iOS ↔ Android
**Dado** o mesmo token (ex.: `titleLarge`)
**Então** font-family, size, weight, line-height e tracking são idênticos.

## Spec técnica

### APIs públicas
- **iOS**: `Zodiak.typography.<token>` → `Font` ou `TextStyle` (struct com size + weight + lineSpacing + tracking).
- **Android**: `ZodiakTheme.typography.<token>` → `androidx.compose.ui.text.TextStyle`.

### Estilos esperados (consultar Swift para a lista canônica)
- `displayLarge` / `displayMedium` / `displaySmall`
- `headlineLarge` / `headlineMedium` / `headlineSmall`
- `titleLarge` / `titleMedium` / `titleSmall`
- `bodyLarge` / `bodyMedium` / `bodySmall`
- `labelLarge` / `labelMedium` / `labelSmall`
- `captionLarge` / `captionSmall`
- Variantes opcionais: `*Underline`, `*Strong`, `*Italic`

### Atributos por estilo
- `fontFamily`, `fontSize`, `fontWeight`, `lineHeight`, `letterSpacing` (tracking), `textDecoration`.

### Comportamento
- Conversão sp ↔ pt respeita densidade.
- Underline preserva descenders.
- Line-height usa o multiplicador da Supernova (`lineHeightMultiplier`).

## Boas práticas — iOS
- **HIG**: [Typography](https://developer.apple.com/design/human-interface-guidelines/typography).
- **SwiftUI**: usar `Font.custom(_:size:relativeTo:)` com `TextStyle` base correspondente para Dynamic Type automático.
- `@Environment(\.dynamicTypeSize)` para clampear se necessário (`.dynamicTypeSize(.xSmall ... .xxxLarge)`).
- Carregar fontes via `Info.plist` `UIAppFonts` e registrar com `CTFontManagerRegisterFontsForURL` quando vier de pacote.
- Acessibilidade: estilos relativos (`.relativeTo:`) preservam hierarquia ao escalar.

## Boas práticas — Android
- **Material 3**: [Typography](https://m3.material.io/styles/typography/overview).
- **Compose**: registrar fontes em `res/font/` e expor `FontFamily(Font(R.font.zodiak_*))`. Estender `androidx.compose.material3.Typography` com mapping para os tokens semânticos do Zodiak.
- Suporte FontScale via `LocalDensity.fontScale`; clampear com `androidx.compose.ui.unit.TextUnit` quando necessário.
- `TextStyle.lineHeight` em `sp` para escalar com o sistema.
- `letterSpacing` em `em` (relativo ao fontSize) para escalar proporcionalmente.

## Acessibilidade
- Dynamic Type / FontScale até **2.0** em todos os estilos exceto `display*` (que clampa em 1.5× para evitar quebra de layout).
- Contraste do `text*` token sobre `surface*` sempre AA+.
- Não usar `caption` para conteúdo crítico (legibilidade abaixo do limite).

## Referências
- [iOS `ZodiakTypography.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakTypography.swift)
- [iOS `Utils/ZodiakFontModifier.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Utils/ZodiakFontModifier.swift)
- [Supernova: Overview](../../ZodiakiOS/docs/zodiak-pdf/Overview%20-%20Typography.md)
- [Supernova: Size](../../ZodiakiOS/docs/zodiak-pdf/Size%20-%20Typography.md)
- [Supernova: Color](../../ZodiakiOS/docs/zodiak-pdf/Color%20-%20Typography.md)
- [Supernova: Usage](../../ZodiakiOS/docs/zodiak-pdf/Usage%20-%20Typography.md)
- HIG Typography: https://developer.apple.com/design/human-interface-guidelines/typography
- Material 3 Typography: https://m3.material.io/styles/typography/overview

## Gaps & dúvidas para o time de Design
- [ ] Definir `maxFontScale` oficial por nível (atualmente derivado por convenção).
- [ ] Confirmar família de fonte para títulos vs corpo (mesma família ou pareada?).
- [ ] Estilos para **caixa-alta / small-caps / monoespaço** se necessários.
- [ ] Tokens para variantes `*Underline` e `*Strong` (atualmente derivados).

## DoD
Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias). Específico:
- [ ] Fontes registradas e carregando em iOS e Android.
- [ ] 100% dos estilos da Supernova expostos como tokens.
- [ ] Snapshot test da "typography sheet" em light/dark × FontScale 1.0/1.5/2.0.


## Boas práticas — React/Web

### Importação
```tsx
import { Typography } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `type` | `'heading' \| 'body'` | — | Família tipográfica (obrigatório) |
| `size` | `HeadingSize \| BodySize` | — | Escala: Heading `6XL`…`2XS`; Body `XL`…`XS` |
| `weight` | `300 \| 400 \| 500` | `300` | Peso (apenas para `type="heading"`) |
| `as` | `React.ElementType` | `'span'`/`'p'` | Elemento HTML semântico a renderizar |

### Acessibilidade
- Sempre defina `as` com o elemento HTML correto na hierarquia da página (`h1`…`h6`, `p`, `span`).
- Nunca use `Typography` para decorar elementos interativos — prefira `ButtonRegular` ou `Link`.

### Storybook
- `AllOptions`: grade de todos os estilos de heading e body em light/dark
- `Playground`: controles interativos de `type`, `size`, `weight` e `as`
