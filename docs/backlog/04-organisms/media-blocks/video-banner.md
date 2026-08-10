# VideoBanner

> **Categoria**: Organism (Media Blocks) · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog

## Contexto
Banner com vídeo de fundo (loop, muted) ou preview clicável. Overlay com título + CTA.

## Critérios de aceite
- **Loop muted**: vídeo decorativo loops sem som.
- **Preview clicável**: tap abre player full-screen.
- **Reduce Motion**: loop desabilita; mostra poster frame estático.
- **Acessibilidade**: descrição via `accessibilityLabel`; controles para reduzir movimento.
- **Light/Dark**: overlay garante AA.

## APIs públicas
- `ZodiakVideoBanner(source: ZodiakVideoSource, mode: ZodiakVideoBannerMode = ZodiakVideoBannerMode.loopMuted, overlay: ZodiakVideoBannerOverlay? = none, onTap: Action? = none)`.

## Boas práticas — iOS
- `AVPlayerLayer` em `UIViewRepresentable` ou `VideoPlayer` (SwiftUI iOS 14+).

## Boas práticas — Android
- Media3 `PlayerView` com auto-play muted; respeitar AccessibilityManager para Reduce Motion.

## Referências
- [iOS `ZodiakMediaBlocks.swift` (ZodiakVideoBanner)](../../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/Media/ZodiakMediaBlocks.swift)

## DoD
- [ ] Reduce motion fallback.
- [ ] Ver [README família](README.md).


## Boas práticas — React/Web

### Importação
```tsx
import { VideoBanner } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `title` | `ReactNode` | — | Título da seção |
| `description` | `string \| ReactNode` | — | Texto descritivo |
| `ctaLabel` | `string` | — | Label do CTA |
| `mode` | `'none' \| 'autoplay'` | `'none'` | Modo de reprodução automática |
| `showCta` | `boolean` | `true` | Exibe botão CTA |

### Acessibilidade
- Vídeo em autoplay deve ter `muted` e sem `prefers-reduced-motion` ativo.
- O título deve ser o heading correto para a hierarquia da página.

### Storybook
- `AllOptions`: modos de vídeo × variações de CTA
- `Playground`: controles interativos
