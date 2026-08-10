# Button Nav

> **Categoria**: Atom (Button) · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Botões de navegação superior — back, close, search, share, etc. — usados em `NavigationBar`/`TopAppBar`. Padronizam ícone, hit-target e label acessível.

## História de usuário
Como **usuário**, quero **botões de navegação consistentes** (voltar, fechar, compartilhar) em **todas as telas**.

## Critérios de aceite

### Cenário 1 — Kinds
**Dado** `kind: .back | .close | .search | .share | .more | .help | .settings | .filter | .edit | .done`
**Então** ícone e label acessível padrão são aplicados.

### Cenário 2 — Posição
**Dado** uso em top bar leading/trailing
**Então** alinha conforme HIG (back/close à esquerda) ou Material (back leading, ações trailing).

### Cenário 3 — Estados
**Dado** `default/pressed/disabled`
**Então** visuais corretos; back desabilitado quando navegação não permite.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** label por kind ("Voltar", "Fechar", ...).

### Cenário 5 — RTL
**Dado** locale RTL + `kind: .back`
**Então** ícone espelha automaticamente.

## Spec técnica

### APIs públicas
- `ZodiakNavBackButton(action:)`, `ZodiakNavCloseButton(action:)`, `ZodiakNavShareButton(action:)`, etc. (uma API por kind para clareza no call-site).
- Internamente todas chamam `ZodiakIconButtonImpl` (style ghost).

### Tokens
- Herda icon button ghost.
- Cor: `colors.iconPrimary` ou `iconOnPrimary` quando em bar colorida.

## Boas práticas — iOS
- HIG: [Navigation bars](https://developer.apple.com/design/human-interface-guidelines/navigation-bars).
- `chevron.backward` (back), `xmark` (close), `square.and.arrow.up` (share).
- Idealmente fornecer modifier `.zodiakNavigationBar(leading:, trailing:)` em template.

## Boas práticas — Android
- Material 3: `TopAppBar(navigationIcon = { ZodiakNavBackButton(...) }, actions = { ... })`.
- `Icons.AutoMirrored.Filled.ArrowBack` (auto-mirror RTL).

## Acessibilidade
- Labels específicos por kind.
- Back é primeiro elemento focável (TalkBack/VoiceOver).

## Referências
- [iOS `Atoms/Button/ZodiakNavButtons.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Atoms/Button/ZodiakNavButtons.swift)

## Gaps & dúvidas para o time de Design
- [ ] Lista oficial completa de kinds de navegação?

## DoD
- [ ] APIs dedicadas por kind.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
