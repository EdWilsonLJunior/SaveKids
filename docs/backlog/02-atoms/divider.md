# Divider

> **Categoria**: Atom · **Prioridade**: P0 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Sim

## Contexto
Linha divisória horizontal/vertical entre seções/itens. Espessura via [borders](../00-foundations/borders.md), cor via `colors.borderSubtle`/`borderDefault`.

## História de usuário
Como **desenvolvedor**, quero **separar conteúdo com `ZodiakDivider`** para que **espessura, cor e inset sigam o DS**.

## Critérios de aceite

### Cenário 1 — Orientações
**Dado** `ZodiakDivider(orientation: .horizontal)` e `.vertical`
**Então** renderiza linha correta com espessura `borders.hairline` ou `borders.thin`.

### Cenário 2 — Variantes
**Dado** `inset: .none / .leading / .both`
**Então** padding lateral aplica conforme variante (ex.: dividers em lista com leading inset alinhado com ícone).

### Cenário 3 — Light/Dark
**Dado** dark mode
**Então** cor resolve para variante dark de `borderSubtle`.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** divider é decorativo (`accessibilityHidden`/`contentDescription = null`); não interrompe leitura.

### Cenário 5 — Em listas
**Dado** uso entre itens de `ZodiakList`
**Então** divider respeita o inset definido pela lista.

## Spec técnica

### APIs públicas
- `ZodiakDivider(orientation: ZodiakDividerOrientation = ZodiakDividerOrientation.horizontal, inset: ZodiakDividerInset = ZodiakDividerInset.none, thickness: ZodiakBorderToken = ZodiakBorderToken.hairline, color: ZodiakColor = ZodiakColor.borderSubtle)`.
- Enum `ZodiakDividerOrientation { horizontal, vertical }`, `ZodiakDividerInset { none, leading, trailing, both }`.

### Tokens
- Espessura: `borders.hairline | thin`.
- Cor: `colors.borderSubtle | borderDefault`.

## Boas práticas — iOS
- SwiftUI: `Divider()` (padrão sistema), mas Zodiak usa `Rectangle().fill(...)` com altura/largura controlada para garantir 1px físico.
- HIG: [Layout — Dividers](https://developer.apple.com/design/human-interface-guidelines/layout).

## Boas práticas — Android
- Material 3: `HorizontalDivider` e `VerticalDivider` em `androidx.compose.material3`.
- `HorizontalDivider(modifier, thickness, color)`.
- Acessibilidade: `Modifier.semantics { invisibleToUser() }` (experimental) para esconder do TalkBack.

## Acessibilidade
- Sempre decorativo.
- Não criar dependência semântica (ex.: "depois do divider, status muda" — não funciona para leitores de tela).

## Referências
- [iOS `Atoms/Divider/ZodiakDivider.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Atoms/Divider/ZodiakDivider.swift)
- [Supernova: Divider](../../ZodiakiOS/docs/zodiak-pdf/Divider.md)

## Gaps & dúvidas para o time de Design
- [ ] Inset oficial para listas — token dedicado `Zodiak.spacing.dividerInset*`?

## DoD
- [ ] API única com enums.
- [ ] Snapshot.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Importação
```tsx
import { DividerLine } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `thickness` | `'thin' \| 'thick'` | `'thin'` | Espessura: thin = 0.5 px, thick = 1 px |
| `color` | `'primary' \| 'secondary'` | `'primary'` | Conjunto de tokens de cor |

### Acessibilidade
- Renderiza `<hr>` nativo, que é anunciado como separador por screen readers.
- Use `aria-hidden="true"` apenas se o divisor for puramente decorativo e não separar seções de conteúdo.

### Storybook
- `AllOptions`: grade de espessuras × cores em light/dark
- `Playground`: controles interativos
