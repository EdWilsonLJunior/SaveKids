# IconView

> **Categoria**: Atom · **Prioridade**: P0 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não — Swift é fonte primária

## Contexto
`ZodiakIconView` renderiza um ícone do catálogo semântico Zodiak (ver [icons foundation](../00-foundations/icons.md)). Mapeia para SF Symbols (iOS) e Material Symbols (Android) quando aplicável; caso contrário, asset vetorial Zodiak.

## História de usuário
Como **desenvolvedor**, quero **exibir um ícone por nome semântico** para que **assets, tamanho, cor e RTL sigam o DS**.

## Critérios de aceite

### Cenário 1 — Catálogo semântico
**Dado** `ZodiakIconView(.search)` (enum / token)
**Então** ícone correto é renderizado; trocar tema/plataforma não altera o ponto de chamada.

### Cenário 2 — Tamanhos
**Dado** `size: ZodiakSize`
**Então** ícone escala para `sizing.iconXs/Sm/Md/Lg/Xl` mantendo aspect.

### Cenário 3 — Cor
**Dado** `color: ZodiakColor`
**Então** ícone é template-rendered com a cor token (afeta mono icons).

### Cenário 4 — Acessibilidade
**Dado** ícone decorativo
**Então** marcado como hidden; ícone informativo recebe `accessibilityLabel`.

### Cenário 5 — RTL
**Dado** ícone direcional (`chevron.left`, `arrow.forward`)
**Então** espelha em RTL; ícones simbólicos (search, heart) não espelham.

## Spec técnica

### APIs públicas
- `ZodiakIconView(_ icon: ZodiakIcon, size: ZodiakSize = ZodiakSize.md, color: ZodiakColor = ZodiakColor.iconPrimary)` + enum `ZodiakIcon`.

### Tokens
- Tamanho: `sizing.icon*`.
- Cor: `colors.icon*`.

## Boas práticas — iOS
- **Assinatura concreta**: `ZodiakIconView(_ icon: ZodiakIcon, size: ZodiakSize = .md, color: ZodiakColor = .iconPrimary)` + enum `ZodiakIcon`.

- `Image(systemName:)` quando SF Symbols cobre; `Image("zodiak_<name>")` para custom.
- `.symbolRenderingMode(.monochrome|.hierarchical|.palette|.multicolor)` conforme guideline.
- `.imageScale(.small|.medium|.large)` + `.font(...)` para Dynamic Type relativo.
- `.flipsForRightToLeftLayoutDirection(true)` em ícones direcionais.

## Boas práticas — Android
- **Assinatura concreta**: `@Composable fun ZodiakIconView(icon: ZodiakIcon, size: ZodiakSize = ZodiakSize.Md, color: Color = ZodiakTheme.colors.iconPrimary, contentDescription: String? = null, modifier: Modifier = Modifier)`.

- Material Symbols via `androidx.compose.material.icons.Icons` ou Material Symbols extended.
- `Icon(imageVector | painter, contentDescription, modifier, tint)`.
- `Modifier.scale(...)` ou `Modifier.size(...)`.
- `androidx.compose.ui.unit.LayoutDirection` + `Modifier.graphicsLayer(scaleX = -1f)` em RTL para ícones direcionais.

## Acessibilidade
- Decorativo: `contentDescription = null` (Android) / `accessibilityHidden(true)` (iOS).
- Informativo: label semântico.
- Contraste AA com fundo.

## Referências
- [iOS `Atoms/Icon/ZodiakIconView.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Atoms/Icon/ZodiakIconView.swift)
- [Foundation: icons](../00-foundations/icons.md)

## Gaps & dúvidas para o time de Design
- [ ] Catálogo semântico oficial completo (mapping name → SF + Material)?
- [ ] Política de **multicolor / hierarchical** symbols?

## DoD
- [ ] Enum `ZodiakIcon` completo.
- [ ] Mapping para SF Symbols + Material Symbols + custom Zodiak.
- [ ] RTL.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Importação
```tsx
import { Icon, ArrowRightIcon, CheckIcon } from '@cg-groupit/zodiak-design-system';
```

### Props principais — Icon (wrapper)
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `Component` | `React.ComponentType<IconProps>` | — | Componente SVG (obrigatório) |
| `size` | `'small' \| 'medium' \| 'large' \| 'xlarge'` | `'small'` | Tamanho (16/24/32/56 px) |
| `decorative` | `boolean` | `true` | `true` → `aria-hidden`; `false` exige `aria-label` |
| `rawSize` | `string \| number` | — | Tamanho CSS exato (sobrescreve `size`) |

### Acessibilidade
- Ícones puramente decorativos: `decorative={true}` (padrão).
- Ícones independentes com significado: `decorative={false}` + `aria-label`.

### Storybook
- `AllOptions`: grade completa de ícones disponíveis por categoria
- `Playground`: controles de tamanho, `strokeWidth` e acessibilidade
