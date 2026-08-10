# Design System Gaps

Registro de lacunas, inconsistências e oportunidades de melhoria identificadas durante auditorias e implementações no ZodiakiOS. Cada gap está acompanhado do status atual e de uma sugestão de resolução.

---

## 1. Templates sem suporte a eyebrow e intro

**Status:** Mitigado (PR deste documento)
**Componentes afetados:** `ZodiakActivityTemplate`, `ZodiakAdaptiveTemplate`, `ZodiakInputOutputTemplate`, `ZodiakListTemplate`

**Problema:** Os templates de feature aceitavam apenas `title: String` e renderizavam `ZodiakText(title, style: .headline)` internamente, ignorando o componente `ZodiakHeadlineSection` já existente no design system. Isso impossibilitava adicionar eyebrow e texto introdutório às páginas.

**Resolução aplicada:** Adicionados parâmetros opcionais `eyebrow: String? = nil` e `intro: String? = nil` a todos os templates. Quando qualquer um deles é fornecido, o template usa `ZodiakHeadlineSection` em vez de `ZodiakText`. Backward-compatible: usos existentes sem esses parâmetros continuam funcionando.

---

## 2. `galleryHeader` não usava `ZodiakHeadlineSection`

**Status:** Mitigado (PR deste documento)
**Arquivo:** `ZodiakiOS/App/Catalog/CatalogGalleryHelpers.swift`

**Problema:** A função `galleryHeader` (usada em todos os ~50 gallery views do catálogo) construía o cabeçalho manualmente com `ZodiakText(.headline)` + `ZodiakText(.body)`, duplicando a lógica já encapsulada em `ZodiakHeadlineSection`. Além disso, não aproveitava a responsividade automática do componente (iPad: 32pt headline / iPhone: 24pt title1).

**Resolução aplicada:** `galleryHeader` agora usa `ZodiakHeadlineSection(title:, intro:, style: .plainWithIntro)`. A linha de referência Figma (específica do catálogo, sem equivalente no DS) foi mantida abaixo do componente.

---

## 3. `TemplatesGalleryView` e `ExamplesListView` não usavam `ZodiakGalleryShell`

**Status:** Mitigado (PR deste documento)
**Arquivos:** `App/Catalog/Components/Templates/TemplatesGalleryView.swift`, `App/Catalog/Examples/ExamplesListView.swift`

**Problema:** Ambas as views replicavam manualmente o padrão `ZStack { ZodiakColors.background.ignoresSafeArea() + ScrollView + VStack }` com `.navigationTitle` e `.navigationBarTitleDisplayMode(.inline)` diretos — violando as regras do catálogo que exigem `ZodiakGalleryShell` como root.

**Resolução aplicada:** Ambas migradas para `ZodiakGalleryShell`. O `header` private var manual foi removido e substituído por `galleryHeader(title:subtitle:)`.

---

## 4. `ExamplesListView` usava chips de componente manuais

**Status:** Mitigado (PR deste documento)
**Arquivo:** `App/Catalog/Examples/ExamplesListView.swift`

**Problema:** Os chips de tags de componente dentro de `exampleCard` eram construídos com `Text + .padding + .background + .cornerRadius`, replicando o visual de `ZodiakChip` sem usar o componente.

**Resolução aplicada:** Substituídos por `ZodiakChip(label: component, isActive: false)`.

---

## 5. `ZodiakListTemplate` usa empty state inline

**Status:** Aberto
**Arquivo:** `ZodiakiOS/Shared/DesignSystem/Templates/ZodiakActivityTemplate.swift`

**Problema:** Quando `items` está vazio, o `ZodiakListTemplate` exibe um estado vazio construído com `Image(systemName: "list.bullet")` + `ZodiakText("Nenhum item", style: .body(color: .secondary))` inline, em vez de usar o componente `ZodiakEmptyState` já disponível no design system.

**Sugestão:** Adicionar parâmetros opcionais `emptyStateIcon`, `emptyStateTitle` e `emptyStateDescription` ao template, e usar `ZodiakEmptyState` internamente quando `items.isEmpty`.

---

## 6. `ZodiakPreamble` sem uso

**Status:** Aberto
**Arquivo:** `ZodiakiOS/Shared/DesignSystem/Organisms/Typographic/ZodiakPreamble.swift`

**Problema:** O componente `ZodiakPreamble` (eyebrow + headline + summary, suporte a fundo escuro via `onHeavy`) existe no design system mas não é usado em nenhuma view — nem no catálogo, nem nas features. É um componente editorial de alto valor para telas introdutórias ou landings.

**Sugestão:** Considerar o uso em telas de onboarding, splash content ou como alternativa ao `ZodiakHeadlineSection` quando o texto introdutório for mais longo e editorial.

---

## 7. Ausência de "PageHeader sticky" no design system

**Status:** Aberto (gap de arquitetura)

**Problema:** Features de lista (07-PersonManager, 10-TaskManager) precisam de um cabeçalho fixo fora do scroll, com o conteúdo da lista rolando abaixo. Atualmente cada screen implementa isso manualmente com `VStack(spacing: 0) { header.padding(...); List(...) }`, sem uma abstração no DS.

**Sugestão:** Criar um `ZodiakStickyHeaderTemplate<Item, Content>` que encapsule esse padrão com:
- Header fora do scroll (aceita `ZodiakHeadlineSection` como título)
- `List` ou `ScrollView` como área de conteúdo rolável
- Suporte a `ZodiakEmptyState` quando `items.isEmpty`
- Padding adaptativo iPhone/iPad já embutido

---

## 8. `ZodiakActivityTemplate` — header dentro do ScrollView

**Status:** Observação de design / debate em aberto

**Problema:** Nos templates `ZodiakActivityTemplate` e `ZodiakAdaptiveTemplate`, o `ZodiakHeadlineSection` (título) está *dentro* do `ScrollView`. Isso significa que em telas com muito conteúdo, o título rola para cima e some da visão do usuário. Para features curtas isso é aceitável; para features longas pode degradar a UX.

**Sugestão:** Avaliar caso a caso se o título deveria ser movido para fora do scroll (padrão de features de lista 07/10) ou se o comportamento atual é adequado para features de formulário.

---

## 9. `ZodiakInfoRow` sem variante para especificações técnicas

**Status:** Mitigado (PR deste documento)
**Arquivos:** `ZodiakiOS/Shared/DesignSystem/Organisms/ZodiakInfoRow.swift`, `ZodiakiOS/App/Catalog/CatalogGalleryHelpers.swift`

**Problema:** O `ZodiakInfoRow` original suportava apenas o estilo "dado de domínio" (label em body/secondary, valor em body/bold, fundo surface com cornerRadius). Para as tabelas de especificações técnicas do catálogo (label compacto, valor em caption, sem fundo) havia uma função auxiliar ad-hoc `specRow()` definida em `CatalogGalleryHelpers.swift` — um helper específico de catálogo que duplicava a responsabilidade de layout do DS e não estava disponível em nenhuma feature.

**Impacto:** ~50 gallery views dependiam de `specRow()` fora do design system. Qualquer screen de produção que precisasse de uma tabela de especificações técnicas (ex: página de detalhe, dashboard, tela de revisão) teria de reimplementar esse padrão manualmente.

**Resolução aplicada:**

1. Adicionado enum `ZodiakInfoRowStyle` com dois casos:
   - `.data` (padrão, backward-compatible): comportamento original — body typography, valor bold, fundo surface, cornerRadius.
   - `.spec(labelWidth: CGFloat = 90)`: compacto — caption typography em label e valor, label com largura fixa, sem fundo.

2. `ZodiakInfoRow` ganhou parâmetro `style: ZodiakInfoRowStyle = .data`, mantendo total backward-compatibility com todos os call sites existentes que usam `label:` e `value:` nomeados.

3. `specRow()` em `CatalogGalleryHelpers.swift` foi refatorado para ser um thin wrapper de `ZodiakInfoRow(.spec)`:
   ```swift
   func specRow(_ label: LocalizedStringKey, _ value: LocalizedStringKey, labelWidth: CGFloat = 90) -> some View {
       ZodiakInfoRow(label, value: value, style: .spec(labelWidth: labelWidth))
   }
   ```

**Sugestão para o DS:** O estilo `.spec` pode ser útil em telas de produção (páginas de detalhe de produto, revisão de configurações, dashboards técnicos). Considerar documentar como padrão oficial para "tabelas de especificação" no guia de componentes.

---

*Última atualização: 2026-04-30*

---

## 10. Phase 0 — Token & Spec Reconciliation (NOVO)

**Status:** Mitigado (commit Phase 0)
**Arquivos afetados:** `ZodiakColors.swift`, `ZodiakPrimitives.swift`, `ZodiakGradients.swift`, `ZodiakShadows.swift`, `ZodiakTypography.swift`, `ZodiakText.swift`, 5 colorsets em `Assets.xcassets`.

**Problema:** validação contra os 48 PDFs Zodiak (`docs/zodiak-pdf/`) revelou divergências entre a documentação markdown e a verdade visual:
- 5 tokens warning detalhados ausentes (`actionWarningContent/Hover/HoverOutline/Pressed/PressedOutline`).
- `actionFocusOnHeavy`, `actionPrimaryOnPhoto`, `textLinkInverse`, `heroPhotographic` ausentes.
- 6 escalas grandes de heading ausentes (40 → 128pt).
- Italic e dual-weight (300/400) não expostos.
- Line-height nunca aplicado em `ZodiakText`.
- B/W overlay primitives ausentes (`black5/6/8/10/15/55/75`, `white5/50`).
- `photoOverlay` gradient ausente.
- Limite SwiftUI sobre `shadow.spread` não documentado.

**Resolução aplicada:** todos os itens acima foram adicionados de forma **puramente aditiva** (zero breaking change). Asset catalog ganhou 5 novos colorsets adaptativos. `ZodiakText` agora aplica `.lineSpacing(...)` automaticamente em todos os estilos. Validado por build (`xcodebuild ... build` exit 0) e SwiftLint (exit 0).

**Descobertas adicionais durante a Phase 0:**
- `ZodiakIconButton` **já estava correto** com sizes 38/48/56 (auditoria inicial confundiu icon size com diameter).
- `ZodiakArrowButton` **já estava correto** (Canvas-based lengthening arrow per spec).

Ver detalhes em [zodiak-ds-fidelity.md](zodiak-ds-fidelity.md).

---

## 11. Layout Grid divergente do PDF Zodiak

**Status:** Aberto (Phase 3)
**Arquivo:** `ZodiakiOS/Shared/DesignSystem/Templates/ZodiakLayoutGrid.swift`

**Problema:** o `ZodiakLayoutGrid` atual escolhe número de colunas via `UIDevice.current.userInterfaceIdiom` + `verticalSizeClass`. PDF Zodiak define **5 viewports por largura** (Desktop large 1920+, Desktop small 1280-1919, Tablet large 992-1279, Tablet 768-991, Mobile 320-767).

**Impacto:** Stage Manager, split-view, Mac Catalyst e iPhone Plus em landscape recebem layout incorreto.

**Sugestão:** refatorar para `GeometryReader` + lookup por largura, conforme proposta em [ipad-adaptivity-audit.md](ipad-adaptivity-audit.md) seção "Tabela de matching".

---

## 12. Accessibility — débito acumulado

**Status:** Aberto (Phase 2)
**Documento:** [accessibility-audit.md](accessibility-audit.md)

**Problema:** zero ocorrências de `accessibilityIdentifier`, zero de `accessibilityValue`, zero suporte a Dynamic Type, zero suporte a Reduce Motion. Componentes de estado (Checkbox, Radio, Toggle, Rating, Progress, Step) não anunciam estado para VoiceOver.

**Sugestão:** roadmap completo na Phase 2, priorizado por:
1. P0 — `accessibilityIdentifier` em Atoms interactivos (habilita UI tests).
2. P0 — `accessibilityValue` em componentes de estado.
3. P1 — Reduce Motion + `@ScaledMetric`.
4. P2 — Script automático de validação de contraste WCAG.

---

## 13. Warning Button — variantes incompletas

**Status:** Aberto (Phase 4)
**Arquivo:** `ZodiakiOS/Shared/DesignSystem/Atoms/Button/ZodiakWarningButtons.swift`

**Problema:** Tertiary variant ausente (PDF [Specs _ Warning button tertiary.pdf](zodiak-pdf/Specs%20_%20Warning%20button%20tertiary%20_%20Made%20with%20Supernova.pdf)). Estados hover/pressed do Primary e Secondary não usam os tokens detalhados (`actionWarningHover`, `actionWarningPressed`, `actionWarningHoverOutline`, `actionWarningPressedOutline`) — adicionados na Phase 0 mas ainda não consumidos.

**Sugestão:** adicionar `ZodiakWarningTertiaryButton` + estado-aware coloring nos existentes, na Phase 4.

---

## 14. ZodiakButton sem `context: .onPhoto`

**Status:** Aberto (Phase 4)
**Arquivo:** `ZodiakiOS/Shared/DesignSystem/Atoms/Button/ZodiakButton.swift`

**Problema:** `ZodiakIconButton` e `ZodiakMediaButton` aceitam `context: .onLite | .onHeavy | .onPhoto`. `ZodiakButton` (regular) só tem `.onLite | .onHeavy`. PDF [Specs _ Regular button onphoto.pdf](zodiak-pdf/Specs%20_%20Regular%20button%20onphoto_%20Made%20with%20Supernova.pdf) define spec completo onPhoto.

**Sugestão:** adicionar `.onPhoto` em `ZodiakButton` aproveitando `actionPrimaryOnPhoto` (Phase 0).

---

## 15. Media Button — set incompleto de ações

**Status:** Aberto (Phase 4)
**Arquivo:** `ZodiakiOS/Shared/DesignSystem/Atoms/Button/ZodiakMediaButton.swift`

**Problema:** PDF descreve 15 ações de media (play, pause, stop, replay, mute, unmute, volume up/down, fullscreen, exit-fullscreen, captions, settings, prev, next, expand). Implementação atual cobre subset.

**Sugestão:** completar enum `ZodiakMediaAction` com todos os 15 + ícones SF Symbols correspondentes, na Phase 4.

---

## 16. Tabs — pesos variáveis ausentes

**Status:** Aberto (Phase 4)
**Arquivo:** `ZodiakiOS/Shared/DesignSystem/Atoms/Tabs/`

**Problema:** PDF [Overview _ Tabs.pdf](zodiak-pdf/Overview%20_%20Tabs%20_%20Made%20with%20Supernova.pdf) define dois "weights" de tabs (medium e large com paddings/heights diferentes). Impl atual tem apenas um tamanho.

**Sugestão:** adicionar `ZodiakTabsSize` enum (medium/large) na Phase 4.

---
