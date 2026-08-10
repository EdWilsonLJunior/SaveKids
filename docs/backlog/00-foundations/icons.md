# Icons (tokens)

> **Categoria**: Foundation · **Prioridade**: P0 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não (sem documentação oficial — Swift é fonte primária)

## Contexto
Biblioteca de ícones Zodiak — sistema de nomes simbólicos resolvidos para assets vetoriais. Suporta tamanhos `xs/sm/md/lg/xl` (tokens em [sizing](sizing.md)) e variantes de peso/preenchimento quando aplicável.

## História de usuário
Como **desenvolvedor**, quero **renderizar ícones via nome simbólico** para que **eu não dependa de bundle paths nem de imagens raster, e o ícone respeite cor/tamanho/tema automaticamente**.

## Critérios de aceite

### Cenário 1 — Catálogo
**Dado** [`ZodiakIcons.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakIcons.swift)
**Então** todo ícone listado está disponível como token nomeado (`ZodiakIcon.arrowRight`, `ZodiakIcon.check`, …).

### Cenário 2 — Tinting
**Dado** `ZodiakIconView(icon: .check, tint: .actionPrimary)`
**Então** o ícone renderiza na cor solicitada (template/tint rendering).

### Cenário 3 — Tamanho
**Dado** `size: Zodiak.sizing.iconMd`
**Então** usa o token de sizing correspondente — nunca um literal numérico.

### Cenário 4 — RTL
**Dado** ícones direcionais (seta, chevron)
**Quando** layout RTL ativo
**Então** espelham automaticamente; ícones não-direcionais não espelham.

### Cenário 5 — Paridade
**Dado** o mesmo símbolo
**Então** existe em iOS (SF Symbol customizado ou PDF vetorial) e Android (XML vetorial em `res/drawable/ic_zodiak_*`).

## Spec técnica

### APIs públicas
- **iOS**: enum `ZodiakIcon` (cases por nome) + `ZodiakIconView(icon:size:tint:)`. Underlying asset: SF Symbol (`Image(systemName:)`) ou Asset Catalog Symbol.
- **Android**: enum `ZodiakIcon` + `ZodiakIconView(icon, size, tint, modifier)` que renderiza `Icon(painter = painterResource(icon.resId), ...)`.

### Comportamento
- **Tinting**: ícone monocromático respeita `LocalContentColor` (Android) / `.foregroundStyle()` (iOS) por default; override via `tint:`.
- **Espelhamento RTL**: ícones direcionais marcados com flag `mirrorsInRTL = true`.
- **Acessibilidade**: ícones decorativos = `accessibilityHidden(true)` / `contentDescription = null`; ícones semânticos exigem `accessibilityLabel` / `contentDescription`.

## Boas práticas — iOS
- HIG: [SF Symbols](https://developer.apple.com/design/human-interface-guidelines/sf-symbols).
- Preferir SF Symbols quando o ícone tem equivalente nativo (consistência sistema-wide); usar símbolos customizados quando brand-specific.
- `.symbolRenderingMode(.hierarchical)` ou `.palette` para ícones multicolor.
- `Image(systemName:).symbolEffect(.bounce)` (iOS 17+) para animações nativas.

## Boas práticas — Android
- Material 3: usar `Icon(imageVector = ...)` para ícones do `androidx.compose.material.icons`; para ícones brand, `Icon(painter = painterResource(R.drawable.ic_zodiak_check), contentDescription = ...)`.
- VectorDrawables em `res/drawable/` com `<vector autoMirrored="true">` para ícones direcionais.
- Tamanho padrão Material alinhado ao token `Zodiak.sizing.iconMd`.

## Acessibilidade
- `contentDescription` / `accessibilityLabel` obrigatório em ícones semânticos.
- Decorativos: `accessibilityHidden(true)` / `contentDescription = null`.
- Hit-target em ícones interativos: garantir `Zodiak.hitTarget.minimum` via padding ou wrapper button.

## Referências
- [iOS `ZodiakIcons.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakIcons.swift)
- [iOS `Atoms/Icon/ZodiakIconView.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Atoms/Icon/ZodiakIconView.swift) — ver história [icon-view](../02-atoms/icon-view.md)
- HIG SF Symbols: https://developer.apple.com/design/human-interface-guidelines/sf-symbols
- Material 3 Icons: https://m3.material.io/styles/icons/overview

## Gaps & dúvidas para o time de Design
- [ ] Sem doc Supernova — pedir catálogo oficial com nomenclatura e variantes (outline/filled/duotone).
- [ ] Definir lista oficial de **ícones direcionais** (que espelham em RTL).
- [ ] Política para SF Symbols vs brand symbols (iOS).

## DoD
- [ ] Catálogo completo em iOS (Asset Catalog) e Android (`res/drawable/`).
- [ ] Snapshot da icon sheet por tamanho × tint × tema.
- [ ] RTL mirroring testado.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Importação
```tsx
import { Icon, ArrowRightIcon } from '@cg-groupit/zodiak-design-system';
```

### Props principais — Icon
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `Component` | `React.ComponentType` | — | Componente SVG do ícone (obrigatório) |
| `size` | `'small' \| 'medium' \| 'large' \| 'xlarge'` | `'small'` | Tamanho (16/24/32/56 px) |
| `decorative` | `boolean` | `true` | Se `true`, aplica `aria-hidden`; se `false`, exige `aria-label` |
| `className` | `string` | — | Classe extra |

### Acessibilidade
- Ícones decorativos: `decorative={true}` (padrão) → `aria-hidden="true"`.
- Ícones informativos: `decorative={false}` + `aria-label="Descrição do ícone"`.

### Storybook
- `AllOptions`: grade de todos os ícones disponíveis por categoria
- `Playground`: controles de tamanho e cor
