# Carousel

> **Categoria**: Organism (Image Compositions) · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog

## Contexto
Slider horizontal com paginação por slide. Mostra `ZodiakSliderCounter` opcional.

## Critérios de aceite
- **Swipe**: muda slide; snapping ao centro.
- **Paginação**: dots ou counter (configurável).
- **Auto-play**: opcional com pausa em hover/foco/Reduce Motion.
- **Acessibilidade**: cada slide acessível; "Slide X de Y" anunciado.
- **Light/Dark**: tokens.

## APIs públicas
- `ZodiakCarousel(items: [ZodiakImageTile], autoplay: Duration? = none, showCounter: Bool = true, onSelect: ((ZodiakImageTile) -> Void)? = none)`.

## Boas práticas
- **iOS**: `TabView(.page)` ou `ScrollView` + `LazyHStack` + paging behavior (iOS 17+).
- **Android**: `HorizontalPager(state)` (Compose Foundation); `PageIndicator` custom.

## Acessibilidade
- Auto-play pausa com VoiceOver/TalkBack/Reduce Motion.
- Swipe nativo entre slides.

## Referências
- [iOS `ZodiakImageCompositions.swift` (ZodiakCarousel)](../../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/ImageCompositions/ZodiakImageCompositions.swift)

## DoD
- [ ] Paging + counter + autoplay pausável.
- [ ] Ver [README família](README.md) e [ARCHITECTURE.md § 8](../../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
