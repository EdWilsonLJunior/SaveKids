# Specs - Card standard

Show an image with short text and a link for quick navigation.

## Properties

| Property | Type | Values / Notes |
| --- | --- | --- |
| Viewport | Enum | Desktop, Desktop small, Tablet, Mobile |
| Variant | Enum | Regular, Tall |
| Show eyebrow | Boolean | true / false |
| Headline | Text | String curta, orientada a ação |
| CTA label | Text | Preferir rótulo descritivo do destino |

## Size and responsiveness

Os cards Regular e Tall possuem comportamento responsivo e se ajustam ao layout disponível por viewport.

## Used component sizes

| Element | Desktop | Desktop small | Tablet | Mobile |
| --- | --- | --- | --- | --- |
| Eyebrow | M | M | M | S |
| Button (tertiary) | M | M | M | S |

## Typography

### Regular card

| Item | Desktop | Desktop small | Tablet | Mobile |
| --- | --- | --- | --- | --- |
| Headline | heading-m-400-regular | heading-m-400-regular | heading-s-400-regular | heading-s-400-regular |

### Tall card

| Item | Desktop | Desktop small | Tablet | Mobile |
| --- | --- | --- | --- | --- |
| Headline | heading-m-400-regular | heading-m-400-regular | heading-m-400-regular | heading-s-400-regular |

## Placement

- Pode ser usado ao longo da página, entre blocos de conteúdo.
- Evitar posicionamento isolado no topo da página sem contexto.

## Character limits

| Item | Max chars (aprox.) |
| --- | --- |
| Headline | ~80 |
| CTA label | ~30 |
| Eyebrow | ~30 |

## Color guidance

### Background

| Hex | Usage |
| --- | --- |
| #ffffff | Light surface |
| #12151d | Dark surface |

### Text

| Hex | Usage |
| --- | --- |
| #171a22 | Text primary on light |
| #f8fafc | Text primary on dark |

### Image treatment

| Value | Usage |
| --- | --- |
| rgba(255,255,255,0) | Overlay light baseline |
| rgba(0,0,0,0.1) | Overlay darkening for readability |

### CTA button

| Hex | Usage |
| --- | --- |
| #1d365a | Action Primary Default onLite |
| #ffffff | Light action text/contrast case |

## Notes for Carousel integration

Quando o Card standard for usado dentro de carrossel:

- Desktop: até 3 cards por visão, com o 3o parcialmente visível.
- Desktop small / Tablet large: até 2 cards por visão, com o 2o parcialmente visível.
- Tablet / Mobile: 1 card por visão.
- Em desktop-family, o texto de suporte pode surgir em hover e expandir card.
- Em tablet/mobile, não depende de hover.

## Referências oficiais

- Card standard Overview: https://doc-zodiak.capgemini.com/latest/components/containers/cards/card-standard/overview-oZE9c5qV
- Card standard Specs: https://doc-zodiak.capgemini.com/latest/components/containers/cards/card-standard/specs-QWD1eIwG
- Card standard Guidelines: https://doc-zodiak.capgemini.com/latest/components/containers/cards/card-standard/guidelines-F8gXPgWY
- Carousel Overview: https://doc-zodiak.capgemini.com/latest/compositions/image-layouts/carousel/overview-NVSMKuBo
- Carousel Specs: https://doc-zodiak.capgemini.com/latest/compositions/image-layouts/carousel/specs-rPhjUZ47
- Carousel Guidelines: https://doc-zodiak.capgemini.com/latest/compositions/image-layouts/carousel/guidelines-Am7LHH8N
