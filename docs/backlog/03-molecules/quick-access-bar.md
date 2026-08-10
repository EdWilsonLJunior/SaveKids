# QuickAccessBar

> **Categoria**: Molecule · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Barra horizontal com atalhos rápidos (ícones grandes + label curto). Comum em telas de home / dashboard.

## História de usuário
Como **usuário**, quero **atalhos rápidos para ações frequentes** em um **bloco horizontal compacto**.

## Critérios de aceite

### Cenário 1 — Itens
**Dado** `items: [Item(icon, label, action)]`
**Então** layout horizontal igualmente distribuído ou rolável.

### Cenário 2 — Estados
**Dado** item `pressed/disabled`
**Então** estados visuais.

### Cenário 3 — Light/Dark + superfícies
**Dado** `surface: ZodiakSurface.onPhoto`
**Então** backdrop e cores garantem AA.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** cada item é botão; ícone decorativo; label = texto.

### Cenário 5 — Responsivo
**Dado** itens > largura
**Então** scroll horizontal habilita.

## Spec técnica

### APIs públicas
- `ZodiakQuickAccessBar(items: [ZodiakQuickAccessItem], layout: ZodiakQuickAccessLayout = ZodiakQuickAccessLayout.evenSpacing, surface: ZodiakSurface = ZodiakSurface.onLite)`.

### Tokens
- Ícone: `sizing.iconLg`. Label: `typography.labelSmall`. Padding item: `spacing.s12`.

## Boas práticas — iOS
- `ScrollView(.horizontal)` ou `HStack` com `Spacer`s.

## Boas práticas — Android
- `LazyRow` ou `Row { items.forEach { ... } }`.
- M3 `NavigationBar` é alternativa quando bar é de tela inteira; QuickAccessBar é embed.

## Acessibilidade
- Cada item botão com label.
- Hit-target ≥ `Zodiak.hitTarget.minimum` por item.

## Referências
- [iOS `Molecules/QuickAccessBar/ZodiakQuickAccessBar.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Molecules/QuickAccessBar/ZodiakQuickAccessBar.swift)

## Gaps & dúvidas para o time de Design
- [ ] Especificação visual oficial?
- [ ] Itens com badge — necessário?

## DoD
- [ ] Layout flexível.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
