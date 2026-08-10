# ImageBanner

> **Categoria**: Organism (Media Blocks) · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog

## Contexto
Banner full-bleed com imagem + overlay (gradient) + texto/CTA. Variante "estática" do `ZodiakVideoBanner`.

## Critérios de aceite
- **Composição**: imagem + overlay + título + body + CTA.
- **Overlay**: `gradients.heroOverlay` garante AA.
- **Acessibilidade**: imagem com descrição quando informativa; texto tem papel heading.
- **Light/Dark**: tokens.

## APIs públicas
- `ZodiakImageBanner(image: ZodiakImageSource, headline: String, body: String? = none, cta: ZodiakBannerAction? = none, overlay: Bool = true)`.

## Boas práticas
- **iOS**: `AsyncImage` + `LinearGradient` overlay.
- **Android**: `AsyncImage` + `Box { ... Spacer; Column overlay }`.

## Referências
- [iOS `ZodiakMediaBlocks.swift` (ZodiakImageBanner)](../../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/Media/ZodiakMediaBlocks.swift)

## DoD
- [ ] Overlay AA.
- [ ] Ver [README família](README.md).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
