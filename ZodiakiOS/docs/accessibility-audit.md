# Accessibility Audit — ZodiakiOS

> **Última auditoria:** 2026-04-30 · **Padrão:** WCAG 2.1 AA (Zodiak [Accessibility _ Color.pdf](zodiak-pdf/Accessibility%20_%20Color%20_%20Made%20with%20Supernova.pdf))
>
> **Escopo:** acessibilidade de UI iOS/iPadOS — VoiceOver, Dynamic Type, Reduce Motion, contraste, touch target, foco/teclado.

---

## 📊 Sumário Executivo

| Vetor | Cobertura atual | Meta | Gap |
|---|---|---|---|
| `accessibilityLabel` | ~29 ocorrências (Atoms+Molecules+Features) | 100% Atoms interactivos | ~25% interactivo sem label |
| `accessibilityHint` | ~8 ocorrências | 100% Atoms com action complexa | Cobertura baixa |
| `accessibilityIdentifier` | **0** | 100% Atoms para UI tests | **Crítico** — UI tests não confiáveis |
| `accessibilityValue` | **0** | Componentes com estado/range (Toggle, Slider, Rating, Progress, Checkbox, Radio) | **7 componentes ausentes** |
| `accessibilityAddTraits` | ~27 ocorrências | 100% buttons/headers/links | Boa cobertura em buttons + headers |
| `@ScaledMetric` | **0** | Spacings críticos em forms/buttons | Não usado |
| `.dynamicTypeSize` | **0** | Test previews com AX1-AX5 | Não usado |
| Touch target ≥ 44pt | ✅ ZodiakSizing.minTouchTarget | 100% interactive elements | OK por token, mas não verificado runtime |
| Reduce Motion | **❌ 0 hits** | Animações respeitam `accessibilityReduceMotion` | Não implementado |
| Contraste WCAG AA | ✅ ZodiakColors validados visualmente | Validação automatizada | Falta tooling |

---

## 🎯 Findings detalhados

### A. Componentes interactivos SEM `accessibilityIdentifier`

**Crítico** — sem identifiers, UI tests dependem de strings localizadas (frágeis a mudanças de tradução).

Componentes afetados (todos os 28+ Atoms interactivos):
- ZodiakButton, ZodiakIconButton, ZodiakArrowButton, ZodiakWarningButtons, ZodiakMediaButton, ZodiakNavButtons, ZodiakSystemButtons, ZodiakVideoPreviewButton
- ZodiakCheckbox, ZodiakRadioButton, ZodiakRating, ZodiakTabs
- ZodiakTextField, ZodiakSearchField, ZodiakPasswordField
- ZodiakBreadcrumbPagination, ZodiakMiniMenu, ZodiakSliderCounter

**Solução proposta** (Phase 2):
```swift
struct ZodiakButton: View {
    var title: String
    var identifier: String  // NOVO
    var body: some View {
        Button(action: action) { /* ... */ }
            .accessibilityIdentifier(identifier)
    }
}
```

### B. Componentes com estado SEM `accessibilityValue`

| Componente | Estado a expor | PDF reference |
|---|---|---|
| ZodiakCheckbox | `isChecked` (1/0) + `.isToggle` | — |
| ZodiakRadioButton | `isSelected` (selected/unselected) | — |
| ZodiakToggleSwitch | `isOn` (on/off) + `.isToggle` | — |
| ZodiakRating | "3 of 5 stars" | — |
| ZodiakProgressIndicator | percentual ou step atual | — |
| ZodiakStepIndicator | "Step 2 of 5" | — |
| ZodiakSliderCounter | valor atual + min/max | — |

**Exemplo de fix:**
```swift
.accessibilityValue(isChecked ? "checked" : "unchecked")
.accessibilityAddTraits(.isToggle)  // ou equivalente
```

### C. `Image(systemName:)` sem `accessibilityLabel` próximo

| Arquivo | Linha | Status |
|---|---|---|
| [ZodiakAlert.swift](../ZodiakiOS/Shared/DesignSystem/Molecules/Alert/ZodiakAlert.swift) | 47 | ⚠️ falta label |
| [ZodiakNotice.swift](../ZodiakiOS/Shared/DesignSystem/Molecules/Notice/ZodiakNotice.swift) | 63 | ⚠️ falta label |
| [ZodiakAccordion.swift](../ZodiakiOS/Shared/DesignSystem/Molecules/Accordion/ZodiakAccordion.swift) | 37 | ⚠️ falta label |
| [ZodiakCardVariants.swift](../ZodiakiOS/Shared/DesignSystem/Organisms/CardGrid/ZodiakCardVariants.swift) | 39 | ⚠️ falta label (avatar) |
| ZodiakIconButton.swift | 130 | ✅ tem `.accessibilityLabel(accessibilityLabel)` |
| ZodiakButton.swift | 45-48 | ✅ parent label cobre |
| ZodiakWarningButtons.swift | 23, 63 | ✅ parent label cobre |

### D. Dynamic Type — não suportado deliberadamente

**Estado:** Tipografia atual usa `Font.custom(Ubuntu, size:)` ou `.system(size:)`. Nenhum dos dois respeita `dynamicTypeSize` automaticamente.

**Impacto:** usuários com **AX1-AX5** (acessibilidade extrema) verão o app no tamanho fixo do design.

**Solução proposta** (Phase 2):
1. Audit visual em previews para `dynamicTypeSize: .xSmall` até `.accessibility5`.
2. Onde quebra layout, aplicar `@ScaledMetric` para spacings que escalam com texto:
   ```swift
   @ScaledMetric(relativeTo: .body) var iconSize: CGFloat = 24
   ```
3. Considerar usar `Font.custom(...).dynamicTypeSize(.xSmall ... .accessibility3)` para limitar range de escala (Zodiak não foi desenhado para AX5 sem reflow).
4. Documentar trade-off explícito em [zodiak-ds-fidelity.md](zodiak-ds-fidelity.md).

### E. Reduce Motion

**Estado:** 0 ocorrências de `@Environment(\.accessibilityReduceMotion)`.

Animações que **devem** respeitar Reduce Motion:
- ZodiakArrowButton — lengthen on press (atualmente sempre 0.12s easeInOut).
- ZodiakIconButton — pressed overlay fade.
- ZodiakAccordion — expand/collapse.
- ZodiakDropdown — slide animation.
- ZodiakModal — present/dismiss transition.
- ZodiakToast — auto-dismiss slide.

**Solução proposta:**
```swift
@Environment(\.accessibilityReduceMotion) var reduceMotion
.animation(reduceMotion ? nil : .easeInOut(duration: 0.12), value: isPressed)
```

### F. Reduce Transparency / Differentiate Without Color

**Reduce Transparency:** Componentes com `.background(Color...opacity(0.5))` ou similar (modal scrim, glass) devem checar `accessibilityReduceTransparency` e usar opacity 1.0 quando ativo.

**Differentiate Without Color:** Estados de erro/sucesso atuais usam **apenas cor**. WCAG 1.4.1 exige redundância: ícone OU texto. Verificar:
- ZodiakAlert / ZodiakNotice — ✅ já têm ícone + texto.
- ZodiakWarningButton — ⚠️ usa cor; o `Image(systemName: "exclamationmark.triangle.fill")` cobre parcialmente.
- ZodiakBadge / StatusChip — verificar se status (success/warning/error) tem ícone associado.

### G. Touch target

[ZodiakSizing.swift](../ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakSizing.swift) define `minTouchTarget = 44` (Apple HIG). Buttons usam diretamente os heights 38/48/56 — **botão Small (38) está abaixo do mínimo**.

**Solução proposta:**
- Adicionar `.contentShape(Rectangle().inset(by: -3))` em ZodiakButton/IconButton size `.small` para expandir hit-test sem alterar visual. ZodiakArrowButton já faz isso (`.contentShape(Rectangle().inset(by: -12))`).

### H. Contraste WCAG 2.1 AA

PDF Zodiak ([Accessibility _ Color.pdf](zodiak-pdf/Accessibility%20_%20Color%20_%20Made%20with%20Supernova.pdf)) define:
- **4.5:1** para texto normal vs background.
- **3:1** para texto grande (≥18pt regular ou ≥14pt bold) e UI/graphics.

**Tokens já validados em design** (PDF):
- textPrimary vs surface ✅
- textSecondary vs surface ✅
- actionPrimary vs surfaceAlwaysWhite ✅
- actionWarning vs surface ⚠️ — verificar tokens novos (warningContent / warningHoverOutline).

**Solução proposta** (Phase 2):
- Script Python `scripts/audit_color_contrast.py` lendo `Assets.xcassets/*.colorset` e calculando ratio para todos os pares semanticamente válidos.
- Geração de relatório `docs/contrast-report.md` com cada par + ratio + status (PASS/FAIL).

### I. Localização e VoiceOver

VoiceOver lê o `accessibilityLabel`. Hoje a maioria dos labels é hardcoded em chaves localizadas (✅), mas alguns são strings literais:

| Arquivo | Linha | Hardcoded |
|---|---|---|
| ZodiakIconButton.swift | (default param) | `"catalog.spec.label_action"` ✅ chave |
| ZodiakArrowButton.swift | (default param) | `"shared.action.navigate"` ✅ chave |

✅ **Status: OK** — todos os labels que vimos passam por `LocalizedStringKey`. Verificar amostra completa via UI tests em pt-BR + en (Phase 2).

---

## 🛠️ Roadmap Phase 2

| Prioridade | Item | Esforço | Impacto |
|---|---|---|---|
| P0 | `accessibilityIdentifier` em todos os Atoms interactivos | M | Habilita UI tests confiáveis |
| P0 | `accessibilityValue` em Checkbox/Radio/Toggle/Rating/Progress/Step/Slider | S | VoiceOver passa a anunciar estado |
| P0 | `accessibilityLabel` em Alert/Notice/Accordion (4 arquivos) | XS | VoiceOver fica completo |
| P1 | Reduce Motion em todas as animações (5+ componentes) | M | WCAG 2.3.3 |
| P1 | `@ScaledMetric` em spacings críticos + audit visual em AX1-AX3 | L | Dynamic Type |
| P1 | Hit-test expandido em buttons size `.small` | XS | WCAG 2.5.5 |
| P2 | Script `audit_color_contrast.py` + relatório | M | Validação contínua |
| P2 | Reduce Transparency em modais/glass | S | A11y |
| P2 | UI tests em pt-BR + en com VoiceOver mock | L | Cobertura |
| P3 | Differentiate Without Color audit (Badge, Chip) | S | WCAG 1.4.1 |

---

## 📋 Checklist por componente (a preencher na Phase 2)

> Esta tabela será mantida ao longo do roadmap. Atualizar conforme cada item for fechado.

| Componente | Label | Hint | Identifier | Value | Traits | Reduce Motion | Dynamic Type | Hit ≥44 |
|---|---|---|---|---|---|---|---|---|
| ZodiakButton | ✅ | ✅ | ❌ | n/a | ✅ | ❌ | ❌ | ⚠️ small=38 |
| ZodiakIconButton | ✅ | ✅ | ❌ | n/a | ✅ | ❌ | ❌ | ⚠️ small=38 |
| ZodiakArrowButton | ✅ | ✅ | ❌ | n/a | ✅ | ❌ | n/a | ✅ |
| ZodiakWarningButtons | ✅ | ✅ | ❌ | n/a | ✅ | ❌ | ❌ | ⚠️ |
| ZodiakCheckbox | ❌ | ❌ | ❌ | ❌ | ❌ | n/a | ❌ | ⚠️ |
| ZodiakRadioButton | ❌ | ❌ | ❌ | ❌ | ❌ | n/a | ❌ | ⚠️ |
| ZodiakToggleSwitch | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | n/a | ⚠️ |
| ZodiakRating | ❌ | ❌ | ❌ | ❌ | ❌ | n/a | ❌ | ⚠️ |
| ZodiakProgressIndicator | ❌ | n/a | ❌ | ❌ | ❌ | ❌ | n/a | n/a |
| ZodiakStepIndicator | ❌ | n/a | ❌ | ❌ | ❌ | ❌ | ❌ | n/a |
| ZodiakTabs | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ⚠️ |
| ZodiakTextField | ❌ | n/a | ❌ | n/a | ❌ | n/a | ❌ | ✅ |
| ZodiakAlert | ❌ | n/a | ❌ | n/a | ❌ | n/a | ❌ | n/a |
| ZodiakNotice | ❌ | n/a | ❌ | n/a | ❌ | n/a | ❌ | n/a |
| ZodiakAccordion | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ |
| ZodiakModal | n/a | n/a | ❌ | n/a | n/a | ❌ | ❌ | n/a |

---

*Este documento é a fonte canônica de débito de acessibilidade. Atualizar a cada PR que tocar em componentes interactivos.*
