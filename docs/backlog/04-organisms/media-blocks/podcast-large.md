# PodcastLarge

> **Categoria**: Organism (Media Blocks) · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog

## Contexto
Player completo de podcast: artwork grande + título/autor + scrubber + controles (skip 15s, play, skip +30s) + velocidade.

## Critérios de aceite
- **Composição**: artwork + meta + scrubber (`ZodiakProgressIndicator`) + 3-5 botões + velocidade.
- **Scrubber**: arrastar muda posição.
- **Acessibilidade**: todos controles labeled; scrubber é `adjustable`.
- **Reduce Motion**: sem animações de scrubber suave.
- **Light/Dark**: tokens.

## APIs públicas
- `ZodiakPodcastLarge(item: ZodiakMediaItem, state: ZodiakPlaybackState, onCommand: (ZodiakPlaybackCommand) -> Void)`.

## Boas práticas
- **iOS**: `AVPlayer` + custom UI; integrar com Now Playing Info Center.
- **Android**: Media3 + MediaSession (notificação + Auto/WearOS).

## Referências
- [iOS `ZodiakMediaBlocks.swift` (ZodiakPodcastLarge)](../../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/Media/ZodiakMediaBlocks.swift)

## DoD
- [ ] Scrubber acessível.
- [ ] Background playback.
- [ ] Ver [README família](README.md).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
