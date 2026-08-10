# Gerenciar Categorias

> **Épico**: PayFlow
> **US-ID**: US-36.04
> **Tela nº**: 4 de 8
> **Prioridade**: P1
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Gerenciamento de categorias de assinatura. O app vem com categorias padrão (Streaming, Educação, Produtividade, Saúde, Outros). O usuário pode criar categorias customizadas com ícone e cor.

---

## História de usuário

Como **usuário**, quero **organizar minhas assinaturas por categoria**, para que **veja onde gasto mais e identifique padrões**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Lista de categorias (happy path)
**Dado** que acesso a tela Categorias
**Então** exibo lista com ícone, nome, número de assinaturas e gasto mensal total por categoria

### Cenário 2 — Criar categoria
**Dado** que toco em "+ Nova categoria"
**Então** exibo `ZodiakModal` com `ZodiakLabelledField` nome, seletor de emoji (grid) e seletor de cor (ZodiakChipGroup)
**Quando** confirmo
**Então** `PFCategory` é inserido no SwiftData

### Cenário 3 — Editar categoria customizada
**Dado** que faço swipe em uma categoria customizada
**Então** exibo ações "Editar" e "Excluir"
**Se** excluir uma categoria com assinaturas
**Então** exibo `ZodiakAlert` "As assinaturas serão movidas para 'Outros'"

### Cenário 4 — Categoria padrão não pode ser excluída
**Dado** que toco em excluir uma categoria padrão
**Então** não exibo a ação de exclusão (swipe não disponível)

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** cada categoria anuncia: nome, número de assinaturas e total mensal
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push da tela de Assinaturas
- **Saída**: ← back

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Categorias | `@Query(sort: \.name) var categories: [PFCategory]` | SwiftData |
| Assinaturas por categoria | Derivado de `PFSubscription` | SwiftData |

### Categorias padrão (seed)
| Nome | Ícone |
|---|---|
| Streaming | 📺 |
| Educação | 📚 |
| Produtividade | ⚡ |
| Saúde | 🏥 |
| Outros | 📦 |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakModal` | Criar/editar categoria |
| `ZodiakLabelledField` | Nome da categoria |
| `ZodiakAlert` | Aviso de exclusão com assinaturas |
| `ZodiakButton` | "+ Nova categoria" |
| `ZodiakEyebrow` | "Minhas categorias" |
| `ZodiakInfoRow` | Dados de cada categoria |

---

## Definition of Done

- [ ] Strings: `pf.categories.title`, `pf.categories.action_new`, `pf.categories.modal_title`, `pf.categories.field_name`, `pf.categories.action_edit`, `pf.categories.action_delete`, `pf.categories.delete_alert_title`, `pf.categories.delete_alert_message`
- [ ] Lista de categorias padrão documentada com flag `isDefault: Bool`
- [ ] Comportamento de cascade delete especificado
- [ ] Implementação pode começar sem ambiguidades
