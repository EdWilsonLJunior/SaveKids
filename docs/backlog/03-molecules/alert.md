# Alert

> **Categoria**: Molecule · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Bloco de mensagem inline com ícone + título + descrição + (opcional) ação. Tons: `info`, `success`, `warning`, `error`. Não confundir com `ZodiakNotificationBanner` (organism, com posicionamento de topo) ou `ZodiakToast` (transitório).

## História de usuário
Como **usuário**, quero **mensagens contextuais inline** para **compreender o estado/feedback sem perder o contexto**.

## Critérios de aceite

### Cenário 1 — Tons
**Dado** `tone: .info/.success/.warning/.error`
**Então** cores e ícone correspondentes via tokens `status*`.

### Cenário 2 — Estrutura
**Dado** title + description + action opcional + dismissible opcional
**Então** layout horizontal: ícone | conteúdo | ações/close.

### Cenário 3 — Light/Dark
**Dado** dark mode
**Então** tokens resolvem.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** ícone decorativo; alert lido como bloco coeso (title + description + action); papel `alert` quando crítico.

### Cenário 5 — Dismiss
**Dado** `dismissible: true`
**Então** botão close aparece; ao tocar, anima saída e chama `onDismiss`.

## Spec técnica

### APIs públicas
- `ZodiakAlert(tone: ZodiakStatusTone, title: String, description: String? = none, action: ZodiakAlertAction? = none, dismissible: Bool = false, onDismiss: Action? = none)`.
- `ZodiakAlertAction(label, onTap)` — usa `ZodiakSystemButton` internamente.

### Tokens
- Background: `status<Tone>Container`.
- Texto: `status<Tone>OnContainer`.
- Ícone: `status<Tone>`.
- Raio: `radii.md`. Padding: `spacing.s16`.

## Boas práticas — iOS
- SwiftUI: estrutura `HStack { Icon; VStack { Title; Description; Action }; CloseButton }` dentro de `RoundedRectangle`.
- HIG: [Alerts](https://developer.apple.com/design/human-interface-guidelines/alerts) (atenção: HIG `alert` é o modal — Zodiak alert é inline; nomenclatura diverge).
- `.accessibilityElement(children: .combine)` quando descrição curta.

## Boas práticas — Android
- Material 3: não há "Alert" inline nativo (Material `Snackbar` é transitório). Construir com `Surface(color, shape) { Row { Icon; Column { Text; Text; TextButton }; IconButton(close) } }`.
- `Modifier.semantics { liveRegion = LiveRegionMode.Polite }` quando aparece dinamicamente.

## Acessibilidade
- LiveRegion polite para alerts não-bloqueantes; `assertive` para erros críticos.
- Cor + ícone (não apenas cor).

## Referências
- [iOS `Molecules/Alert/ZodiakAlert.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Molecules/Alert/ZodiakAlert.swift)

## Gaps & dúvidas para o time de Design
- [ ] Especificação visual oficial (tokens, padding, ícone size)?
- [ ] Diferença com `ZodiakNotice` — quando usar cada?

## DoD
- [ ] 4 tons + dismiss.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Importação
```tsx
import { Notification } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `variant` | `'information' \| 'positive' \| 'warning'` | `'information'` | Variante semântica |
| `title` | `string` | — | Título em negrito |
| `text` | `string` | — | Corpo da mensagem |
| `firstCTA` | `boolean` | `false` | Exibe botão CTA primário |
| `secondCTA` | `boolean` | `false` | Exibe botão CTA secundário |
| `firstCtaProps` | `NotificationCtaProps` | — | Props do CTA primário |
| `onFirstCtaClick` | `MouseEventHandler` | — | Handler do CTA primário |

### Acessibilidade
- Use `role="alert"` no contêiner pai para anúncio automático em screen readers quando a notificação aparece dinamicamente.

### Storybook
- `AllOptions`: variantes × combinações de CTA
- `Playground`: controles interativos
