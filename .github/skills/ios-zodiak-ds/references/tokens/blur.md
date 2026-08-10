# Zodiak DS — Blur (`ZodiakBlur`)

> **Source**: `ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakBlur.swift`
> Last synced: 2026-04-27

Um único blur oficial. Reservado para containers sobre fundos fotográficos.

---

## Tokens

| Token | Value | Use |
|---|---|---|
| `radius` | 30pt | Raio do blur aplicado via `.ultraThinMaterial` |
| `pageOverlay` | `rgba(23, 26, 34, 0.40)` | Overlay escuro aplicado à foto de fundo (passo 1) |
| `colorOverlay` | `rgba(255, 255, 255, 0.05)` | Véu branco translucido no container (passo 2) |

---

## Padrão de uso (2 passos)

```swift
// Passo 1 — na foto de fundo:
Image("photo")
    .overlay(ZodiakBlur.pageOverlay)

// Passo 2 — no container de conteúdo:
VStack { ... }
    .zodiakBlurBackground()  // modifier em ZodiakViewModifiers
```

---

## Regras

<rules>
- Conteúdo sobre blur **sempre** claro: `ZodiakColors.textInverse`, botões claros
- Não substituir as cores especificadas por outras
- Não usar blur sobre fundos de cor sólida (apenas sobre fotografia)
</rules>
