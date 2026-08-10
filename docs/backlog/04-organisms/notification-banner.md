# NotificationBanner

> **Categoria**: Organism · **Prioridade**: P0 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Banner persistente no topo da tela para mensagens importantes (manutenção, atualização, recados de sistema). Não-transitório. **Três APIs públicas** — `Info`, `Positive`, `Negative` — sobre primitivo `ZodiakNotificationBannerImpl`.

## História de usuário
Como **usuário**, quero **ver avisos persistentes do sistema** sem **bloquear interação**.

## Critérios de aceite

### Cenário 1 — Variantes via APIs dedicadas
**Dado** `ZodiakNotificationBannerInfo / Positive / Negative`
**Então** cada uma renderiza com tom correto.

### Cenário 2 — Persistência
**Dado** apresentado
**Então** permanece até dismiss manual ou navegação.

### Cenário 3 — Estrutura
**Dado** ícone + título + body + close + action opcional
**Então** layout consistente.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** anunciado ao aparecer (LiveRegion polite); foco programático opcional.

### Cenário 5 — Light/Dark + safe area
**Dado** dark + iPhone com notch
**Então** respeita safe area; tokens resolvem.

## Spec técnica

### APIs públicas
- `ZodiakNotificationBannerInfo(title, body?, action?, onDismiss?)`.
- Mesmo padrão para `Positive` e `Negative`.

### Primitivo interno
- `ZodiakNotificationBannerImpl(tone, title, body, action, onDismiss)`.

### Tokens
- Background: `status<Tone>Container`. Texto: `status<Tone>OnContainer`. Padding: `spacing.s16`.

## Boas práticas — iOS
- Apresentar via overlay próprio (não confundir com Notifications nativos do SO).
- Safe area inset top.

## Boas práticas — Android
- `Box` no topo da hierarquia + `WindowInsets.systemBars`.
- Não usar `Snackbar` (transitório).

## Acessibilidade
- LiveRegion polite.
- Foco se action requer atenção urgente.

## Referências
- [iOS `Organisms/Notification/`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/Notification/)

## Gaps & dúvidas para o time de Design
- [ ] Stack de múltiplos banners?
- [ ] Variante warning além de positive/negative?

## DoD
- [ ] 3 APIs + Impl.
- [ ] Safe area.
- [ ] Ver [ARCHITECTURE.md § 2](../ARCHITECTURE.md#2-padrão-arquitetural-primitivo-interno--apis-dedicadas-públicas) e [§ 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
