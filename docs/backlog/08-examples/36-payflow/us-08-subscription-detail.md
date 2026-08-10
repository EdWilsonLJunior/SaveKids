# Detalhe da Assinatura

> **Épico**: PayFlow
> **US-ID**: US-36.08
> **Tela nº**: 8 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Tela de criação e edição de uma assinatura. Formulário completo com catálogo de serviços pré-definidos (carregado de `services_mock.json`) ou entrada manual. Exibe histórico de pagamentos da assinatura.

---

## História de usuário

Como **usuário**, quero **cadastrar e editar os detalhes de uma assinatura**, para que **o app reflita com precisão os serviços que pago**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Criar a partir do catálogo (happy path)
**Dado** que acesso a tela em modo criação
**Quando** seleciono um serviço do catálogo via `ZodiakSearchField`
**Então** os campos nome, logo e valor sugerido são preenchidos automaticamente
**E** posso editar qualquer campo antes de salvar

### Cenário 2 — Salvar assinatura
**Dado** que preenchi todos os campos obrigatórios
**Quando** toco em "Salvar"
**Então** `PFSubscription` é inserido ou atualizado no SwiftData
**E** `UNUserNotificationCenter` é chamado para agendar notificação de vencimento
**E** navego de volta com pop

### Cenário 3 — Editar assinatura existente
**Dado** que acesso em modo edição
**Quando** modifico o valor ou a data de vencimento
**Então** ao salvar, o modelo é atualizado e a notificação é reagendada

### Cenário 4 — Campos obrigatórios ausentes
**Dado** que toco em "Salvar" sem preencher nome ou valor
**Então** exibo `ZodiakAlert` com lista de campos faltantes
**E** destaco os campos com erro

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** cada campo anuncia seu rótulo e valor atual
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push da tela de Assinaturas com `subscriptionId: UUID?` (nil = criação)
- **Saída**: ← back após salvar ou cancelar

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Assinatura | SwiftData `PFSubscription` (insert ou update) | SwiftData |
| Catálogo | `services_mock.json` via URLSession (in-memory) | Nenhuma |
| Categorias | `@Query var categories: [PFCategory]` | SwiftData |

### Campos do formulário
| Campo | Tipo | Obrigatório |
|---|---|---|
| Nome do serviço | `ZodiakLabelledField` | Sim |
| Logo / ícone | Emoji ou SF Symbol | Não |
| Valor | `ZodiakLabelledNumericField` | Sim |
| Ciclo de cobrança | `ZodiakDropdown` (Mensal/Trimestral/Anual) | Sim |
| Próximo vencimento | `DatePicker` | Sim |
| Categoria | `ZodiakDropdown` | Sim |
| Última vez usado | `DatePicker` (opcional) | Não |
| Notas | `ZodiakLabelledField` multilinha | Não |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakFormContainer` | Container do formulário |
| `ZodiakLabelledField` | Nome e notas |
| `ZodiakLabelledNumericField` | Valor |
| `ZodiakDropdown` | Ciclo e categoria |
| `ZodiakSearchField` | Busca no catálogo |
| `ZodiakAlert` | Campos obrigatórios ausentes |
| `ZodiakButton` | "Salvar" |
| `ZodiakSecondaryButton` | "Cancelar" |
| `ZodiakSkeletonLoader` | Carregando catálogo |

---

## Definition of Done

- [ ] Strings: `pf.detail.title_new`, `pf.detail.title_edit`, `pf.detail.field_name`, `pf.detail.field_amount`, `pf.detail.field_cycle`, `pf.detail.field_due_date`, `pf.detail.field_category`, `pf.detail.field_last_used`, `pf.detail.field_notes`, `pf.detail.action_save`, `pf.detail.action_cancel`, `pf.detail.error_required_fields`, `pf.detail.catalog_eyebrow`
- [ ] Schema de `services_mock.json` documentado
- [ ] Lógica de reagendamento de notificação ao editar data de vencimento
- [ ] Implementação pode começar sem ambiguidades
