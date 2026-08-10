# Zodiak DS — Fidelity Matrix (iOS / SwiftUI)

> **Última verificação:** 2026-04-30 · **Fonte de verdade:** 48 PDFs em [zodiak-pdf/](zodiak-pdf/) (extraídos via Markitdown).
>
> **Legenda:**
> - ✅ **match** — paridade total (tokens + estados + dimensões + a11y)
> - ⚠️ **partial** — implementado mas com gap conhecido (estados, tokens, ou dimensões faltando)
> - 🔄 **different** — abordagem deliberadamente adaptada à plataforma iOS (com justificativa)
> - ❌ **missing** — componente/spec não implementado
>
> **Status pós-Phase 0** (2026-04-30): 6 P0 fechados, 11 P1 reduzidos para 6 (5 ainda abertos para Phase 4).

---

## 1. Foundations

| Categoria | PDF de referência | iOS Impl | Status | Notas |
|---|---|---|---|---|
| Cores semânticas | [Semantic colors _ Color.pdf](zodiak-pdf/Semantic%20colors%20_%20Color%20_%20Made%20with%20Supernova.pdf) | [ZodiakColors.swift](../ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakColors.swift) | ✅ match | Phase 0 fechou 7 tokens (warning content/hover/pressed/outline, focusOnHeavy, primaryOnPhoto, heroPhotographic, textLinkInverse). |
| Cores primitivas | [Primitive colors _ Color.pdf](zodiak-pdf/Primitive%20colors%20_%20Color%20_%20Made%20with%20Supernova.pdf) | [ZodiakPrimitives.swift](../ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakPrimitives.swift) | ✅ match | Blue/Teal/Neutral/Green/Red/Yellow/Orange ramps + B/W Overlay (Phase 0). |
| Tipografia (sizes) | [Size _ Typography.pdf](zodiak-pdf/Size%20_%20Typography%20_%20Made%20with%20Supernova.pdf) | [ZodiakTypography.swift](../ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakTypography.swift) | ✅ match | 11 estilos básicos + 6 large headings (XL→6XL) + italic + dual weight (300/400). Line-height aplicado no `ZodiakText`. |
| Tipografia (uso) | [Usage _ Typography.pdf](zodiak-pdf/Usage%20_%20Typography%20_%20Made%20with%20Supernova.pdf) | [ZodiakText.swift](../ZodiakiOS/Shared/DesignSystem/Atoms/Text/ZodiakText.swift) | ⚠️ partial | Falta documentação inline de "quando usar cada heading" (Phase 1.5). |
| Spacing | [Spacing.pdf](zodiak-pdf/Spacing%20_%20Made%20with%20Supernova.pdf) | [ZodiakSpacing.swift](../ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakSpacing.swift) | ✅ match | hairline=2 + 3XS-8XL escala completa. |
| Sizing | [Sizing.pdf](zodiak-pdf/Sizing%20_%20Made%20with%20Supernova.pdf) | [ZodiakSizing.swift](../ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakSizing.swift) | ✅ match | T-shirt scale 2XS-12XL + button heights 38/48/56 + icon scale + minTouchTarget 44. |
| Radii | [Radius.pdf](zodiak-pdf/Radius%20_%20Made%20with%20Supernova.pdf) | [ZodiakRadii.swift](../ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakRadii.swift) | ✅ match | XS=4, S=16, M=32, L=999. |
| Shadows | [Shadows.pdf](zodiak-pdf/Shadows%20_%20Made%20with%20Supernova.pdf) | [ZodiakShadows.swift](../ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakShadows.swift) | 🔄 different | SwiftUI `.shadow(...)` não suporta `spread=3px`. Documentado como trade-off conhecido. |
| Borders | [Borders.pdf](zodiak-pdf/Borders%20_%20Made%20with%20Supernova.pdf) | [ZodiakBorders.swift](../ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakBorders.swift) | ✅ match | hairline=0.5, default=1, strong=2. |
| Blurs | [Blurs.pdf](zodiak-pdf/Blurs%20_%20Made%20with%20Supernova.pdf) | [ZodiakBlur.swift](../ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakBlur.swift) | ✅ match | radius=30, overlayRadius=8, pageOverlay rgba(23,26,34,0.4). |
| Gradients | (page interna Color > Overlay) | [ZodiakGradients.swift](../ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakGradients.swift) | ✅ match | brand/marine/azur/orange/overlayDark/overlayMedium/fadeWhiteDown/glass + photoOverlay (Phase 0). |
| Accessibility (color) | [Accessibility _ Color.pdf](zodiak-pdf/Accessibility%20_%20Color%20_%20Made%20with%20Supernova.pdf) | — | ⚠️ partial | Tokens conformes WCAG; falta auditoria automática de contraste runtime. Ver [accessibility-audit.md](accessibility-audit.md). |

---

## 2. Buttons

| Componente | PDF | iOS Impl | Status | Notas |
|---|---|---|---|---|
| Regular Button (overview) | [Overview _ Regular button.pdf](zodiak-pdf/Overview%20_%20Regular%20button%20_%20Made%20with%20Supernova.pdf) | [ZodiakButton.swift](../ZodiakiOS/Shared/DesignSystem/Atoms/Button/ZodiakButton.swift) | ⚠️ partial | Primary/Secondary/Tertiary OK em tamanhos S/M/L. **Gap:** falta variante explicita "with icon trailing" e "icon-only collapse" automática em viewports estreitos. |
| Regular Button — onLite specs | [Specs _ Regular button.pdf](zodiak-pdf/Specs%20_%20Regular%20button%20_%20Made%20with%20Supernova.pdf) | ZodiakButton | ✅ match | Heights 38/48/56, padding horizontal correto. |
| Regular Button — onHeavy specs | [Specs _ Regular button onheavy.pdf](zodiak-pdf/Specs%20_%20Regular%20button%20onheavy%20_%20Made%20with%20Supernova.pdf) | ZodiakButton | ⚠️ partial | Implementado via param `context: .onHeavy`. **Gap:** falta `context: .onPhoto` no `ZodiakButton` (existe em IconButton, MediaButton). |
| Regular Button — onPhoto specs | [Specs _ Regular button onphoto.pdf](zodiak-pdf/Specs%20_%20Regular%20button%20onphoto_%20Made%20with%20Supernova.pdf) | ZodiakButton | ❌ missing | Não há `context: .onPhoto` em ZodiakButton. **P1 — Phase 4.** |
| Regular Button (guidelines) | [Guidelines _ Regular button.pdf](zodiak-pdf/Guidelines%20_%20Regular%20button%20_%20Made%20with%20Supernova.pdf) | — | — | Texto de uso. Validar nos previews/catalog. |
| Icon Button (overview) | [Overview _ Icon button.pdf](zodiak-pdf/Overview%20_%20Icon%20button%20_%20Made%20with%20Supernova.pdf) | [ZodiakIconButton.swift](../ZodiakiOS/Shared/DesignSystem/Atoms/Button/ZodiakIconButton.swift) | ✅ match | 38/48/56 + 3 estilos + 3 contextos. **Phase 0 confirmou correção total.** |
| Icon Button — onLite specs | [Specs _ Icon button onLite.pdf](zodiak-pdf/Specs%20_%20Icon%20button%20onLite%20_%20Made%20with%20Supernova.pdf) | ZodiakIconButton | ✅ match | — |
| Icon Button — onHeavy specs | [Specs _ Icon button onHeavy.pdf](zodiak-pdf/Specs%20_%20Icon%20button%20onHeavy%20_%20Made%20with%20Supernova.pdf) | ZodiakIconButton | ✅ match | — |
| Icon Button — onPhoto specs | [Specs _ Icon button onPhoto.pdf](zodiak-pdf/Specs%20_%20Icon%20button%20onPhoto%20_%20Made%20with%20Supernova.pdf) | ZodiakIconButton | ✅ match | Spec exige bg transparente (rgba 0,0,0,0). Phase 0 já adicionou `actionPrimaryOnPhoto = .clear`. |
| Arrow Button (overview) | [Overview _ Arrow button.pdf](zodiak-pdf/Overview%20_%20Arrow%20button%20_%20Made%20with%20Supernova.pdf) | [ZodiakArrowButton.swift](../ZodiakiOS/Shared/DesignSystem/Atoms/Button/ZodiakArrowButton.swift) | ✅ match | Canvas-based lengthening arrow, 4 tamanhos com strokes proporcionais (1/1.4/1.8/2.8). |
| Arrow Button — onLite specs | [Specs _ Arrow button onlite.pdf](zodiak-pdf/Specs%20_%20Arrow%20button%20onlite%20_%20Made%20with%20Supernova.pdf) | ZodiakArrowButton | ✅ match | actionPrimary → actionPressed no estado pressed. |
| Arrow Button — onHeavy specs | [Specs _ Arrow button onHeavy.pdf](zodiak-pdf/Specs%20_%20Arrow%20button%20onHeavy%20_%20Made%20with%20Supernova.pdf) | ZodiakArrowButton | ✅ match | actionPrimaryOnHeavy → actionPressedOnHeavy. |
| Arrow Button — onPhoto specs | [Specs _ Arrow button onPhoto.pdf](zodiak-pdf/Specs%20_%20Arrow%20button%20onPhoto%20_%20Made%20with%20Supernova.pdf) | ZodiakArrowButton | ✅ match | Mesmo comportamento de onHeavy. |
| Arrow Button (guidelines) | [Guidelines _ Arrow button.pdf](zodiak-pdf/Guidelines%20_%20Arrow%20button%20_%20Made%20with%20Supernova.pdf) | — | — | Texto de uso. |
| Warning Button (overview) | [Overview _ Warning button.pdf](zodiak-pdf/Overview%20_%20Warning%20button%20_%20Made%20with%20Supernova.pdf) | [ZodiakWarningButtons.swift](../ZodiakiOS/Shared/DesignSystem/Atoms/Button/ZodiakWarningButtons.swift) | ⚠️ partial | Primary + Secondary implementados. **Tertiary ainda não.** Phase 0 adicionou 5 tokens detalhados — precisa rollout. |
| Warning Button primary specs | [Specs _ Warning button primary.pdf](zodiak-pdf/Specs%20_%20Warning%20button%20primary%20_%20Made%20with%20Supernova.pdf) | ZodiakWarningButtons | ⚠️ partial | Estados default OK; **hover/pressed ainda não usam tokens detalhados** (warningHover, warningPressed) — usar hoje os tokens novos. |
| Warning Button secondary specs | [Specs _ Warning button secundary.pdf](zodiak-pdf/Specs%20_%20Warning%20button%20secundary%20_%20Made%20with%20Supernova.pdf) | ZodiakWarningButtons | ⚠️ partial | Outline border deveria usar `actionWarningHoverOutline` no hover, `actionWarningPressedOutline` no pressed. **P1 — rollout Phase 4.** |
| Warning Button tertiary specs | [Specs _ Warning button tertiary.pdf](zodiak-pdf/Specs%20_%20Warning%20button%20tertiary%20_%20Made%20with%20Supernova.pdf) | — | ❌ missing | **P1 — Phase 4.** |
| System Warning Button (overview) | [Overview _ System warning button.pdf](zodiak-pdf/Overview%20_%20System%20warning%20button%20_%20Made%20with%20Supernova.pdf) | [ZodiakSystemButtons.swift](../ZodiakiOS/Shared/DesignSystem/Atoms/Button/ZodiakSystemButtons.swift) | ✅ match | — |
| System Warning primary specs | [Specs _ System warning button primary.pdf](zodiak-pdf/Specs%20_%20System%20warning%20button%20primary%20_%20Made%20with%20Supernova.pdf) | ZodiakSystemButtons | ✅ match | — |
| System Warning Secondary specs | [Specs _ System warning button Secondary.pdf](zodiak-pdf/Specs%20_%20System%20warning%20button%20Secondary%20_%20Made%20with%20Supernova.pdf) | ZodiakSystemButtons | ✅ match | — |
| Warning Button (guidelines) | [Guidelines _ Warning button.pdf](zodiak-pdf/Guidelines%20_%20Warning%20button%20_%20Made%20with%20Supernova.pdf) | — | — | Texto de uso. |
| Button guidelines (geral) | [Button guidelines.pdf](zodiak-pdf/Button%20guidelines%20_%20Made%20with%20Supernova.pdf) | — | — | Texto de uso. |
| Media Button onLite | [Overview _ Media button onLite.pdf](zodiak-pdf/Overview%20_%20Media%20button%20onLite%20_%20Made%20with%20Supernova.pdf) | [ZodiakMediaButton.swift](../ZodiakiOS/Shared/DesignSystem/Atoms/Button/ZodiakMediaButton.swift) | ⚠️ partial | Implementado mas sem cobrir todos os 15 ícones de ação especificados (play, pause, stop, mute, fullscreen, etc.). **P1 — Phase 4.** |
| Media Button onHeavy | [Overview _ Media button onHeavy.pdf](zodiak-pdf/Overview%20_%20Media%20button%20onHeavy%20_%20Made%20with%20Supernova.pdf) | ZodiakMediaButton | ⚠️ partial | Idem. |
| Media Button onPhoto | [Overview _ Media button onPhoto.pdf](zodiak-pdf/Overview%20_%20Media%20button%20onPhoto%20_%20Made%20with%20Supernova.pdf) | ZodiakMediaButton | ⚠️ partial | Idem; bg transparente OK. |
| Media Button onLite specs | [Specs _ Media button onLite.pdf](zodiak-pdf/Specs%20_%20Media%20button%20onLite%20_%20Made%20with%20Supernova.pdf) | ZodiakMediaButton | ⚠️ partial | — |
| Media Button onHeavy/onPhoto specs | [Specs _ Media button onHeavy and onPhoto.pdf](zodiak-pdf/Specs%20_%20Media%20button%20onHeavy%20and%20onPhoto%20_%20Made%20with%20Supernova.pdf) | ZodiakMediaButton | ⚠️ partial | — |
| Media Button onPhoto specs | [Specs _ Media button onPhoto.pdf](zodiak-pdf/Specs%20_%20Media%20button%20onPhoto%20_%20Made%20with%20Supernova.pdf) | ZodiakMediaButton | ⚠️ partial | — |

---

## 3. Tabs

| Componente | PDF | iOS Impl | Status | Notas |
|---|---|---|---|---|
| Tabs overview | [Overview _ Tabs.pdf](zodiak-pdf/Overview%20_%20Tabs%20_%20Made%20with%20Supernova.pdf) | [Atoms/Tabs/](../ZodiakiOS/Shared/DesignSystem/Atoms/Tabs) | ⚠️ partial | Estrutura visual OK. **Gap:** PDF descreve tabs com pesos variáveis (medium/large) — não implementado. **P2 — Phase 4.** |
| Tabs darkmode overview | [Overview _ Tabs darkmode.pdf](zodiak-pdf/Overview%20_%20Tabs%20darkmode%20_%20Made%20with%20Supernova.pdf) | Atoms/Tabs/ | ✅ match | Adapta via ZodiakColors. |
| Tabs specs | [Specs _ Tabs.pdf](zodiak-pdf/Specs%20_%20Tabs%20_%20Made%20with%20Supernova.pdf) | Atoms/Tabs/ | ⚠️ partial | Active indicator OK; falta ajuste fino dos paddings em mobile. |
| Tabs guidelines | [Guidelines _ Tabs.pdf](zodiak-pdf/Guidelines%20_%20Tabs%20_%20Made%20with%20Supernova.pdf) | — | — | Texto de uso. |

---

## 4. Layout & Grid

| Componente | PDF | iOS Impl | Status | Notas |
|---|---|---|---|---|
| Layout grid (overview) | [Overview _ Layout grid.pdf](zodiak-pdf/Overview%20_%20Layout%20grid%20_%20Made%20with%20Supernova.pdf) | [ZodiakLayoutGrid.swift](../ZodiakiOS/Shared/DesignSystem/Templates/ZodiakLayoutGrid.swift) | ⚠️ partial | iOS impl usa device idioms (iPhone SE/std/Pro Max, iPad mini/Air/Pro). **PDF define 5 viewports por largura (Desktop large 1920+, Desktop small 1280-1919, Tablet large 992-1279, Tablet 768-991, Mobile 320-767)** — abordagem diferente, ver [ipad-adaptivity-audit.md](ipad-adaptivity-audit.md). |
| Text layout | [Text layout _ Layout grid.pdf](zodiak-pdf/Text%20layout%20_%20Layout%20grid%20_%20Made%20with%20Supernova.pdf) | — | ⚠️ partial | Texto define proporções de coluna para body/headlines em cada viewport. iOS usa `cardMaxWidth=480` e `contentMaxWidth=1024` como aproximação. **Verificação visual ainda pendente.** |

---

## 5. Color (Introduction)

| Página | PDF | Status |
|---|---|---|
| Introduction _ Color | [Introduction _ Color.pdf](zodiak-pdf/Introduction%20_%20Color%20_%20Made%20with%20Supernova.pdf) | Texto introdutório. ✅ ciente. |
| Color _ Typography | [Color _ Typography.pdf](zodiak-pdf/Color%20_%20Typography%20_%20Made%20with%20Supernova.pdf) | Mapeamento de cores semânticas para texto. ✅ refletido em `ZodiakColors.text*` + `ZodiakTextColor`. |

---

## 6. Resumo de Status

| Camada | ✅ match | ⚠️ partial | 🔄 different | ❌ missing | Total |
|---|---|---|---|---|---|
| Foundations | 11 | 1 | 1 | 0 | 13 |
| Buttons | 12 | 8 | 0 | 2 | 22 |
| Tabs | 1 | 2 | 0 | 0 | 3 |
| Layout & Grid | 0 | 2 | 0 | 0 | 2 |
| Color (intro) | 2 | 0 | 0 | 0 | 2 |
| **TOTAL** | **26** | **13** | **1** | **2** | **42** |

> 2 páginas de PDF são pure-text (guidelines), não contam como components.

**Cobertura efetiva (match + different aceito):** 27/42 = **64%** com paridade total.
**Conformidade parcial:** 13/42 = 31% com gaps documentados (Phase 4).
**Faltantes:** 2/42 = 5% — Warning Tertiary, ZodiakButton onPhoto context.

---

## 7. Gaps abertos (consolidação)

### P1 (alto valor, candidatos a Phase 4)
1. **ZodiakButton com `context: .onPhoto`** — paridade com Specs Regular Button onPhoto.
2. **ZodiakWarningButton.tertiary** — variant ausente.
3. **Rollout dos tokens warning detalhados** (warningHover/Pressed/Outline) em ZodiakWarningButtons.
4. **ZodiakMediaButton — 15 ícones de ação** (play, pause, mute, fullscreen, replay, etc.).
5. **Tabs com peso variável** (medium/large per PDF Overview Tabs).

### P2 (refinamento)
1. ZodiakLayoutGrid — alinhar com 5 viewports do PDF (não device idiom).
2. ZodiakButton — variante "icon trailing" e auto-collapse "icon-only" em viewports estreitos.
3. Documentação inline de uso de typography em ZodiakText (quando usar `.headline2XL` vs `.headline`).
4. Auditoria de contraste WCAG 2.1 AA em runtime para tokens warning.

### P3 (nice to have)
1. Snapshot tests light/dark/AX1/AX5/iPad/en/pt-BR (Phase 5).
2. Workaround de `spread=3px` em shadows para componentes que precisem de paridade pixel-perfect.

---

## 8. Como manter este documento

1. Sempre que um PDF Zodiak for atualizado, rode `bash scripts/extract_zodiak_pdfs.sh` para regerar `docs/zodiak-pdf/_extracted/*.txt`.
2. Compare o diff do `.txt` com o estado anterior para identificar mudanças de spec.
3. Atualize a coluna **Status** + linha de notas para o componente afetado.
4. Se um gap for fechado, mova-o de "Gaps abertos" para a tabela principal com status ✅.

---

*Este documento é a verdade canônica de paridade entre o Zodiak DS e a impl iOS. Markdowns externos (zodiak-doc) podem estar desatualizados.*
