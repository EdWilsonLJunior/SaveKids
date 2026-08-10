# Button Media

> **Categoria**: Atom (Button) · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Botão para controles de mídia (play, pause, replay, mute, fullscreen). Visualmente próximo do `IconButton`, mas com semântica e estilos próprios (overlay sobre vídeo, glass/blur background).

## História de usuário
Como **usuário**, quero **controlar reprodução de mídia** com **botões visíveis sobre conteúdo de vídeo/áudio**.

## Critérios de aceite

### Cenário 1 — Ícones de mídia
**Dado** `kind: .play | .pause | .replay | .mute | .unmute | .fullscreen | .exitFullscreen`
**Então** ícone correto + label acessível padrão.

### Cenário 2 — Backdrop
**Dado** overlay sobre vídeo
**Então** botão usa fundo translúcido/blur (Material/Glass) para garantir AA.

### Cenário 3 — Estados
**Dado** `default/pressed/disabled`
**Então** estados visuais corretos.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** anuncia "Reproduzir / Pausar / ..."; estado lido após ação (play ↔ pause).

### Cenário 5 — Hit-target
**Dado** controle compacto
**Então** ≥ `Zodiak.hitTarget.minimum`.

## Spec técnica

### APIs públicas
- `ZodiakMediaButton(kind: ZodiakMediaButtonKind, size: ZodiakButtonSize = ZodiakButtonSize.medium, backdrop: ZodiakMediaBackdrop = ZodiakMediaBackdrop.glass, isEnabled: Bool = true, action: Action)`.

### Implementação
- Internamente wrapper sobre `ZodiakIconButtonImpl` com ícone pre-definido por `kind` e backdrop translúcido.

### Tokens
- Backdrop: ver [blurs](../00-foundations/blurs.md) (`Material.ultraThin`/`thin`).
- Ícone: branco com `colors.iconOnPhoto`.

## Boas práticas — iOS
- SwiftUI: `Material.ultraThinMaterial` em `.background()` para glass.
- HIG: [Players](https://developer.apple.com/design/human-interface-guidelines/playing-video).
- `AVPlayerViewController` usa controles nativos — `ZodiakMediaButton` é para player custom.

## Boas práticas — Android
- Material 3: não há "media button" nativo; combinar `IconButton` + `Modifier.background(Zodiak.colors.scrimBase.copy(alpha = Zodiak.opacity.scrim), CircleShape)` ou `Modifier.blur(Zodiak.blurs.light)` (Android 12+).
- Para player: Media3 (`androidx.media3.ui.PlayerView`) integra controles nativos.

## Acessibilidade
- Labels semânticos: "Reproduzir", "Pausar" — anunciar estado após toggle.
- Hit-target.

## Referências
- [iOS `Atoms/Button/ZodiakMediaButton.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Atoms/Button/ZodiakMediaButton.swift)

## Gaps & dúvidas para o time de Design
- [ ] Backdrop padrão: glass, sólido translúcido, ou nenhum?
- [ ] Variante "sem backdrop" (botão direto sobre vídeo)?

## DoD
- [ ] Kinds enumerados.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Importação
```tsx
import { ButtonVideoPreview } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `variant` | `'play' \| 'volume'` | `'play'` | Comportamento do botão |
| `isPlaying` | `boolean` | `false` | Estado atual de reprodução |
| `progress` | `number` | — | Progresso 0–1 para o anel circular |
| `showRing` | `boolean` | `false` | Exibe anel de progresso (variant="play") |
| `background` | `'onLite' \| 'onHeavy' \| 'onPhoto'` | `'onLite'` | Contexto de superfície |
| `size` | `'mobile' \| 'desktop' \| 'desktopSmallTablet'` | `'desktop'` | Tamanho responsivo |

### Acessibilidade
- `aria-label` é gerado automaticamente com base em `isPlaying`/`isMuted`; sobrescreva com `ariaLabel` se necessário.

### Storybook
- `AllOptions`: variantes play/volume × superfícies × tamanhos
- `Playground`: controles interativos com simulação de progresso
