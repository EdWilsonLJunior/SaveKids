# VideoAndText

> **Categoria**: Organism (Media Blocks) · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog

## Contexto
Layout combinando vídeo (lateral) + bloco de texto (eyebrow + headline + body + CTA).

## Critérios de aceite
- **Layout**: 50/50 (tablet+), stacked (mobile).
- **Side**: configurável `videoSide: .leading | .trailing`.
- **Reduce Motion**: vídeo não auto-plays; mostra poster.
- **Acessibilidade**: vídeo tem controles; texto navegável.
- **Light/Dark**: tokens.

## APIs públicas
- `ZodiakVideoAndText(video: ZodiakVideoSource, eyebrow: String? = none, headline: String, body: String? = none, cta: ZodiakBannerAction? = none, videoSide: ZodiakMediaSide = ZodiakMediaSide.leading)`.

## Boas práticas
- WindowSizeClass / horizontalSizeClass para alternar layout.

## Referências
- [iOS `ZodiakMediaBlocks.swift` (ZodiakVideoAndText)](../../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/Media/ZodiakMediaBlocks.swift)

## DoD
- [ ] Layout adaptativo.
- [ ] Ver [README família](README.md).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
