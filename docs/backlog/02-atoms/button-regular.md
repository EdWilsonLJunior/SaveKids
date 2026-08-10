# Button Regular

> **Categoria**: Atom (Button) · **Prioridade**: P0 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Sim

## Contexto
Botão padrão Zodiak. **Quatro estilos públicos** — `Primary`, `Secondary`, `Tertiary`, `Ghost` — sobre primitivo interno `ZodiakButtonImpl`. Suporta superfícies `onLite`, `onHeavy`, `onPhoto` (conforme Supernova).

## História de usuário
Como **usuário**, quero **executar a ação principal/secundária com um botão claro** para **navegar ou confirmar com confiança**.

## Critérios de aceite

### Cenário 1 — Variantes
**Dado** APIs públicas `ZodiakButtonPrimary`, `ZodiakButtonSecondary`, `ZodiakButtonTertiary`, `ZodiakButtonGhost`
**Então** cada uma renderiza com tokens corretos por Supernova.

### Cenário 2 — Superfícies
**Dado** `surface: ZodiakSurface.onLite | ZodiakSurface.onHeavy | ZodiakSurface.onPhoto`
**Então** cor/contraste resolvem conforme Supernova `Specs - Regular button (onLite|onHeavy|onPhoto)`.

### Cenário 3 — Estados
**Dado** `default / hover / pressed / focused / disabled / loading`
**Então** estados visuais corretos; durante `loading`, mostra `ZodiakProgressIndicator` circular e desabilita toque.

### Cenário 4 — Tamanhos
**Dado** `size: .small / .medium / .large`
**Então** altura, padding e tipografia escalam (tokens `sizing.button*`).

### Cenário 5 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** anuncia "<label>, botão"; estado `disabled` anuncia "indisponível"; `loading` anuncia "carregando".

### Cenário 6 — Hit-target
**Dado** botão em tamanho `small`
**Então** padding garante hit-target ≥ `Zodiak.hitTarget.minimum`.

### Cenário 7 — Reduce Motion
**Dado** Reduce Motion ativo
**Então** sem scale-bounce; apenas mudança de cor.

## Spec técnica

### APIs públicas
- `ZodiakButtonPrimary(title: String, surface: ZodiakSurface = ZodiakSurface.onLite, size: ZodiakButtonSize = ZodiakButtonSize.medium, isLoading: Bool = false, isEnabled: Bool = true, leadingIcon: ZodiakIcon? = none, trailingIcon: ZodiakIcon? = none, action: Action)`.
- Mesmo padrão para `ZodiakButtonSecondary`, `ZodiakButtonTertiary`, `ZodiakButtonGhost`.

### Primitivo interno
- `internal ZodiakButtonImpl(title, style: ZodiakButtonStyle, surface, size, isLoading, isEnabled, leadingIcon, trailingIcon, action)`.
- APIs públicas são wrappers finos que fixam `style`.

### Tokens
- Cores: ver Supernova `Specs - Regular button (onLite|onHeavy|onPhoto)`.
- Altura: `Zodiak.sizing.buttonHeightSm/Md/Lg`.
- Tipografia: `typography.labelLarge`.
- Raio: `radii.full` (pílula) ou `radii.md` (conforme spec).
- Padding: `spacing.s16` horizontal (medium).

## Boas práticas — iOS
- SwiftUI: `Button(action:) { Label(...) }`. Custom via `.buttonStyle(ZodiakPrimaryStyle())`.
- HIG: [Buttons](https://developer.apple.com/design/human-interface-guidelines/buttons).
- `.disabled(...)` + `.opacity(...)` controlado por style.
- `.hoverEffect(.lift)` em iPad com pointer.
- `.sensoryFeedback(.impact, trigger: action)` (iOS 17+).
- Loading: `ProgressView()` substitui ícone trailing.

## Boas práticas — Android
- Material 3: base `Button` / `OutlinedButton` / `TextButton` / `FilledTonalButton` — Zodiak mapeia:
  - `Primary` → `Button` (filled).
  - `Secondary` → `FilledTonalButton`.
  - `Tertiary` → `OutlinedButton`.
  - `Ghost` → `TextButton`.
- `ButtonDefaults.buttonColors(...)` consumindo `ZodiakTheme.colors`.
- `interactionSource` + `LocalRippleConfiguration` para ripple Zodiak.
- M3 Expressive: shape morphing em press (`MaterialShapes`).
- Loading: `Box(contentAlignment = Center) { if (isLoading) CircularProgressIndicator(...) else Row { ... } }`.

## Acessibilidade
- Papel `button`.
- `accessibilityHint` quando ação não é óbvia.
- Hit-target sempre ≥ `Zodiak.hitTarget.minimum` (padding interno se size pequeno).
- Foco visível.
- Disabled anunciado.

## Referências
- [iOS `Atoms/Button/ZodiakButton.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Atoms/Button/ZodiakButton.swift)
- [Supernova: Overview](../../ZodiakiOS/docs/zodiak-pdf/Overview%20-%20Regular%20button.md)
- [Supernova: Guidelines (button)](../../ZodiakiOS/docs/zodiak-pdf/Guidelines%20-%20Button.md)
- [Supernova: Guidelines (regular)](../../ZodiakiOS/docs/zodiak-pdf/Guidelines%20-%20Regular%20button.md)
- [Supernova: Specs onLite](../../ZodiakiOS/docs/zodiak-pdf/Specs%20-%20Regular%20button%20(onLite).md)
- [Supernova: Specs onHeavy](../../ZodiakiOS/docs/zodiak-pdf/Specs%20-%20Regular%20button%20(onHeavy).md)
- [Supernova: Specs onPhoto](../../ZodiakiOS/docs/zodiak-pdf/Specs%20-%20Regular%20button%20(onPhoto).md)

## Gaps & dúvidas para o time de Design
- [ ] **Ghost** existe oficialmente ou é tratado como `Tertiary`?
- [ ] Token de **focus ring** padronizado entre estilos?
- [ ] Comportamento `loading` mantém largura ou estrutura colapsa?

## DoD
- [ ] 4 APIs públicas + Impl interno.
- [ ] 3 superfícies × 4 estilos × 3 tamanhos × 6 estados snapshotados.
- [ ] Ver [ARCHITECTURE.md § 2](../ARCHITECTURE.md#2-padrão-arquitetural-primitivo-interno--apis-dedicadas-públicas) e [§ 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Importação
```tsx
import { ButtonRegular } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `label` | `string` | — | Texto do botão |
| `hierarchy` | `'primary' \| 'secondary' \| 'tertiary'` | `'primary'` | Hierarquia visual |
| `size` | `'small' \| 'medium' \| 'large'` | `'medium'` | Tamanho |
| `background` | `'onLite' \| 'onHeavy' \| 'onPhoto'` | `'onLite'` | Contexto de superfície |
| `isWarning` | `boolean` | `false` | Aplica tratamento visual de aviso |
| `disabled` | `boolean` | `false` | Estado desabilitado |
| `url` | `string` | — | Renderiza como `<a>` quando fornecido |
| `fullWidth` | `boolean` | `false` | Ocupa toda a largura do contêiner |

### Acessibilidade
- Use `aria-label` para botões cujo texto visível não é descritivo o suficiente.
- `disabled` desabilita interação e anúncio via screen reader.

### Storybook
- `AllOptions`: grade de hierarquias × superfícies × tamanhos
- `Playground`: controles interativos com todos os estados
