# Toast

> **Categoria**: Organism · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Mensagem transitória sobre conteúdo, descartável automaticamente (3-5s) ou manualmente. Posicionada no topo ou base. Não interrompe interação.

## História de usuário
Como **usuário**, quero **feedback rápido sobre ações** (ex.: "Item salvo") sem **bloquear a tela**.

## Critérios de aceite

### Cenário 1 — Tons
**Dado** `tone: .info/.success/.warning/.error`
**Então** ícone e cor corretos.

### Cenário 2 — Auto-dismiss
**Dado** `duration: 3s`
**Então** anima saída após 3s; pode ser dispensado com swipe.

### Cenário 3 — Ação opcional
**Dado** action "Desfazer"
**Então** botão inline no toast.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** anunciado via LiveRegion polite; tempo de dismiss aumenta com VoiceOver ativo (mín 5s).

### Cenário 5 — Reduce Motion
**Dado** Reduce Motion ativo
**Então** entrada/saída por fade simples.

## Spec técnica

### APIs públicas
- `ZodiakToast(message: String, tone: ZodiakStatusTone = ZodiakStatusTone.info, duration: Duration = .seconds(3), action: ZodiakAlertAction? = none, position: ZodiakToastPosition = ZodiakToastPosition.bottom)`.
- Apresentação via Environment/Snackbar host.

### Tokens
- Background: `surfaceInverse`. Texto: `textOnInverse`. Sombra: `shadows.level3`. Raio: `radii.md`.

## Boas práticas — iOS
- Custom overlay; iOS 16+ pode usar `.alert(...)` para casos críticos.

## Boas práticas — Android
- Material 3: `SnackbarHostState.showSnackbar(...)` + `Snackbar` customizado com tokens Zodiak.

## Acessibilidade
- LiveRegion polite; assertive apenas para erros bloqueantes.
- Duration estendida com VoiceOver/TalkBack ativos.

## Referências
- [iOS `Organisms/Toast/`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/Toast/)

## Gaps & dúvidas para o time de Design
- [ ] Posição padrão (top/bottom)?
- [ ] Stack de múltiplos toasts?

## DoD
- [ ] Auto-dismiss + manual.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
