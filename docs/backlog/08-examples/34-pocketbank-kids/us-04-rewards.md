# Recompensas

> **Épico**: PocketBank Kids
> **US-ID**: US-34.04
> **Tela nº**: 4 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Catálogo de recompensas que a criança pode resgatar com as moedas acumuladas. Recompensas são definidas pela família (carregadas de `rewards_mock.json`). Resgate com confirmação e animação de confetti.

---

## História de usuário

Como **criança**, quero **resgatar recompensas com minhas moedas**, para que **eu seja reconhecida pelo esforço de completar missões**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Catálogo de recompensas (happy path)
**Dado** que há recompensas disponíveis
**Quando** acesso a tela Recompensas
**Então** exibo grid de cards com emoji, nome, custo em moedas e botão "Resgatar"
**E** cards com custo > saldo exibem `ZodiakStatusChip` "Moedas insuficientes" e botão desabilitado

### Cenário 2 — Resgatar recompensa
**Dado** que toco em "Resgatar" com saldo suficiente
**Então** exibo `ZodiakModal` de confirmação com custo e saldo após resgate
**Quando** confirmo
**Então** `pk.coins -= reward.cost` e `reward.isRedeemed = true` no SwiftData
**E** executo animação de confetti (emoji 🎉 animado com offset + opacity + withAnimation)
**E** exibo `ZodiakNotice` "Recompensa resgatada! Fale com seus pais para receber."

### Cenário 3 — Recompensa já resgatada
**Dado** que uma recompensa já foi resgatada
**Então** exibo `ZodiakStatusChip` "Resgatada" e o botão fica desabilitado

### Cenário 4 — Estado vazio
**Dado** que não há recompensas disponíveis
**Então** exibo `ZodiakEmptyState` com ícone 🎁 e título "Nenhuma recompensa disponível"

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** cada card anuncia nome, custo e disponibilidade
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push de `PKPiggyBankScreen`
- **Saída**: ← back

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Recompensas | `@Query var rewards: [PKReward]` | SwiftData |
| Saldo | `@AppStorage("pk.coins")` | UserDefaults |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakCardGrid` | Grid 2 colunas |
| `ZodiakStatusChip` | Moedas insuficientes / Resgatada |
| `ZodiakModal` | Confirmação de resgate |
| `ZodiakButton` | "Resgatar" |
| `ZodiakNotice` | Sucesso e moedas insuficientes |
| `ZodiakEmptyState` | Nenhuma recompensa |
| `ZodiakKeyFigures` | Saldo atual |

---

## Definition of Done

- [ ] Strings: `pk.rewards.title`, `pk.rewards.action_redeem`, `pk.rewards.confirm_title`, `pk.rewards.confirm_subtitle`, `pk.rewards.status_insufficient`, `pk.rewards.status_redeemed`, `pk.rewards.success_notice`, `pk.rewards.empty_title`
- [ ] Schema de `rewards_mock.json` definido (proposto: 6 recompensas de 20–100 moedas)
- [ ] Animação de confetti documentada
- [ ] Implementação pode começar sem ambiguidades
