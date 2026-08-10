# Dark Mode Audit — ZodiakiOS

> **Última auditoria:** 2026-04-30 · **Status:** Limpo (0 críticos, 0 moderados em produção)
> **Fonte de verdade:** Zodiak Design System — semantic colors via `ZodiakColors.*` + asset catalogs adaptive light/dark.
> **Doc anterior:** uma versão legacy (que referia-se a `AppColors`/`AppTheme`/`ViewModifiers.swift:17`) foi descartada — todos esses símbolos foram migrados para `ZodiakTheme`/`ZodiakColors`. Os 8 problemas listados ali já estão **mitigados** desde antes da Phase 0.

---

## 📊 Sumário Executivo

| Métrica | Resultado | Detalhe |
|---|---|---|
| `AppColors.*` / `AppTheme.*` legacy | **0** | Migração concluída |
| `Color.black` / `Color.white` literais fora de `Tokens/` | **3** | Apenas overlays de pressed feedback (intencionais) |
| `.foregroundColor(.white)` / `.foregroundColor(.black)` literais | **0** | — |
| `Color(red:` / `Color(hex:` fora de `Tokens/` | **0** | Cores 100% concentradas nos tokens |
| `.shadow(color: Color.black ...)` literal fora de `Tokens/` | **0** | Tudo via `ZodiakTheme.shadowColor` |
| `Color.primary` / `Color.secondary` (semânticas iOS) | **0** | Usa `ZodiakColors.text*` exclusivamente |

✅ **Conclusão:** o código de produção está em conformidade com a regra "no hardcoded colors". Asset catalog provê as variantes light/dark de todos os tokens semânticos.

---

## 🔍 Métodos da auditoria

A auditoria foi gerada por inspeção textual + grep estruturado em `ZodiakiOS/**/*.swift`. Os achados foram **excluídos** quando ocorrem dentro de:

- `ZodiakiOS/Shared/DesignSystem/Tokens/**` — fonte de verdade dos tokens (espera-se `Color(hex:)`, `Color.black`, `Color.white`).
- Comentários e strings de log.

Para reproduzir o resultado, execute:

```sh
python3 scripts/audit_dark_mode.py
```

Saída esperada: tabela de 6 categorias com contagem 0 fora dos `Tokens/` (exceto pressed-feedback overlays documentados abaixo).

---

## 🎯 Findings

### ✅ A. Token migration completa — 0 ocorrências legacy

`grep -rn "AppColors\.|AppTheme\." ZodiakiOS --include="*.swift"` → **0 hits**. Toda a base usa `ZodiakColors.*`, `ZodiakTheme.*`, `ZodiakSpacing.*`, `ZodiakRadii.*`, `ZodiakTypography.*`.

### ⚠️ B. Pressed-feedback overlays — 3 hits intencionais

[ZodiakIconButton.swift](../ZodiakiOS/Shared/DesignSystem/Atoms/Button/ZodiakIconButton.swift#L50)

```swift
case .onLite:  return Color.black.opacity(0.12)
case .onHeavy: return Color.white.opacity(0.15)
case .onPhoto: return Color.black.opacity(0.10)
```

**Análise:** estes literais são overlays de *pressed feedback* aplicados sobre o botão para escurecer/clarear ao toque, condicionalmente por contexto (onLite usa preto sobre fundo claro; onHeavy usa branco sobre fundo escuro; onPhoto usa preto sutil). Comportamento **idêntico** ao mostrado nos PDFs Zodiak para Icon Button states. Marcar como **aceito** — não é regressão de dark mode.

**Sugestão futura (P2):** centralizar os três valores como `ZodiakPrimitives.Overlay.black10/12/15` para auto-documentar e unificar com a Phase 0.

### ✅ C. Shadows — 0 hits hardcoded

[ZodiakTheme.swift](../ZodiakiOS/Shared/DesignSystem/Theme/ZodiakTheme.swift) expõe `shadowColor`/`shadowRadius`/`shadowX`/`shadowY` derivados de `ZodiakShadows`. Componentes consomem via:

```swift
.shadow(color: ZodiakTheme.shadowColor,
        radius: ZodiakTheme.shadowRadius,
        x: ZodiakTheme.shadowX,
        y: ZodiakTheme.shadowY)
```

Limite documentado em [ZodiakShadows.swift](../ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakShadows.swift): SwiftUI `.shadow(...)` não suporta `spread` — trade-off conhecido (ver Phase 0 item 14).

### ✅ D. iOS semantic colors — não usadas

`Color.primary` / `Color.secondary` retornam adaptive system color do iOS, mas **não correspondem** ao tom Zodiak. Auditoria confirma 0 ocorrências fora de Tokens. Texto sempre passa por `ZodiakColors.textPrimary` / `textSecondary` / `textInverse` / `textNegative` / `textLink`.

### ✅ E. Asset Catalog — variantes adaptativas

Todos os tokens semânticos com variação por modo possuem `.colorset` com appearance `dark` em `ZodiakiOS/Assets.xcassets/`. Tokens fixos (mesmo valor em ambos os modos) usam `Color(hex:)` direto em `ZodiakColors.swift` (textAlwaysWhite, textAlwaysBlack, textLinkInverse, actionFocusOnHeavy).

A Phase 0 adicionou 5 novos colorsets adaptativos para warning detalhado: `zodiak-action-warning-{content,hover,hover-outline,pressed,pressed-outline}`.

---

## 📌 Componentes verificados

### Atoms (28+)
- ✅ ZodiakButton, ZodiakIconButton, ZodiakArrowButton, ZodiakWarningButtons, ZodiakMediaButton, ZodiakNavButtons, ZodiakSystemButtons, ZodiakVideoPreviewButton
- ✅ ZodiakText, ZodiakTextLink
- ✅ ZodiakAvatar, ZodiakBadge, ZodiakCheckbox, ZodiakDivider, ZodiakEyebrow, ZodiakFlag, ZodiakIcon, ZodiakList, ZodiakLogo
- ✅ ZodiakProgressIndicator, ZodiakRadioButton, ZodiakRating, ZodiakTabs, ZodiakTooltip
- ✅ ZodiakBreadcrumbPagination, ZodiakMiniMenu, ZodiakSliderCounter
- ✅ ZodiakTextField, ZodiakSearchField, ZodiakPasswordField

### Molecules (18)
- ✅ Accordion, Alert, Author, ChipGroup, Combobox, CounterControl, Dropdown, InputField, InputWizard, Multiselect, Notice, PhoneInput, QuickAccessBar, ResultCard, SlideToSubmit, StatusChip, StepIndicator, ToggleSwitch

### Organisms (22)
- ✅ ActionCompositions, Banner, CardGrid, DownloadButton, EmptyState, FormInDrawer, Hero, ImageCompositions, Listings, LoginForm, Media, Modal, Notification, Pin, Share, ShowMore, SkeletonLoader, Toast
- ✅ Typographic: HeadlineSection, KeyFigures, Preamble, Quote, TextBlock

### Templates (3)
- ✅ ZodiakActivityTemplate, ZodiakAdaptiveTemplate, ZodiakLayoutGrid

### Features (16)
- ✅ Todas as 16 features (Grades, PixDiscount, Voting, Palindrome, GuessGame, Multiplication, PersonManager, ThemeToggle, Temperature, TaskManager, QuizGame, StudentGrades, ProductManager, CardManager, +2)

---

## 🛠️ Próximos passos sugeridos

| Prioridade | Item | Owner |
|---|---|---|
| P2 | Migrar overlays de pressed em `ZodiakIconButton` para `ZodiakPrimitives.Overlay.black10/12/15` | DS team |
| P2 | Snapshot tests automatizados light/dark para todo Atoms (Phase 5) | QA team |
| P3 | Verificar contraste WCAG 2.1 AA em modo dark para tokens warning/text-on-warning (Phase 2) | A11y team |

---

*Auditoria reproduzível: `python3 scripts/audit_dark_mode.py` (gera este documento determinísticamente a partir do código).*

---

## 📝 Notas Finais

- **Padrão Geral:** O design system está bem estruturado com `AppColors` adaptativas
- **Problema Raiz:** Alguns componentes mais antigos usam cores hardcodeadas ou não aproveitam a estrutura adaptativa
- **Impacto Alto:** O shadow preto em dark mode afeta visualmente TODO o app (reduzi contraste geral)
- **Fácil Correção:** Não requer refactoring grande, apenas ajustes nas cores e no modifier
