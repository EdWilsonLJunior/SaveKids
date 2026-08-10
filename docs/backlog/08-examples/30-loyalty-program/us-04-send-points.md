# Envio de Pontos

> **Épico**: Programa Fidelidade
> **US-ID**: US-30.04
> **Tela nº**: 4 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Fluxo de 3 etapas para transferência de pontos entre clientes: (1) destinatário via CPF, (2) valor em pontos, (3) confirmação. Usa `ZodiakStepIndicator` para guiar o usuário. O `LPSendPointsViewModel` é compartilhado como `@EnvironmentObject` entre as etapas.

---

## História de usuário

Como **cliente**, quero **enviar meus pontos para outro cliente da plataforma**, para que **eu possa ajudar amigos e familiares a acumularem benefícios**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Fluxo principal (happy path)
**Dado** que preenchi CPF de destinatário válido (11 dígitos) e selecionei 200 pontos
**Quando** confirmo na etapa 3 com `ZodiakSlideToSubmit`
**Então** `lp.points` diminui 200 em `@AppStorage`
**E** uma transação `.sent` é adicionada ao `lp.statement`
**E** exibo `ZodiakModal` de sucesso com nome fictício do destinatário e pontos enviados

### Cenário 2 — Validação de CPF do destinatário (etapa 1)
**Dado** que o CPF digitado tem menos de 11 dígitos ou é igual ao CPF do usuário logado
**Quando** tento avançar para a etapa 2
**Então** `ZodiakNotice` inline exibe mensagem de erro específica

### Cenário 3 — Pontos insuficientes (etapa 2)
**Dado** que o valor informado excede `lp.points`
**Quando** tento avançar para a etapa 3
**Então** `ZodiakNotice` inline exibe "Saldo insuficiente"
**E** exibo saldo disponível ao lado do campo

### Cenário 4 — Estado vazio / cancelamento
**Dado** que estou em qualquer etapa
**Quando** toco no botão "Cancelar"
**Então** exibo `ZodiakModal` de confirmação de cancelamento
**Quando** confirmo
**Então** retorno para `LPHomeScreen` sem persistir nada

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** `ZodiakStepIndicator` anuncia "Etapa 1 de 3: Destinatário"
**E** campo de CPF anuncia "CPF do destinatário, campo de texto numérico"
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push de `LPHomeScreen` (ação "Enviar")
- **Saída**: ← cancelamento (popToRoot) · `ZodiakModal` de sucesso com botão "Voltar ao início"
- **Parâmetros**: nenhum

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| CPF do destinatário | `@State` em step 1 | — |
| Quantidade de pontos | `@State` em step 2 | — |
| Saldo do remetente | `@AppStorage("lp.points")` | UserDefaults |
| Extrato | `@AppStorage("lp.statement")` | UserDefaults |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakStepIndicator` | Indicador 3 etapas |
| `ZodiakPhoneInput` | Campo CPF do destinatário |
| `ZodiakLabelledNumericField` | Quantidade de pontos |
| `ZodiakInfoRow` | Saldo disponível e resumo do destinatário |
| `ZodiakNotice` | Erros de validação inline |
| `ZodiakButton` | "Próximo" / "Voltar" por etapa |
| `ZodiakSlideToSubmit` | Confirmação na etapa 3 |
| `ZodiakModal` | Sucesso e confirmação de cancelamento |
| `ZodiakKeyFigures` | Saldo atual no topo |

### Estados da tela
- `step1_idle`, `step1_error` · `step2_idle`, `step2_error` · `step3_review`, `step3_processing`, `step3_success`, `step3_error`

### Validações
- CPF: 11 dígitos, não pode ser igual ao CPF do usuário logado
- Pontos: mínimo 10, múltiplo de 10, ≤ saldo disponível

---

## Boas práticas — iOS

- `LPSendPointsViewModel` como `@EnvironmentObject` compartilhado entre as 3 sub-views de cada etapa
- Destinatário "mock": qualquer CPF válido é aceito; nome exibido é fictício (ex: "Usuário ****123")

---

## Referências

- [finalBacklog.md — Projeto 2](../../raw_pdf/finalBacklog.md)
- [US-30.02 — Home](us-02-home.md)

---

## Gaps e dúvidas

- Pontos enviados precisam ser múltiplos de 10? Proposto: sim, incremento mínimo de 10 pontos.
- Nome do destinatário: exibir CPF mascarado ou nome fictício?

---

## Definition of Done

- [ ] História revisada, critérios aprovados, componentes mapeados
- [ ] Strings: `lp.send.title`, `lp.send.step1_label`, `lp.send.step2_label`, `lp.send.step3_label`, `lp.send.field_cpf`, `lp.send.field_points`, `lp.send.balance_label`, `lp.send.error_cpf`, `lp.send.error_self`, `lp.send.error_insufficient`, `lp.send.success_title`, `lp.send.action_next`, `lp.send.action_back`, `lp.send.slide_label`
- [ ] Validações de pontos documentadas (mínimo, múltiplo)
- [ ] Implementação pode começar sem ambiguidades
