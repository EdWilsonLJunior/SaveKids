# Escolha de Unidade — Step 2 de 3

> **Épico**: Provisionamento de Saque
> **US-ID**: US-29.05
> **Tela nº**: 5 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Segunda etapa do fluxo de reserva. O usuário escolhe em qual unidade bancária realizará o saque. A lista de unidades foi pré-carregada no Dashboard (prefetch), mas pode ser recarregada aqui caso tenha falhado. O usuário pode filtrar pelo nome da unidade via campo de busca.

---

## História de usuário

Como **correntista**, quero **escolher a unidade bancária onde realizarei o saque**, para que **o caixa da unidade esteja preparado com o valor reservado**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Fluxo principal (happy path)
**Dado** que estou na tela Escolha de Unidade (step 2/3)
**E** a lista de unidades foi carregada com sucesso
**Quando** seleciono uma unidade via `ZodiakRadioButton`
**E** toco em "Próximo"
**Então** navego para a tela Confirmação (step 3/3)
**E** a unidade selecionada é armazenada no `WPReserveViewModel`

### Cenário 2 — Estados de carregamento
**Dado** que as unidades ainda estão sendo buscadas (prefetch pendente ou retry)
**Quando** a tela é exibida
**Então** exibo `ZodiakSkeletonLoader` no lugar da lista
**E** o botão "Próximo" fica desabilitado

### Cenário 3 — Busca / filtro
**Dado** que há 15 unidades na lista
**Quando** digito "Centro" no `ZodiakSearchField`
**Então** a lista é filtrada em tempo real para mostrar apenas unidades com "Centro" no nome
**E** se nenhuma unidade corresponder, exibo `ZodiakEmptyState` com mensagem "Nenhuma unidade encontrada"

### Cenário 4 — Estado de erro
**Dado** que o prefetch falhou e a lista está vazia
**Quando** a tela é exibida
**Então** exibo `ZodiakNotice` com `.error`, mensagem "Não foi possível carregar as unidades" e botão "Tentar novamente"
**Quando** toco "Tentar novamente"
**Então** disparo `WPMockService.fetchUnits()` novamente com skeleton durante o carregamento

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** `ZodiakStepIndicator` anuncia "Passo 2 de 3: Unidade"
**E** cada `ZodiakRadioButton` anuncia nome e endereço da unidade, e estado ("selecionado" / "não selecionado")
**E** `ZodiakSearchField` anuncia "Buscar unidade, campo de busca"
**E** em dark mode, seleção usa `Zodiak.colors.actionPrimary` sem hardcode

---

## Spec de tela

### Navegação
- **Entrada**: push a partir de `WPReserveValueScreen`
- **Saída**: → `WPConfirmationScreen` (push, após seleção confirmada)
- **Parâmetros recebidos**: `units: [WPUnit]` (via `WPReserveViewModel` compartilhado)

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Lista de unidades | `WPReserveViewModel.units` (prefetchado ou lazy) | em memória |
| Unidade selecionada | `WPReserveViewModel.selectedUnit` | em memória (até confirmação) |
| Query de busca | `@State var searchQuery: String` | em memória |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakStepIndicator` | Indicador de progresso "2 de 3" |
| `ZodiakSearchField` | Filtro por nome da unidade |
| `ZodiakRadioButton` | Seleção de unidade (única) |
| `ZodiakSkeletonLoader` | Placeholder durante carregamento |
| `ZodiakEmptyState` | Nenhuma unidade encontrada na busca |
| `ZodiakNotice` | Erro de carregamento com retry |
| `ZodiakInfoRow` | Endereço e horário de cada unidade |
| `ZodiakButton` | Botão "Próximo" (desabilitado se nenhuma unidade selecionada) |

### Estados da tela
- `loading` — buscando unidades
- `success(units)` — lista exibida
- `empty` — sem resultados para a busca
- `error(message)` — falha no carregamento

### Validações
- Botão "Próximo" habilitado apenas quando `selectedUnit != nil`

---

## Boas práticas — iOS

- Filtro aplicado com `Binding` sobre `WPReserveViewModel.units` filtrado por `searchQuery` — sem refetch
- `ZodiakRadioButton` em lista usa `ForEach` com `id: \.id` para performance
- A tela reutiliza o `WPReserveViewModel` passado como `@EnvironmentObject`

---

## Referências

- [finalBacklog.md — Projeto 1](../../raw_pdf/finalBacklog.md)
- [US-29.04 — Reserva de Valor](us-04-reserve-value.md) — tela anterior
- [US-29.06 — Confirmação](us-06-confirmation.md) — próximo passo

---

## Gaps e dúvidas

- Definir campos de `WPUnit`: id, name, address, city, openingHours?
- Quantas unidades no mock? Proposto: 12 unidades em 3 cidades diferentes.

---

## Definition of Done

- [ ] História revisada pelo time
- [ ] Critérios de aceite aprovados
- [ ] Componentes DS mapeados
- [ ] Strings: `wp.unit_picker.title`, `wp.unit_picker.step_label`, `wp.unit_picker.search_placeholder`, `wp.unit_picker.empty_title`, `wp.unit_picker.empty_subtitle`, `wp.unit_picker.error`, `wp.unit_picker.retry`, `wp.unit_picker.action_next`
- [ ] Schema de `units_mock.json` definido
- [ ] Implementação pode começar sem ambiguidades
