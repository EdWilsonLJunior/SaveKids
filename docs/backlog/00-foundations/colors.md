# Cores (tokens)

> **Categoria**: Foundation · **Prioridade**: P0 · **Plataformas**: iOS · Android · **Status**: Em Progresso · **Doc Supernova**: Verificado (Mai 2026)

## Contexto
Tokens de cor são a base do DS. Existem em duas camadas: **primitivos** (paleta bruta, sem semântica — Brand, Neutral, Teal, Green, Red, Yellow, Orange + Basics) e **semânticos** (uso intencional — `actionPrimary`, `surfaceBackground`, `textPrimary`, `borderSubtle`, `statusError`, etc.). Todo componente consome **apenas semânticos**; primitivos só aparecem dentro do Theme.

## História de usuário
Como **desenvolvedor de produto**, quero **acessar tokens semânticos via `Zodiak.colors` / `ZodiakTheme.colors`** para que **nenhum hex seja hardcoded e light/dark + contraste AA sejam garantidos automaticamente**.

## Critérios de aceite

### Cenário 1 — Cobertura
**Dado** o arquivo iOS [`Tokens/ZodiakColors.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakColors.swift) e [`ZodiakPrimitives.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakPrimitives.swift)
**Quando** comparo com o Supernova oficial
**Então** todos os tokens listados na doc Supernova existem em código, com o mesmo nome semântico.

> **Status**: ⚠️ Parcial. 63 tokens Zodiak verificados e implementados (Mai 2026). `brandHoverTint` e `ratingActive` removidos — ausentes do spec Zodiak (`ratingActive` é local em `ZodiakRating.swift`). Tokens Status/Banner/Warning-tints confirmados no spec — implementados via aliases de primitivos. Token `brand` em dark mode ambíguo no spec (ver Gaps).

### Cenário 2 — Light/Dark
**Dado** um token semântico que tem variante dark
**Quando** o ColorScheme muda
**Então** o valor resolve para a hex de dark sem qualquer lógica do componente consumidor.

> **Status**: ✅ Implementado (iOS via `Assets.xcassets`, Android via `LocalZodiakColors`). ⚠️ Pendente: slots High Contrast em todos os 41 colorsets iOS — aguardam hex values do design.

### Cenário 3 — Superfícies
**Dado** os tokens em famílias `onLite`, `onHeavy`, `onPhoto`
**Então** existe um token para cada combinação papel × superfície.

> **Status**: ✅ Implementado. Famílias `onLite`, `onHeavy` e `onPhoto` cobertas em iOS e Android.

### Cenário 4 — Acessibilidade
**Dado** qualquer par texto/fundo na biblioteca
**Quando** medo o contraste WCAG
**Então** alcança ≥ 4.5:1 (texto) ou ≥ 3:1 (UI).

> **Status**: ✅ 16 testes WCAG AA automatizados criados em [`ZodiakColorContrastTests.swift`](../../ZodiakiOS/ZodiakiOSTests/ZodiakColorContrastTests.swift). ⚠️ Pendente: integração no CI e cobertura dos pares em dark mode com HC.

### Cenário 5 — Paridade iOS ↔ Android
**Dado** a mesma chave semântica
**Então** o hex é idêntico nas duas plataformas (light e dark).

> **Status**: ✅ Implementado. Android reconstruído com [`ZodiakColorTokens.kt`](../../ZodiakAndroid/design-system/src/main/kotlin/com/zodiak/android/design_system/theme/ZodiakColorTokens.kt) (primitivos) e [`ZodiakSemanticColors.kt`](../../ZodiakAndroid/design-system/src/main/kotlin/com/zodiak/android/design_system/theme/ZodiakSemanticColors.kt) espelhando iOS. Paridade verificada por [`ZodiakColorParityTest.kt`](../../ZodiakAndroid/design-system/src/test/kotlin/com/zodiak/android/design_system/theme/ZodiakColorParityTest.kt) com **58 asserções de hex** (4 Blue + 4 Neutral + 4 Red primitivos + 32 Light semânticos + 14 Dark semânticos). `brandHoverTint` e `ratingActive` removidos (ausentes do spec Zodiak). Correcção de bug pré-existente em `Color.kt` e `ZodiakSemanticColors.kt` (nested object access via file-level `val`). Launcher JUnit Platform adicionado às dependências de teste.

## Spec técnica

### APIs públicas
- **iOS**: `ZodiakColors.<token>` retorna `Color` (SwiftUI) com asset catalog backing. Override em testes/previews via `@Environment(\.zodiakColors)` ([`ZodiakColorsEnvironment.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakColorsEnvironment.swift)).
- **Android**: `ZodiakTheme.colors.<token>` retorna `androidx.compose.ui.graphics.Color`, exposto via `LocalZodiakColors` (`compositionLocalOf<ZodiakSemanticColors>`).

### Tokens semânticos implementados (verificados contra Supernova, Mai 2026)

| Família | iOS | Android | Tokens |
|---|---|---|---|
| Brand | `brand`, `brandOrange` | ✅ | 2 |
| Surface | `background`, `surface`, `surfaceSmoke`, `surfaceFog`, `surfaceCaribbean`, `surfaceCaribbeanInverse`, `surfaceInk`, `surfaceMarine`, `surfaceAzur`, `surfaceAlwaysWhite`, `surfaceAlwaysBlack`, `surfacePositive`, `surfaceNegative`, `surfaceDecorativeBrand`, `surfaceDecorativeOrange` | ✅ | 15 |
| Text | `textPrimary`, `textSecondary`, `textInverse`, `textDisabled`, `textAlwaysWhite`, `textAlwaysBlack`, `textLink`, `textLinkHover`, `textLinkPressed`, `textLinkInverse`, `textNegative`, `textNegativeOnHeavy`, `textPositive` | ✅ | 13 |
| Status | `statusOnline`, `statusAway`, `statusDoNotDisturb`, `statusOffline` | ✅ | 4 |
| Warning tints | `actionWarningTint`, `surfaceWarningTint` | ✅ | 2 |
| Banner | `bannerSuccess`, `bannerWarning`, `bannerError` | ✅ | 3 |
| Action onLite | `actionPrimary`, `actionHover`, `actionPressed`, `actionFocus`, `actionDisabled`, `actionDisabledContent`, `actionActive` | ✅ | 7 |
| Action Warning | `actionWarning`, `actionWarningContent`, `actionWarningHover`, `actionWarningHoverOutline`, `actionWarningPressed`, `actionWarningPressedOutline`, `actionWarningSecondary`, `actionWarningSecondaryHover` | ✅ | 8 |
| Action onHeavy | `actionPrimaryOnHeavy`, `actionHoverOnHeavy`, `actionPressedOnHeavy`, `actionFocusOnHeavy`, `actionPrimaryOnPhoto` | ✅ | 5 |
| Border | `borderPrimary`, `borderSecondary` | ✅ | 2 |
| Overlay | `pageOverlay`, `heroPhotographic` | ✅ | 2 |
| **Total verificado e implementado** | | ✅ | **63** |

### Valores verificados pelo Supernova (referência rápida — pares críticos)

| Token | Light | Dark |
|---|---|---|
| `actionWarningContent` | `#171a22` | `#9e0029` |
| `actionWarningPressedOutline` | `#dd1d46` | `#e9edf3` |
| `textLinkInverse` | `#ffffff` | `#1d365a` |
| `textNegative` | `#9e0029` | `#ffa7a9` |
| `actionPrimary` | `#1d365a` | `#ffffff` |
| `background` | `#eff0f4` | `#21252d` |
| `surface` | `#ffffff` | `#12151d` |

## Boas práticas — iOS
- **HIG**: [Color](https://developer.apple.com/design/human-interface-guidelines/color), [Materials](https://developer.apple.com/design/human-interface-guidelines/materials).
- **SwiftUI**: definir cores como **Color Sets** em `Assets.xcassets` com slot light/dark/high-contrast; carregar via `Color("zodiak-action-primary", bundle: .module)`.
- Suportar **Increase Contrast** com a variante "Any Appearance" → "High Contrast".
- Expor via `EnvironmentValues` para overrides (testes, previews).

## Boas práticas — Android
- **Material 3**: usar `ColorScheme` semântico do Material como base e estender com `ZodiakColors` customizado via `CompositionLocal` (`LocalZodiakColors`).
- Não usar `Color(0xFFxxxxxx)` em componente — sempre `ZodiakTheme.colors.<token>`.
- **Dynamic Color (Material You)**: parâmetro `dynamicColor: Boolean` em `ZodiakTheme`; quando `true` E Android 12+, usar `dynamicLightColorScheme` mantendo brand tokens intactos.
- Contraste verificado com `androidx.core.graphics.ColorUtils.calculateContrast`.

## Acessibilidade
- Contraste AA mínimo em todos os pares texto/fundo definidos.
- Suporte automático a **Dark Mode** e **High Contrast** (iOS) / **Increase Contrast** (Android Accessibility Suite).
- Tokens nunca dependem só de cor para transmitir significado (status ganha ícone).

## Referências
- [iOS `ZodiakColors.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakColors.swift)
- [iOS `ZodiakPrimitives.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakPrimitives.swift)
- [Supernova: Introdução](../../ZodiakiOS/docs/zodiak-pdf/Introduction%20-%20Color.md)
- [Supernova: Primitivos](../../ZodiakiOS/docs/zodiak-pdf/Primitive%20colors%20-%20Color.md)
- [Supernova: Semânticos](../../ZodiakiOS/docs/zodiak-pdf/Semantic%20colors%20-%20Color.md)
- [Supernova: Acessibilidade](../../ZodiakiOS/docs/zodiak-pdf/Accessibility%20-%20Color.md)
- HIG Color: https://developer.apple.com/design/human-interface-guidelines/color
- Material 3 Color: https://m3.material.io/styles/color/overview

## Gaps & dúvidas para o time de Design

### Pendentes de input de design (bloqueiam DoD)

- [ ] **HC slots** — Fornecer os hex values para High Contrast (light HC + dark HC) de cada um dos 41 tokens semânticos. Nenhum colorset iOS tem slot HC atualmente. Após sign-off, ~41 arquivos `Contents.json` precisam ser atualizados (automatizável via script).

- [ ] **Token `brand` em dark mode** — O Supernova exibe `#0058ab` e `#ffffff` na seção Brand, mas o formato é ambíguo: pode ser `brand` fixo em `#0058ab` (ambos os modos) com `Capgemini Logo` como token separado `#ffffff`, ou `brand` adaptativo (light=`#0058ab`, dark=`#ffffff`). Atualmente hardcoded como fixo `#0058ab`. Confirmar intenção.

- [ ] **Política de Dynamic Color (Material You)** — Quando `dynamicColor=true` no Android, a `MaterialTheme.colorScheme` reflete as cores do wallpaper do sistema, ignorando os brand tokens Zodiak. Definir se isso é aceitável ou se deve ser desabilitado por padrão.

### Resolvidas

- [x] ~~Naming `background`/`surface` semanticamente invertidos~~ — Falso alarme. `background` = Page Background (#eff0f4) e `surface` = Surface (#ffffff) estão corretos conforme Supernova.
- [x] ~~`actionWarningContent` com valores trocados~~ — Regressão introduzida e revertida (Mai 2026). Spec confirma: light=`#171a22`, dark=`#9e0029`.
- [x] ~~`actionWarningPressedOutline` com valor light errado~~ — Corrigido para `#dd1d46` (Red-600) conforme Supernova.
- [x] ~~`textLinkInverse` sem variante dark~~ — Corrigido; colorset criado com dark=`#1d365a` conforme Supernova.
- [x] ~~Android com paleta Material genérica incorreta~~ — Reconstruído com primitivos e tokens semânticos Zodiak corretos.
- [x] ~~Sem mecanismo de override para testes/previews (iOS)~~ — `ZodiakColorScheme` + `EnvironmentValues` implementados.

## DoD
Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias). Específico aqui:
- [x] Asset catalog iOS com 100% dos tokens Supernova, light + dark. ⚠️ HC pendente (bloqueado pelo design).
- [x] `LocalZodiakColors` Compose com 100% dos tokens, light + dark, com integração opcional Dynamic Color.
- [x] Snapshot test do color sheet (grid de swatches) em light e dark — iOS ([`ZodiakColorSheetSnapshotTests.swift`](../../ZodiakiOS/ZodiakiOSTests/ZodiakColorSheetSnapshotTests.swift)).
- [x] Verificação automatizada de contraste — iOS ([`ZodiakColorContrastTests.swift`](../../ZodiakiOS/ZodiakiOSTests/ZodiakColorContrastTests.swift), 16 testes WCAG AA).
- [x] Paridade iOS ↔ Android verificada por testes ([`ZodiakColorParityTest.kt`](../../ZodiakAndroid/design-system/src/test/kotlin/com/zodiak/android/design_system/theme/ZodiakColorParityTest.kt), 36 asserções).
- [ ] HC slots nos 41 colorsets iOS — aguarda hex values do design.
- [x] ~~Sign-off tokens iOS-only~~ — Confirmados no spec Zodiak (Mai 2026). 63 tokens implementados (`ratingActive` ausente do spec — cor local em `ZodiakRating.swift`).
- [ ] Confirmação do comportamento de `brand` em dark mode.
- [ ] Testes de contraste integrados no CI.


## Boas práticas — React/Web

### Disponibilidade
Tokens de cor expostos como **CSS Custom Properties** via `ThemeProvider`. A classe `.zodiak-theme-light` ou `.zodiak-theme-dark` no elemento raiz resolve automaticamente os valores semânticos.

### Uso
```tsx
import { ThemeProvider } from '@cg-groupit/zodiak-design-system';

<ThemeProvider defaultTheme="light" storageKey="zodiak-theme">
  <App />
</ThemeProvider>
```

```css
/* Em qualquer folha CSS sob o ThemeProvider: */
.meu-componente {
  color:      var(--zodiak-text-primary);
  background: var(--zodiak-surface-background);
  border:     1px solid var(--zodiak-border-primary);
}
```

### Props principais — ThemeProvider
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `defaultTheme` | `'light' \| 'dark'` | sistema | Tema inicial |
| `storageKey` | `string` | — | Chave localStorage para persistência |

### Acessibilidade
- Contraste mínimo: ≥ 4.5:1 para texto, ≥ 3:1 para UI.
- Nunca use primitivos hexadecimais em produção; use tokens semânticos.

### Storybook
- `AllOptions`: grade de todas as variantes de tema
- `Playground`: alternância light/dark interativa
