# Button Arrow

> **Categoria**: Atom (Button) · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não documentado isoladamente

## Contexto
Botão com seta de avanço (chevron / arrow) — geralmente usado em CTAs editoriais ou navegação para próximo passo. Variante visual do `ZodiakButton` regular onde a seta é parte integral do design (sempre presente, mesmo sem label).

## História de usuário
Como **usuário**, quero **avançar via botão de seta** para **continuar para a próxima etapa com indicação direcional clara**.

## Critérios de aceite

### Cenário 1 — Direções
**Dado** `direction: .forward | .backward | .up | .down`
**Então** seta renderiza na direção correta; em RTL, `.forward`/`.backward` invertem automaticamente.

### Cenário 2 — Estados
**Dado** `default / pressed / disabled / loading`
**Então** estados visuais corretos.

### Cenário 3 — Light/Dark + superfícies
**Dado** `surface: ZodiakSurface.onLite/ZodiakSurface.onHeavy/ZodiakSurface.onPhoto`
**Então** cor da seta + fundo resolvem.

### Cenário 4 — Acessibilidade
**Dado** botão sem label (apenas seta)
**Então** `accessibilityLabel` obrigatório (ex.: "Próximo", "Anterior").

### Cenário 5 — Hit-target
**Dado** botão pequeno
**Então** padding garante ≥ `Zodiak.hitTarget.minimum`.

## Spec técnica

### APIs públicas
- `ZodiakArrowButton(label: String? = none, direction: ZodiakArrowDirection = ZodiakArrowDirection.forward, surface: ZodiakSurface = ZodiakSurface.onLite, size: ZodiakButtonSize = ZodiakButtonSize.medium, isEnabled: Bool = true, action: Action)`.

### Implementação
- Reusa `ZodiakButtonImpl` ou define visual próprio quando difere substancialmente; preferência: usar `ZodiakButtonImpl` + `trailingIcon: .chevronRight` (forward).

### Tokens
- Herda de [button-regular](button-regular.md).

## Boas práticas — iOS
- SF Symbols `chevron.right` com `.flipsForRightToLeftLayoutDirection(true)`.
- `.sensoryFeedback(.impact)` no tap.

## Boas práticas — Android
- `Icons.Filled.ArrowForward` / `KeyboardArrowRight` (Material Symbols).
- `Modifier.autoMirrored` (Material Symbols já suporta auto-mirror para arrow icons).

## Acessibilidade
- Label semântico OBRIGATÓRIO quando sem texto visível.
- Papel `button`.

## Referências
- [iOS `Atoms/Button/ZodiakArrowButton.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Atoms/Button/ZodiakArrowButton.swift)

## Gaps & dúvidas para o time de Design
- [ ] Existe especificação isolada ou é tratado como variante do regular?
- [ ] Estilos (primary/secondary/tertiary) aplicam ao arrow?

## DoD
- [ ] API com direction.
- [ ] RTL auto-mirror.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Importação
```tsx
import { ButtonArrow } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `ariaLabel` | `string` | — | Rótulo acessível (obrigatório) |
| `size` | `'small' \| 'medium' \| 'large' \| 'xlarge'` | `'large'` | Tamanho |
| `background` | `'onLite' \| 'onHeavy' \| 'onPhoto'` | `'onLite'` | Contexto de superfície |
| `disabled` | `boolean` | `false` | Estado desabilitado |
| `onClick` | `MouseEventHandler` | — | Handler de clique |

### Acessibilidade
- `ariaLabel` é obrigatório — o botão não exibe texto visível.
- O atributo `aria-label` (kebab-case) está bloqueado; use apenas `ariaLabel`.

### Storybook
- `AllOptions`: grade de tamanhos × superfícies
- `Playground`: controles interativos
