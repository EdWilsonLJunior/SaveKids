# Button Menu

> **Categoria**: Atom (Button) · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Botão que abre um menu contextual (more options / overflow). Tipicamente um icon button com ícone `more_vert` ou `more_horiz`.

## História de usuário
Como **usuário**, quero **acessar ações secundárias via menu** sem **poluir a tela com botões expostos**.

## Critérios de aceite

### Cenário 1 — Abertura
**Dado** toco no botão
**Então** menu (popover/dropdown) abre ancorado ao botão.

### Cenário 2 — Direção do ícone
**Dado** plataforma iOS
**Então** padrão `ellipsis` (horizontal); Android padrão `more_vert`.

### Cenário 3 — Estados
**Dado** `default/pressed/disabled`
**Então** estados visuais corretos.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** anuncia "Mais opções, botão"; ao abrir, foco vai para primeiro item do menu.

### Cenário 5 — Dismiss
**Dado** menu aberto
**Quando** toco fora ou pressiono back/escape
**Então** menu fecha; foco retorna ao botão.

## Spec técnica

### APIs públicas
- `ZodiakMenuButton(items: [ZodiakMenuItem], iconStyle: ZodiakMenuIconStyle = ZodiakMenuIconStyle.platformDefault, size: ZodiakButtonSize = ZodiakButtonSize.medium, accessibilityLabel: String = "Mais opções")`.
- `ZodiakMenuItem(title, icon, isDestructive, action)`.

### Implementação
- Wrapper sobre `ZodiakIconButtonImpl` + popover/dropdown nativo da plataforma.

### Tokens
- Herda icon button.
- Popover: `colors.surface`, `shadows.level3`, `radii.md`.

## Boas práticas — iOS
- SwiftUI: `Menu { Button(...) ... } label: { ... }` (nativo, recomendado).
- HIG: [Menus](https://developer.apple.com/design/human-interface-guidelines/menus).
- Ícone padrão: `ellipsis.circle` (filled) ou `ellipsis`.

## Boas práticas — Android
- Compose: `DropdownMenu(expanded, onDismissRequest) { DropdownMenuItem(...) }`.
- Ícone padrão: `Icons.Default.MoreVert`.
- `Modifier.semantics { contentDescription = "Mais opções" }`.

## Acessibilidade
- Anunciar abertura ("Menu aberto, X itens").
- Itens destrutivos sinalizados ("Excluir, destrutivo").
- Trap focus durante menu aberto.

## Referências
- [iOS `Atoms/Button/ZodiakMenuButton.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Atoms/Button/ZodiakMenuButton.swift)

## Gaps & dúvidas para o time de Design
- [ ] Ícone único multi-plataforma ou diferenciado por OS (HIG vs Material)?

## DoD
- [ ] Menu nativo + items DS-styled.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Importação
```tsx
import { ButtonMenu } from '@cg-groupit/zodiak-design-system';
import type { ButtonMenuOption } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `label` | `string` | `'Make a choice'` | Texto do botão gatilho |
| `options` | `ButtonMenuOption[]` | — | Itens do menu (obrigatório) |
| `size` | `'small' \| 'medium'` | `'medium'` | Tamanho do gatilho |
| `hierarchy` | `'primary' \| 'secondary' \| 'tertiary'` | `'primary'` | Hierarquia visual |
| `onSelect` | `(value: string) => void` | — | Callback de seleção |

### Acessibilidade
- O menu usa padrão ARIA `role="menu"` + `role="menuitem"` com navegação por seta do teclado.
- Fecha ao pressionar `Escape` ou clicar fora.

### Storybook
- `AllOptions`: exemplos de menus com diferentes hierarquias e tamanhos
- `Playground`: controles interativos com opções configuráveis
