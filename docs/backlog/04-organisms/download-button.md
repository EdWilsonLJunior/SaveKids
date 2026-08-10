# DownloadButton

> **Categoria**: Organism · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Botão multistate que reflete ciclo de download/upload: idle → downloading (progresso) → success/error. Animação inline.

## História de usuário
Como **usuário**, quero **acompanhar progresso de download** sem **sair da tela**.

## Critérios de aceite

### Cenário 1 — Estados
**Dado** `state: .idle/.queued/.downloading(progress)/.completed/.failed`
**Então** visual correto: ícone → progresso circular → check → error.

### Cenário 2 — Cancelamento
**Dado** estado downloading
**Quando** toco
**Então** cancela; volta a idle.

### Cenário 3 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** anuncia estado e progresso; LiveRegion para mudanças.

### Cenário 4 — Reduce Motion
**Dado** Reduce Motion ativo
**Então** progresso atualiza por chunks (não suave).

### Cenário 5 — Light/Dark
**Dado** dark
**Então** tokens resolvem.

## Spec técnica

### APIs públicas
- `ZodiakDownloadButton(state: ZodiakDownloadState, onStart: Action, onCancel: Action, onRetry: Action, accessibilityLabel: String = "Download")`.

### Tokens
- Cor: `actionPrimary` / `statusSuccess` / `statusError`.
- Tamanho: `sizing.buttonIconLarge`.

## Boas práticas — iOS
- SwiftUI: `ZStack { Circle progress; Icon }`; `withAnimation` ou `.animation(.linear, value: progress)`.

## Boas práticas — Android
- `Box { CircularProgressIndicator(progress); Icon }`.

## Acessibilidade
- Progresso anunciado em chunks de 10%.
- Estado final ("Download concluído" / "Falhou").

## Referências
- [iOS `Organisms/DownloadButton/`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/DownloadButton/)

## Gaps & dúvidas para o time de Design
- [ ] Variante linear (progress bar) — necessária?

## DoD
- [ ] Estados completos.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Importação
```tsx
import { ButtonDownload } from '@cg-groupit/zodiak-design-system';
import type { DownloadItem } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `downloads` | `DownloadItem[]` | — | Lista de arquivos (obrigatório) |
| `size` | `TriggerSize` | — | Tamanho do botão gatilho |
| `disabled` | `boolean` | `false` | Estado desabilitado |
| `placement` | `string` | `'bottom-end'` | Posição do popover (floating-ui) |
| `overflowBehavior` | `'self' \| 'page'` | `'self'` | Controle de overflow do popover |

### Acessibilidade
- O popover usa `role="menu"` com `role="menuitem"` para cada arquivo.
- Downloads em nova aba incluem indicação visual e textual.

### Storybook
- `AllOptions`: variações de quantidade de arquivos e tipos
- `Playground`: controles interativos com itens configuráveis
