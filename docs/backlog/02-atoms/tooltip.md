# Tooltip

> **Categoria**: Atom · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Sim

## Contexto
Tooltip exibe texto curto contextual sobre um elemento, ativado por toque longo (mobile) ou hover (iPad com mouse / desktop).

## História de usuário
Como **usuário**, quero **ver explicação contextual** ao pressionar prolongadamente um ícone **sem sair da tela**.

## Critérios de aceite

### Cenário 1 — Trigger
**Dado** elemento com tooltip
**Quando** mantenho pressionado (long-press) por 500ms
**Então** tooltip aparece próximo ao elemento; dismiss ao soltar.

### Cenário 2 — Posicionamento
**Dado** tooltip próximo a borda
**Então** se ajusta (top → bottom, etc.) para ficar visível; arrow aponta para o trigger.

### Cenário 3 — Light/Dark
**Dado** dark
**Então** tokens resolvem.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack ativo
**Então** texto do tooltip é fornecido via `accessibilityHint` no elemento trigger; usuário não precisa long-press para ouvir.

### Cenário 5 — Auto-dismiss
**Dado** tooltip aberto por 5s sem interação
**Então** fecha automaticamente.

## Spec técnica

### APIs públicas
- Exposto como **modifier/extensão** aplicável a qualquer view-host: `.zodiakTooltip(text: String, position: ZodiakTooltipPosition = ZodiakTooltipPosition.auto)`. A forma concreta (ViewModifier no iOS, Modifier no Android) está em Boas práticas.

### Tokens
- Tipografia: `typography.labelSmall`.
- Cor: fundo `colors.surfaceInverse`, texto `colors.textOnInverse`.
- Raio: `radii.sm`. Sombra: `shadows.level2`.

## Boas práticas — iOS
- iOS 16+: `.help("...")` em macOS Catalyst; mobile precisa custom (`LongPressGesture` + `Popover`).
- HIG: [Tooltips](https://developer.apple.com/design/human-interface-guidelines/tooltips) (macOS-focused).
- `.accessibilityHint(text)` no trigger.

## Boas práticas — Android
- Material 3: `TooltipBox` (`androidx.compose.material3` experimental) — `PlainTooltip` e `RichTooltip`.
- `TooltipBox(positionProvider, tooltip = { PlainTooltip { Text(text) } }, state = rememberTooltipState()) { ... }`.

## Acessibilidade
- Texto disponível via `accessibilityHint` / `contentDescription` mesmo sem o gesto.
- Auto-dismiss respeita `Reduce Motion` (sem fade abrupto).

## Referências
- [iOS `Atoms/Tooltip/ZodiakTooltip.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Atoms/Tooltip/ZodiakTooltip.swift)
- [Supernova: Overview](../../ZodiakiOS/docs/zodiak-pdf/Overview%20-%20Tooltip.md)
- [Supernova: Specs](../../ZodiakiOS/docs/zodiak-pdf/Specs%20-%20Tooltip.md)

## Gaps & dúvidas para o time de Design
- [ ] Variante **rich tooltip** (com title + body + action)?

## DoD
- [ ] Modifier/extensão API.
- [ ] Posicionamento auto.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Importação
```tsx
import { Tooltip } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `content` | `ReactNode` | — | Conteúdo do tooltip (obrigatório) |
| `children` | `ReactNode` | — | Elemento gatilho (obrigatório) |
| `position` | `'top' \| 'bottom'` | `'top'` | Posicionamento preferencial (auto-inverte) |

### Acessibilidade
- O tooltip usa `role="tooltip"` + `aria-describedby` associado ao gatilho.
- Gatilho deve ser focalizável via teclado; o componente adiciona `tabIndex` automaticamente se necessário.
- Evite colocar ações interativas dentro do conteúdo do tooltip.

### Storybook
- `AllOptions`: posições × tipos de gatilho
- `Playground`: controles interativos com conteúdo configurável
