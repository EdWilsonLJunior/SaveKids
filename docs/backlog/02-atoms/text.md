# Text

> **Categoria**: Atom · **Prioridade**: P0 · **Plataformas**: iOS · Android · **Status**: In Progress · **Doc Supernova**: Sim

## Contexto
`ZodiakText` é o componente canônico para renderizar texto no DS. Aceita estilo tipográfico via `ZodiakTextViewStyle` (enum com 17 cases) e cor semântica integrada ao case ou como parâmetro (body/italic). É o substituto do `Text` nativo em todo o código de produto — ninguém usa o nativo diretamente.

> **⚠️ Divergência spec/implementação iOS**: O backlog original especificava `ZodiakTextStyle` com `color: ZodiakColor` separado. A implementação real usa `ZodiakTextViewStyle` com cor embutida nos cases body e fixa (textPrimary) em headings. Pendente decisão do time de Design para alinhar a API.

## História de usuário
Como **desenvolvedor**, quero **renderizar textos com `ZodiakText`** para que **estilo, cor, line-height, tracking e dynamic type sigam o DS automaticamente**.

## Critérios de aceite

### Cenário 1 — Estilo + cor
**Dado** `ZodiakText("Olá", style: .title2)` (heading) ou `ZodiakText("Corpo", style: .body(color: .secondary))` (body)
**Então** texto renderiza com o style token e cor token corretas em light/dark.

### Cenário 2 — Multilinha + truncamento
**Dado** texto longo + `lineLimit: 2`
**Então** truncado com `…` no fim, sem layout shift.

### Cenário 3 — Dynamic Type / FontScale 2.0
**Dado** o sistema em FontScale 2.0
**Então** texto cresce respeitando o `relativeTo:` do token; layout não quebra.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver ativo
**Então** headings (display + padrão) recebem trait `.isHeader` automaticamente; body não recebe. Texto lido com pronúncia correta.

### Cenário 5 — RTL
**Dado** locale RTL
**Então** alinhamento padrão inverte (`leading` → trailing visual).

## Spec técnica iOS

### API pública (implementação atual)
```swift
// Init via chave de localização (padrão para UI estática)
ZodiakText(_ text: String, style: ZodiakTextViewStyle, alignment: TextAlignment = .leading, lineLimit: Int? = nil)

// Init com LocalizedStringKey tipado
ZodiakText(_ key: LocalizedStringKey, style: ZodiakTextViewStyle, alignment: TextAlignment = .leading, lineLimit: Int? = nil)

// Init verbatim — dados dinâmicos sem lookup
ZodiakText(verbatim text: String, style: ZodiakTextViewStyle, alignment: TextAlignment = .leading, lineLimit: Int? = nil)
```

### `ZodiakTextViewStyle` — 17 cases

#### Display Headings (peso configurável)
| Case | Tamanho | Peso padrão | Tracking | Line-height |
|---|---|---|---|---|
| `.headline6XL(weight:)` | 128pt | Light 300 | −1.5pt | 134pt |
| `.headline5XL(weight:)` | 96pt | Light 300 | −0.8pt | 108pt |
| `.headline4XL(weight:)` | 72pt | Light 300 | −1.2pt | 84pt |
| `.headline3XL(weight:)` | 56pt | Light 300 | −0.6pt | 68pt |
| `.headline2XL(weight:)` | 48pt | Light 300 | −0.3pt | 58pt |
| `.headlineXL(weight:)` | 40pt | Light 300 | −0.2pt | 50pt |

`HeadingWeight`: `.light` (300) · `.regular` (400)

#### Standard Headings (peso fixo)
| Case | Tamanho | Peso | Tracking | Line-height |
|---|---|---|---|---|
| `.headline` | 32pt | Light 300 | 0pt | 40pt |
| `.title1` | 24pt | Light 300 | +0.3pt | 32pt |
| `.title2` | 18pt | Regular 400 | +0.2pt | 26pt |
| `.title3` | 16pt | Regular 400 | +0.3pt | 21pt |
| `.subtitleSmall` | 14pt | Regular 400 | +1.4% | 18pt |

#### Body (cor e bold configuráveis)
| Case | Tamanho | Tracking | Line-height | Cor padrão |
|---|---|---|---|---|
| `.bodyXL(bold:color:)` | 24pt | +1.2% | 36pt | `.primary` |
| `.bodyLarge(bold:color:)` | 18pt | +1.2% | 30pt | `.primary` |
| `.body(bold:color:)` | 16pt | +0.24pt | 26pt | `.primary` |
| `.bodySmall(bold:color:)` | 14pt | +2.2% | 21pt | `.primary` |
| `.caption(bold:color:)` | 12pt | +2.5% | 18pt | `.secondary` |

#### Italic
| Case | Parâmetros |
|---|---|
| `.italic(size:color:)` | `size: ZodiakTypography.BodySize` (padrão `.m`), `color: ZodiakTextColor` (padrão `.primary`) |

### `ZodiakTextColor`
`.primary` · `.secondary` · `.disabled` · `.negative` · `.link` · `.linkHover` · `.linkPressed` · `.linkInverse` · `.inverse`

### Comportamento de acessibilidade
- Todos os headings (display + padrão) aplicam `.accessibilityAddTraits(.isHeader)` automaticamente.
- Body e italic não recebem `.isHeader`.

### Tokens consumidos
- `ZodiakTypography.*` (font, tracking, line-height). Ver [typography](../00-foundations/typography.md).
- `ZodiakColors.text*` via `ZodiakTextColor`. Ver [colors](../00-foundations/colors.md).

## Gallery View iOS

**`TextsGalleryView`** — 3 abas:

| Aba | Arquivo | Conteúdo |
|---|---|---|
| Galeria | `TextsGalleryView.swift` | Playground + todos os 17 cases + italic + alinhamento + cores |
| Specs | `TextsSpecsView.swift` | Tabela size/tracking/line-height + comportamento de cor + inicializadores |
| A11y | `TextsA11yView.swift` | isHeader trait + contraste WCAG + Dynamic Type + verbatim vs. localizado |

## Boas práticas — iOS
- Use `ZodiakText("key", style:)` para texto de UI estático (chave de localização).
- Use `ZodiakText(verbatim: data, style:)` para dados dinâmicos.
- **Não** use `Text` nativo em código de feature — sempre `ZodiakText`.
- `TypographyGalleryView` demonstra os tokens `ZodiakTypography.*` diretamente; `TextsGalleryView` demonstra o **componente** `ZodiakText`.
- HIG: [Typography](https://developer.apple.com/design/human-interface-guidelines/typography).

## Boas práticas — Android
- **Assinatura concreta**: `@Composable fun ZodiakText(text: String, style: ZodiakTextStyle = ZodiakTheme.typography.bodyMedium, color: Color = ZodiakTheme.colors.textPrimary, textAlign: TextAlign? = null, maxLines: Int = Int.MAX_VALUE, overflow: TextOverflow = TextOverflow.Clip, modifier: Modifier = Modifier)`. Overload `AnnotatedString`.
- `Modifier.semantics { heading() }` para títulos.
- `AnnotatedString` + `ClickableText` para inline links.

## Boas práticas — React/Web

### Importação
```tsx
import { Typography } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `type` | `'heading' \| 'body'` | — | Família tipográfica (obrigatório) |
| `size` | `HeadingSize \| BodySize` | — | Heading `6XL`…`2XS`; Body `XL`…`XS` |
| `weight` | `300 \| 400 \| 500` | `300` | Peso (somente type="heading") |
| `as` | `React.ElementType` | `'span'`/`'p'` | Elemento HTML semântico |

### Alinhamento React vs iOS
| React (HeadingSize) | iOS (ZodiakTextViewStyle) |
|---|---|
| `6XL`–`XL` | `.headline6XL`–`.headlineXL` |
| `L` | `.headline` (32pt) |
| `M` | `.title1` (24pt) |
| `S` | `.title2` (18pt) |
| `XS` | `.title3` (16pt) |
| `2XS` | `.subtitleSmall` (14pt) |
| body `XL` | `.bodyXL` |
| body `L` | `.bodyLarge` |
| body `M` | `.body` |
| body `S` | `.bodySmall` |
| body `XS` | `.caption` |

> **Diferença**: React tem 11 heading sizes e peso 500 (medium). iOS tem 11 heading cases (6 display + 5 standard) e 2 pesos (light/regular). Peso 500 não está implementado em iOS.

## Acessibilidade
- Headings declarados (`.accessibilityAddTraits(.isHeader)` iOS / `semantics { heading() }` Android).
- Texto importante nunca em `.caption` com `.disabled` color.
- Suporte FontScale 2.0 via `relativeTo:` em todos os tokens.

## Gaps & dúvidas para o time de Design
- [ ] Alinhar API iOS: `ZodiakTextViewStyle` (atual) vs `ZodiakTextStyle` com `color:` separado (backlog original).
- [ ] Peso 500 (Medium/semibold) para headings — implementado em React, ausente em iOS/Android.
- [ ] Suporte oficial a **markdown inline** (bold, italic, link) em `ZodiakText`?
- [ ] Política para texto **truncado clicável** (ver mais inline)?

## DoD
- [x] API iOS implementada: 3 inits (String, LocalizedStringKey, verbatim) × 17 cases de estilo.
- [x] Todos os 17 `ZodiakTextViewStyle` documentados e exibidos na gallery view.
- [x] Gallery view com 3 abas: Galeria, Specs, A11y.
- [x] Trait `.isHeader` automático em todos os headings.
- [x] Dynamic Type via `relativeTo:` em todos os tokens.
- [ ] Snapshot por style × tema × FontScale.
- [ ] Android: implementar `ZodiakText` equivalente.
- [ ] Alinhamento de nomenclatura `ZodiakTextViewStyle` ↔ `ZodiakTextStyle` entre plataformas.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).

## Referências
- [iOS `Atoms/Text/ZodiakText.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Atoms/Text/ZodiakText.swift)
- [iOS `App/Catalog/Components/Atoms/TextsGalleryView.swift`](../../ZodiakiOS/ZodiakiOS/App/Catalog/Components/Atoms/TextsGalleryView.swift)
- [iOS `Utils/ZodiakFontModifier.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Utils/ZodiakFontModifier.swift)
- [Tokens `ZodiakTypography.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakTypography.swift)
- [Supernova: Overview](../../ZodiakiOS/docs/zodiak-pdf/Overview%20-%20Typography.md)
- [Supernova: Usage](../../ZodiakiOS/docs/zodiak-pdf/Usage%20-%20Typography.md)

## História de usuário
Como **desenvolvedor**, quero **renderizar textos com `ZodiakText`** para que **estilo, cor, line-height, tracking e dynamic type sigam o DS automaticamente**.

## Critérios de aceite

### Cenário 1 — Estilo + cor
**Dado** `ZodiakText("Olá", style: .titleLarge, color: .textPrimary)`
**Então** texto renderiza com o style token e cor token corretas em light/dark.

### Cenário 2 — Multilinha + truncamento
**Dado** texto longo + `lineLimit(2, reservesSpace: true)`
**Então** truncado com `…` no fim, sem layout shift.

### Cenário 3 — Dynamic Type / FontScale 2.0
**Dado** o sistema em FontScale 2.0
**Então** texto cresce respeitando `maxScale` do token; layout não quebra.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** o texto é lido com pronúncia correta (atributos linguísticos quando aplicável), e papel `text` ou `header` quando style for `headline*`/`title*`.

### Cenário 5 — RTL
**Dado** locale RTL
**Então** alinhamento padrão inverte (`leading` → trailing visual).

## Spec técnica

### APIs públicas
- `ZodiakText(_ text: String, style: ZodiakTextStyle = ZodiakTextStyle.bodyMedium, color: ZodiakColor = ZodiakColor.textPrimary, alignment: TextAlignment = .leading, lineLimit: Int? = none)`. Suporta `AttributedString` overload.

### Primitivo interno
- Não há primitivo separado — `ZodiakText` é o primitivo único; styles são parâmetros (assinatura idêntica).

### Estados
- N/A (texto não tem estados interativos).

### Tokens consumidos
- `typography.*`, `colors.text*`. Ver [typography](../00-foundations/typography.md), [colors](../00-foundations/colors.md).

## Boas práticas — iOS
- **Assinatura concreta**: `ZodiakText(_ text: String, style: ZodiakTextStyle = .bodyMedium, color: ZodiakColor = .textPrimary, alignment: TextAlignment = .leading, lineLimit: Int? = none)`. Suporta `AttributedString` overload.

- HIG: [Typography](https://developer.apple.com/design/human-interface-guidelines/typography).
- SwiftUI nativo equivalente: `Text(_:)` com `.font()`/`.foregroundStyle()`.
- `Font.custom(_:size:relativeTo:)` para Dynamic Type relativo.
- `.dynamicTypeSize(...)` para clampear.
- `.accessibilityHeading(.h1)` quando style for headline.
- `AttributedString` para markdown inline (links, ênfase).

## Boas práticas — Android
- **Assinatura concreta**: `@Composable fun ZodiakText(text: String, style: ZodiakTextStyle = ZodiakTheme.typography.bodyMedium, color: Color = ZodiakTheme.colors.textPrimary, textAlign: TextAlign? = null, maxLines: Int = Int.MAX_VALUE, overflow: TextOverflow = TextOverflow.Clip, modifier: Modifier = Modifier)`. Overload `AnnotatedString`.

- Material 3: `Text` (composable).
- `androidx.compose.material3.Text(text, style, color, ...)` — `ZodiakText` é wrapper fino sobre ele.
- `Modifier.semantics { heading() }` para títulos.
- `LocalDensity.fontScale` para clampear quando necessário.
- `AnnotatedString` + `ClickableText` para inline links (preferir `ZodiakTextLink` quando link ocupa fragmento inteiro).

## Acessibilidade
- Headings declarados (`accessibilityHeading` / `semantics { heading() }`).
- Texto importante nunca em `caption` (legibilidade baixa).
- Suporte FontScale 2.0 (clampar `display*` em 1.5×).

## Referências
- [iOS `Atoms/Text/ZodiakText.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Atoms/Text/ZodiakText.swift)
- [iOS `Utils/ZodiakFontModifier.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Utils/ZodiakFontModifier.swift)
- [Supernova: Overview](../../ZodiakiOS/docs/zodiak-pdf/Overview%20-%20Typography.md)
- [Supernova: Usage](../../ZodiakiOS/docs/zodiak-pdf/Usage%20-%20Typography.md)

## Gaps & dúvidas para o time de Design
- [ ] Suporte oficial a **markdown inline** (bold, italic, link) em `ZodiakText`?
- [ ] Política para texto **truncado clicável** (ver mais inline)?

## DoD
- [ ] API única exposta, com overloads para `String` e `AttributedString`/`AnnotatedString`.
- [ ] Suporte completo a Dynamic Type / FontScale 2.0.
- [ ] Snapshot por style × tema × FontScale.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


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
| `weight` | `300 \| 400 \| 500` | `300` | Peso (somente type="heading") |
| `as` | `React.ElementType` | `'span'`/`'p'` | Elemento HTML semântico |

### Acessibilidade
- Sempre defina `as` com a tag semântica correta para a hierarquia de headings da página.
- Não use `Typography` para estilizar elementos interativos.

### Storybook
- `AllOptions`: grade completa de estilos heading e body em light/dark
- `Playground`: controles interativos
