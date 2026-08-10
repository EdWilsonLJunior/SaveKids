# HIG Review — iOS Design System (ZodiakiOS)

> **Categoria**: Audit · **Prioridade**: P1 · **Plataformas**: iOS · **Status**: Backlog · **Doc Supernova**: Não

---

## Contexto

O Zodiak Design System iOS possui implementações em SwiftUI para todas as camadas (foundations → theme → atoms → molecules → organisms → templates → utils). As implementações foram construídas de forma incremental, priorizando spec interna e tokens Zodiak. Entretanto, nenhuma delas passou por uma revisão sistemática contra as **Apple Human Interface Guidelines (HIG)**.

Este audit usa as **14 HIG Skills** disponíveis em `.github/skills/hig-*/` (fonte: [`raintree-technology/hig-doctor`](https://github.com/raintree-technology/hig-doctor)) para revisar cada componente implementado e identificar gaps em: acessibilidade, interação, dark mode, Dynamic Type, RTL, comportamento de plataforma e padrões Apple.

O resultado alimenta diretamente o [GAPS.md](../GAPS.md) e serve de insumo para priorizar correções antes do Wave P1.

---

## História de usuário

Como **agente de IA (ou desenvolvedor iOS)**, quero **revisar sistematicamente cada componente do DS iOS contra as Apple HIG** para que **as implementações respeitem convenções de plataforma, acessibilidade e qualidade visual antes de entrarem em produção**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Cobertura total dos componentes implementados
**Dado** que os seguintes componentes iOS existem em `ZodiakiOS/ZodiakiOS/Shared/DesignSystem/`:
- **Foundations**: `ZodiakColors`, `ZodiakTypography`, `ZodiakSpacing`, `ZodiakSizing`, `ZodiakRadii`, `ZodiakBorders`, `ZodiakShadows`, `ZodiakGridTokens`, `ZodiakIcons`, `ZodiakBlur`, `ZodiakGradients`, `ZodiakOpacity`, `ZodiakFlag`, `ZodiakLogo`
- **Theme**: `ZodiakTheme`, `ZodiakThemeEnvironment`, `ZodiakColorsEnvironment`
- **Atoms**: `ZodiakText`, `ZodiakTextLink`, `ZodiakButton`, `ZodiakIconButton`, `ZodiakArrowButton`, `ZodiakWarningButtons`, `ZodiakSystemButton`, `ZodiakSystemWarningButton`, `ZodiakMediaButton`, `ZodiakFilterButton`, `ZodiakMenuButton`, `ZodiakNavButtons`, `ZodiakTextField`, `ZodiakPasswordField`, `ZodiakSearchField`, `ZodiakCheckbox`, `ZodiakRadioButton`, `ZodiakTabs`, `ZodiakIconView`, `ZodiakProgressIndicator`, `ZodiakDivider`, `ZodiakEyebrow`, `ZodiakBadge`, `ZodiakAvatar`, `ZodiakFlagView`, `ZodiakLogoView`, `ZodiakTooltip`, `ZodiakList`, `ZodiakRating`
- **Molecules**: `ZodiakLabelledField`, `ZodiakSwitch`, `ZodiakNotice`, `ZodiakAlert`, `ZodiakAccordion`, `ZodiakAuthor`, `ZodiakChipGroup`, `ZodiakCombobox`, `ZodiakDropdown`, `ZodiakMultiselect`, `ZodiakPhoneInput`, `ZodiakStepIndicator`, `ZodiakCounterControl`
- **Organisms**: `ZodiakModal`, `ZodiakNotificationBanner`, `ZodiakToast`, `ZodiakBanner`, `ZodiakHero`, `ZodiakLoginForm`, `ZodiakShare`, `ZodiakPin`, `ZodiakListings`, `ZodiakEmptyState`, `ZodiakFormContainer`, `ZodiakFormInDrawer`, `ZodiakSkeletonLoader`, `ZodiakCardGrid` e variantes de Card/Typographic/MediaBlock
- **Templates**: `ZodiakLayoutGrid`, `ZodiakAdaptiveTemplate`, `ZodiakActivityTemplate`, `ZodiakViewport`
- **Utils**: `ZodiakAccessibility`, `ZodiakFontModifier`, `ZodiakViewModifiers`, `ZodiakExtensions`

**Então** cada componente recebe uma revisão HIG documentada com findings classificados por severidade.

---

### Cenário 2 — Findings por área HIG (usando as skills)

Para cada componente, o revisor consulta as skills relevantes e verifica:

| Área | Skill HIG | O que verificar |
|---|---|---|
| **Acessibilidade** | `hig-foundations` | `.accessibilityLabel`, `.accessibilityHint`, `.accessibilityAddTraits`, VoiceOver, hit-target ≥ 44pt, Dynamic Type até AX5, Reduce Motion, Increase Contrast |
| **Cores / Dark Mode** | `hig-foundations` | Cores semânticas (sem hardcode), contraste AA mínimo, adaptação light/dark, uso de `ZodiakColors.*` |
| **Tipografia** | `hig-foundations` | `ZodiakTypography.*` aplicado, `.minimumScaleFactor` com fallback, Dynamic Type respeitado |
| **Interação** | `hig-inputs`, `hig-patterns` | Gestos Apple-nativos, feedback tátil, estados de foco para teclado/Tab |
| **Componentes nativos** | `hig-components-controls`, `hig-components-dialogs`, `hig-components-layout` | Conformidade com padrões Apple (ex.: `.sheet` vs custom modal, `TabView` vs tab bar custom) |
| **Padrões de UX** | `hig-patterns` | Onboarding, modality, navigation, feedback, loading, error states |
| **Plataforma iOS** | `hig-platforms` | Idiomas iOS-específicos: safe area, keyboard avoidance, pull-to-refresh, context menus |
| **Internacionalização** | `hig-foundations` | RTL via `zodiakMirrorRTL()`, ícones direcionais, layout flexível para text expansion |
| **Tecnologias Apple** | `hig-technologies` | SharePlay, Sign in with Apple, Apple Pay (quando aplicável) |

**Então** cada finding é registrado em `docs/backlog/GAPS.md` com:
- Componente afetado
- Severidade: `critical` | `serious` | `moderate` | `suggestion`
- Skill HIG consultada
- Descrição do gap
- Recomendação de correção

---

### Cenário 3 — Classificação de severidade

**Dado** um finding identificado durante o audit:

| Severidade | Critério | Ação |
|---|---|---|
| `critical` | Quebra de acessibilidade (sem label, hit-target < 44pt, `user-scalable=no`, vídeo sem legenda) | Bloqueia PR — corrigir antes do merge |
| `serious` | Degradação significativa de UX (hardcode de cor, Dynamic Type quebrado, foco não gerenciado) | Corrigir no mesmo sprint |
| `moderate` | Violação de estilo/melhor prática HIG (ícone não-SF Symbols sem justificativa, padding inconsistente) | Backlog priorizado |
| `suggestion` | Melhoria opcional (animação mais expressiva, haptic feedback adicional) | Registrar em GAPS.md como P2 |

**Então** apenas findings `critical` e `serious` bloqueiam a aprovação do componente para produção.

---

### Cenário 4 — Relatório final e atualização do GAPS.md

**Dado** que todos os componentes foram revisados
**Então** o GAPS.md contém:
- Tabela de resumo por componente (✅ aprovado / ⚠️ moderado / 🔴 crítico/sério)
- Lista detalhada de findings agrupados por severidade
- Recomendações de correção priorizadas

**E** os findings `critical`/`serious` viram histórias no backlog com prioridade P0/P1.

---

### Cenário 5 — Uso correto das skills

**Dado** que o agente está realizando o audit
**Então** para cada componente:
1. Identifica as skills HIG relevantes (ex.: modal → `hig-components-dialogs` + `hig-patterns`)
2. Carrega a skill via `read_file` com o caminho `.github/skills/hig-<nome>/SKILL.md`
3. Cruza os critérios da skill com o código-fonte do componente
4. Classifica cada finding com a severidade correta
5. Não inventa findings sem base na skill ou no código

---

## Spec técnica

### Escopo do audit
- **Plataforma**: iOS apenas (SwiftUI + Swift 5.9+, deployment target iOS 26.4)
- **Frameworks inspecionados**: SwiftUI, UIKit (quando usado), UIAccessibility
- **Arquivos fonte**: `ZodiakiOS/ZodiakiOS/Shared/DesignSystem/**/*.swift`
- **Arquivos excluídos**: testes (`*Tests.swift`), previews standalone, scripts

### Skills HIG a utilizar (por camada DS)

| Camada DS | Skills primárias | Skills secundárias |
|---|---|---|
| Foundations / Theme | `hig-foundations` | `hig-platforms` |
| Atoms (texto, tipografia) | `hig-foundations`, `hig-components-controls` | `hig-inputs` |
| Atoms (botões) | `hig-components-menus`, `hig-components-controls` | `hig-foundations` |
| Atoms (inputs) | `hig-components-controls` | `hig-inputs`, `hig-foundations` |
| Molecules (formulários) | `hig-components-controls`, `hig-patterns` | `hig-inputs` |
| Molecules (feedback inline) | `hig-components-status` | `hig-foundations` |
| Organisms (modais, sheets) | `hig-components-dialogs` | `hig-patterns`, `hig-platforms` |
| Organisms (notificações) | `hig-components-system` | `hig-components-status` |
| Organisms (cards, listas) | `hig-components-content`, `hig-components-layout` | `hig-foundations` |
| Templates | `hig-components-layout`, `hig-platforms` | `hig-patterns` |
| Utils (acessibilidade) | `hig-foundations`, `hig-technologies` | `hig-inputs` |

### Checklist de revisão por componente

Para cada componente, verificar:

```
[ ] accessibilityLabel e accessibilityHint presentes em elementos interativos
[ ] accessibilityAddTraits correto (isButton, isHeader, isImage, etc.)
[ ] Hit-target ≥ 44pt (via zodiakHitTarget())
[ ] Dynamic Type: texto escala sem layout quebrado até .accessibility5
[ ] Reduce Motion: animações têm alternativa fade/crossfade
[ ] Increase Contrast: bordas/separadores visíveis sem depender só de cor
[ ] Dark mode: sem Color(hex:) hardcoded — apenas ZodiakColors.*
[ ] RTL: ícones direcionais usam zodiakMirrorRTL(); layout não depende de .leading fixo
[ ] Teclado: campos têm keyboardType, textContentType, returnKeyType corretos
[ ] Estados: disabled visualmente distinto sem depender só de cor
[ ] Focus ring: elementos interativos custom têm zodiakFocusRing() quando focalizados por teclado
[ ] VoiceOver: navegação lógica, grouping correto, live regions para mudanças dinâmicas
[ ] SF Symbols: ícones usam ZodiakIcons.* (não strings literais) e têm peso correto
[ ] Heading semantics: títulos de seção usam zodiakHeading(level:)
```

### Output esperado

Cada finding no GAPS.md segue o formato:

```markdown
### [<Severidade>] <Componente> — <Descrição curta>
- **Arquivo**: `Shared/DesignSystem/<Camada>/<Componente>.swift`
- **Skill consultada**: `hig-<nome>`
- **Descrição**: <o que está errado ou ausente>
- **Recomendação**: <o que fazer para corrigir>
- **História gerada**: <link para backlog item, se criado>
```

---

## Boas práticas — iOS

- Usar `zodiakA11yID(_:role:context:)` para testar acessibilidade programaticamente nos testes unitários.
- Preferir `.accessibilityElement(children: .combine)` para grupos semânticos simples; `.accessibilityElement(children: .contain)` quando os filhos têm interação própria.
- Consultar `hig-components-dialogs` antes de qualquer customização de `sheet`, `alert` ou `confirmationDialog` — o HIG tem regras estritas sobre quando usar cada pattern.
- Validar RTL com `Environment(\.layoutDirection)` e testar com árabe ou hebraico no simulador.
- Para haptics: `UIImpactFeedbackGenerator(.medium)` em buttons primários; `.light` em ações secundárias; nenhum em elementos decorativos.

---

## Referências

- HIG Skills: `.github/skills/hig-*/SKILL.md` (submodule `raintree-technology/hig-doctor`)
- Componentes iOS: `ZodiakiOS/ZodiakiOS/Shared/DesignSystem/`
- Gaps consolidados: [GAPS.md](../GAPS.md)
- Skill de projeto HIG: `.github/skills/hig-project-context/SKILL.md`
- WWDC: https://developer.apple.com/videos/all-videos/

---

## Gaps & dúvidas para o time de Design

- [ ] Qual é o nível mínimo de acessibilidade alvo — WCAG AA ou AAA?
- [ ] Há componentes com intenção deliberada de não seguir o HIG (ex.: branding override)? Documentar exceções.
- [ ] O audit deve cobrir também os testes de snapshot existentes em `ZodiakiOSTests/`?

---

## DoD

- [ ] Todos os componentes listados no Cenário 1 foram revisados com pelo menos uma skill HIG.
- [ ] Findings `critical` e `serious` registrados em `GAPS.md` com história correspondente no backlog.
- [ ] Findings `moderate` e `suggestion` registrados em `GAPS.md` sem obrigação de história imediata.
- [ ] Tabela de resumo por componente adicionada ao início do `GAPS.md`.
- [ ] Nenhum finding inventado — toda referência rastreável a uma skill HIG e ao código-fonte.
