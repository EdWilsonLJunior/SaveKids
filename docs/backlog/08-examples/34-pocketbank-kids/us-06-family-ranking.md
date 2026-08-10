# Ranking Familiar

> **Épico**: PocketBank Kids
> **US-ID**: US-34.06
> **Tela nº**: 6 de 8
> **Prioridade**: P1
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Lista de membros da família ordenada por moedas acumuladas. Dados mockados em `@AppStorage` (JSON encoded). Posição do usuário atual destacada. Badge de posição (🥇🥈🥉).

---

## História de usuário

Como **criança**, quero **ver minha posição no ranking familiar**, para que **me motive a completar mais missões que meus irmãos**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Lista de ranking (happy path)
**Dado** que há membros no ranking familiar
**Quando** acesso a tela Ranking
**Então** exibo lista ordenada por moedas decrescente
**E** cada item exibe `ZodiakAvatar`, nome, moedas e badge de posição (🥇🥈🥉 para top 3)

### Cenário 2 — Usuário atual destacado
**Dado** que vejo meu próprio item no ranking
**Então** meu card é destacado com `ZodiakBadge` "Você"
**E** exibo barra de progresso até o próximo colocado

### Cenário 3 — Atualizar após ganhar moedas
**Dado** que completei uma missão e ganhei moedas
**Quando** retorno à tela de ranking
**Então** minha posição é recalculada com base no novo saldo
**E** se subi de posição exibo `ZodiakNotice` "Você subiu para X°!"

### Cenário 4 — Família com apenas 1 membro
**Dado** que sou o único membro
**Então** exibo `ZodiakEmptyState` "Convide seus familiares para competir!"

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** cada item anuncia: posição, nome e moedas
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push de `PKPiggyBankScreen`
- **Saída**: ← back

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Ranking | `@AppStorage("pk.family_ranking")` (JSON decodificado) | UserDefaults |
| Meu saldo | `@AppStorage("pk.coins")` | UserDefaults |
| Meu nome | `@AppStorage("pk.name")` | UserDefaults |
| Meu avatar | `@AppStorage("pk.avatar")` | UserDefaults |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakAvatar` | Avatar de cada membro |
| `ZodiakBadge` | Badge "Você" no usuário atual |
| `ZodiakEyebrow` | "Ranking da família" |
| `ZodiakNotice` | Subida de posição |
| `ZodiakEmptyState` | Sem outros membros |
| `ZodiakProgressIndicator` | Progresso até próximo colocado |

---

## Definition of Done

- [ ] Strings: `pk.ranking.title`, `pk.ranking.badge_me`, `pk.ranking.notice_promoted`, `pk.ranking.empty_title`, `pk.ranking.empty_subtitle`
- [ ] Schema mock de `pk.family_ranking` documentado (proposto: 4 membros mockados)
- [ ] Lógica de recálculo de posição ao retornar à tela
- [ ] Implementação pode começar sem ambiguidades
