# Plano de Execução — Android DS (baseado na sessão iOS)

> **Gerado em**: 2026-05-17 · **Baseado em**: sessão completa de implementação + auditoria iOS
> **Referência iOS**: PRs #187–#215, GAPS.md G-001–G-070, `07-audit/hig-review-ios.md`

Este documento é o playbook direto para replicar no Android o que foi executado no iOS.
Cada fase mapeia uma etapa real da sessão iOS com a adaptação necessária para Compose + Material Design 3.

> **Nota sobre issues**: iOS e Android compartilham o mesmo tracker de issues (`mflipe/zodiak-mobile`). Os números de issue (#7, #18, etc.) são os mesmos para ambas as plataformas — cada issue representa a implementação do componente DS nas duas plataformas.

---

## Estado atual do Android DS

### Implementado em `design-system/`

| Camada | Arquivos |
|---|---|
| **Theme** | `Color.kt`, `Shape.kt`, `Typography.kt`, `ZodiakColorTokens.kt`, `ZodiakSemanticColors.kt`, `ZodiakTheme.kt` |
| **Atoms** | `ZodiakBadge.kt`, `ZodiakButton.kt`, `ZodiakText.kt`, `ZodiakTextField.kt` |
| **Molecules** | `ZodiakAlert.kt`, `ZodiakChipGroup.kt`, `ZodiakInputField.kt`, `ZodiakSwitch.kt` |
| **Organisms** | `ZodiakEmptyState.kt`, `ZodiakFormContainer.kt`, `ZodiakInfoRow.kt` |

**Total: ~17 componentes** (iOS tem 110+). A maioria dos P0 de atoms, molecules e organisms ainda não existe.

### Features já implementadas (app/)
`bookreader`, `cardmanager`, `catalog`, `currencyconverter`, `grades`, `guessgame`, `login`, `multiplication`, `palindrome`, `personmanager`, `pixdiscount`, `productmanager`, `quizgame`, `shopmaster`, `studentgrades`, `taskmanager`, `temperatureconverter`, `themeswitch`, `voting`

Essas features são **referências de uso real** — os componentes de DS que criarmos devem ser validados substituindo os primitivos dessas telas.

---

## Otimizações aprendidas na sessão iOS

> Estas otimizações foram identificadas durante a execução real. Aplique-as do início para não ter retrabalho.

| # | Otimização | Por quê |
|---|---|---|
| 1 | **ELI5 é parte do template de gap** | Na sessão iOS foi adicionado retroativamente a 70 gaps. Escrever junto economiza uma fase inteira. |
| 2 | **Auditar por camada, não por componente** | Atoms compartilham as mesmas skills; agrupar reduz contexto trocado. |
| 3 | **Referenciar gaps iOS existentes** | G-003 (tipografia), G-004 (spacing), G-005 (shadow/elevation), G-007 (grid) já documentam o problema raiz. Gaps Android podem ter `Ver também: G-00X`. |
| 4 | **Criar branch de auditoria separado** | iOS misturou fixes e audit no mesmo branch. Para Android: branch `feat/backlog-stitch-audit-android` separado de implementação. |
| 5 | **Sincronizar Android DS skill antes de auditar** | Rodar o agente `Android DS Knowledge Sync` antes de cada wave de auditoria para garantir que o skill file está atualizado. |
| 6 | **Gap template padronizado com ELI5** | Ver seção [Formato de Gap](#formato-de-gap-android) abaixo — não omitir nenhum campo. |
| 7 | **Issues são compartilhadas iOS/Android** | Não criar issues novas. Adicionar label `platform: android` e comentar na issue existente quando uma implementação Android for criada. |

---

## Fases de execução

### Fase 0 — Preparação (1× por projeto)

**iOS equivalente:** adição do submodule `hig-doctor` + 14 HIG skills symlinks (PR #214).

**Android equivalente:** configurar o **Stitch MCP server** + instalar as **Stitch Skills** como fonte de autoridade de design — o equivalente exato do `hig-doctor`, mas para Material Design (Google Labs).

#### O que é Stitch

[Stitch](https://stitch.withgoogle.com) é o design canvas AI-native do Google Labs. Gera telas de alta fidelidade seguindo Material Design 3 a partir de prompts em linguagem natural. Para auditorias de DS, Stitch funciona como:
- **Referência de implementação**: gera a versão "ideal" de um componente MD3 para comparar com a implementação Zodiak
- **Validador de design system**: usa `DESIGN.md` para ingerir os tokens do Zodiak e gerar telas consistentes
- **Autoridade MD3**: a IA de geração é treinada sobre Material Design Guidelines — os resultados são a referência canônica

#### Setup do Stitch MCP (1× por máquina)

```bash
# 1. Instalar as Stitch Skills globalmente (equivalente dos symlinks hig-doctor)
npx skills add google-labs-code/stitch-skills --skill stitch-design --global
npx skills add google-labs-code/stitch-skills --skill design-md --global
npx skills add google-labs-code/stitch-skills --skill enhance-prompt --global

# 2. Configurar MCP server no VS Code (settings.json ou .vscode/mcp.json):
# {
#   "mcp": {
#     "servers": {
#       "stitch": {
#         "url": "https://stitch.googleapis.com/mcp",
#         "env": { "STITCH_API_KEY": "${env:STITCH_API_KEY}" }
#       }
#     }
#   }
# }
#
# Documentação completa: https://stitch.withgoogle.com/docs/mcp/setup/

# 3. Exportar API key (obter em stitch.withgoogle.com)
export STITCH_API_KEY="<sua-chave>"
```

#### Skills Stitch disponíveis (análogo às 14 HIG skills)

| Skill | Instalação | Uso na auditoria |
|---|---|---|
| `stitch-design` | `npx skills add ... --skill stitch-design` | Gera telas de referência MD3 por prompt; edita telas existentes |
| `design-md` | `npx skills add ... --skill design-md` | Exporta `DESIGN.md` do Zodiak DS para ingestão no Stitch |
| `enhance-prompt` | `npx skills add ... --skill enhance-prompt` | Melhora prompts para auditoria → gera referências mais precisas |

#### SDK para uso programático (opcional)

```bash
npm install @google/stitch-sdk
# STITCH_API_KEY no environment
```

```typescript
import { stitch } from "@google/stitch-sdk";
// Gerar tela de referência para componente
const project = stitch.project("zodiak-android-audit");
const screen = await project.generate(
  "Material Design 3 Alert Dialog with title, body text, and two action buttons"
);
const html = await screen.getHtml();  // HTML da referência para comparar
```

#### Ação de preparação

```bash
# 1. Instalar Stitch skills (uma vez)
npx skills add google-labs-code/stitch-skills --skill stitch-design --global
npx skills add google-labs-code/stitch-skills --skill design-md --global

# 2. Criar branch de auditoria dedicado
git checkout main && git pull
git checkout -b feat/backlog-stitch-audit-android

# 3. Rodar Android DS Knowledge Sync (agente)
# → Garante que .github/skills/android-zodiak-ds/ reflete os 17 componentes atuais

# 4. Criar o documento de user story de auditoria
# → docs/backlog/07-audit/stitch-review-android.md  (análogo a hig-review-ios.md)
```

---

### Fase 1 — User Story de Auditoria Stitch

**iOS equivalente:** `docs/backlog/07-audit/hig-review-ios.md` (PR #215).

Criar `docs/backlog/07-audit/stitch-review-android.md` com:
- Contexto: o Android DS tem ~17 componentes sem revisão Stitch/MD3
- História: Como agente/dev Android, quero revisar cada componente contra Material Design 3 usando Stitch como fonte canônica
- Cenários Gherkin: cobertura total, findings por área, critérios de severidade
- Checklist por componente (ver abaixo)
- Formato de output para GAPS.md

#### Metodologia de auditoria Stitch

Para cada componente auditado, o workflow é:
1. **Gerar referência**: usar `stitch-design` skill para gerar a versão ideal MD3 do componente
2. **Comparar**: confrontar a referência Stitch com a implementação Zodiak Android
3. **Identificar gaps**: registrar desvios de tokens, acessibilidade, dark mode, estados, etc.
4. **Documentar**: adicionar ao GAPS.md com formato completo (incluindo ELI5)

#### Checklist de auditoria Stitch/MD3 por componente (15 pontos)

```
[ ] 1. Semantics: contentDescription, stateDescription, role (semantics { }) presentes
[ ] 2. TalkBack: ordem de foco lógica, mergePolicies corretas
[ ] 3. Hit-target: mínimo 48dp × 48dp (WCAG 2.5.5 / MD3)
[ ] 4. Dynamic Font: suporte a escala de fonte do sistema (sp, não dp para texto)
[ ] 5. Dark mode: cores via MaterialTheme.colorScheme.*, sem Color(0xFF...) hardcoded
[ ] 6. Dynamic Color (Material You): responde a wallpaper colors onde aplicável (API 31+)
[ ] 7. Reduce Motion: animações verificam LocalReduceMotionEnabled.current
[ ] 8. Tokens: spacing em 4dp grid via ZodiakSpacing.*, sem literal dp hardcoded
[ ] 9. Elevation: via Compose elevation / ZodiakShadows token — sem shadow manual
[ ] 10. Shape: via MaterialTheme.shapes.* ou ZodiakRadii — sem hardcode dp
[ ] 11. RTL: uso de Start/End (não Left/Right) + Modifier.mirror para ícones direcionais
[ ] 12. Estado (loading/error/disabled): todos os estados especificados e implementados
[ ] 13. Keyboard navigation: Tab order correto, ação de teclado (ImeAction) configurada
[ ] 14. Contrast: ratio mínimo AA (4.5:1 texto normal, 3:1 texto grande) validado
[ ] 15. Conformidade visual Stitch: a tela gerada pelo Stitch e o componente Zodiak são visualmente equivalentes em hierarquia, espaçamento e paleta
```

---

### Fase 2 — Waves de Implementação do DS

**iOS executado:** PRs #187–#212 · 31 PRs · 5 ondas · split 15 (user) + 16 (agente).

**Android equivalente:** mesma estrutura de ondas, componentes adaptados para Compose + Material Design 3.

---

#### Referência: plano iOS executado (31 PRs)

> Manter como guia de sequência, dependências entre ondas e convenção de naming de branches.

**Regra de operação iOS:** usuário reivindica metade com `gh issue edit --assignee` primeiro; agente verifica assignees e pega o restante sem conflito. Agente de execução: **`iOS DS Feature Builder`** com nome do componente como argumento.

##### Onda 1 — Foundations + Utils (paralela, sem dependência)

| Executor | Issue | Componente | Branch |
|---|---|---|---|
| **User** | #7 | colors | `feature/ds-foundation-colors-ios` |
| **User** | #18 | shadows | `feature/ds-foundation-shadows-ios` |
| **User** | #19 | sizing | `feature/ds-foundation-sizing-ios` |
| **User** | #20 | spacing | `feature/ds-foundation-spacing-ios` |
| **User** | #21 | typography | `feature/ds-foundation-typography-ios` |
| **User** | #120 | font-modifier | `feature/ds-utils-font-modifier-ios` |
| **Agente** | #6 | borders | `feature/ds-foundation-borders-ios` |
| **Agente** | #11 | grid | `feature/ds-foundation-grid-ios` |
| **Agente** | #12 | hit-target | `feature/ds-foundation-hit-target-ios` |
| **Agente** | #13 | icons | `feature/ds-foundation-icons-ios` |
| **Agente** | #17 | radii | `feature/ds-foundation-radii-ios` |
| **Agente** | #118 | accessibility-helpers | `feature/ds-utils-accessibility-helpers-ios` |

##### Onda 2 — Theme *(depende de Onda 1)*

| Executor | Issue | Branch |
|---|---|---|
| **User** | #22 ZodiakTheme | `feature/ds-theme-zodiak-theme-ios` |

##### Onda 3 — Atoms *(depende de Onda 2, paralela)*

| Executor | Issue | Componente | Branch |
|---|---|---|---|
| **User** | #28 | button-icon | `feature/ds-atom-button-icon-ios` |
| **User** | #32 | button-regular | `feature/ds-atom-button-regular-ios` |
| **User** | #45 | password-field | `feature/ds-atom-password-field-ios` |
| **User** | #52 | text-field | `feature/ds-atom-text-field-ios` |
| **User** | #54 | text | `feature/ds-atom-text-ios` |
| **Agente** | #37 | checkbox | `feature/ds-atom-checkbox-ios` |
| **Agente** | #38 | divider | `feature/ds-atom-divider-ios` |
| **Agente** | #41 | icon-view | `feature/ds-atom-icon-view-ios` |
| **Agente** | #46 | progress-indicator | `feature/ds-atom-progress-indicator-ios` |
| **Agente** | #47 | radio-button | `feature/ds-atom-radio-button-ios` |
| **Agente** | #51 | tabs | `feature/ds-atom-tabs-ios` |

##### Onda 4 — Molecules *(depende de Onda 3)*

| Executor | Issue | Componente | Branch |
|---|---|---|---|
| **User** | #73 | switch | `feature/ds-molecule-switch-ios` |
| **Agente** | #64 | labelled-field | `feature/ds-molecule-labelled-field-ios` |
| **Agente** | #66 | notice | `feature/ds-molecule-notice-ios` |

##### Onda 5 — Organisms + Templates *(depende de Onda 4)*

| Executor | Issue | Componente | Branch |
|---|---|---|---|
| **User** | #102 | modal | `feature/ds-organism-modal-ios` |
| **User** | #116 | layout-grid | `feature/ds-template-layout-grid-ios` |
| **Agente** | #103 | notification-banner | `feature/ds-organism-notification-banner-ios` |
| **Agente** | #115 | adaptive-template | `feature/ds-template-adaptive-ios` |

**Contagem iOS:** User = 15 PRs · Agente = 16 PRs · Total = 31 PRs

---

#### Plano Android — Split e Ondas (adaptar ao criar issues Android)

> Mesma lógica de split: user reivindica primeiro, agente pega o restante sem conflito.
> **Agente de execução**: `Android DS Feature Builder` com nome do componente como argumento.

**Pré-requisito:** criar issues GitHub para cada componente Android abaixo, então rodar o assign:

```bash
# User reivindica sua metade primeiro (ajustar issue numbers reais após criação)
for issue in <ISSUES_USER>; do
  gh issue edit $issue --repo mflipe/zodiak-mobile --assignee mflipe
done
```

##### Onda 1 — Foundations + Utils Android (paralela, sem dependência)

| Executor | Componente | Arquivo | Observação | Branch |
|---|---|---|---|---|
| **User** | `ZodiakSpacing` | `theme/ZodiakSpacing.kt` | G-004 — escala 4dp | `feature/ds-foundation-spacing-android` |
| **User** | `ZodiakSizing` | `theme/ZodiakSizing.kt` | — | `feature/ds-foundation-sizing-android` |
| **User** | `ZodiakShadows` | `theme/ZodiakShadows.kt` | G-005 — elevation tokens | `feature/ds-foundation-shadows-android` |
| **User** | `ZodiakIcons` | `theme/ZodiakIcons.kt` | G-008 — filled vs outlined | `feature/ds-foundation-icons-android` |
| **Agente** | `ZodiakGrid` | `theme/ZodiakGrid.kt` | G-007 — colunas/gutters | `feature/ds-foundation-grid-android` |
| **Agente** | `ZodiakHitTarget` | `theme/ZodiakHitTarget.kt` | G-060 — 48dp mínimo | `feature/ds-foundation-hit-target-android` |
| **Agente** | Validar `ZodiakColorTokens` | `theme/ZodiakColorTokens.kt` | G-001/G-002 — primitive→semantic | `feature/ds-foundation-colors-android` |
| **Agente** | Validar `Typography` | `theme/Typography.kt` | G-003 — mapeamento DS → MD3 scale | `feature/ds-foundation-typography-android` |

##### Onda 2 — Theme Android *(depende de Onda 1)*

| Executor | Componente | Branch |
|---|---|---|
| **User** | Validar/completar `ZodiakTheme.kt` — DynamicColor, dark mode tokens | `feature/ds-theme-android` |

##### Onda 3 — Atoms Android *(depende de Onda 2, paralela)*

| Executor | Componente | Arquivo | MD3 base | Branch |
|---|---|---|---|---|
| **User** | `ZodiakDivider` | `atoms/ZodiakDivider.kt` | `HorizontalDivider` | `feature/ds-atom-divider-android` |
| **User** | `ZodiakCheckbox` | `atoms/ZodiakCheckbox.kt` | MD3 `Checkbox` | `feature/ds-atom-checkbox-android` |
| **User** | `ZodiakRadioButton` | `atoms/ZodiakRadioButton.kt` | MD3 `RadioButton` | `feature/ds-atom-radio-button-android` |
| **Agente** | `ZodiakTabs` | `atoms/ZodiakTabs.kt` | `TabRow` / `ScrollableTabRow` — G-014 | `feature/ds-atom-tabs-android` |
| **Agente** | `ZodiakProgressIndicator` | `atoms/ZodiakProgressIndicator.kt` | `LinearProgressIndicator` + circular — G-020 | `feature/ds-atom-progress-indicator-android` |
| **Agente** | `ZodiakIconView` | `atoms/ZodiakIconView.kt` | Wrapper `Icon` + ZodiakIcons | `feature/ds-atom-icon-view-android` |

##### Onda 4 — Molecules Android *(depende de Onda 3)*

| Executor | Componente | Arquivo | Observação | Branch |
|---|---|---|---|---|
| **User** | `ZodiakLabelledField` | `molecules/ZodiakLabelledField.kt` | `OutlinedTextField` + semantics | `feature/ds-molecule-labelled-field-android` |
| **Agente** | `ZodiakNotice` | `molecules/ZodiakNotice.kt` | G-021 — tokens Info/Success/Error | `feature/ds-molecule-notice-android` |

##### Onda 5 — Organisms Android *(depende de Onda 4)*

| Executor | Componente | Arquivo | Observação | Branch |
|---|---|---|---|---|
| **User** | `ZodiakModal` | `organisms/ZodiakModal.kt` | MD3 `AlertDialog` — G-033, G-022 | `feature/ds-organism-modal-android` |
| **Agente** | `ZodiakNotificationBanner` | `organisms/ZodiakNotificationBanner.kt` | MD3 `Snackbar` customizado — G-038 | `feature/ds-organism-notification-banner-android` |

**Contagem Android:** User = 8 PRs · Agente = 8 PRs · Total = 16 PRs (P0 inicial)

> Após cada onda, rodar `Android DS Knowledge Sync` para manter o skill file atualizado antes da auditoria MD3.

---

### Fase 3 — Auditoria Stitch (Wave 1)

**iOS equivalente:** Auditoria HIG do `ZodiakModal` → 9 findings (G-062 a G-070) — usando hig-doctor skills.

**Android equivalente:** Auditar `ZodiakAlert.kt` (molecules) como primeiro componente — usando Stitch como referência canoníca MD3.

#### Exemplo de execução (ZodiakAlert — Android)

```
# Passo 1 — Gerar referência Stitch
# (via skill stitch-design no agente)
Prompt: "Material Design 3 Alert Dialog — title, body, two action buttons (cancel + confirm),
dark mode support, proper elevation, semantic roles for TalkBack, Zodiak brand colors"

Comparar o output HTML/screenshot com ZodiakAndroid/design-system/molecules/ZodiakAlert.kt

# Passo 2 — Pontos de verificação prioritários (checklist, pontos mais críticos para Alert):
  1. semantics { role = Role.Dialog } no container?
  2. dismissOnClickOutside / dismissOnBackPress configurados?
  3. Cores via MaterialTheme.colorScheme.* (sem hardcode)?
  4. Botão destrutivo com MaterialTheme.colorScheme.error?
  5. Reduce Motion: animação de entrada respeita LocalReduceMotionEnabled.current?
  6. API title: @StringRes Int vs String — ambiguidade de localização?
  7. Elevation: Compose shadow vs token ZodiakShadows?
  8. Conformidade visual: hierarquia, espaçamento e paleta batem com referência Stitch?
```

---

### Fase 4 — Gaps Android em GAPS.md

**iOS equivalente:** G-062 a G-070 adicionados após auditoria HIG; ELI5 adicionado retroativamente a todos os 70 gaps.

**Android equivalente:** usar o formato completo **desde o início** — sem retrabalho retroativo.

#### Formato de gap Android (template)

```markdown
### G-XXX — [Componente] — [Resumo curto]
- **Tipo**: token | estado | a11y | dark | plataforma | inconsistência | decisão
- **Plataforma**: Android
- **Severidade Stitch**: serious | moderate | suggestion  *(para gaps de auditoria)*
- **Impacto**: P0 | P1 | P2
- **Referência Stitch**: prompt usado para gerar a referência + URL do projeto Stitch (se aplicável)
- **Descrição**: O que está errado ou faltando.
- **Referência Android**: `ZodiakAndroid/design-system/.../Zodiak<X>.kt` (linha ...)
- **Recomendação**:
  ```kotlin
  // código da correção
  ```
- **ELI5**: Explicação em linguagem simples do porquê do problema e o que acontece se ignorado.
- **Ver também**: G-00X *(se há gap iOS relacionado)*
- **Status**: Aberto
```

> **Regra**: nenhum gap Android entra no GAPS.md sem ELI5.

#### Seção a criar em GAPS.md

Após o bloco "HIG Review — iOS (Audit Wave 1)", adicionar:

```markdown
---

## Stitch Review — Android (Audit Wave 1)

> Findings gerados por revisão sistemática usando **Stitch** (Google Labs) como referência
> canônica de Material Design 3. Cada componente é comparado contra uma tela gerada pelo
> Stitch com o mesmo prompt. Metodologia definida em [07-audit/stitch-review-android.md](07-audit/stitch-review-android.md).

### Componente auditado: `ZodiakAlert` (Molecules/ZodiakAlert.kt)
```

---

### Fase 5 — Atualizar README do backlog

**iOS equivalente:** PR #213 — corrigiu Alert e Toast de P0 → P1 no README.

**Android equivalente:** ao criar componentes Android, verificar se o README do backlog:
- Lista os componentes Android implementados separadamente dos iOS
- Prioridades P0/P1/P2 batem com os spec files

---

## Sequência completa de comandos Git/GitHub

```bash
# ─── Setup inicial (1× por máquina) ──────────────────────────────────────────
export STITCH_API_KEY="<sua-chave>"                   # obter em stitch.withgoogle.com
npx skills add google-labs-code/stitch-skills --skill stitch-design --global
npx skills add google-labs-code/stitch-skills --skill design-md --global

git checkout main && git pull
git checkout -b feat/backlog-stitch-audit-android
# Criar stitch-review-android.md, commit, push, abrir PR

# ─── Reivindicar issues (MESMAS issues do iOS — adicionar label Android) ──────
# IMPORTANTE: iOS e Android compartilham os mesmos números de issue.
# Adicionar label 'platform: android' + assignee antes de iniciar:
for issue in <ISSUES_USER>; do
  gh issue edit $issue --repo mflipe/zodiak-mobile --add-label "platform: android"
  gh issue edit $issue --repo mflipe/zodiak-mobile --assignee mflipe
done
# Depois o agente verifica assignees e pega os restantes livres

# ─── Wave de implementação (repetir por branch) ───────────────────────────────
git checkout main && git pull
git checkout -b feature/ds-foundation-spacing-android
# Implementar via agente: "Android DS Feature Builder" → "ZodiakSpacing"
# Testar: cd ZodiakAndroid && ./gradlew :design-system:test
# Lint:   ./gradlew detekt
# Commit com mensagem convencional, push
# Abrir PR: base = main (ou último branch da wave anterior)

# ─── Após cada onda: sync skill + exportar DESIGN.md para Stitch ──────────────
# Agente: Android DS Knowledge Sync
# Skill design-md: gera .stitch/DESIGN.md com tokens Zodiak (contexto para Stitch)

# ─── Auditoria Stitch (em branch separado) ────────────────────────────────────
git checkout feat/backlog-stitch-audit-android
# Skill stitch-design: gerar tela de referência MD3 para o componente auditado
# Comparar com implementação Zodiak, documentar gaps
# Editar GAPS.md: seção "Stitch Review — Android (Audit Wave N)"
# Commit: "feat(audit): Stitch Review Wave 1 — ZodiakAlert (N findings, G-XXX..G-YYY)"
git push
```

---

## Diferenças críticas iOS → Android

| Aspecto | iOS (SwiftUI) | Android (Compose) |
|---|---|---|
| **Accessibility API** | `.accessibilityLabel`, `.accessibilityHint`, `.accessibilityAddTraits` | `Modifier.semantics { contentDescription = ""; role = Role.X }` |
| **Leitor de tela** | VoiceOver | TalkBack |
| **Modal a11y** | `.accessibilityViewIsModal(true)` | `semantics { role = Role.Dialog }` + `paneTitle` |
| **Foco inicial em modal** | `.accessibilityFocused()` + `onChange(of:)` | `FocusRequester()` + `LaunchedEffect` |
| **Reduce Motion** | `@Environment(\.accessibilityReduceMotion)` | `LocalReduceMotionEnabled.current` (API 26+) ou `Settings.Global.ANIMATOR_DURATION_SCALE` |
| **Dark mode** | Color Assets + `@Environment(\.colorScheme)` | `isSystemInDarkTheme()` + `MaterialTheme.colorScheme.*` |
| **Dynamic Color** | N/A (iOS não tem) | `dynamicLightColorScheme()` / `dynamicDarkColorScheme()` (API 31+) |
| **Sombra / elevação** | `.shadow(color:radius:)` com token | `Modifier.shadow(elevation = Xdp)` + tonal color automático MD3 |
| **Cantos arredondados** | `.clipShape(RoundedRectangle(style:.continuous))` | `MaterialTheme.shapes.medium` ou `RoundedCornerShape(ZodiakRadii.m)` |
| **Haptic** | `UIImpactFeedbackGenerator` | `HapticFeedbackType.LongPress` via `LocalHapticFeedback` |
| **Keyboard shortcut (Escape)** | `.keyboardShortcut(.escape, modifiers: [])` | `BackHandler` (retorna) + `Modifier.onKeyEvent { it.key == Key.Escape }` |
| **Teclado dismiss** | `.ignoresSafeArea(.keyboard)` | `WindowInsets.ime` + `imePadding()` |
| **Breakpoints adaptativos** | `@Environment(\.horizontalSizeClass)` | `WindowSizeClass.compute()` via `calculateWindowSizeClass()` |
| **Localização** | `String(localized: "key")` | `stringResource(R.string.key)` |
| **LocalizedStringKey vs String** | Dois inits explícitos | `@StringRes Int` vs `String` overloads |

---

## Checklist de conclusão de fase

### Wave de implementação (por componente)
- [ ] Compose code revisado contra `android-design-system.instructions.md`
- [ ] Zero warnings Detekt
- [ ] Strings em `values/strings.xml` + `values-pt-BR/strings.xml`
- [ ] Teste unitário do ViewModel (se aplicável)
- [ ] Componente registrado em `ZodiakNavGraph.kt` (se feature) ou em CatalogScreen (se DS)
- [ ] PR aberto e assignado a `mflipe`

### Wave de auditoria (por componente)
- [ ] Tela de referência gerada via Stitch skill `stitch-design` e salva como artefato
- [ ] Checklist Stitch/MD3 de 15 pontos executado
- [ ] Findings adicionados ao GAPS.md com formato completo (incluindo ELI5 e `**Referência Stitch**`)
- [ ] Campos `**Ver também**: G-00X` preenchidos para gaps com raiz iOS compartilhada
- [ ] Resumo por prioridade no final de GAPS.md atualizado
- [ ] Commit mensagem segue: `feat(audit): Stitch Review Wave N — ComponentName (N findings, G-XXX..G-YYY)`

---

## Agentes disponíveis para Android

| Agente | Quando usar |
|---|---|
| `Android DS Feature Builder` | Criar um feature module completo do zero (ViewModel + Screen + Navigation + Strings + Tests) |
| `Android DS Knowledge Sync` | Após adicionar/alterar componentes em `design-system/` — atualiza o skill file |
| `Explore` | Mapear código existente antes de implementar (rápido, sem poluir o chat) |
