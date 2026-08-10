# Conquistas

> **Épico**: PocketBank Kids
> **US-ID**: US-34.08
> **Tela nº**: 8 de 8
> **Prioridade**: P1
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Galeria de badges/conquistas. Conquistas desbloqueadas ficam coloridas; bloqueadas ficam com `.opacity(0.3)` e ícone de cadeado. Desbloqueio automático ao atingir marcos (ex: primeira missão, 100 moedas, 5 missões concluídas).

---

## História de usuário

Como **criança**, quero **ver minhas conquistas desbloqueadas e as que ainda posso conquistar**, para que **me motive a continuar usando o app**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Galeria de conquistas (happy path)
**Dado** que existem conquistas no SwiftData
**Quando** acesso a tela Conquistas
**Então** exibo grid de cards com ícone emoji, título e estado visual:
  - Desbloqueada: colorida + data de desbloqueio
  - Bloqueada: `.opacity(0.3)` + ícone 🔒

### Cenário 2 — Detalhes de conquista desbloqueada
**Dado** que toco em uma conquista desbloqueada
**Então** exibo `ZodiakModal` com título, descrição completa e data formatada

### Cenário 3 — Detalhes de conquista bloqueada
**Dado** que toco em uma conquista bloqueada
**Então** exibo `ZodiakModal` com título e dica sobre como desbloquear

### Cenário 4 — Nova conquista desbloqueada
**Dado** que uma ação disparou desbloqueio
**Quando** navego para a tela de Conquistas
**Então** executo animação de destaque (scale + glow) na nova conquista desbloqueada
**E** exibo `ZodiakNotice` "Nova conquista desbloqueada: [nome]!"

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** cada badge anuncia título e estado (desbloqueada ou bloqueada)
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push de `PKPiggyBankScreen`
- **Saída**: ← back

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Conquistas | `@Query var achievements: [PKAchievement]` | SwiftData |

### Marcos de desbloqueio propostos
| Conquista | Gatilho |
|---|---|
| 🌟 Primeira missão | Completar 1 missão |
| 💰 Poupador iniciante | Acumular 50 moedas |
| 🚀 Mestre das missões | Completar 5 missões |
| 🎯 Meta batida | Concluir 1 meta |
| 👑 Rei do ranking | Atingir 1° posição no ranking |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakCardGrid` | Grid de conquistas |
| `ZodiakModal` | Detalhes da conquista |
| `ZodiakNotice` | Nova conquista desbloqueada |
| `ZodiakBadge` | Badge "Novo" na conquista recém-desbloqueada |
| `ZodiakEyebrow` | "Suas conquistas" |
| `ZodiakStatusChip` | X / Y desbloqueadas |

---

## Definition of Done

- [ ] Strings: `pk.achievements.title`, `pk.achievements.eyebrow`, `pk.achievements.status`, `pk.achievements.locked_hint`, `pk.achievements.notice_unlocked`, `pk.achievements.modal_unlocked_date`
- [ ] Lista completa de conquistas + gatilhos documentados
- [ ] Animação de desbloqueio especificada (scale + glow, duração, easing)
- [ ] Implementação pode começar sem ambiguidades
