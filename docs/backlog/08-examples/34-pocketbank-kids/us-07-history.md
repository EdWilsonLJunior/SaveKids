# Histórico de Moedas

> **Épico**: PocketBank Kids
> **US-ID**: US-34.07
> **Tela nº**: 7 de 8
> **Prioridade**: P1
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Histórico paginado de transações de moedas da criança (entradas por missões, saídas por resgates, entradas por depósitos em metas). Organizado em duas abas: Entradas e Resgates.

---

## História de usuário

Como **criança**, quero **ver o histórico de como ganhei e gastei minhas moedas**, para que **entenda minha evolução financeira de forma divertida**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Histórico completo (happy path)
**Dado** que há transações registradas
**Quando** acesso a tela Histórico
**Então** exibo `ZodiakTabs` com "Entradas" e "Resgates"
**E** cada aba lista transações ordenadas por data decrescente

### Cenário 2 — Item de transação
**Dado** que vejo um item na lista
**Então** exibo ícone de missão/resgate, descrição, data formatada e valor com cor (verde para entrada, vermelho para saída)

### Cenário 3 — Carregar mais
**Dado** que há mais de 10 transações
**Quando** estou no final da lista
**Então** exibo `ZodiakShowMore` "Ver mais"
**Quando** toco
**Então** mais 10 itens são exibidos

### Cenário 4 — Aba vazia
**Dado** que não há transações na aba ativa
**Então** exibo `ZodiakEmptyState` específico para a aba ("Nenhuma entrada" ou "Nenhum resgate")

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** cada item anuncia: tipo, valor, data
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push de `PKPiggyBankScreen`
- **Saída**: ← back

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Histórico | Derivado dos eventos em `PKMission` e `PKReward` (SwiftData) + depósitos em metas | SwiftData |

> **Nota de design**: Criar modelo auxiliar `PKHistoryEntry` (não persistido) derivado das consultas SwiftData.

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakTabs` | Abas Entradas / Resgates |
| `ZodiakShowMore` | Paginação |
| `ZodiakEmptyState` | Aba sem transações |
| `ZodiakEyebrow` | Rótulo de data / seção |
| `ZodiakInfoRow` | Cada linha de transação |
| `ZodiakDivider` | Separador entre itens |

---

## Definition of Done

- [ ] Strings: `pk.history.title`, `pk.history.tab_income`, `pk.history.tab_redeemed`, `pk.history.empty_income`, `pk.history.empty_redeemed`
- [ ] Modelo auxiliar `PKHistoryEntry` especificado (type, description, amount, date)
- [ ] Lógica de paginação simples (slice de array)
- [ ] Implementação pode começar sem ambiguidades
