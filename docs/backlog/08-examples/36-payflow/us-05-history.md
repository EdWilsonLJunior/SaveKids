# Histórico de Pagamentos

> **Épico**: PayFlow
> **US-ID**: US-36.05
> **Tela nº**: 5 de 8
> **Prioridade**: P1
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Histórico completo de pagamentos registrados, agrupados por mês. Permite filtrar por assinatura e por categoria. Exibe total pago por período.

---

## História de usuário

Como **usuário**, quero **ver o histórico de todos os pagamentos registrados**, para que **acompanhe o quanto gastei em cada serviço ao longo do tempo**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Histórico agrupado por mês (happy path)
**Dado** que tenho pagamentos registrados
**Quando** acesso a tela Histórico
**Então** exibo lista agrupada por mês com `ZodiakEyebrow` de data e total do mês
**E** cada item exibe: nome da assinatura, valor e data

### Cenário 2 — Filtrar por categoria
**Dado** que seleciono uma categoria no `ZodiakDropdown`
**Então** filtro os pagamentos exibidos por `categoryId`
**E** atualizo o total do período

### Cenário 3 — Carregar mais
**Dado** que há mais de 15 itens
**Quando** chego ao final da lista
**Então** exibo `ZodiakShowMore`
**Quando** toco
**Então** mais 15 itens são carregados

### Cenário 4 — Histórico vazio
**Dado** que não há pagamentos registrados
**Então** exibo `ZodiakEmptyState` "Nenhum pagamento registrado ainda"

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** cada pagamento anuncia: nome, valor e data
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push da tela de Assinaturas
- **Saída**: ← back

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Pagamentos | `@Query(sort: \.paidAt, order: .reverse) var payments: [PFPayment]` | SwiftData |
| Categorias | `@Query var categories: [PFCategory]` | SwiftData |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakDropdown` | Filtro por categoria |
| `ZodiakShowMore` | Paginação |
| `ZodiakEmptyState` | Sem pagamentos |
| `ZodiakEyebrow` | Cabeçalho do mês com total |
| `ZodiakInfoRow` | Dados de cada pagamento |
| `ZodiakDivider` | Separador de grupos mensais |
| `ZodiakKeyFigures` | Total filtrado |

---

## Definition of Done

- [ ] Strings: `pf.history.title`, `pf.history.filter_all_categories`, `pf.history.total_label`, `pf.history.empty_title`
- [ ] Lógica de agrupamento por mês (seção = `yyyy-MM`)
- [ ] Implementação pode começar sem ambiguidades
