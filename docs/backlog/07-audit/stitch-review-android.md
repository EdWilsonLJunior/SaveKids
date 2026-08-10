# Stitch Review — Android DS

> **Gerado em**: 2026-05-17  
> **Referência**: `07-audit/android-execution-plan.md` · Fases 1–4  
> **Fonte de autoridade MD3**: [Stitch (Google Labs)](https://stitch.withgoogle.com) — AI design canvas treinado sobre Material Design 3 Guidelines  
> **Análogo iOS**: `07-audit/hig-review-ios.md`

---

## Contexto

O Android DS Zodiak tem **17 componentes** (6 theme · 4 atoms · 4 molecules · 3 organisms) sem nenhuma revisão sistemática contra Material Design 3. Ao contrário do iOS — que usou o `hig-doctor` (Apple HIG skills) como referência canônica — o Android usa **Stitch** do Google Labs como gerador de referências MD3. Para cada componente, o workflow é:

1. Gerar tela de referência via skill `stitch-design` (prompt → HTML/screenshot)
2. Confrontar a referência com a implementação `Zodiak<X>.kt`
3. Documentar desvios no `GAPS.md` com formato Android completo (incluindo ELI5), começando em G-071

---

## User Story

**Como** desenvolvedor Android ou agente de implementação,  
**Quero** revisar cada componente do Zodiak DS Android contra Material Design 3  
**Usando** Stitch (Google Labs) como fonte canônica de referência  
**Para que** os componentes Zodiak no Android tenham a mesma fidelidade de token, acessibilidade e comportamento que os componentes iOS têm após a revisão HIG.

---

## Critérios de Aceitação

### Cobertura

```gherkin
Feature: Stitch Audit Coverage

  Scenario: Every existing component is reviewed
    Given the Android DS has 17 components across 4 layers (theme/atoms/molecules/organisms)
    When the Stitch audit is complete
    Then each component has been through the 15-point MD3 checklist
    And findings are logged in GAPS.md starting at G-071

  Scenario: New components are audited before merge
    Given a Wave 1-5 component branch is ready for PR
    When the PR is opened
    Then the PR description includes the Stitch checklist result
    And any serious/moderate findings link to a GAPS.md entry
```

### Severidade

```gherkin
  Scenario Outline: Findings are classified correctly
    Given a Stitch audit finding on a component
    When it violates a required MD3 rule
    Then it is classified as "<severity>"
    And it has the correct impact "<impact>"

    Examples:
      | rule                                                   | severity  | impact |
      | Missing semantics role / contentDescription            | serious   | P0     |
      | Hardcoded Color(0xFF...) in a component (not token)    | serious   | P0     |
      | Hit-target below 48dp                                  | serious   | P0     |
      | Spacing not on 4dp grid                                | moderate  | P1     |
      | Missing Reduce Motion support                          | moderate  | P1     |
      | Shape not via MaterialTheme.shapes.*                   | moderate  | P1     |
      | RTL not using Start/End                                | moderate  | P1     |
      | Missing state (loading/error/disabled)                 | moderate  | P1     |
      | Stitch visual divergence (minor hierarchy difference)  | suggestion| P2     |
```

### Output em GAPS.md

```gherkin
  Scenario: Each finding is documented completely
    Given a Stitch audit finding
    Then the GAPS.md entry includes all required fields:
      | field               | required |
      | G-XXX number        | yes      |
      | Tipo                | yes      |
      | Plataforma: Android | yes      |
      | Severidade Stitch   | yes      |
      | Impacto             | yes      |
      | Referência Stitch   | yes      |
      | Descrição           | yes      |
      | Referência Android  | yes      |
      | Recomendação (code) | yes      |
      | ELI5                | yes      |
      | Ver também G-00X    | if applicable |
      | Status: Aberto      | yes      |
```

---

## Metodologia Stitch

### Pré-requisitos

```bash
# Instalar skills Stitch (1× por máquina)
npx skills add google-labs-code/stitch-skills --skill stitch-design --global
npx skills add google-labs-code/stitch-skills --skill design-md --global
npx skills add google-labs-code/stitch-skills --skill enhance-prompt --global

# API Key (obter em stitch.withgoogle.com)
export STITCH_API_KEY="<sua-chave>"
```

### Configurar MCP Server no VS Code

```json
// .vscode/mcp.json (ou User settings.json)
{
  "mcp": {
    "servers": {
      "stitch": {
        "url": "https://stitch.googleapis.com/mcp",
        "env": { "STITCH_API_KEY": "${env:STITCH_API_KEY}" }
      }
    }
  }
}
```

### Workflow por componente

1. **Gerar referência** — skill `stitch-design`:  
   `"Material Design 3 <ComponentName> — <variantes>, dark mode, Zodiak brand palette"`
2. **Exportar DESIGN.md** — skill `design-md`:  
   Gera `.stitch/DESIGN.md` com tokens Zodiak como contexto de ingestão
3. **Comparar** — confrontar referência HTML/screenshot com `Zodiak<X>.kt`
4. **15-point checklist** — executar todos os pontos abaixo
5. **Documentar** — adicionar findings ao GAPS.md com formato completo

---

## Checklist MD3 por Componente (15 pontos)

```
[ ] 1.  Semantics: contentDescription, stateDescription, role (semantics { }) presentes
[ ] 2.  TalkBack: ordem de foco lógica, mergePolicies corretas
[ ] 3.  Hit-target: mínimo 48dp × 48dp (WCAG 2.5.5 / MD3) — via ZodiakHitTarget
[ ] 4.  Dynamic Font: texto usa sp (não dp), escala de fonte do sistema respeitada
[ ] 5.  Dark mode: cores via MaterialTheme.colorScheme.* ou ZodiakTheme.colors.*, sem Color(0xFF...) hardcoded
[ ] 6.  Dynamic Color (Material You): responde a wallpaper colors onde aplicável (API 31+)
[ ] 7.  Reduce Motion: animações verificam LocalReduceMotionEnabled.current (API 26+)
[ ] 8.  Tokens de spacing: valores em 4dp grid via ZodiakSpacing.*, sem literal Xdp hardcoded
[ ] 9.  Elevation: via Compose elevation / ZodiakShadows token — sem shadow manual
[ ] 10. Shape: via MaterialTheme.shapes.* ou ZodiakShapes — sem hardcode dp em RoundedCornerShape
[ ] 11. RTL: uso de Start/End (não Left/Right) + Modifier.mirror para ícones direcionais
[ ] 12. Estado (loading/error/disabled): todos os estados especificados e implementados
[ ] 13. Keyboard navigation: Tab order correto, ImeAction configurada, onKeyEvent para Escape
[ ] 14. Contrast: ratio AA mínimo (4.5:1 texto normal, 3:1 texto grande) — verificar light e dark
[ ] 15. Conformidade visual Stitch: hierarquia, espaçamento e paleta são equivalentes à referência gerada
```

---

## Componentes a auditar

### Wave 1 — Molecules (prioridade por uso real nas features)

| Componente | Arquivo | Status |
|---|---|---|
| `ZodiakAlert` | `molecules/ZodiakAlert.kt` | ⏳ Pendente |
| `ZodiakChipGroup` | `molecules/ZodiakChipGroup.kt` | ⏳ Pendente |
| `ZodiakInputField` | `molecules/ZodiakInputField.kt` | ⏳ Pendente |
| `ZodiakSwitch` | `molecules/ZodiakSwitch.kt` | ⏳ Pendente |

### Wave 2 — Atoms

| Componente | Arquivo | Status |
|---|---|---|
| `ZodiakButton` | `atoms/ZodiakButton.kt` | ⏳ Pendente |
| `ZodiakBadge` | `atoms/ZodiakBadge.kt` | ⏳ Pendente |
| `ZodiakText` | `atoms/ZodiakText.kt` | ⏳ Pendente |
| `ZodiakTextField` | `atoms/ZodiakTextField.kt` | ⏳ Pendente |
| `ZodiakDivider` | `atoms/ZodiakDivider.kt` | ⏳ A implementar (Wave 3) |
| `ZodiakCheckbox` | `atoms/ZodiakCheckbox.kt` | ⏳ A implementar (Wave 3) |
| `ZodiakRadioButton` | `atoms/ZodiakRadioButton.kt` | ⏳ A implementar (Wave 3) |
| `ZodiakTabs` | `atoms/ZodiakTabs.kt` | ⏳ A implementar (Wave 3) |
| `ZodiakProgressIndicator` | `atoms/ZodiakProgressIndicator.kt` | ⏳ A implementar (Wave 3) |
| `ZodiakIconView` | `atoms/ZodiakIconView.kt` | ⏳ A implementar (Wave 3) |

### Wave 3 — Organisms

| Componente | Arquivo | Status |
|---|---|---|
| `ZodiakFormContainer` | `organisms/ZodiakFormContainer.kt` | ⏳ Pendente |
| `ZodiakInfoRow` | `organisms/ZodiakInfoRow.kt` | ⏳ Pendente |
| `ZodiakEmptyState` | `organisms/ZodiakEmptyState.kt` | ⏳ Pendente |
| `ZodiakModal` | `organisms/ZodiakModal.kt` | ⏳ A implementar (Wave 5) |
| `ZodiakNotificationBanner` | `organisms/ZodiakNotificationBanner.kt` | ⏳ A implementar (Wave 5) |

### Wave 4 — Theme / Foundations

| Componente | Arquivo | Status |
|---|---|---|
| `ZodiakColorTokens` | `theme/ZodiakColorTokens.kt` | ⏳ Em validação (Wave 1) |
| `ZodiakSemanticColors` | `theme/ZodiakSemanticColors.kt` | ⏳ Pendente |
| `Typography` | `theme/Typography.kt` | ⏳ Em validação (Wave 1) |
| `ZodiakTheme` | `theme/ZodiakTheme.kt` | ⏳ Pendente |
| `Shape` | `theme/Shape.kt` | ⏳ Pendente |
| `ZodiakGrid` | `theme/ZodiakGrid.kt` | ⏳ A implementar (Wave 1) |
| `ZodiakHitTarget` | `theme/ZodiakHitTarget.kt` | ⏳ A implementar (Wave 1) |
| `ZodiakSpacing` | `theme/ZodiakSpacing.kt` | ⏳ A implementar (Wave 1 — User) |
| `ZodiakSizing` | `theme/ZodiakSizing.kt` | ⏳ A implementar (Wave 1 — User) |
| `ZodiakShadows` | `theme/ZodiakShadows.kt` | ⏳ A implementar (Wave 1 — User) |
| `ZodiakIcons` | `theme/ZodiakIcons.kt` | ⏳ A implementar (Wave 1 — User) |

---

## Auditoria Wave 1 — ZodiakAlert (primeiro componente)

> ZodiakAlert é o `ZodiakModal` do Android: componente de diálogo de maior risco de regressão de a11y.

### Prompt Stitch de referência

```
Material Design 3 Alert Dialog — title, supporting text, two action buttons (cancel + confirm),
dark mode support, proper elevation (tonalElevation = 6dp, shadowElevation = 0dp),
semantic role Dialog for TalkBack, Zodiak brand colors (primary #0058ab), dismiss on outside tap
```

### Pontos de verificação prioritários para ZodiakAlert

```
[ ] 1.  semantics { role = Role.Dialog; paneTitle = "Alert" } no container?
[ ] 2.  dismissOnClickOutside / dismissOnBackPress configurados?
[ ] 3.  Cores via MaterialTheme.colorScheme.* (nenhum Color(0xFF...) no componente)?
[ ] 4.  Botão de confirmação usa colorScheme.primary, botão destrutivo usa colorScheme.error?
[ ] 5.  Reduce Motion: animação de entrada respeita LocalReduceMotionEnabled.current?
[ ] 6.  API title: aceita AnnotatedString / String sem hardcode de @StringRes? (ver G-006)
[ ] 7.  Elevation: tonalElevation via ZodiakShadows token (não hardcoded 6.dp)?
[ ] 8.  Conformidade visual Stitch: hierarquia, espaçamento e paleta batem com referência?
[ ] 9.  FocusRequester + LaunchedEffect para foco inicial no primeiro botão (TalkBack)?
[ ] 10. BackHandler presente (Escape / Back gesture fecha o dialog)?
```

---

## Referências

- [android-execution-plan.md](android-execution-plan.md) — playbook completo com fases e branches
- [GAPS.md](../GAPS.md) — gaps Android iniciam em G-071
- [Material Design 3 Guidelines](https://m3.material.io)
- [Stitch](https://stitch.withgoogle.com)
- [Accessibility — Compose](https://developer.android.com/jetpack/compose/accessibility)
