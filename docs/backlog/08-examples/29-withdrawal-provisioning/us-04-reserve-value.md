# Reserva de Valor — Step 1 de 3

> **Épico**: Provisionamento de Saque
> **US-ID**: US-29.04
> **Tela nº**: 4 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Primeira etapa do fluxo de três passos para reservar um saque. O usuário informa o valor desejado, que deve ser múltiplo de R$ 50 e menor ou igual ao saldo disponível. O `ZodiakStepIndicator` mostra o progresso (1/3). O valor é validado no ViewModel antes de permitir avançar.

---

## História de usuário

Como **correntista**, quero **informar o valor que desejo reservar para saque**, para que **eu inicie o processo de provisionamento com o valor correto**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Fluxo principal (happy path)
**Dado** que estou na tela Reserva de Valor (step 1/3)
**E** informei R$ 500,00 (múltiplo de 50, ≤ saldo)
**Quando** toco em "Próximo"
**Então** navego para a tela Escolha de Unidade (step 2/3)
**E** o valor é armazenado no `WPReserveViewModel` compartilhado

### Cenário 2 — Estados de carregamento
**Dado** que a tela carrega
**Quando** o saldo disponível ainda está sendo calculado (caso dashborad ainda não tenha terminado o prefetch)
**Então** exibo `ZodiakSkeletonLoader` no campo de saldo de referência
**E** o campo de valor e o botão "Próximo" ficam desabilitados até o saldo estar disponível

### Cenário 3 — Valor inválido
**Dado** que informei R$ 375,00 (não é múltiplo de 50)
**Quando** toco em "Próximo"
**Então** exibo `ZodiakNotice` inline com mensagem "O valor deve ser múltiplo de R$ 50"
**E** permaneço na mesma tela

**Dado** que informei R$ 15.000,00 (superior ao saldo de R$ 12.340,00)
**Quando** toco em "Próximo"
**Então** exibo `ZodiakNotice` com mensagem "Valor superior ao saldo disponível"

### Cenário 4 — Campo vazio
**Dado** que o campo de valor está vazio
**Quando** toco em "Próximo"
**Então** exibo `ZodiakNotice` com mensagem "Informe o valor para continuar"
**E** o foco retorna ao campo

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** `ZodiakStepIndicator` anuncia "Passo 1 de 3: Valor"
**E** `ZodiakLabelledNumericField` anuncia "Valor a reservar, campo de texto, R$"
**E** `ZodiakSliderCounter` anuncia valor atual e incremento ("R$ 500, ajustar com controle deslizante")
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push a partir de `WPDashboardScreen` ("Reservar Saque")
- **Saída**: → `WPUnitPickerScreen` (push, após validação bem-sucedida)
- **Parâmetros recebidos**: `saldoDisponivel: Double` (passado pelo ViewModel compartilhado)

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Saldo disponível | `WPReserveViewModel.availableBalance` | em memória (sessão) |
| Valor informado | `@State var amount: String` | em memória (até confirmação) |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakStepIndicator` | Indicador de progresso "1 de 3" |
| `ZodiakLabelledNumericField` | Campo de entrada do valor em R$ |
| `ZodiakSliderCounter` | Ajuste rápido do valor em incrementos de R$ 50 |
| `ZodiakInfoRow` | Exibição do saldo disponível como referência |
| `ZodiakNotice` | Erro de validação inline |
| `ZodiakButton` | Botão "Próximo" (primário) |
| `ZodiakSkeletonLoader` | Placeholder do saldo enquanto carrega |

### Estados da tela
- `loading` — saldo ainda não disponível
- `idle` — aguardando input do usuário
- `validating` — validando valor ao tocar "Próximo"
- `error(message)` — valor inválido

### Validações
- Valor > R$ 0
- Valor múltiplo de R$ 50
- Valor ≤ saldo disponível
- Todas as validações em `WPReserveViewModel.validateAmount(_:)`

---

## Boas práticas — iOS

- `WPReserveViewModel` é um `@StateObject` criado no root screen e passado como `@EnvironmentObject` para as 3 telas do fluxo de reserva (evita recriação e perda de estado)
- `ZodiakSliderCounter` opera de R$ 50 em R$ 50 com mínimo R$ 50 e máximo = saldo disponível
- O campo numérico usa `keyboardType: .decimalPad` com formatação automática via `ZodiakLabelledNumericField`

---

## Referências

- [finalBacklog.md — Projeto 1](../../raw_pdf/finalBacklog.md)
- [US-29.02 — Dashboard](us-02-dashboard.md) — tela anterior
- [US-29.05 — Escolha de Unidade](us-05-unit-picker.md) — próximo passo

---

## Gaps e dúvidas

- Confirmar o valor mínimo e máximo para reserva (proposto: R$ 50 a R$ 10.000 por operação).
- `ZodiakSliderCounter` suporta passo configurável (R$ 50)? Verificar API do componente.

---

## Definition of Done

- [ ] História revisada pelo time
- [ ] Critérios de aceite aprovados
- [ ] Componentes DS mapeados
- [ ] Strings: `wp.reserve.title`, `wp.reserve.step_label`, `wp.reserve.field_amount`, `wp.reserve.available_balance`, `wp.reserve.action_next`, `wp.reserve.error_not_multiple`, `wp.reserve.error_exceeds_balance`, `wp.reserve.error_empty`
- [ ] Regras de validação documentadas e aprovadas
- [ ] Implementação pode começar sem ambiguidades
