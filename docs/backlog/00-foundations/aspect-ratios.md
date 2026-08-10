# Aspect Ratios (tokens)

> **Categoria**: Foundation · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não (gap — ver [GAPS.md](../GAPS.md))

## Contexto
Razões de aspecto canônicas usadas por mídia, cards, banners, vídeos e thumbnails do Zodiak. Centralizar como tokens elimina literais como `16/9` em componentes.

## História de usuário
Como **desenvolvedor**, quero **referenciar aspect-ratios por nome** para que **componentes de mídia/card sigam proporções oficiais sem números mágicos**.

## Critérios de aceite

### Cenário 1 — Catálogo
**Dado** `Zodiak.aspectRatios.*`
**Então** existem ao menos: `video16x9`, `widescreen21x9`, `photo4x3`, `photo3x2`, `square`, `portrait3x4`, `story9x16`.

### Cenário 2 — Uso
**Dado** componente de mídia
**Então** referencia `Zodiak.aspectRatios.video16x9` (nunca `16.0 / 9.0`).

### Cenário 3 — Acessibilidade
**Sem impacto direto** — aspect ratio não afeta a11y, mas conteúdo em razões extremas (9:16) deve permanecer legível em FontScale alto.

### Cenário 4 — Light/Dark
**Sem impacto.**

### Cenário 5 — Paridade
**Dado** o mesmo token
**Então** valor numérico equivalente em iOS e Android.

## Spec técnica

### APIs públicas
- **iOS**: `Zodiak.aspectRatios.<token>` → `CGFloat`.
- **Android**: `ZodiakTheme.aspectRatios.<token>` → `Float`. Aplicar via `Modifier.aspectRatio(ZodiakTheme.aspectRatios.video16x9)`.

### Tokens (canônicos)
- `Zodiak.aspectRatios.video16x9`
- `Zodiak.aspectRatios.widescreen21x9`
- `Zodiak.aspectRatios.photo4x3`
- `Zodiak.aspectRatios.photo3x2`
- `Zodiak.aspectRatios.square`
- `Zodiak.aspectRatios.portrait3x4`
- `Zodiak.aspectRatios.story9x16`

## Boas práticas — iOS
- `.aspectRatio(Zodiak.aspectRatios.video16x9, contentMode: .fill)`.
- Combinar com `.clipped()` para evitar overflow.

## Boas práticas — Android
- `Modifier.aspectRatio(ZodiakTheme.aspectRatios.video16x9)`.
- Coil/Glide: definir aspect ratio no container, não no `ImageRequest`.

## Acessibilidade
- Em `story9x16`, conteúdo textual sobreposto deve ter contraste ≥ AA mesmo em backgrounds claros/escuros.

## Referências
- Não há `ZodiakAspectRatios.swift` hoje — registrar criação como gap G-057.
- Componentes que hoje consomem (após refatoração): [image-block](../04-organisms/image-compositions/image-block.md), [button-video-preview](../02-atoms/button-video-preview.md), [video-banner](../04-organisms/media-blocks/video-banner.md), [carousel](../04-organisms/image-compositions/carousel.md).

## Gaps & dúvidas para o time de Design
- [ ] G-057 — Token de aspect-ratios não existe hoje no iOS; criar `ZodiakAspectRatios.swift`.
- [ ] Lista oficial de aspect-ratios suportados.

## DoD
- [ ] Tokens expostos.
- [ ] Componentes refatorados para consumir tokens.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Disponibilidade
Tokens disponibilizados como **CSS Custom Properties** via `ThemeProvider`. Não há componente React dedicado — os valores são resolvidos automaticamente pela classe de tema no elemento raiz.
> **Nota:** O prefixo exato depende da versão do tema; verifique `tokens.css` do pacote.


### Uso
```tsx
import { ThemeProvider } from '@cg-groupit/zodiak-design-system';

<ThemeProvider defaultTheme="light">
  {/* --zodiak-aspect-ratio-video fica disponível em todo o subárvore */}
  <div style={{ aspect-ratio: 'var(--zodiak-aspect-ratio-video)' }} />
</ThemeProvider>
```

### Acessibilidade
- Use sempre tokens semânticos (ex.: `--zodiak-action-primary-default`) em vez de valores primitivos ou hardcoded.
