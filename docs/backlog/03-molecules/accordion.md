# Accordion

> **Categoria**: Molecule · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Painel expansível que mostra/oculta conteúdo. Suporta single (apenas um aberto) ou múltiplo (vários abertos simultaneamente).

## História de usuário
Como **usuário**, quero **revelar/ocultar conteúdo secundário** sem **rolar páginas longas**.

## Critérios de aceite

### Cenário 1 — Expansão
**Dado** accordion fechado
**Quando** toco no header
**Então** abre com animação 200ms; chevron rotaciona.

### Cenário 2 — Modo
**Dado** `mode: .single`
**Então** abrir um fecha o anterior automaticamente.

### Cenário 3 — Estados
**Dado** `expanded/collapsed/disabled`
**Então** corretos.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** anuncia "<título>, recolhido/expandido, toque duplo para alternar"; conteúdo dentro só foca se expandido.

### Cenário 5 — Reduce Motion
**Dado** Reduce Motion ativo
**Então** transição instantânea.

## Spec técnica

### APIs públicas
- `ZodiakAccordion(title: String, content: Slot, isExpanded: Binding<Bool>, leadingIcon: ZodiakIcon? = none, surface: ZodiakSurface = ZodiakSurface.onLite)`.
- `ZodiakAccordionGroup(items: [ZodiakAccordionItem], mode: ZodiakAccordionMode = ZodiakAccordionMode.multiple)`.

### Tokens
- Divider entre header e conteúdo: `borderSubtle`.
- Padding header: `spacing.s16`. Chevron: `iconMd`.

## Boas práticas — iOS
- SwiftUI: `DisclosureGroup("title") { content }` nativo, customizado com `.disclosureGroupStyle(...)`.

## Boas práticas — Android
- Compose: `Column { Row(clickable) { Text; Icon(chevron) }; AnimatedVisibility(visible = expanded) { content } }`.
- `animateContentSize()` para expansão suave.

## Acessibilidade
- Papel `button` no header + `accessibilityHint` "abre/fecha".
- Conteúdo oculto: removido da árvore de a11y quando recolhido.

## Referências
- [iOS `Molecules/Accordion/ZodiakAccordion.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Molecules/Accordion/ZodiakAccordion.swift)

## Gaps & dúvidas para o time de Design
- [ ] Ícone leading (sem ícone, com ícone) — variantes oficiais?

## DoD
- [ ] Single + multiple.
- [ ] Reduce motion.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Importação
```tsx
import { Accordion } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `title` | `string` | — | Rótulo do cabeçalho (obrigatório) |
| `children` | `ReactNode` | — | Conteúdo do painel |
| `initialOpen` | `boolean` | `false` | Aberto na primeira renderização |
| `grouped` | `boolean` | `false` | Modo agrupado (bordas ajustadas para stack) |
| `background` | `'default' \| 'secondary' \| 'none'` | `'default'` | Tratamento de fundo |
| `onToggle` | `(isOpen: boolean) => void` | — | Callback com novo estado |

### Acessibilidade
- Usa padrão ARIA `role="button"` no gatilho + `aria-expanded` + `aria-controls`.
- O painel tem `id` associado ao `aria-controls` do gatilho.

### Storybook
- `AllOptions`: single × grouped × backgrounds
- `Playground`: controles interativos com estado inicial configurável
