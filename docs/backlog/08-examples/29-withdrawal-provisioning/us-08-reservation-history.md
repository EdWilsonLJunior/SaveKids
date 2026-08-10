# Histórico de Reservas

> **Épico**: Provisionamento de Saque
> **US-ID**: US-29.08
> **Tela nº**: 8 de 8
> **Prioridade**: P1
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Lista de todas as reservas realizadas pelo usuário na sessão atual e em sessões anteriores (recuperadas de `@AppStorage`). Cada reserva exibe status (Ativa, Concluída, Cancelada), protocolo, valor e unidade. O usuário pode cancelar reservas com status "Ativa".

---

## História de usuário

Como **correntista**, quero **ver o histórico de todas as minhas reservas com seus respectivos status**, para que **eu acompanhe operações passadas e gerencie reservas ativas**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Fluxo principal (happy path)
**Dado** que tenho reservas registradas em `@AppStorage`
**Quando** acesso a tela Histórico de Reservas
**Então** exibo lista de reservas em ordem decrescente de data
**E** cada reserva exibe: protocolo, valor, nome da unidade, data e `ZodiakStatusChip` (Ativa / Concluída / Cancelada)

### Cenário 2 — Estado vazio
**Dado** que não há reservas registradas
**Quando** acesso a tela Histórico de Reservas
**Então** exibo `ZodiakEmptyState` com ícone `"clock.arrow.circlepath"`, título "Nenhuma reserva encontrada" e subtítulo "Suas reservas aparecerão aqui após a primeira operação"
**E** exibo botão "Fazer Reserva" que navega para `WPReserveValueScreen`

### Cenário 3 — Cancelar reserva ativa
**Dado** que uma reserva tem status "Ativa"
**Quando** deslizo o item para a esquerda (swipeActions)
**Então** exibo ação "Cancelar" em vermelho
**Quando** toco em "Cancelar"
**Então** exibo `ZodiakModal` de confirmação com `ZodiakWarningButton` "Confirmar Cancelamento"
**Quando** confirmo
**Então** o status da reserva muda para "Cancelada" em `@AppStorage`
**E** exibo `ZodiakNotice` de sucesso "Reserva cancelada com sucesso"

### Cenário 4 — Recarregar dados
**Dado** que os dados de `@AppStorage` estão disponíveis
**Então** a lista é carregada sincronamente (sem loading state, pois é leitura local)
**E** qualquer mudança em `@AppStorage` reflete automaticamente via `@AppStorage` binding

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** cada item anuncia: "Protocolo ABC12345, R$ 500,00, Agência Centro, 27 de maio, Ativa"
**E** `ZodiakStatusChip` anuncia o status corretamente
**E** `swipeActions` anuncia "Cancelar, deslize para revelar"
**E** em dark mode, `ZodiakStatusChip` usa tokens corretos por variante (ativo: success, cancelado: error)

---

## Spec de tela

### Navegação
- **Entrada**: push a partir de `WPDashboardScreen` ("Histórico")
- **Saída**: 
  - ← back para Dashboard
  - → `WPReserveValueScreen` (push, via botão do empty state)
- **Parâmetros recebidos**: nenhum (lê diretamente do `@AppStorage`)

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Lista de reservas | `@AppStorage("wp.reservations")` decoded como `[WPReservation]` | UserDefaults |
| Status de cada reserva | `WPReservation.status: WPReservationStatus` | UserDefaults (atualizado ao cancelar) |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakHorizontalCard` | Card por reserva com dados e status chip |
| `ZodiakStatusChip` | Status: Ativa (success) / Concluída (neutral) / Cancelada (error) |
| `ZodiakShowMore` | Paginação se houver mais de 10 reservas |
| `ZodiakEmptyState` | Nenhuma reserva registrada |
| `ZodiakModal` | Confirmação de cancelamento |
| `ZodiakWarningButton` | "Confirmar Cancelamento" no modal |
| `ZodiakSecondaryButton` | "Cancelar" (fechar modal sem ação) |
| `ZodiakNotice` | Feedback de cancelamento bem-sucedido |
| `ZodiakButton` | "Fazer Reserva" no empty state |

### Estados da tela
- `loaded(reservations)` — lista exibida (pode estar vazia)
- `cancelling` — modal de confirmação aberto

### Validações
- Apenas reservas com status `Ativa` exibem opção de cancelamento
- Cancelamento atualiza `status` para `.cancelled` + `cancelledAt: Date` no modelo

---

## Boas práticas — iOS

- `WPReservationHistoryViewModel` usa `@AppStorage` wrappado em um `@Published var reservations` para propagação reativa
- O cancelamento é reversível apenas via "Fazer nova reserva" — não há "desfazer cancelamento"
- `ZodiakModal` para cancelamento usa `showCloseButton: true` para permitir dispensa sem ação

---

## Referências

- [finalBacklog.md — Projeto 1](../../raw_pdf/finalBacklog.md)
- [US-29.02 — Dashboard](us-02-dashboard.md) — tela anterior
- [US-29.07 — Comprovante](us-07-receipt.md) — origem das reservas listadas

---

## Gaps e dúvidas

- `WPReservation` deve incluir `cancelledAt: Date?` ou apenas `status: WPReservationStatus`?
- Quantas reservas mock devem ser pré-populadas para fins de demo (proposto: 3 reservas com status variados)?

---

## Definition of Done

- [ ] História revisada pelo time
- [ ] Critérios de aceite aprovados
- [ ] Componentes DS mapeados
- [ ] Strings: `wp.history.title`, `wp.history.empty_title`, `wp.history.empty_subtitle`, `wp.history.action_reserve`, `wp.history.status_active`, `wp.history.status_completed`, `wp.history.status_cancelled`, `wp.history.action_cancel`, `wp.history.confirm_cancel_title`, `wp.history.confirm_cancel_message`, `wp.history.cancelled_success`
- [ ] Schema completo de `WPReservation` definido com todos os campos
- [ ] Implementação pode começar sem ambiguidades
