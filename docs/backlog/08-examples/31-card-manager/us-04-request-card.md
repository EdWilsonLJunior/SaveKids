# Solicitar Novo Cartão

> **Épico**: Gerenciador de Cartões
> **US-ID**: US-31.04
> **Tela nº**: 4 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Wizard de 3 etapas para solicitar um novo cartão: (1) modalidade (Crédito/Débito, bandeira), (2) renda declarada e limite desejado, (3) endereço de entrega. Finaliza com `ZodiakSlideToSubmit` que registra a solicitação em `@AppStorage`.

---

## História de usuário

Como **correntista**, quero **solicitar um novo cartão via app**, para que **eu expanda meus meios de pagamento sem precisar ir a uma agência**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Fluxo principal (happy path)
**Dado** que completei as 3 etapas com dados válidos
**Quando** deslizo `ZodiakSlideToSubmit` na etapa 3
**Então** a solicitação é salva em `@AppStorage("cm.card_requests")`
**E** exibo `ZodiakModal` de sucesso "Solicitação enviada com protocolo #CM-XXXXXXXX"
**E** botão "Voltar à lista" retorna para `CMCardListScreen`

### Cenário 2 — Seleção de modalidade (etapa 1)
**Dado** que estou na etapa 1
**Então** exibo opções via `ZodiakDropdown`: Crédito ou Débito
**E** exibo seletor de bandeira: Visa, Mastercard, Elo
**E** o `ZodiakStepIndicator` exibe "1 de 3: Modalidade"

### Cenário 3 — Validação de renda (etapa 2)
**Dado** que preenchi renda menor que R$ 500,00
**Quando** tento avançar para etapa 3
**Então** `ZodiakNotice` exibe "Renda mínima: R$ 500,00"

### Cenário 4 — Endereço incompleto (etapa 3)
**Dado** que deixei CEP em branco
**Quando** tento confirmar com `ZodiakSlideToSubmit`
**Então** `ZodiakNotice` exibe "CEP é obrigatório"

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** `ZodiakStepIndicator` anuncia etapa atual
**E** `ZodiakDropdown` anuncia opção selecionada e estado
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push de `CMCardListScreen` (botão "+")
- **Saída**: ← back para CardList (cancelamento) · `ZodiakModal` sucesso com "Voltar à lista"
- **Parâmetros**: nenhum

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Dados da solicitação | `@AppStorage("cm.card_requests")` (JSON encoded) | UserDefaults |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakStepIndicator` | 3 etapas |
| `ZodiakDropdown` | Tipo (Crédito/Débito) e bandeira |
| `ZodiakLabelledNumericField` | Renda e limite desejado |
| `ZodiakFormContainer` | Container do formulário de endereço |
| `ZodiakLabelledField` | CEP, rua, número, complemento, cidade |
| `ZodiakNotice` | Erros de validação |
| `ZodiakButton` | "Próximo" / "Voltar" |
| `ZodiakSlideToSubmit` | Confirmação final |
| `ZodiakModal` | Sucesso |

### Validações
- Renda mínima: R$ 500,00
- CEP: obrigatório, 8 dígitos
- Limite desejado: entre R$ 500,00 e R$ 50.000,00

---

## Definition of Done

- [ ] Strings: `cm.request.title`, `cm.request.step1_label`, `cm.request.step2_label`, `cm.request.step3_label`, `cm.request.field_type`, `cm.request.field_brand`, `cm.request.field_income`, `cm.request.field_limit`, `cm.request.field_cep`, `cm.request.error_income`, `cm.request.error_cep`, `cm.request.slide_label`, `cm.request.success_title`
- [ ] Schema de `CMCardRequest` definido
- [ ] Implementação pode começar sem ambiguidades
