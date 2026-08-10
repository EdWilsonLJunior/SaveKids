# Configuração de Alertas

> **Épico**: PayFlow
> **US-ID**: US-36.03
> **Tela nº**: 3 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Configuração de notificações locais para vencimento de assinaturas. O usuário define quantos dias antes quer ser notificado e quais assinaturas devem gerar alertas.

---

## História de usuário

Como **usuário**, quero **configurar lembretes de vencimento**, para que **seja avisado com antecedência e evite cobranças por falta de saldo**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Configurar antecedência global (happy path)
**Dado** que acesso a tela de Alertas
**Quando** seleciono "3 dias antes" no `ZodiakDropdown`
**Então** `@AppStorage("pf.notify_days_before")` é atualizado
**E** reescalono todas as notificações pendentes

### Cenário 2 — Ativar/desativar por assinatura
**Dado** que vejo a lista de assinaturas
**Quando** desativo o `ZodiakSwitch` de uma assinatura
**Então** cancelo a notificação pendente com `UNUserNotificationCenter.removePendingNotificationRequests`

### Cenário 3 — Permissão não concedida
**Dado** que o usuário não concedeu permissão de notificações
**Quando** tenta ativar alertas
**Então** exibo `ZodiakAlert` "Permissão de notificações necessária" com botão "Abrir Configurações"

### Cenário 4 — Nenhuma assinatura
**Dado** que não há assinaturas cadastradas
**Então** o painel de alertas por assinatura exibe `ZodiakEmptyState`
**E** a configuração global ainda é exibida e editável

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** cada switch anuncia o nome da assinatura e estado (Ativado/Desativado)
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push da tela de Assinaturas
- **Saída**: ← back

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Dias de antecedência | `@AppStorage("pf.notify_days_before")` | UserDefaults |
| Assinaturas | `@Query var subscriptions: [PFSubscription]` | SwiftData |
| Status de permissão | `UNUserNotificationCenter.getNotificationSettings` | Sistema |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakDropdown` | Dias de antecedência (1, 2, 3, 5, 7) |
| `ZodiakSwitch` | Ativar/desativar por assinatura |
| `ZodiakAlert` | Permissão negada |
| `ZodiakEyebrow` | "Configurações globais" / "Por assinatura" |
| `ZodiakEmptyState` | Sem assinaturas |
| `ZodiakFormContainer` | Container de configurações |

---

## Definition of Done

- [ ] Strings: `pf.notifications.title`, `pf.notifications.global_eyebrow`, `pf.notifications.dropdown_days`, `pf.notifications.per_sub_eyebrow`, `pf.notifications.permission_alert_title`, `pf.notifications.permission_action_settings`, `pf.notifications.empty_title`
- [ ] Opções do dropdown documentadas: 1, 2, 3, 5, 7 dias
- [ ] Fluxo de reagendamento de notificações especificado
- [ ] Implementação pode começar sem ambiguidades
