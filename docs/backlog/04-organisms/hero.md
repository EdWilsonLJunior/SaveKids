# Hero

> **Categoria**: Organism · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Bloco principal de topo de tela editorial — imagem grande full-bleed + eyebrow + headline + body + CTA.

## História de usuário
Como **leitor**, quero **um bloco de destaque visual** que **comunique o tema da tela imediatamente**.

## Critérios de aceite

### Cenário 1 — Composição
**Dado** image + eyebrow + headline + body + CTA
**Então** layout vertical mobile, horizontal/imersivo tablet.

### Cenário 2 — Overlay
**Dado** texto sobre imagem
**Então** gradient `heroOverlay` garante AA.

### Cenário 3 — Light/Dark
**Dado** dark
**Então** tokens resolvem; overlay invertido se necessário.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** ordem: headline → eyebrow → body → CTA; imagem descritiva ou decorativa.

### Cenário 5 — Responsivo
**Dado** tablet
**Então** altura/largura adaptam (16:9 → 21:9 ou similar).

## Spec técnica

### APIs públicas
- `ZodiakHero(image: ZodiakImageSource, eyebrow: String? = none, headline: String, body: String? = none, cta: ZodiakBannerAction? = none, overlay: ZodiakHeroOverlay = ZodiakHeroOverlay.auto, height: ZodiakHeroHeight = ZodiakHeroHeight.auto)`.

### Tokens
- Gradient: [gradients.heroOverlay](../00-foundations/gradients.md).
- Tipografia: headline `displayMedium`, eyebrow `labelSmall`.

## Boas práticas — iOS
- HIG: [Layout](https://developer.apple.com/design/human-interface-guidelines/layout).
- Parallax opcional com `GeometryReader`.

## Boas práticas — Android
- `Box { AsyncImage; Spacer; Column overlay }`.
- `CollapsingTopAppBar` quando combinado com scroll (Material 3).

## Acessibilidade
- Headline tem papel heading.
- Imagem com descrição quando informativa.

## Referências
- [iOS `Organisms/Hero/`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/Hero/)

## Gaps & dúvidas para o time de Design
- [ ] Altura oficial por breakpoint?
- [ ] Suporte a vídeo de fundo?

## DoD
- [ ] Overlay legibilidade.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Importação
```tsx
import { Hero } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `title` | `ReactNode` | — | Título da seção (renderizado em `<h1>`) |
| `description` | `string \| ReactNode` | — | Texto descritivo |
| `ctaLabel` | `string` | — | Label do CTA primário |
| `ctaBehavior` | `'openFullscreen' \| 'togglePlayback'` | `'openFullscreen'` | Comportamento do CTA |
| `size` | `'small' \| 'medium' \| 'large'` | `'large'` | Tamanho do hero |
| `backgroundMode` | `'photo' \| 'color' \| 'video'` | — | Modo de fundo |
| `showCta` | `boolean` | `true` | Exibe o botão CTA principal |

### Acessibilidade
- O `<h1>` do hero deve ser o único `<h1>` da página.
- Vídeos de fundo devem respeitar `prefers-reduced-motion`.

### Storybook
- `AllOptions`: tamanhos × modos de fundo × combinações de CTA
- `Playground`: controles interativos com vídeo e foto
