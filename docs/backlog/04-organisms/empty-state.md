# EmptyState

> **Categoria**: Organism · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Estado vazio (sem dados, sem resultados, sem permissão) com ilustração, mensagem e ação.

## História de usuário
Como **usuário**, quero **entender por que uma seção está vazia** e **o que posso fazer**.

## Critérios de aceite

### Cenário 1 — Variantes
**Dado** `kind: .noData/.noResults/.noPermission/.error`
**Então** ilustração + mensagem padrão.

### Cenário 2 — Ação opcional
**Dado** ação configurada
**Então** botão visível para resolver.

### Cenário 3 — Light/Dark
**Dado** dark
**Então** ilustração com versão dark.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** lê mensagem + ação; ilustração decorativa.

### Cenário 5 — Customização
**Dado** `image: custom`
**Então** overrides default.

## Spec técnica

### APIs públicas
- `ZodiakEmptyState(kind: ZodiakEmptyStateKind = ZodiakEmptyStateKind.noData, title: String, body: String? = none, action: ZodiakAlertAction? = none, image: ZodiakImageSource? = none)`.

### Tokens
- Tipografia: title `titleLarge`, body `bodyMedium`.
- Padding vertical: `spacing.s48`.

## Boas práticas — iOS
- iOS 17+: `ContentUnavailableView` nativo (incorporar tokens Zodiak via custom).

## Boas práticas — Android
- Composable custom; Material 3 não tem componente nativo.

## Acessibilidade
- Mensagem clara e acionável.

## Referências
- [iOS `Organisms/EmptyState/`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/EmptyState/)

## Gaps & dúvidas para o time de Design
- [ ] Ilustrações oficiais (catálogo)?

## DoD
- [ ] Kinds enumerados.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
