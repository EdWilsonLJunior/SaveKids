# Cofrinho Principal

> **Épico**: PocketBank Kids
> **US-ID**: US-34.01
> **Tela nº**: 1 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Tela principal do app. Exibe o saldo de moedas com animação de cofrinho, anel de progresso da meta ativa e botões de acesso rápido às funcionalidades. Design lúdico e colorido para crianças.

---

## História de usuário

Como **criança**, quero **ver meu saldo de moedas e progresso de forma visual e divertida**, para que **eu me motive a completar missões e economizar**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Saldo e progresso (happy path)
**Dado** que acesso o app
**Quando** a tela é exibida
**Então** exibo saldo de moedas via `ZodiakKeyFigures` com ícone 🪙
**E** exibo `PKProgressRing` mostrando progresso da meta ativa (se existir)
**E** exibo botões de acesso rápido: Missões, Metas, Recompensas

### Cenário 2 — Animação de moeda ao ganhar
**Dado** que voltei de completar uma missão
**Quando** a tela é exibida
**Então** executo animação de moeda caindo (`withAnimation(.spring()) { coinOffset = 0 }`)
**E** exibo `ZodiakNotice` "+X moedas ganhas!"

### Cenário 3 — Sem meta ativa
**Dado** que não há metas criadas
**Quando** a tela é exibida
**Então** o espaço do `PKProgressRing` exibe `ZodiakNotice` "Crie uma meta para ver seu progresso"

### Cenário 4 — Avatar do usuário
**Dado** que o avatar foi configurado
**Quando** a tela é exibida
**Então** exibo avatar emoji selecionado no topo com saudação "Olá, [nome]!"

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** `ZodiakKeyFigures` anuncia "Você tem 342 moedas"
**E** `PKProgressRing` anuncia "Meta [nome]: 60% concluída"
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: raiz do `NavigationStack`
- **Saída**: → Missions, Goals, Rewards (QuickAccess) · → Avatar (tap no avatar) · → Ranking, History, Achievements (menu ou botões)

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Saldo de moedas | `@AppStorage("pk.coins")` | UserDefaults |
| Meta ativa | `@Query(sort: \.createdAt) var goals: [PKGoal]` — primeira com progresso incompleto | SwiftData |
| Avatar | `@AppStorage("pk.avatar")` | UserDefaults |
| Nome | `@AppStorage("pk.name")` | UserDefaults |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakKeyFigures` | Saldo de moedas em destaque |
| `ZodiakAvatar` | Avatar emoji do usuário |
| `ZodiakButton` | Botões de acesso rápido |
| `ZodiakNotice` | Moedas ganhas e aviso sem meta |
| `ZodiakEyebrow` | "Sua meta atual" |

### Componentes Customizados (a criar)
| Componente | Descrição |
|---|---|
| `PKProgressRing` | `Circle` + `.trim(from: 0, to: progress)` + animação `.animation(.spring())` |
| `PKCoinAnimation` | Moeda com `.offset(y: coinOffset)` animada ao ganhar moedas |

---

## Boas práticas — iOS

- `PKProgressRing` deve usar `ZodiakTheme.colors.actionPrimary` para o arco ativo — sem hardcode
- Saldo reativo: `@AppStorage("pk.coins")` atualiza automaticamente ao retornar de sub-telas

---

## Definition of Done

- [ ] Strings: `pk.home.greeting`, `pk.home.balance_label`, `pk.home.goal_eyebrow`, `pk.home.no_goal_notice`, `pk.home.coins_earned_notice`, `pk.home.action_missions`, `pk.home.action_goals`, `pk.home.action_rewards`
- [ ] Design de `PKProgressRing` especificado (raio, stroke width, cores por token)
- [ ] Animação de moeda especificada (duração, offset inicial/final)
- [ ] Implementação pode começar sem ambiguidades
