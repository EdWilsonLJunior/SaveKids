# Saldo / Dashboard

> **Épico**: Provisionamento de Saque
> **US-ID**: US-29.02
> **Tela nº**: 2 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Tela principal pós-login. Apresenta o saldo disponível para saque e as ações principais do mini-app. Ao carregar, dispara uma chamada assíncrona para buscar a lista de unidades disponíveis (necessária na tela de escolha de unidade), antecipando o dado para reduzir latência percebida. Inclui botão de logout.

---

## História de usuário

Como **correntista autenticado**, quero **ver meu saldo disponível e acessar rapidamente as ações de saque**, para que **eu possa tomar decisões informadas sobre minha reserva**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Fluxo principal (happy path)
**Dado** que estou autenticado e na tela Dashboard
**Quando** a tela carrega
**Então** exibo saldo disponível (mock R$ 12.340,00) via `ZodiakKeyFigures`
**E** exibo três ações via `ZodiakArrowButton`: "Reservar Saque", "Ver Extrato", "Histórico"
**E** inicio em background a busca de unidades via `WPMockService.fetchUnits()`

### Cenário 2 — Estados de carregamento
**Dado** que a busca de unidades está em andamento
**Quando** visualizo o dashboard
**Então** as ações "Reservar Saque" estão disponíveis imediatamente (saldo é mock local)
**E** o carregamento de unidades ocorre em background sem bloquear a UI

### Cenário 3 — Estado de erro na busca de unidades
**Dado** que a busca de unidades falha (ex.: arquivo JSON indisponível)
**Então** o Dashboard continua funcional
**E** o erro é tratado silenciosamente — apenas quando o usuário tocar "Reservar Saque" será exibido `ZodiakNotice` de retry

### Cenário 4 — Logout
**Dado** que estou no Dashboard
**Quando** toco no ícone de logout na toolbar
**Então** `@AppStorage("wp.isAuthenticated")` é definido como `false`
**E** o `NavigationStack` retorna ao root (tela de Login)

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** `ZodiakKeyFigures` anuncia "Saldo disponível: R$ 12.340,00"
**E** cada `ZodiakArrowButton` possui `accessibilityLabel` descritivo
**E** em dark mode, todos os tokens respondem corretamente ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push a partir de `WPLoginScreen` (após autenticação)
- **Saída(s)**:
  - → `WPStatementScreen` (push via "Ver Extrato")
  - → `WPReserveValueScreen` (push via "Reservar Saque")
  - → `WPReservationHistoryScreen` (push via "Histórico")
  - → `WPLoginScreen` (popToRoot via logout)
- **Parâmetros recebidos**: nenhum

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Saldo disponível | Mock local (R$ 12.340,00) em `WPDashboardViewModel` | em memória |
| Lista de unidades | `WPMockService.fetchUnits()` via URLSession + `units_mock.json` | em memória (repassado ao ReserveViewModel) |
| Estado de auth | `@AppStorage("wp.isAuthenticated")` | UserDefaults |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakKeyFigures` | Exibição do saldo disponível com rótulo |
| `ZodiakArrowButton` | Ações: Reservar, Extrato, Histórico |
| `ZodiakInfoRow` | Dados complementares (agência, conta, nome mock) |
| `ZodiakEyebrow` | Rótulo de seção "Conta corrente" |
| `ZodiakSkeletonLoader` | Placeholder enquanto dados de unidades carregam (área de actions só) |
| `ZodiakNotice` | Erro de carregamento de unidades (exibido ao tentar "Reservar") |

### Estados da tela
- `loading` — busca de unidades em background (UI não bloqueada)
- `ready` — saldo e ações disponíveis
- `error` — falha na busca de unidades (diferido para o momento de uso)

### Validações
- Saldo deve ser > R$ 0 para habilitar "Reservar Saque" (se R$ 0, botão exibe estado `disabled` com `ZodiakNotice` explicativo)

---

## Boas práticas — iOS

- `WPDashboardViewModel` inicia `fetchUnits()` em `onAppear` via `Task { await viewModel.prefetchUnits() }`
- O resultado das unidades é armazenado no ViewModel e passado via binding para `WPReserveViewModel` no momento da navegação
- Logout é implementado como `@AppStorage("wp.isAuthenticated") = false` + `dismiss()` até o root

---

## Referências

- [finalBacklog.md — Projeto 1](../../raw_pdf/finalBacklog.md)
- [US-29.01 — Login](us-01-login.md) — tela anterior
- [US-29.03 — Extrato](us-03-statement.md), [US-29.04 — Reserva](us-04-reserve-value.md), [US-29.08 — Histórico](us-08-reservation-history.md) — destinos

---

## Gaps e dúvidas

- Definir o valor de saldo mock — fixo ou gerado aleatoriamente por sessão?
- O prefetch de unidades deve ter retry automático ou apenas on-demand?

---

## Definition of Done

- [ ] História revisada pelo time
- [ ] Critérios de aceite aprovados
- [ ] Componentes DS mapeados
- [ ] Strings: `wp.dashboard.title`, `wp.dashboard.available_balance`, `wp.dashboard.action_reserve`, `wp.dashboard.action_statement`, `wp.dashboard.action_history`, `wp.dashboard.action_logout`, `wp.dashboard.error_units`
- [ ] Dados mock definidos (saldo R$ 12.340,00; `units_mock.json` especificado)
- [ ] Implementação pode começar sem ambiguidades
