# ZodiakVideoPreviewCard — Implementação Futura

> **Status**: Pendente — lógica documentada, componente não criado.  
> **Motivação**: A `VideoPreviewButtonGalleryView` ainda gere estado e lógica AVPlayer diretamente. Este Molecule encapsularia tudo isso.

---

## Problema atual (VideoPreviewButtonGalleryView)

A Gallery tem hoje, fora do componente DS:

| State / Lógica | Onde deveria estar |
|---|---|
| `realVideoPlayer: AVPlayer?` | Molecule |
| `isRealVideoPlaying: Bool` | Molecule |
| `videoProgress: Double` | Molecule |
| `progressObserver: Any?` | Molecule |
| `loadRealVideo() async` | Molecule |
| `restartVideo()` | Molecule |
| `.task`, `.onChange`, `.onDisappear` | Molecule |
| `showProgressRing: Bool` | parâmetro do caller |

---

## API proposta

```swift
// Layer: Molecule
// Path: Shared/DesignSystem/Molecules/VideoPreview/ZodiakVideoPreviewCard.swift

struct ZodiakVideoPreviewCard: View {
    let url: URL
    var showProgressRing: Bool = true
    var aspectRatio: CGFloat = 16 / 9

    // interno — não exposto
    @State private var player: AVPlayer?
    @State private var isPlaying: Bool = false
    @State private var progress: Double = 0.0
    @State private var observer: Any?
}
```

### Uso na Gallery

```swift
// Antes (27 linhas de lógica na Gallery):
ZStack(alignment: .bottomTrailing) {
    Group {
        if let player = realVideoPlayer { ... }
        else { ... ZodiakSpinner() }
    }
    ZodiakVideoPreviewButton(
        isPlaying: $isRealVideoPlaying,
        progress: videoProgress,
        action: {},
        showRing: showProgressRing
    )
    .padding(ZodiakSpacing.twoXSmall)
}
.task { await loadRealVideo() }
.onChange(of: isRealVideoPlaying) { ... }
// + loadRealVideo(), restartVideo(), states...

// Depois (1 linha):
ZodiakVideoPreviewCard(url: url, showProgressRing: showProgressRing)
```

---

## Comportamentos internos

- **Carregamento assíncrono**: `AVURLAsset.load(.isPlayable)` off-main via `async/await` — sem bloquear UI
- **Spinner de loading**: `ZodiakSpinner()` enquanto `player == nil`
- **Progresso**: `addPeriodicTimeObserver` a cada 0.5s → atualiza `progress`
- **Play/Pause**: `ZodiakVideoPreviewButton(isPlaying:, progress:, showRing:)` posicionado em `.bottomTrailing`
- **Fim do vídeo**: `NotificationCenter.AVPlayerItemDidPlayToEndTime` → pausa e reseta `progress = 0`
- **Cleanup**: `.onDisappear` invalida observer e pausa player
- **Aspect ratio**: `.aspectRatio(aspectRatio, contentMode: .fit)` + `clipShape(RoundedRectangle)`

---

## Componentes Zodiak internos

| Componente | Uso |
|---|---|
| `ZodiakVideoPreviewButton` | Controlo play/pause + anel de progresso |
| `ZodiakSpinner` | Fallback durante carregamento |
| `AVKit.VideoPlayer` | Renderização do vídeo |

---

## Verificação prévia

Antes de criar, verificar se o Zodiak DS já tem um componente equivalente (`VideoCard`, `MediaCard`, `VideoPreview`) — a galeria ainda não chegou a esses componentes de nível Molecule/Organism.

---

## Ficheiros a criar

```
ZodiakiOS/Shared/DesignSystem/Molecules/VideoPreview/
    ZodiakVideoPreviewCard.swift
```

## Ficheiros a atualizar

```
ZodiakiOS/App/Catalog/Components/Atoms/VideoPreviewButtonGalleryView.swift
    — substituir bloco "Vídeo real" pelo novo Molecule
    — remover states: realVideoPlayer, isRealVideoPlaying, videoProgress, progressObserver
    — remover funções: loadRealVideo(), restartVideo()
    — remover imports: AVKit
```
