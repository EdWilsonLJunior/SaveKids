# PodcastCard

> **Categoria**: Organism (Media Blocks) · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog

## Contexto
Card compacto de podcast: thumbnail + título + autor + duração + botão play.

## Critérios de aceite
- **Composição**: thumbnail + title + author + duration + `ZodiakMediaButton(.play)`.
- **Estados**: idle / playing / paused (indica visualmente).
- **Acessibilidade**: bloco lido como "Podcast <título> por <autor>, duração X minutos"; botão play separado.
- **Light/Dark**: tokens.

## APIs públicas
- `ZodiakPodcastCard(item: ZodiakMediaItem, isPlaying: Bool = false, onPlayPause: Action)`.

## Boas práticas
- **iOS**: `AVPlayer` para áudio; UI Zodiak.
- **Android**: Media3 (`androidx.media3`) para player engine.

## Referências
- [iOS `ZodiakMediaBlocks.swift` (ZodiakPodcastCard)](../../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/Media/ZodiakMediaBlocks.swift)

## DoD
- [ ] Estados.
- [ ] Ver [README família](README.md).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
