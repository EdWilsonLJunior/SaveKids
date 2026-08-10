# Missões

> **Épico**: PocketBank Kids
> **US-ID**: US-34.03
> **Tela nº**: 3 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Lista de missões disponíveis para a criança. Missões são definidas pela família e carregadas de `missions_mock.json` (seedadas no SwiftData no primeiro acesso). Cada missão tem título, descrição, recompensa em moedas e status.

---

## História de usuário

Como **criança**, quero **ver e completar missões**, para que **eu ganhe moedas e progrida no app**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Lista de missões (happy path)
**Dado** que há missões no SwiftData
**Quando** acesso a tela Missões
**Então** exibo cards em grid 2 colunas com título, ícone, recompensa (🪙 X) e `ZodiakStatusChip` (Nova / Em progresso / Concluída)

### Cenário 2 — Completar missão
**Dado** que toco em "Concluir" em uma missão com status "Nova" ou "Em progresso"
**Então** exibo `ZodiakModal` de confirmação
**Quando** confirmo
**Então** `mission.status = .completed` no SwiftData
**E** `pk.coins += mission.reward`
**E** executo animação de moeda caindo + `ZodiakNotice` "+X moedas!"

### Cenário 3 — Carregamento inicial (seed)
**Dado** que é o primeiro acesso
**Quando** a tela carrega
**Então** exibo `ZodiakSkeletonLoader` enquanto busco `missions_mock.json` e insiro no SwiftData

### Cenário 4 — Estado vazio
**Dado** que todas as missões foram concluídas
**Então** exibo `ZodiakEmptyState` "Parabéns! Todas as missões foram concluídas" com ícone 🏆

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** cada card anuncia: missão, recompensa em moedas, status
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push de `PKPiggyBankScreen`
- **Saída**: ← back
- **Parâmetros**: nenhum

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Missões | `@Query(sort: \.title) var missions: [PKMission]` | SwiftData |
| Saldo | `@AppStorage("pk.coins")` | UserDefaults |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakCardGrid` | Grid 2 colunas de missões |
| `ZodiakStatusChip` | Nova / Em progresso / Concluída |
| `ZodiakSkeletonLoader` | Placeholder no carregamento inicial |
| `ZodiakEmptyState` | Todas concluídas |
| `ZodiakModal` | Confirmação de conclusão |
| `ZodiakButton` | "Concluir" por missão |
| `ZodiakNotice` | Feedback de moedas ganhas |

---

## Definition of Done

- [ ] Strings: `pk.missions.title`, `pk.missions.action_complete`, `pk.missions.confirm_title`, `pk.missions.coins_earned`, `pk.missions.status_new`, `pk.missions.status_in_progress`, `pk.missions.status_completed`, `pk.missions.empty_title`
- [ ] Schema de `missions_mock.json` definido (proposto: 8 missões com recompensas de 5–20 moedas)
- [ ] Implementação pode começar sem ambiguidades
