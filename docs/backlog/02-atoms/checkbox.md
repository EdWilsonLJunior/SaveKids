# Checkbox

> **Categoria**: Atom · **Prioridade**: P0 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Sim

## Contexto
Checkbox para seleção múltipla. Estados: unchecked, checked, indeterminate (parent de árvore), disabled, error.

## História de usuário
Como **usuário**, quero **marcar opções múltiplas com checkbox visualmente claro** para que **eu confirme escolhas com confiança**.

## Critérios de aceite

### Cenário 1 — Estados
**Dado** `unchecked/checked/indeterminate/disabled/error`
**Então** cada estado renderiza com tokens corretos (cor de preenchimento, borda, ícone check/dash).

### Cenário 2 — Toque
**Dado** checkbox + label
**Quando** toco no label OU no quadrado
**Então** ambos disparam toggle (mesma área de hit ≥ `Zodiak.hitTarget.minimum`).

### Cenário 3 — Light/Dark
**Dado** dark
**Então** tokens resolvem.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** anuncia "checkbox, marcado/desmarcado, <label>"; double-tap alterna; estado é anunciado em mudanças.

### Cenário 5 — Acessibilidade — Reduce Motion
**Dado** Reduce Motion ativo
**Então** animação de check é instantânea (sem bounce).

## Spec técnica

### APIs públicas
- `ZodiakCheckbox(isChecked: Binding<Bool>, label: String? = none, state: ZodiakCheckboxState = ZodiakCheckboxState.normal)` (state = normal/error).

### Tokens
- Tamanho: `Zodiak.sizing.iconMd` com hit-target via padding.
- Cor: fundo checked = `colors.actionPrimary`; ícone = `colors.actionOnPrimary`; borda unchecked = `colors.borderDefault`; erro = `colors.statusError`.

## Boas práticas — iOS
- **Assinatura concreta**: `ZodiakCheckbox(isChecked: Binding<Bool>, label: String? = none, state: ZodiakCheckboxState = .normal)` (state = normal/error).

- SwiftUI: `Toggle("...", isOn:)` com `.toggleStyle(...)` custom para o visual Zodiak.
- HIG: [Toggles](https://developer.apple.com/design/human-interface-guidelines/toggles).
- `.accessibilityRepresentation { Toggle(...) }` para preservar trait `isToggle`.

## Boas práticas — Android
- **Assinatura concreta**: `@Composable fun ZodiakCheckbox(checked: Boolean, onCheckedChange: ((Boolean) -> Unit)?, label: String? = null, state: ZodiakCheckboxState = ZodiakCheckboxState.Normal, enabled: Boolean = true)`.

- Material 3: `Checkbox` e `TriStateCheckbox` (`androidx.compose.material3`).
- `Modifier.toggleable(value, onValueChange, role = Role.Checkbox)` no row inteiro.
- Para indeterminate: `TriStateCheckbox(state = ToggleableState.Indeterminate)`.

## Acessibilidade
- Papel `checkbox`.
- Label clicável estende hit-target.
- Estado anunciado.
- Suporte FontScale.

## Referências
- [iOS `Atoms/Checkbox/ZodiakCheckbox.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Atoms/Checkbox/ZodiakCheckbox.swift)
- [Supernova: Overview](../../ZodiakiOS/docs/zodiak-pdf/Overview%20-%20Checkbox.md)
- [Supernova: Specs](../../ZodiakiOS/docs/zodiak-pdf/Specs%20-%20Checkbox.md)
- Material 3 Checkbox: https://m3.material.io/components/checkbox/overview

## Gaps & dúvidas para o time de Design
- [ ] Estado **error** documentado oficialmente?
- [ ] Variante **indeterminate** — design final?

## DoD
- [ ] Suporte tri-state.
- [ ] Snapshot 5 estados × 2 temas.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Importação
```tsx
import { Checkbox } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `label` | `string` | — | Texto visível do checkbox |
| `checked` | `boolean` | `false` | Estado marcado (controlado) |
| `indeterminate` | `boolean` | `false` | Estado tri-state intermediário |
| `disabled` | `boolean` | `false` | Estado desabilitado |
| `state` | `'default' \| 'error'` | `'default'` | Estado de validação |
| `helperText` | `string` | — | Texto auxiliar (visível em `state="error"`) |
| `onChange` | `ChangeEventHandler` | — | Handler de mudança (obrigatório) |

### Acessibilidade
- Forneça `aria-label` quando não houver `label` visível.
- `indeterminate` define `aria-checked="mixed"` automaticamente.

### Storybook
- `AllOptions`: estados default/error × checked/indeterminate × disabled
- `Playground`: controles interativos
