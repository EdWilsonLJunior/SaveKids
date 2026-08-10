# RadioButton

> **Categoria**: Atom · **Prioridade**: P0 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Sim

## Contexto
Radio button para seleção mutuamente exclusiva dentro de um grupo. Estados: unselected, selected, disabled, error.

## História de usuário
Como **usuário**, quero **escolher uma única opção em um grupo de radios** para que **a seleção seja clara e exclusiva**.

## Critérios de aceite

### Cenário 1 — Grupo exclusivo
**Dado** grupo de N radios
**Quando** seleciono um
**Então** os demais desselecionam automaticamente (single source of truth via binding).

### Cenário 2 — Estados
**Dado** `unselected/selected/disabled/error`
**Então** estados visuais corretos.

### Cenário 3 — Light/Dark
**Dado** dark
**Então** tokens resolvem.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** anuncia "botão de rádio, selecionado/não selecionado, <label>, 1 de N".

### Cenário 5 — Teclado
**Dado** foco no primeiro radio
**Quando** pressiono Arrow Down/Up
**Então** foco e seleção movem dentro do grupo (semântica de role group).

## Spec técnica

### APIs públicas
- `ZodiakRadioButton(isSelected: Bool, label: String, action: Action, state: ZodiakRadioState = ZodiakRadioState.normal)`.

### Tokens
- Tamanho: `sizing.iconMd`.
- Cor: dot selected = `actionPrimary`; ring = `borderDefault`/`actionPrimary`/`statusError`.

## Boas práticas — iOS
- **Assinatura concreta**: `ZodiakRadioButton(isSelected: Bool, label: String, action: Action, state: ZodiakRadioState = .normal)`.

- SwiftUI nativo: não há Radio padrão — usar `Picker(.segmented)` ou implementar custom com `Toggle` no estilo radio.
- HIG: [Pickers](https://developer.apple.com/design/human-interface-guidelines/pickers) (radio recomendado para 2-5 opções).
- `.accessibilityRepresentation` para semântica de radio group.

## Boas práticas — Android
- **Assinatura concreta**: `@Composable fun ZodiakRadioButton(selected: Boolean, onClick: (() -> Unit)?, label: String, state: ZodiakRadioState = Normal, enabled: Boolean = true)`.

- Material 3: `RadioButton` e `RadioGroup` (via `Modifier.selectableGroup()`).
- `Row(modifier = Modifier.selectableGroup()) { Row(modifier = Modifier.selectable(selected, onClick, role = Role.RadioButton)) { RadioButton(...) Text(...) } }`.

## Acessibilidade
- Wrapper `selectableGroup` (Android) / `accessibilityElement(children: .contain)` + group label (iOS).
- Papel `radio`.
- Estado e posição (1 de N) anunciados.

## Referências
- [iOS `Atoms/RadioButton/ZodiakRadioButton.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Atoms/RadioButton/ZodiakRadioButton.swift)
- [Supernova: Overview](../../ZodiakiOS/docs/zodiak-pdf/Overview%20-%20Radio.md)
- [Supernova: Specs](../../ZodiakiOS/docs/zodiak-pdf/Specs%20-%20Radio.md)

## Gaps & dúvidas para o time de Design
- [ ] Estado **error** documentado?
- [ ] Comportamento em listas longas (>10 opções) — talvez usar dropdown?

## DoD
- [ ] API individual + helper `ZodiakRadioGroup`.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Importação
```tsx
import { Radio } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `label` | `string` | — | Texto visível do radio |
| `value` | `string` | — | Valor enviado no formulário |
| `checked` | `boolean` | `false` | Estado selecionado (controlado) |
| `disabled` | `boolean` | `false` | Estado desabilitado |
| `state` | `'default' \| 'error'` | `'default'` | Estado de validação |
| `helperText` | `string` | — | Mensagem de erro (state="error") |
| `onChange` | `ChangeEventHandler` | — | Handler de mudança (obrigatório) |

### Acessibilidade
- Agrupe rádios com o mesmo `name` em um `<fieldset>` + `<legend>`.
- `required` deve ser aplicado a **um** radio por grupo — o browser trata o grupo inteiro como required.

### Storybook
- `AllOptions`: estados default/error × selecionado/não-selecionado × disabled
- `Playground`: controles interativos
