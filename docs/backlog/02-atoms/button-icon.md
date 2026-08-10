# Button Icon

> **Categoria**: Atom (Button) · **Prioridade**: P0 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Parcial

## Contexto
Botão composto apenas por um ícone, sem label visível. Quatro estilos públicos (`Primary`, `Secondary`, `Tertiary`, `Ghost`) refletindo o regular, em formato circular (preferencial) ou quadrado-arredondado.

## História de usuário
Como **usuário**, quero **acessar ações compactas via botões de ícone** em **toolbars, headers e cards**.

## Critérios de aceite

### Cenário 1 — Estilos
**Dado** `ZodiakIconButtonPrimary`, `Secondary`, `Tertiary`, `Ghost`
**Então** cada um renderiza com tokens corretos.

### Cenário 2 — Tamanhos
**Dado** `size: .small / .medium / .large`
**Então** ícone escala via `sizing.icon*` e container via `sizing.buttonIcon*`.

### Cenário 3 — Estados
**Dado** estados `default/pressed/disabled/loading`
**Então** visual correto; `loading` substitui ícone por spinner.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** `accessibilityLabel` obrigatório (ex.: "Curtir", "Compartilhar"); papel `button`.

### Cenário 5 — Hit-target
**Dado** `size: .small`
**Então** hit-target estendido por padding para ≥ `Zodiak.hitTarget.minimum` mesmo com ícone visual em `Zodiak.sizing.iconSm`.

## Spec técnica

### APIs públicas
- `ZodiakIconButtonPrimary/Secondary/Tertiary/Ghost(icon: ZodiakIcon, accessibilityLabel: String, surface: ZodiakSurface = ZodiakSurface.onLite, size: ZodiakButtonSize = ZodiakButtonSize.medium, isLoading: Bool = false, isEnabled: Bool = true, shape: ZodiakIconButtonShape = ZodiakIconButtonShape.circle, action: Action)`.

### Primitivo interno
- `ZodiakIconButtonImpl` (mesmo padrão do regular).

### Tokens
- Container size: `Zodiak.sizing.buttonIconSm/Md/Lg`.
- Cor: herda de regular (style + surface).
- Raio: `radii.full` (circle) ou `radii.md` (rounded square).

## Boas práticas — iOS
- SwiftUI: `Button { } label: { Image(systemName:) }` + `.buttonStyle(ZodiakIconButtonStyle(.primary))`.
- HIG: [Icons](https://developer.apple.com/design/human-interface-guidelines/icons).
- SF Symbols rendering modes configuráveis por superfície.

## Boas práticas — Android
- Material 3: `IconButton`, `FilledIconButton`, `FilledTonalIconButton`, `OutlinedIconButton`.
- Mapeamento:
  - `Primary` → `FilledIconButton`.
  - `Secondary` → `FilledTonalIconButton`.
  - `Tertiary` → `OutlinedIconButton`.
  - `Ghost` → `IconButton`.
- `IconButtonDefaults.iconButtonColors(...)`.

## Acessibilidade
- `accessibilityLabel` / `contentDescription` é **obrigatório**.
- Hit-target sempre ≥ `Zodiak.hitTarget.minimum` (via padding).
- Estado `pressed`/`focused` visível.

## Referências
- [iOS `Atoms/Button/ZodiakIconButton.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Atoms/Button/ZodiakIconButton.swift)
- [Supernova: Button guidelines](../../ZodiakiOS/docs/zodiak-pdf/Guidelines%20-%20Button.md)

## Gaps & dúvidas para o time de Design
- [ ] **Spec dedicado** Icon button (cores, tamanhos, raios) — existe?
- [ ] Shape padrão (circle vs squircle)?

## DoD
- [ ] 4 APIs + Impl.
- [ ] Hit-target verificado em snapshot.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Importação
```tsx
import { ButtonIcon, ArrowRightIcon } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `icon` | `React.ComponentType` | — | Componente ícone (obrigatório) |
| `ariaLabel` | `string` | — | Rótulo acessível (obrigatório) |
| `size` | `'small' \| 'medium' \| 'large'` | `'medium'` | Tamanho |
| `hierarchy` | `'primary' \| 'secondary' \| 'tertiary'` | `'primary'` | Hierarquia visual |
| `background` | `'onLite' \| 'onHeavy' \| 'onPhoto'` | `'onLite'` | Contexto de superfície |
| `disabled` | `boolean` | `false` | Estado desabilitado |

### Acessibilidade
- `ariaLabel` é obrigatório — não há texto visível.
- Use `url` para renderizar como `<a>` em vez de `<button>`.

### Storybook
- `AllOptions`: grade de ícones × hierarquias × superfícies
- `Playground`: controles interativos
