# <Nome do componente>

> **Categoria**: <Foundation | Theme | Atom | Molecule | Organism | Template | Util>
> **Prioridade**: P0 | P1 | P2
> **Plataformas**: iOS (SwiftUI) · Android (Compose)
> **Status**: Backlog
> **Doc Supernova**: <Sim | Não — fonte primária é o Swift>

---

## Contexto

Para que existe e em que jornadas/telas é usado.

---

## História de usuário

Como **<persona>** quero **<ação>** para que **<benefício>**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Variante padrão
**Dado** que estou em uma tela com o componente exibido
**Quando** renderizo a variante padrão sem interagir
**Então** vejo <descrição visual> com os tokens <listar tokens>

### Cenário 2 — Estados
**Dado** o componente renderizado
**Quando** ele assume os estados `default`, `hover`/`focused`, `pressed`, `disabled`, `loading`, `error`
**Então** cada estado consome os tokens correspondentes e mantém contraste AA

### Cenário 3 — Temas e superfícies
**Dado** o componente renderizado em `light` e `dark`
**E** sobre as superfícies `onLite`, `onHeavy`, `onPhoto` (quando aplicável)
**Então** os tokens corretos são selecionados automaticamente

### Cenário 4 — Acessibilidade
**Dado** um usuário com VoiceOver/TalkBack ativo
**Quando** o foco chega ao componente
**Então** o leitor anuncia <label>, <papel> e <hint>; mudança de estado dispara anúncio
**E** o hit-target é ≥ `Zodiak.hitTarget.minimum`
**E** o componente respeita Dynamic Type / FontScale até 2.0
**E** o layout funciona corretamente em RTL

### Cenário 5 — Responsivo
**Dado** o componente em window-size class `Compact` e `Medium/Expanded`
**Então** o layout se adapta conforme spec

---

## Spec técnica

> Esta seção usa a **notação neutra** (ver [ARCHITECTURE §3.1](../ARCHITECTURE.md#31-contrato-neutro--notação-cross-platform)). Sintaxe Swift/Kotlin aparece apenas em `Boas práticas — iOS` / `Boas práticas — Android`.

### APIs públicas
- `ZodiakXxxPrimary(...)` — descrição
- `ZodiakXxxSecondary(...)` — descrição
- _(ou)_ `ZodiakXxx(variant: ZodiakXxxVariant, ...)` quando todas as variantes têm assinatura idêntica

### Primitivo interno
- `ZodiakXxxImpl(...)` — visibilidade `internal`. Centraliza estados, foco, tokens e a11y.

### Parâmetros comuns
| Parâmetro | Tipo (neutro) | Obrigatório | Default | Descrição |
|-----------|---------------|-------------|---------|-----------|
| `text` | `String` | Sim | — | ... |
| `surface` | `ZodiakSurface` | Não | `ZodiakSurface.onLite` | ... |
| `size` | `ZodiakSize` | Não | `ZodiakSize.medium` | ... |
| `isEnabled` | `Bool` | Não | `true` | ... |
| `leadingIcon` | `ZodiakIcon?` | Não | `none` | ... |
| `onPress` | `Action` | Sim | — | callback disparado ao acionar |

### Variantes
- ...

### Estados
- default, pressed, focused, disabled, loading, error (quando aplicável)

### Tokens consumidos
- **Cor**: `Zodiak.colors.actionPrimary`, `Zodiak.colors.onActionPrimary`, ... (ver [colors](../00-foundations/colors.md))
- **Tipografia**: `Zodiak.typography.labelLarge` (ver [typography](../00-foundations/typography.md))
- **Espaço**: `Zodiak.spacing.s8`, `Zodiak.spacing.s12` (ver [spacing](../00-foundations/spacing.md))
- **Raio**: `Zodiak.radii.full` (ver [radii](../00-foundations/radii.md))
- **Sombra**: `Zodiak.shadows.level1` (ver [shadows](../00-foundations/shadows.md))
- **Hit-target**: `Zodiak.hitTarget.minimum` (ver [hit-target](../00-foundations/hit-target.md))
- **Defaults** (quando aplicável): `Zodiak.defaults.<componente>.<campo>` (ver [defaults](../00-foundations/defaults.md))

> **Regra absoluta**: nunca referenciar tokens por valor (`8`, `16dp`, `44pt`). Apenas por nome.

### Composição atômica
- **Atoms consumidos**: [ZodiakText](../02-atoms/text.md), [ZodiakIconView](../02-atoms/icon-view.md), ...
- **Molecules consumidas** (se organism): [ZodiakLabelledField](../03-molecules/labelled-field.md), ...
- **Organisms consumidos** (só em templates ou mesma família): ...
- **Primitivo interno reusado**: `ZodiakXxxImpl` (se aplicável)

### Animações / Foco / Teclado
- Animação de pressed: ...
- Foco: anel de foco em <token>, espessura <token>
- Teclado: Enter/Space disparam ação; Tab navega; Esc cancela (quando aplicável)

### Hit-target
- `Zodiak.hitTarget.minimum` (resolve para 44pt iOS / 48dp Android — nunca cite o valor literal).

---

## Boas práticas — iOS

- **HIG**: <seções relevantes, ex.: Buttons, Lists, Modality>
- **SwiftUI nativo equivalente**: <ex.: `Button` + `ButtonStyle`, `Toggle`, `Picker`>
- **Assinatura concreta** (tradução da DSL neutra para SwiftUI):
  ```swift
  public struct ZodiakXxxPrimary: View {
    public init(
      text: String,
      surface: ZodiakSurface = .onLite,
      size: ZodiakSize = .medium,
      isEnabled: Bool = true,
      leadingIcon: ZodiakIcon? = nil,
      action: @escaping () -> Void
    )
  }
  ```
- **APIs a usar**:
  - `@Environment(\.dynamicTypeSize)`
  - `@Environment(\.colorScheme)`
  - `@Environment(\.layoutDirection)`
  - `Button(role:)` para destrutivos/cancel
  - `.accessibilityLabel`, `.accessibilityHint`, `.accessibilityAddTraits`
  - `Sensory feedback` (iOS 17+) ou `UIImpactFeedbackGenerator`
  - Suporte a **Reduce Motion**, **Increase Contrast**, **Differentiate Without Color**
- **Documentação esperada**: DocC (`///`) com sumário, parâmetros, exemplo, `#Preview` por variante × tema × dynamic type.

---

## Boas práticas — Android

- **Material 3 / M3 Expressive**: <componente equivalente, ex.: `FilledTonalButton`, `OutlinedTextField`, `ModalBottomSheet`>
- **Assinatura concreta** (tradução da DSL neutra para Compose):
  ```kotlin
  @Composable
  fun ZodiakXxxPrimary(
    text: String,
    onPress: () -> Unit,
    modifier: Modifier = Modifier,
    surface: ZodiakSurface = ZodiakSurface.OnLite,
    size: ZodiakSize = ZodiakSize.Medium,
    isEnabled: Boolean = true,
    leadingIcon: ZodiakIcon? = null,
  )
  ```
- **APIs Compose a usar**:
  - `Modifier.semantics { role = Role.Xxx; contentDescription = ... }`
  - `InteractionSource` para hover/focus/press
  - `Modifier.indication` / `LocalIndication` para ripple
  - `LocalContentColor`, `LocalDensity`, `LocalLayoutDirection`
  - `WindowSizeClass` para layouts adaptativos
  - `HapticFeedback`
- **Dynamic Color (Material You)**: <integrar via `ZodiakTheme.dynamicColor` quando habilitado, mas brand colors prevalecem>
- **Documentação esperada**: KDoc com `@param`, `@sample`, `@see`; `@Preview` com `uiMode = UI_MODE_NIGHT_YES`, `fontScale = 1.5f`, `device = Devices.PIXEL_TABLET`.

---

## Acessibilidade

- **Papel semântico**: `<button | link | toggle | header | image | textfield>`
- **Label**: ...
- **Hint**: ...
- **Anúncios de mudança de estado**: ...
- **Ordem de foco**: ...
- **Contraste**: AA (4.5:1 texto / 3:1 UI)
- **Hit-target**: `Zodiak.hitTarget.minimum`
- **Suporte**: Dynamic Type / FontScale 2.0, RTL, Reduce Motion, Increase Contrast

---

## Referências

- **iOS source**: [`ZodiakiOS/.../Zodiak<X>.swift`](../../../ZodiakiOS/...)
- **Docs Supernova**:
  - [`Overview - <X>.md`](../../../ZodiakiOS/docs/zodiak-pdf/Overview%20-%20<X>.md)
  - [`Guidelines - <X>.md`](../../../ZodiakiOS/docs/zodiak-pdf/Guidelines%20-%20<X>.md)
  - [`Specs - <X>.md`](../../../ZodiakiOS/docs/zodiak-pdf/Specs%20-%20<X>.md)
- **HIG**: <link/título>
- **Material 3**: <link/título>

---

## Gaps & dúvidas para o time de Design

- [ ] Item 1 — descrição (referência: ...)
- [ ] Item 2 — ...

_(Adicionar identificador `G-NNN` ao mover para [GAPS.md](../GAPS.md).)_

---

## Definition of Done

Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias) para o checklist completo. Resumo:

- [ ] iOS (SwiftUI) implementado conforme contrato.
- [ ] Android (Compose) implementado conforme contrato.
- [ ] Tokens-only (zero magic numbers — todos os valores referenciados por nome via `Zodiak.<categoria>.<token>`).
- [ ] Composição atômica documentada (atoms/molecules consumidos listados).
- [ ] Story em **notação neutra** (sem sintaxe Swift/Kotlin fora das seções `Boas práticas — iOS` / `Boas práticas — Android` / `Referências`).
- [ ] Light/Dark, Dynamic Type/FontScale 2.0, RTL, contraste AA.
- [ ] Hit-target via `Zodiak.hitTarget.minimum`.
- [ ] KDoc/DocC completo com `@sample`/`#Preview`.
- [ ] Snapshot test por variante × tema.
- [ ] Teste de interação.
- [ ] Lint limpo.
- [ ] Gaps registrados em [GAPS.md](../GAPS.md).
