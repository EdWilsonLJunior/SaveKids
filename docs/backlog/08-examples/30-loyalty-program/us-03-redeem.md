# Troca de Pontos

> **Épico**: Programa Fidelidade
> **US-ID**: US-30.03
> **Tela nº**: 3 de 7 (US-30.08 fundida aqui)
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Permite ao usuário trocar pontos por recompensas (produtos, serviços ou desconto em fatura), tanto via navegação direta quanto explorando o catálogo completo ("Browse rewards catalog" na Home). O grid de recompensas é carregado da API mock e pode ser filtrado por categoria. Cada recompensa exibe o custo em pontos e um indicador de disponibilidade (suficiente / insuficiente). A confirmação usa `ZodiakSlideToSubmit`.

---

## História de usuário

Como **cliente**, quero **trocar meus pontos por recompensas do catálogo**, para que **eu obtenha benefícios reais pelo meu relacionamento com a plataforma**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Fluxo principal (happy path)
**Dado** que estou na tela Troca de Pontos com saldo suficiente
**Quando** seleciono uma recompensa com 500 pontos e meu saldo é 1.250
**E** deslizo `ZodiakSlideToSubmit` para confirmar
**Então** `LPMockService.redeem(reward:)` é chamado
**E** saldo atualiza para 750 pontos em `@AppStorage("lp.points")`
**E** transação é adicionada ao `@AppStorage("lp.statement")` como `.redeem`
**E** exibo `ZodiakModal` com confirmação de sucesso e pontos restantes

### Cenário 2 — Carregamento do catálogo
**Dado** que `rewards_mock.json` está sendo buscado
**Quando** a tela abre
**Então** exibo `ZodiakSkeletonLoader` no lugar do grid
**E** o `ZodiakChipGroup` de categorias fica desabilitado durante o carregamento

### Cenário 3 — Pontos insuficientes
**Dado** que seleciono uma recompensa que custa mais pontos que meu saldo
**Então** o card da recompensa exibe `ZodiakStatusChip` "Pontos insuficientes"
**E** o botão de seleção fica desabilitado
**E** `ZodiakSlideToSubmit` não é exibido para esse item

### Cenário 4 — Erro de carregamento
**Dado** que o fetch de `rewards_mock.json` falha
**Então** exibo `ZodiakEmptyState` com título "Catálogo indisponível" e botão "Tentar novamente"

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** cada card anuncia: nome da recompensa, custo em pontos, disponível ou não
**E** `ZodiakChipGroup` anuncia categoria selecionada
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push de `LPHomeScreen` (ação "Trocar") ou via ação "Browse rewards catalog" (anteriormente US-30.08)
- **Saída**: ← back para Home; `ZodiakModal` de sucesso com botão "Voltar ao início"
- **Parâmetros recebidos**: `reward: LPReward?` (pré-selecionado se vindo do catálogo ou detalhe de promoção)

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Catálogo de recompensas | `LPMockService.fetchRewards()` via `rewards_mock.json` | em memória |
| Categorias de filtro | derivadas das recompensas carregadas | em memória |
| Saldo | `@AppStorage("lp.points")` | UserDefaults |
| Extrato | `@AppStorage("lp.statement")` | UserDefaults |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakCardGrid` | Grid 2 colunas de recompensas |
| `ZodiakChipGroup` | Filtro por categoria |
| `ZodiakStatusChip` | "Pontos insuficientes" nos cards indisponíveis |
| `ZodiakSkeletonLoader` | Placeholder do grid |
| `ZodiakEmptyState` | Erro de carregamento |
| `ZodiakSlideToSubmit` | Confirmação do resgate |
| `ZodiakModal` | Sucesso do resgate |
| `ZodiakKeyFigures` | Saldo atual no topo |

### Estados da tela
- `loading` — buscando catálogo
- `success(rewards)` — grid exibido
- `error` — falha no fetch
- `redeeming` — processando resgate

### Validações
- Recompensas com `reward.pointsCost > currentPoints` ficam desabilitadas
- Nenhuma outra validação adicional

---

## Boas práticas — iOS

- `LPRedeemViewModel` recalcula disponibilidade via `computed property` reativa ao `@AppStorage("lp.points")`
- `ZodiakCardGrid` recebe `columns: 2` e aceita view builder de conteúdo customizado

---

## Referências

- [finalBacklog.md — Projeto 2](../../raw_pdf/finalBacklog.md)
- [US-30.02 — Home](us-02-home.md)

---

## Gaps e dúvidas

- Schema de `LPReward`: id, name, description, imageURL, pointsCost, category, type (product/service/discount)?
- Quantas categorias de recompensa? Proposto: Produtos, Descontos, Serviços, Doações.

---

## Definition of Done

- [ ] História revisada, critérios aprovados, componentes mapeados
- [ ] Strings: `lp.redeem.title`, `lp.redeem.balance_label`, `lp.redeem.filter_all`, `lp.redeem.status_insufficient`, `lp.redeem.slide_label`, `lp.redeem.success_title`, `lp.redeem.success_subtitle`, `lp.redeem.error_title`, `lp.redeem.retry`
- [ ] Schema de `rewards_mock.json` definido
- [ ] Implementação pode começar sem ambiguidades
