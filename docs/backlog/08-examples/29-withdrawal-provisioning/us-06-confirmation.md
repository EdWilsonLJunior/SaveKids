# Confirmação — Step 3 de 3

> **Épico**: Provisionamento de Saque
> **US-ID**: US-29.06
> **Tela nº**: 6 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Última etapa do fluxo de reserva. Apresenta um resumo completo da operação (valor, unidade, data prevista) para revisão antes da confirmação definitiva. A confirmação é feita com `ZodiakSlideToSubmit` — gesto intencional que reduz confirmações acidentais. Após confirmar, a reserva é persistida e o usuário navega para o Comprovante.

---

## História de usuário

Como **correntista**, quero **revisar os dados da minha reserva antes de confirmar**, para que **eu evite erros e tenha certeza da operação antes de finalizá-la**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Fluxo principal (happy path)
**Dado** que estou na tela Confirmação com valor R$ 500,00 e unidade "Agência Centro"
**Quando** deslizo o `ZodiakSlideToSubmit` até o final
**Então** `WPReserveViewModel.confirmReservation()` é chamado
**E** a reserva é persistida em `@AppStorage("wp.reservations")`
**E** navego para `WPReceiptScreen` com o protocolo gerado
**E** o `WPStepIndicator` não é mais exibido (fluxo concluído)

### Cenário 2 — Estados de carregamento
**Dado** que deslizei o `ZodiakSlideToSubmit`
**Quando** a persistência está em andamento (mock de 500ms)
**Então** o componente exibe estado "processando" (animação de progresso interna ao `ZodiakSlideToSubmit`)
**E** o botão "Voltar" fica desabilitado para evitar dupla submissão

### Cenário 3 — Cancelamento e edição
**Dado** que estou na tela Confirmação
**Quando** toco no botão "Editar" ao lado do valor
**Então** navego de volta para `WPReserveValueScreen` com o valor pré-preenchido
**Quando** toco no botão "Editar" ao lado da unidade
**Então** navego de volta para `WPUnitPickerScreen` com a seleção mantida

### Cenário 4 — Falha na persistência
**Dado** que a persistência em `@AppStorage` falha
**Quando** o `ZodiakSlideToSubmit` é acionado
**Então** exibo `ZodiakAlert` com título "Erro ao reservar" e opção "Tentar novamente"
**E** o `ZodiakSlideToSubmit` retorna à posição inicial

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** `ZodiakStepIndicator` anuncia "Passo 3 de 3: Confirmação"
**E** cada `ZodiakInfoRow` anuncia rótulo e valor ("Valor: R$ 500,00", "Unidade: Agência Centro", "Data: 27 de maio de 2026")
**E** `ZodiakSlideToSubmit` anuncia "Deslize para confirmar a reserva" e, ao concluir, "Reserva confirmada"
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push a partir de `WPUnitPickerScreen`
- **Saída(s)**:
  - → `WPReceiptScreen` (push, após confirmação bem-sucedida)
  - ← `WPUnitPickerScreen` (pop, via "Editar unidade")
  - ← `WPReserveValueScreen` (popTo, via "Editar valor")
- **Parâmetros recebidos**: via `WPReserveViewModel` compartilhado (`amount`, `unit`, `estimatedDate`)

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Valor da reserva | `WPReserveViewModel.amount` | em memória |
| Unidade selecionada | `WPReserveViewModel.selectedUnit` | em memória |
| Data estimada de saque | calculada: hoje + 1 dia útil (lógica mock) | em memória |
| Reserva confirmada | `@AppStorage("wp.reservations")` (JSON encoded `[WPReservation]`) | UserDefaults |
| Número de protocolo | `UUID().uuidString.prefix(8).uppercased()` gerado no VM | em memória → passado ao Comprovante |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakStepIndicator` | Indicador de progresso "3 de 3" |
| `ZodiakInfoRow` | Resumo: valor, unidade, data estimada |
| `ZodiakSlideToSubmit` | Gesto de confirmação final |
| `ZodiakSecondaryButton` | Botões "Editar" ao lado de valor e unidade |
| `ZodiakAlert` | Erro de persistência com retry |
| `ZodiakEyebrow` | Rótulo de seção "Resumo da reserva" |
| `ZodiakDivider` | Separação entre itens do resumo |

### Estados da tela
- `review` — aguardando ação do usuário
- `processing` — persistindo reserva (mock delay)
- `error(message)` — falha na persistência

### Validações
- Nenhuma validação adicional — dados já validados nas telas anteriores
- Garantir que `WPReserveViewModel.amount > 0` e `selectedUnit != nil` antes de exibir esta tela (defensivo)

---

## Boas práticas — iOS

- `ZodiakSlideToSubmit` dispara `onConfirm: () async throws -> Void` — o ViewModel lida com o async
- A tela desabilita interação durante processamento via `.disabled(isProcessing)`
- "Editar valor" usa `navigationPath.removeLast()` ou equivalente para popTo específico

---

## Referências

- [finalBacklog.md — Projeto 1](../../raw_pdf/finalBacklog.md)
- [US-29.05 — Escolha de Unidade](us-05-unit-picker.md) — tela anterior
- [US-29.07 — Comprovante](us-07-receipt.md) — próximo passo

---

## Gaps e dúvidas

- `ZodiakSlideToSubmit` suporta callback async? Verificar API do componente.
- Confirmar lógica de "dia útil" — pode ser simplesmente D+1 sem calcular fins de semana.

---

## Definition of Done

- [ ] História revisada pelo time
- [ ] Critérios de aceite aprovados
- [ ] Componentes DS mapeados
- [ ] Strings: `wp.confirmation.title`, `wp.confirmation.step_label`, `wp.confirmation.section_summary`, `wp.confirmation.field_amount`, `wp.confirmation.field_unit`, `wp.confirmation.field_date`, `wp.confirmation.action_edit`, `wp.confirmation.slide_label`, `wp.confirmation.error_title`, `wp.confirmation.retry`
- [ ] Esquema de persistência de `WPReservation` definido
- [ ] Implementação pode começar sem ambiguidades
