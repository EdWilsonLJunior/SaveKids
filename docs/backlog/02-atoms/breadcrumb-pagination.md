# Breadcrumb / Pagination

> **Categoria**: Atom (Navigation) · **Prioridade**: P2 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Componente combinado para mostrar caminho hierárquico (breadcrumb: Home > Categoria > Item) e/ou paginação numérica (1, 2, 3, … N). Mais comum em apps editoriais/web; em mobile geralmente colapsa para "<" / ">".

## História de usuário
Como **usuário**, quero **entender minha posição na hierarquia** ou **navegar entre páginas** com **controles claros**.

## Critérios de aceite

### Cenário 1 — Breadcrumb
**Dado** `items: ["Home", "Roupas", "Camisas"]`
**Então** renderiza com separadores ">"; último item não é link.

### Cenário 2 — Pagination
**Dado** `current: 3, total: 10`
**Então** renderiza "< 1 ... 3 4 5 ... 10 >"; current destacado.

### Cenário 3 — Overflow
**Dado** breadcrumb com 7 itens em tela mobile
**Então** colapsa intermediários (`Home > … > Camisas`).

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** breadcrumb anunciado como navegação ("Trilha de navegação"); pagination como controle de paginação ("Página 3 de 10").

### Cenário 5 — Hit-target
**Dado** controles em mobile
**Então** ≥ `Zodiak.hitTarget.minimum`.

## Spec técnica

### APIs públicas
- `ZodiakBreadcrumb(items: [ZodiakBreadcrumbItem], onTap: (Int) -> Void)`.
- `ZodiakPagination(current: Binding<Int>, total: Int, visibleRange: Int = Zodiak.defaults.pagination.visibleRange)`.
- Helper conjunto: `ZodiakBreadcrumbPagination` que escolhe ambiente.

### Tokens
- Tipografia: `typography.labelMedium`.
- Cor: link `actionPrimary`, separador `textSecondary`.

## Boas práticas — iOS
- HIG: [Page controls](https://developer.apple.com/design/human-interface-guidelines/page-controls).
- Mobile: muitas vezes substituído por `chevron.backward` + título.

## Boas práticas — Android
- Material 3: não há breadcrumb nativo; pagination tipicamente em `LazyColumn` paginada (Paging 3).
- Para mobile, considerar `BackHandler` + título no top bar.

## Acessibilidade
- Papel `navigation` (`accessibilityHeading`/`semantics { ... }`).
- Página atual marcada como "selecionada".

## Referências
- [iOS `Atoms/Navigation/ZodiakBreadcrumbPagination.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Atoms/Navigation/ZodiakBreadcrumbPagination.swift)

## Gaps & dúvidas para o time de Design
- [ ] Mobile usa breadcrumb? Caso não, focar apenas em pagination.
- [ ] Comportamento de overflow oficial.

## DoD
- [ ] APIs separadas + helper.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
