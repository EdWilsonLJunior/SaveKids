# Switch

> **Categoria**: Molecule · **Prioridade**: P0 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Toggle binário on/off, geralmente acompanhado de label e (opcional) supporting text.

## História de usuário
Como **usuário**, quero **ativar/desativar uma configuração** com **feedback visual imediato**.

## Critérios de aceite

### Cenário 1 — Estados
**Dado** `on/off/disabled`
**Então** estados via tokens; thumb desliza com animação 200ms.

### Cenário 2 — Label clicável
**Dado** label + switch
**Então** toque em qualquer área toggle.

### Cenário 3 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** anuncia "<label>, switch, ligado/desligado, toque duplo para alternar".

### Cenário 4 — Light/Dark
**Dado** dark
**Então** tokens resolvem.

### Cenário 5 — Reduce Motion
**Dado** Reduce Motion ativo
**Então** sem easing prolongado; toggle instantâneo ou linear curto.

## Spec técnica

### APIs públicas
- `ZodiakSwitch(isOn: Binding<Bool>, label: String? = none, supporting: String? = none, enabled: Bool = true)`.

### Tokens
- Track on: `colors.actionPrimary`; off: `colors.surfaceVariant`.
- Thumb: `colors.surface` (off), `colors.actionOnPrimary` (on).
- Tamanho: `sizing.switchTrackHeight/Width`.

## Boas práticas — iOS
- SwiftUI: `Toggle("label", isOn:)` + `.toggleStyle(.switch)` (estilo nativo) ou custom Zodiak.
- HIG: [Toggles](https://developer.apple.com/design/human-interface-guidelines/toggles).
- `.tint(.zodiakActionPrimary)` para colorir track on.

## Boas práticas — Android
- Material 3: `Switch(checked, onCheckedChange, thumbContent = ...)`.
- M3 Expressive: thumb cresce em pressed.
- Usar `Row { Text; Spacer; Switch }` com `Modifier.toggleable` no Row para hit-target completo.

## Acessibilidade
- Papel `switch`.
- Estado anunciado.
- Hit-target ≥ `Zodiak.hitTarget.minimum` via padding/Row.

## Referências
- [iOS `Molecules/Switch/ZodiakSwitch.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Molecules/Switch/ZodiakSwitch.swift)

## Gaps & dúvidas para o time de Design
- [ ] Versão "small" — existe?
- [ ] Switch com ícone no thumb (Material 3) — incluir?

## DoD
- [ ] Snapshot.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Importação
```tsx
import { Switch } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `label` | `string` | — | Texto visível do switch |
| `checked` | `boolean` | `false` | Estado ligado/desligado (controlado) |
| `disabled` | `boolean` | `false` | Estado desabilitado |
| `side` | `'left' \| 'right'` | `'right'` | Posição do label em relação ao toggle |
| `onChange` | `ChangeEventHandler` | — | Handler de mudança (obrigatório) |

### Acessibilidade
- Renderiza `<input type="checkbox" role="switch">` com `aria-checked` correto.
- Forneça `aria-label` quando o `label` visível não for suficiente.

### Storybook
- `AllOptions`: estados checked/unchecked × disabled × lados
- `Playground`: controles interativos
