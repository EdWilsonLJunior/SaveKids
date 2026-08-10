# ZodiakTheme (Light/Dark + ColorScheme)

> **Categoria**: Theme · **Prioridade**: P0 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Parcial

## Contexto
`ZodiakTheme` é o **provider** que expõe todos os tokens (colors, typography, spacing, sizing, radii, borders, shadows, blurs, grid, icons, flags, logo, gradients) para a árvore de UI. Responsável pela resolução **light/dark**, integração opcional com **Dynamic Color (Material You)** no Android, e bridge para `MaterialTheme` (M3) / `EnvironmentValues` (SwiftUI).

## História de usuário
Como **desenvolvedor**, quero **envolver minha tela com `ZodiakTheme`** para que **todo componente Zodiak consuma tokens corretos automaticamente, sem precisar configurar cada cor/tamanho manualmente**.

## Critérios de aceite

### Cenário 1 — Configuração mínima
**Dado** uma raiz com `ZodiakTheme { content }`
**Então** todos os componentes Zodiak filhos renderizam com o esquema light, sem nenhum parâmetro extra.

### Cenário 2 — Dark mode automático
**Dado** o usuário troca o modo no sistema
**Quando** o app está em foreground
**Então** todos os tokens semânticos resolvem para dark, sem reinicialização.

### Cenário 3 — Override por subárvore
**Dado** uma área da UI precisa forçar dark (ex.: hero sobre foto)
**Quando** uso `ZodiakTheme(colorScheme: .dark) { ... }` aninhado
**Então** apenas aquela subárvore é dark.

### Cenário 4 — Dynamic Color (Android)
**Dado** Android 12+ e `ZodiakTheme(dynamicColor: true)`
**Quando** o usuário muda o wallpaper
**Então** **superfícies neutras** acompanham, mas **brand tokens permanecem fixos**.

### Cenário 5 — Acessibilidade
**Dado** `Increase Contrast` (iOS) ativo
**Então** o tema seleciona a variante "High Contrast" dos color sets.

## Spec técnica

### APIs públicas
- **iOS**:
  ```
  ZodiakTheme<Content: View>(
    colorScheme: ColorScheme? = nil,         // nil = segue o sistema
    typography: ZodiakTypography? = nil,      // override opcional
    @ViewBuilder content: () -> Content
  )
  ```
  Exposição via `@Environment(\.zodiakTokens)` (custom EnvironmentKey).
- **Android**:
  ```
  @Composable
  fun ZodiakTheme(
    darkTheme: Boolean = isSystemInDarkTheme(),
    dynamicColor: Boolean = false,
    content: @Composable () -> Unit
  )
  ```
  Exposição via `CompositionLocalProvider(LocalZodiakColors, LocalZodiakTypography, …)`.

### Bridge com APIs nativas
- **SwiftUI**: ZodiakTheme também aplica `.preferredColorScheme` quando override; expõe via `Environment` para componentes.
- **Compose**: ZodiakTheme também invoca `MaterialTheme(colorScheme, typography, shapes)` mapeando tokens Zodiak → roles M3 (`primary` ← `brandPrimary`, etc.), para que componentes Material 3 nativos usados internamente herdem o brand.

## Boas práticas — iOS
- HIG: [Dark Mode](https://developer.apple.com/design/human-interface-guidelines/dark-mode).
- Color sets em asset catalog com slots `Any`, `Dark`, `Any High Contrast`, `Dark High Contrast`.
- `@Environment(\.colorScheme)`, `@Environment(\.accessibilityShowButtonShapes)`.
- Não usar `colorScheme` para lógica de negócio — só visual.

## Boas práticas — Android
- Material 3: [Color schemes](https://m3.material.io/styles/color/the-color-system/color-roles).
- `MaterialTheme(colorScheme = ..., typography = ..., shapes = ...)` envolto pelo `ZodiakTheme`.
- Dynamic Color: `dynamicLightColorScheme(LocalContext.current)` / `dynamicDarkColorScheme(...)` (API 31+); fallback estático.
- `WindowCompat.setDecorFitsSystemWindows(false)` para edge-to-edge; `Modifier.systemBarsPadding()` para safe insets.
- `isSystemInDarkTheme()` para detecção automática.

## Acessibilidade
- Suporte automático a **Dark Mode**, **Increase Contrast**, **Reduce Transparency**, **Reduce Motion** (estes três viram flags acessíveis dentro do Theme).
- Permitir override programático para testes (`@Environment(\.colorScheme, .dark)`).

## Referências
- [iOS `Theme/ZodiakTheme.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Theme/ZodiakTheme.swift)
- [Supernova: Introduction](../../ZodiakiOS/docs/zodiak-pdf/Introduction%20-%20Color.md)
- HIG Dark Mode: https://developer.apple.com/design/human-interface-guidelines/dark-mode
- Material 3 Theming: https://m3.material.io/develop/android/jetpack-compose#theming

## Gaps & dúvidas para o time de Design
- [ ] Política de **Dynamic Color** vs brand fixo — quando habilitar?
- [ ] Suporte a **temas sazonais / co-brand** (ex.: campanha temporária).
- [ ] Comportamento durante mudança de tema **dentro do app** (animação ou snap?).

## DoD
- [ ] Provider funcional em iOS (Environment) e Android (CompositionLocal).
- [ ] Bridge com `MaterialTheme` aplicada e testada.
- [ ] Light/Dark, High Contrast, Dynamic Color verificados.
- [ ] Snapshot test de "theme matrix" (4 combos: light/dark × normal/high-contrast).
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Importação
```tsx
import { ThemeProvider, useZodiakTheme } from '@cg-groupit/zodiak-design-system';
```

### Props principais — ThemeProvider
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `defaultTheme` | `'light' \| 'dark'` | preferência do sistema | Tema inicial |
| `storageKey` | `string` | — | Chave localStorage para persistir a escolha |
| `className` | `string` | — | Classe extra no elemento wrapper |
| `children` | `ReactNode` | — | Subárvore que receberá o tema |

### Uso com hook
```tsx
const { theme, setTheme } = useZodiakTheme();
// theme: 'light' | 'dark'
// setTheme('dark') — persiste se storageKey foi configurado
```

### Acessibilidade
- O `ThemeProvider` aplica a classe `.zodiak-theme-light` ou `.zodiak-theme-dark` no wrapper, resolvendo todos os tokens CSS automaticamente.
- Respeite `prefers-color-scheme` omitindo `defaultTheme` — o provider usa a preferência do sistema como padrão.

### Storybook
- `AllOptions`: demonstração de alternância light/dark com todos os tokens
- `Playground`: controles interativos de tema com persistência
