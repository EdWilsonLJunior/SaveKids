# Architecture — Zodiak Design System (iOS + Android)

Documento de referência para as decisões transversais do DS. Toda história do backlog assume estas convenções.

---

## 1. Princípios

1. **Código-fonte é documentação viva** — toda API pública tem KDoc/Javadoc (Kotlin) ou DocC (Swift) com sumário, parâmetros, exemplo de uso e cenários de a11y.
2. **Tokens-only — regra absoluta** — **zero** valores numéricos crus (cores, raios, espaçamentos, sombras, tamanhos, blurs, opacidades, durações, aspect-ratios, contagens) em componentes, histórias, exemplos ou previews. Tudo é referenciado por nome via `Zodiak.<categoria>.<token>` (iOS) e `ZodiakTheme.<categoria>.<token>` (Android). Se um valor não existe como token, **não inventar** — abrir item em [GAPS.md](GAPS.md) e propor o token. Ver §6.
3. **Atomic design — composição obrigatória** — toda molecule é composta exclusivamente por atoms; todo organism por molecules e atoms; todo template por organisms, molecules e atoms. Cada história lista explicitamente em **Composição atômica** os componentes consumidos (com links). Composição direta entre organisms é permitida apenas dentro da mesma família (ex.: `CardVariants/*` reusam `ZodiakCardImpl`). Ver §3.6.
4. **Native-first** — usar componentes/APIs nativas (`Button`/`Toggle`/`Picker` em SwiftUI; `FilledTonalButton`/`OutlinedTextField`/`ModalBottomSheet` em Compose) e estilizá-las com tokens, em vez de redesenhar do zero. Só implementar do zero quando o componente não existir nativamente.
5. **Acessibilidade é DoD**, não roadmap — TalkBack/VoiceOver, dynamic type/font scale, contraste AA, hit-target via `Zodiak.hitTarget.minimum` (44pt iOS / 48dp Android), RTL, ordem de foco, anúncios de mudança de estado.
6. **Light & Dark sempre** — não há "TODO: dark mode". Toda história tem cenário de dark mode.
7. **Stories neutras quanto à plataforma** — contrato, critérios e cenários usam a **notação neutra** definida em §3.1. Sintaxe específica de SwiftUI/Compose só aparece em `Boas práticas — iOS` / `Boas práticas — Android`.

---

## 2. Primitivo interno + APIs públicas dedicadas

**Decisão**: para componentes multi-variante, expor **uma API pública por variante** que delega a um **primitivo interno (`internal`/`private`) compartilhado**. Superfícies (`onLite`/`onHeavy`/`onPhoto`) são **parâmetros**, não APIs separadas.

### Por que não um único componente com `variant: Enum`?

- **Type-safety**: parâmetros válidos só para certas variantes (ex.: `leadingIcon` em botão Icon-only) ficam permissivos demais quando expostos em uma única assinatura.
- **Descoberta**: autocomplete e busca por nome do componente é mais natural com APIs dedicadas (`ZodiakButtonPrimary` vs `ZodiakButton(variant = .primary)`).
- **Previews e snapshots**: cada variante tem seu arquivo de preview/snapshot dedicado.
- **A11y defaults**: papéis semânticos (button vs link vs toggle) dependem da variante.
- **Material 3, Spectrum, Carbon, Polaris, Lightning**: todos adotam API pública dedicada por variante.

### Por que não uma API pública por superfície?

- Superfícies compartilham 100% dos parâmetros — só mudam tokens consumidos.
- Multiplicar APIs (`ZodiakButtonPrimaryOnLite`, `ZodiakButtonPrimaryOnHeavy`, …) gera 3× a superfície de API sem ganho de type-safety.
- Manter `surface: ZodiakSurface` como parâmetro permite reutilizar em hierarquias dinâmicas (ex.: card sobre foto).

### Quando uma única API com `variant:` é aceitável

Quando **todas as variantes** têm a mesma assinatura e diferem apenas em tokens visuais sem implicação semântica:
- `ZodiakChip(state: .selected | .unselected)`
- `ZodiakBadge(tone: .success | .warning | .error | .info | .neutral)`
- `ZodiakDivider(orientation: .horizontal | .vertical)`

### Exemplos canônicos

**Botões**
- APIs públicas: `ZodiakButtonPrimary`, `ZodiakButtonSecondary`, `ZodiakButtonTertiary`, `ZodiakButtonGhost`.
- Primitivo: `ZodiakButtonImpl(style:, surface:, ...)` (`internal`).
- Parâmetros comuns: `text`, `leadingIcon`, `trailingIcon`, `isLoading`, `isEnabled`, `surface`, `size`, `onClick`.
- Roles (Compose): `Modifier.semantics { role = Role.Button }`. SwiftUI: `Button(role: ...)`.

**TextField**
- APIs públicas: `ZodiakTextField` (regular), `ZodiakPasswordField`, `ZodiakSearchField`.
- Primitivo: `ZodiakTextFieldImpl(kind:, ...)`.
- Os 3 são funções separadas porque cada uma tem affordances específicas (toggle de visibilidade na senha; ícone de busca + clear; etc.).

**Cards**
- APIs públicas: `ZodiakCardHorizontal`, `ZodiakCardTypographic`, `ZodiakCardAuthor`, `ZodiakCardReveal`, `ZodiakCardTall`, `ZodiakCardShortFacts`.
- Primitivo: `ZodiakCardImpl(layout:, surface:, header:, body:, footer:)`.

**Blocos tipográficos**
- APIs públicas: `ZodiakQuote`, `ZodiakTextBlock`, `ZodiakPreamble`, `ZodiakKeyFigures`, `ZodiakHeadlineSection`.
- Primitivo: `ZodiakTypographicBlockImpl(layout:, ...)`.

---

## 3. Naming

| Conceito                  | Kotlin (Compose)                       | Swift (SwiftUI)                  |
|---------------------------|----------------------------------------|----------------------------------|
| API pública               | `ZodiakButtonPrimary` (composable)     | `ZodiakButtonPrimary` (View)     |
| Primitivo interno         | `ZodiakButtonImpl` (`internal`)        | `ZodiakButtonImpl` (`fileprivate`/`internal`)|
| Enum de superfície        | `ZodiakSurface`                        | `ZodiakSurface`                  |
| Enum de tamanho           | `ZodiakSize` (`small/medium/large`)    | `ZodiakSize`                     |
| Enum de estado            | derivado de `InteractionSource`        | derivado de `@State` / `@FocusState` |
| Tokens (cor)              | `ZodiakTheme.colors.actionPrimary`     | `Zodiak.colors.actionPrimary`    |
| Tokens (tipografia)       | `ZodiakTheme.typography.titleLarge`    | `Zodiak.typography.titleLarge`   |

### 3.1 Contrato neutro — notação cross-platform

Para não enviesar a leitura do backlog para uma plataforma, as histórias descrevem **contratos** (assinaturas em `Spec técnica > APIs públicas`, parâmetros em `Critérios de aceite`, exemplos em `Cenários`) em **notação neutra**. Sintaxe específica de SwiftUI/Compose aparece **apenas** nas seções `Boas práticas — iOS` e `Boas práticas — Android`.

#### Tabela canônica de tradução

| Conceito                       | Notação neutra (backlog)            | iOS (SwiftUI)                        | Android (Compose)                              |
|--------------------------------|-------------------------------------|--------------------------------------|------------------------------------------------|
| Função de componente           | `ZodiakComponent(...)`              | `struct ZodiakComponent: View`       | `@Composable fun ZodiakComponent(...)`         |
| Callback sem retorno           | `Action`                            | `() -> Void`                         | `() -> Unit`                                   |
| Callback com valor             | `Callback<T>`                       | `(T) -> Void`                        | `(T) -> Unit`                                  |
| Estado bidirecional            | `Binding<T>`                        | `Binding<T>`                         | `value: T, onValueChange: (T) -> Unit`         |
| Slot de conteúdo               | `Slot`                              | `@ViewBuilder () -> some View`       | `@Composable () -> Unit`                       |
| Slot opcional                  | `Slot?`                             | `(() -> some View)?`                 | `(@Composable () -> Unit)?`                    |
| Booleano                       | `Bool`                              | `Bool`                               | `Boolean`                                      |
| Inteiro                        | `Int`                               | `Int`                                | `Int`                                          |
| Texto                          | `String`                            | `String`                             | `String`                                       |
| Texto rich                     | `RichText`                          | `AttributedString`                   | `AnnotatedString`                              |
| Opcional                       | `T?`                                | `T?`                                 | `T?`                                           |
| Default ausente                | `= none`                            | `= nil`                              | `= null`                                       |
| Comprimento / Dp / pt          | `Length` (sempre via token)         | `CGFloat` (token resolvido)          | `Dp` (token resolvido)                         |
| Cor                            | `Color` (token)                     | `Color` (token)                      | `Color` (token)                                |
| Imagem / asset                 | `ImageSource`                       | `Image` / `UIImage`                  | `Painter` / `ImageVector`                      |
| Ícone do DS                    | `ZodiakIcon` (enum-token)           | `ZodiakIcon`                         | `ZodiakIcon`                                   |
| Modificador / decorator        | (omitir do contrato)                | `some View` builder chains           | `Modifier`                                     |
| Enum DS                        | `ZodiakSurface.onLite` (qualificado)| `.onLite` (dot-shorthand)            | `ZodiakSurface.OnLite`                         |

#### Regras de redação das stories

1. **Em `APIs públicas`**: assinatura usa **somente** os tipos da coluna "Notação neutra". Defaults qualificam o enum por completo (`ZodiakSurface.onLite`, nunca `.onLite`).
2. **Em `Critérios de aceite` / `Cenários (Gherkin)`**: linguagem comportamental ("ao pressionar", "quando o usuário…"). Proibido referenciar APIs de plataforma por nome (`Binding`, `MutableState`, `@ViewBuilder`, `Modifier`).
3. **Em `Tokens consumidos`**: usar nomes de tokens. Quando precisar mencionar a categoria do tipo, usar `Length`/`Color`/`Duration` (neutros), não `CGFloat`/`Dp`.
4. **Em `Boas práticas — iOS`**: única seção onde sintaxe Swift/SwiftUI é nativa. Pode incluir a assinatura concreta `struct …: View` / `func …(...) -> some View`.
5. **Em `Boas práticas — Android`**: única seção onde sintaxe Kotlin/Compose é nativa. Pode incluir a assinatura concreta `@Composable fun …(...)`.
6. **Em `Referências`**: links externos podem apontar para qualquer guideline (HIG, M3) — neutralidade não se aplica.

#### Exemplo canônico — assinatura em DSL neutra

```
ZodiakButtonPrimary(
  text: String,
  surface: ZodiakSurface = ZodiakSurface.onLite,
  size: ZodiakButtonSize = ZodiakButtonSize.medium,
  isLoading: Bool = false,
  isEnabled: Bool = true,
  leadingIcon: ZodiakIcon? = none,
  trailingIcon: ZodiakIcon? = none,
  onPress: Action
)
```

A tradução para SwiftUI/Compose é mecânica via tabela acima e fica documentada em `Boas práticas — iOS` / `Boas práticas — Android` de cada história.

---

## 4. Documentação no código

### Kotlin / Compose

````kotlin
/**
 * Botão primário do Zodiak DS — usado para a ação principal de uma jornada.
 *
 * Variante "Regular Primary" do Supernova. Reusa internamente [ZodiakButtonImpl].
 *
 * Suporta light/dark, dynamic font scale, RTL e três superfícies de fundo
 * ([ZodiakSurface.OnLite], [ZodiakSurface.OnHeavy], [ZodiakSurface.OnPhoto]).
 *
 * @param text rótulo visível, lido pelo TalkBack.
 * @param onClick callback de clique. Disparado apenas quando [enabled] e [isLoading] são `false`.
 * @param modifier modifier aplicado à raiz do componente.
 * @param leadingIcon ícone opcional à esquerda do texto.
 * @param surface superfície de fundo onde o botão aparece. Default = [ZodiakSurface.OnLite].
 * @param size tamanho do botão. Default = [ZodiakSize.Medium].
 * @param isLoading exibe `ProgressIndicator` e desabilita interação.
 * @param enabled `false` aplica estado disabled (cor reduzida, sem ripple).
 *
 * @sample com.zodiak.designsystem.samples.ButtonPrimarySample
 *
 * @see ZodiakButtonSecondary
 * @see ZodiakButtonImpl
 */
@Composable
fun ZodiakButtonPrimary( ... )
````

Requisitos:
- KDoc em **toda** função pública e enum/data class pública.
- `@sample` para pelo menos 1 cenário.
- `@Preview` por variante × tema × superfície (`uiMode = UI_MODE_NIGHT_YES`, `fontScale = 1.5f`, `device = Devices.PIXEL_TABLET`).
- Comentários **dentro** do código apenas quando explicam **por quê** (regra de a11y, workaround, decisão de spec).

### Swift / SwiftUI

````swift
/// Botão primário do Zodiak DS — usado para a ação principal de uma jornada.
///
/// Variante "Regular Primary" do Supernova. Reusa internamente ``ZodiakButtonImpl``.
///
/// Suporta light/dark, dynamic type, RTL e três superfícies de fundo
/// (``ZodiakSurface/onLite``, ``ZodiakSurface/onHeavy``, ``ZodiakSurface/onPhoto``).
///
/// ## Exemplo
/// ```swift
/// ZodiakButtonPrimary("Continuar") { viewModel.next() }
/// ```
///
/// - Parameters:
///   - text: rótulo visível, lido pelo VoiceOver.
///   - leadingIcon: ícone opcional à esquerda.
///   - surface: superfície de fundo. Default: `.onLite`.
///   - size: tamanho. Default: `.medium`.
///   - isLoading: exibe `ProgressView` e desabilita interação.
///   - action: callback de toque.
///
/// - SeeAlso: ``ZodiakButtonSecondary``
public struct ZodiakButtonPrimary: View { ... }
````

Requisitos:
- DocC em toda API pública.
- Pelo menos um `#Preview` por variante × tema (`.preferredColorScheme(.dark)`, `.dynamicTypeSize(.accessibility3)`).
- Symbols cross-referenciados (` ``OtherType`` `).

---

## 5. Previews & Snapshot tests

### Compose
- `@Preview` por variante. Cada `@Preview` cobre: light, dark, font scale 1.5, RTL, device tablet.
- Snapshot test com **Paparazzi** ou **Roborazzi** por variante × tema.
- Teste de interação com **`createComposeRule()`** validando: clique habilitado/desabilitado, `Role.Button`, ordem de foco.

### SwiftUI
- `#Preview` por variante × tema × dynamic type.
- Snapshot test com **`swift-snapshot-testing`** (Point-Free).
- Teste de UI com **`ViewInspector`** ou XCUITest validando hit-target, label de a11y, focus order.

---

## 6. Tokens — contratos

### 6.1 Convenção de referência

**Forma canônica**: `Zodiak.<categoria>.<token>` (iOS) e `ZodiakTheme.<categoria>.<token>` (Android). **Sempre por nome, nunca por valor.**

Histórias, exemplos, previews e KDoc/DocC referenciam tokens **pelo nome**. Os valores numéricos resolvidos vivem apenas em `Tokens/*.swift` (iOS) e `theme/tokens/*.kt` (Android) — nunca nas histórias.

| Categoria       | iOS (`Zodiak.*`)            | Android (`ZodiakTheme.*`)          |
|-----------------|-----------------------------|------------------------------------|
| Color           | `Zodiak.colors`             | `ZodiakTheme.colors`               |
| Typography      | `Zodiak.typography`         | `ZodiakTheme.typography`           |
| Spacing         | `Zodiak.spacing`            | `ZodiakTheme.spacing`              |
| Sizing          | `Zodiak.sizing`             | `ZodiakTheme.sizing`               |
| Radius          | `Zodiak.radii`              | `ZodiakTheme.radii`                |
| Borders         | `Zodiak.borders`            | `ZodiakTheme.borders`              |
| Shadows         | `Zodiak.shadows`            | `ZodiakTheme.shadows`              |
| Blurs           | `Zodiak.blurs`              | `ZodiakTheme.blurs`                |
| Grid            | `Zodiak.grid`               | `ZodiakTheme.grid`                 |
| Icons           | `Zodiak.icons`              | `ZodiakTheme.icons`                |
| Flags           | `Zodiak.flags`              | `ZodiakTheme.flags`                |
| Logo            | `Zodiak.logo`               | `ZodiakTheme.logo`                 |
| Gradients       | `Zodiak.gradients`          | `ZodiakTheme.gradients`            |
| Aspect Ratios   | `Zodiak.aspectRatios`       | `ZodiakTheme.aspectRatios`         |
| Opacity         | `Zodiak.opacity`            | `ZodiakTheme.opacity`              |
| Motion          | `Zodiak.motion`             | `ZodiakTheme.motion`               |
| Hit-target      | `Zodiak.hitTarget`          | `ZodiakTheme.hitTarget`            |
| Defaults*       | `Zodiak.defaults.<comp>`    | `ZodiakTheme.defaults.<comp>`      |

*`defaults` agrupa valores de comportamento padrão por componente (ex.: `Zodiak.defaults.rating.maxValue`, `Zodiak.defaults.showMore.collapsedLines`, `Zodiak.defaults.pagination.visibleRange`). Esses não são tokens visuais, mas seguem a mesma regra de referência por nome.

### 6.2 Regra anti-magic-number

- **Proibido** em histórias, código e exemplos: literais como `8.dp`, `16.pt`, `0.5f` (opacidade), `200ms`, `16/9`, `Int = 5`.
- **Permitido apenas em** `Tokens/*` (definição) e em testes (assertions sobre valor esperado).
- Componente que precisar de um valor não disponível como token **NÃO** define o valor inline — abre um item em [GAPS.md](GAPS.md), propõe o token e usa o token mais próximo enquanto isso.
- Hit-target: sempre `Zodiak.hitTarget.minimum` (resolve para 44pt iOS / 48dp Android), nunca `44`/`48` literal.

### 6.3 Composição atômica (referência cruzada com §3.6)

Toda história lista, na seção **Composição atômica**:

```
## Composição atômica

- **Atoms consumidos**: [ZodiakText](../02-atoms/text.md), [ZodiakIconView](../02-atoms/icon-view.md)
- **Molecules consumidas**: [ZodiakLabelledField](../03-molecules/labelled-field.md)
- **Organisms consumidos**: —
- **Foundations / tokens-chave**: `Zodiak.colors.surfacePrimary`, `Zodiak.spacing.s16`, `Zodiak.radii.md`
```

Um organism que reimplementaria a aparência de um atom existente é **rejeitado** — deve consumir o atom. Esse acoplamento é o que garante consistência visual sem disciplina manual.

---

## 7. Plataforma — guidelines a priorizar

### iOS — Apple HIG
- Roles semânticos de botão (`role: .destructive`, `.cancel`).
- `ButtonStyle` / `LabelStyle` / `ToggleStyle` customizados em vez de redesenhar componente.
- `@Environment(\.dynamicTypeSize)`, `@Environment(\.colorScheme)`, `@Environment(\.layoutDirection)`.
- `AccessibilityRotor`, `accessibilityLabel`, `accessibilityHint`, `accessibilityAddTraits`.
- `Sensory feedback` (iOS 17+) ou `UIImpactFeedbackGenerator`.
- Suporte a **Reduce Motion**, **Increase Contrast**, **Differentiate Without Color**.
- iPad: window scenes, multitasking, pointer interactions, hover (`onHover`).
- Mac Catalyst quando aplicável.

### Android — Material 3 / M3 Expressive
- Componentes Material 3 como base (`Button`, `OutlinedTextField`, `Switch`, `Checkbox`, `RadioButton`, `Slider`, `ModalBottomSheet`, `NavigationBar`, `NavigationRail`, `TopAppBar`, `Tabs`, `Snackbar`).
- `Modifier.semantics { ... }`, `Modifier.clearAndSetSemantics`.
- `InteractionSource` + `Modifier.indication` para ripple e estados.
- `WindowSizeClass` (compact/medium/expanded) para layouts adaptativos.
- **Dynamic Color (Material You)** — o `ZodiakTheme` pode opcionalmente integrar com `dynamicLightColorScheme` em Android 12+, mas **brand colors prevalecem** quando o produto exige identidade fixa.
- `HapticFeedback`, `LocalDensity`, `LocalLayoutDirection`, `LocalContentColor`.
- Suporte a **TalkBack**, **FontScale** (até 2.0), **RTL**, **temas Light/Dark**.

---

## 8. Definition of Done — comum a todas as histórias

- [ ] Implementação iOS (SwiftUI) seguindo o contrato.
- [ ] Implementação Android (Compose) seguindo o contrato.
- [ ] Tokens consumidos via `Zodiak`/`ZodiakTheme` — **zero magic numbers** (nenhum literal numérico de cor, raio, espaçamento, tamanho, blur, opacidade, duração, aspect-ratio ou contagem default — tudo por token).
- [ ] Composição atômica documentada e respeitada (molecule só compõe atoms; organism só compõe molecules + atoms; etc.).- [ ] Story em **notação neutra** (§3.1) — sem sintaxe Swift/Kotlin fora das seções `Boas práticas — iOS` / `Boas práticas — Android` / `Referências`.- [ ] Suporte light/dark.
- [ ] Suporte dynamic type / font scale ≥ 2.0.
- [ ] Suporte RTL.
- [ ] Contraste AA verificado.
- [ ] Hit-target via `Zodiak.hitTarget.minimum` (44pt iOS / 48dp Android).
- [ ] Estados de foco e teclado funcionais.
- [ ] VoiceOver/TalkBack: label, hint, role e anúncios de mudança corretos.
- [ ] KDoc / DocC completos com `@sample` / `#Preview` por variante.
- [ ] Snapshot test por variante × tema.
- [ ] Teste de interação cobrindo clique habilitado/desabilitado e estados.
- [ ] Lint sem warnings novos (detekt / SwiftLint).
- [ ] Gaps registrados em [GAPS.md](GAPS.md).
