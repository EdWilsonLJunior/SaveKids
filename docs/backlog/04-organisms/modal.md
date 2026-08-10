# Modal

> **Categoria**: Organism · **Prioridade**: P0 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Diálogo modal que interrompe fluxo para confirmação ou ação focada. Variantes: alert (compacto), full-content (form/conteúdo), bottom sheet (mobile-first).

## História de usuário
Como **usuário**, quero **confirmar ações importantes** em **diálogo focado, com saída clara**.

## Critérios de aceite

### Cenário 1 — Variantes
**Dado** `style: .alert/.sheet/.fullscreen`
**Então** apresentação correta.

### Cenário 2 — Estrutura
**Dado** title + body + primary/secondary action + close
**Então** layout consistente.

### Cenário 3 — Dismiss
**Dado** toque no scrim, swipe (sheet), Esc/back (Android)
**Então** fecha; ações destrutivas requerem botão explícito (não scrim).

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** foco vai para modal; trap focus enquanto aberto; ao fechar, foco retorna ao trigger.

### Cenário 5 — Light/Dark
**Dado** dark
**Então** tokens resolvem; scrim com alpha apropriada.

## Spec técnica

### APIs públicas
- `ZodiakModal(isPresented: Binding<Bool>, style: ZodiakModalStyle = ZodiakModalStyle.alert, title: String, body: Slot, primaryAction: ZodiakModalAction, secondaryAction: ZodiakModalAction? = none, onDismiss: Action? = none)`.

### Tokens
- Background: `surface`. Raio: `radii.xl`. Sombra: `shadows.level5`. Scrim: black α 0.4 (light), α 0.6 (dark).

## Boas práticas — iOS
- SwiftUI: `.sheet(isPresented:) { ZodiakModal... }`, `.fullScreenCover`, `.confirmationDialog`.
- HIG: [Alerts](https://developer.apple.com/design/human-interface-guidelines/alerts), [Sheets](https://developer.apple.com/design/human-interface-guidelines/sheets).
- `presentationDetents([.medium, .large])` para bottom sheet.

## Boas práticas — Android
- Material 3: `AlertDialog`, `ModalBottomSheet`, `BasicAlertDialog`.
- `ModalBottomSheet(onDismissRequest, sheetState) { ... }`.
- BackHandler para back-press.

## Acessibilidade
- Trap focus.
- Anunciar ao abrir.
- Botão close obrigatório (não confiar em scrim).

## Referências
- [iOS `Organisms/Modal/`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/Modal/)

## Gaps & dúvidas para o time de Design
- [ ] Detents (medium/large) — quais oficiais?
- [ ] Modal aninhado — permitido?

## DoD
- [ ] 3 styles.
- [ ] Focus trap.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
