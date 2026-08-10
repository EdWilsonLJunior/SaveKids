# Button Video Preview

> **Categoria**: Atom (Button) · **Prioridade**: P2 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Botão especializado que exibe um preview (thumb estática ou GIF) de um vídeo, com overlay de ícone "play". Tap aciona reprodução.

## História de usuário
Como **usuário**, quero **pré-visualizar um vídeo** antes de **assistir o conteúdo completo**.

## Critérios de aceite

### Cenário 1 — Preview
**Dado** `thumbnail: Image` + `playIcon`
**Então** thumb cobre o container; ícone play centralizado com backdrop glass.

### Cenário 2 — Aspect ratio
**Dado** `aspectRatio: 16/9` (default) ou `1/1`
**Então** container respeita ratio.

### Cenário 3 — Estados
**Dado** `default/pressed/disabled/loading`
**Então** loading mostra spinner sobre thumb; pressed escurece thumb.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** anuncia "Reproduzir vídeo: <descrição>"; thumb decorativa.

### Cenário 5 — Reduce Motion
**Dado** GIF como preview + Reduce Motion ativo
**Então** mostra primeiro frame estático.

## Spec técnica

### APIs públicas
- `ZodiakVideoPreviewButton(thumbnail: Image, accessibilityLabel: String, aspectRatio: Length = Zodiak.aspectRatios.video16x9, duration: String? = none, action: Action)`.

### Implementação
- Container com clipping arredondado (`radii.md`), overlay de `ZodiakMediaButton(.play)`, opcional badge com duração ("2:30").

### Tokens
- Raio: `radii.md`.
- Badge duração: ver [badge](badge.md).

## Boas práticas — iOS
- `AsyncImage` para thumb remota.
- `.accessibilityElement(children: .ignore)` + label customizado.

## Boas práticas — Android
- `AsyncImage` (Coil) + `Box { Image; Icon play overlay }`.
- `Modifier.aspectRatio(16f/9f).clip(RoundedCornerShape(...))`.

## Acessibilidade
- Label semântico com descrição do vídeo.
- Reduce Motion respeitado.

## Referências
- [iOS `Atoms/Button/ZodiakVideoPreviewButton.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Atoms/Button/ZodiakVideoPreviewButton.swift)

## Gaps & dúvidas para o time de Design
- [ ] Variantes (com/sem duração, com/sem badge "live", etc.) — quais oficiais?

## DoD
- [ ] Aspect ratio configurável.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Importação
```tsx
import { ButtonVideoPreview } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `variant` | `'play' \| 'volume'` | `'play'` | Tipo de controle |
| `isPlaying` | `boolean` | `false` | Estado de reprodução |
| `isMuted` | `boolean` | `false` | Estado mudo (variant="volume") |
| `progress` | `number` | — | Progresso 0–1 para anel circular |
| `showRing` | `boolean` | `false` | Exibe anel de progresso |
| `background` | `'onLite' \| 'onHeavy' \| 'onPhoto'` | `'onLite'` | Contexto de superfície |
| `size` | `'mobile' \| 'desktop' \| 'desktopSmallTablet'` | `'desktop'` | Preset responsivo |

### Acessibilidade
- `aria-label` é gerado automaticamente; sobrescreva via `ariaLabel` se necessário.
- Mantenha `isPlaying` sincronizado com o estado real do vídeo.

### Storybook
- `AllOptions`: variantes × superfícies × estados de reprodução
- `Playground`: controles interativos com progresso simulado
