# Alertas de Preço

> **Épico**: Crypto Wallet Fake
> **US-ID**: US-35.07
> **Tela nº**: 7 de 8
> **Prioridade**: P1
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Sistema de alertas de preço. O usuário define uma meta ("avisar quando BTC ultrapassar $70.000"). A verificação é feita a cada refresh do Timer. Ao disparar, envia notificação local via `UserNotifications`.

---

## História de usuário

Como **usuário**, quero **criar alertas de preço para criptomoedas**, para que **seja notificado quando atingirem minha meta sem precisar ficar monitorando**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Criar alerta (happy path)
**Dado** que acesso a tela Alertas e toco em "+ Novo alerta"
**Então** exibo `ZodiakModal` com:
  - `ZodiakDropdown` para selecionar moeda
  - `ZodiakTabs` "Acima de" / "Abaixo de"
  - `ZodiakLabelledNumericField` para valor alvo em USD
**Quando** confirmo
**Então** `CWPriceAlert` é inserido no SwiftData

### Cenário 2 — Alerta disparado
**Dado** que o Timer atualiza as cotações
**Quando** verifico alertas ativos
**Se** `preçoAtual > alerta.targetPrice && alerta.direction == .above`
**Então** `alerta.isTriggered = true`
**E** envio `UNMutableNotificationContent` com "Bitcoin atingiu $70.000!"

### Cenário 3 — Lista de alertas
**Dado** que tenho alertas criados
**Então** exibo lista com: moeda, condição ("Acima de $70.000"), status (`ZodiakStatusChip` Ativo/Disparado)
**E** alertas disparados ficam em estado `.opacity(0.5)` com opção de excluir

### Cenário 4 — Deletar alerta
**Dado** que faço swipe em um alerta
**Então** exibo ação "Excluir" em vermelho
**Quando** confirmo
**Então** `CWPriceAlert` é deletado do SwiftData

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** cada alerta anuncia: moeda, condição e status
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: barra de abas ou push do Dashboard
- **Saída**: ← back

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Alertas | `@Query var alerts: [CWPriceAlert]` | SwiftData |
| Permissão notificação | `UNUserNotificationCenter.requestAuthorization` | Sistema |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakModal` | Criar novo alerta |
| `ZodiakDropdown` | Selecionar moeda |
| `ZodiakTabs` | "Acima de" / "Abaixo de" |
| `ZodiakLabelledNumericField` | Valor alvo |
| `ZodiakStatusChip` | Ativo / Disparado |
| `ZodiakEmptyState` | Nenhum alerta |
| `ZodiakButton` | "+ Novo alerta" |

---

## Definition of Done

- [ ] Strings: `cw.alerts.title`, `cw.alerts.action_new`, `cw.alerts.modal_title`, `cw.alerts.field_target`, `cw.alerts.tab_above`, `cw.alerts.tab_below`, `cw.alerts.status_active`, `cw.alerts.status_triggered`, `cw.alerts.empty_title`
- [ ] Fluxo de permissão `UserNotifications` documentado
- [ ] Conteúdo da notificação local especificado
- [ ] Implementação pode começar sem ambiguidades
