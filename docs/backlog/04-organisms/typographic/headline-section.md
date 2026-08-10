# HeadlineSection

> **Categoria**: Organism (Typographic) · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog

## Contexto
Cabeçalho de seção: eyebrow + headline + (opcional) supporting + action ("Ver todos").

## Critérios de aceite
- **Composição**: eyebrow + headline + supporting + action.
- **Variantes**: `.section/.subSection`.
- **Acessibilidade**: headline com papel `heading`; action separado.
- **Light/Dark**: tokens.

## APIs públicas
- `ZodiakHeadlineSection(eyebrow: String? = none, headline: String, supporting: String? = none, action: ZodiakAlertAction? = none, level: ZodiakHeadlineLevel = ZodiakHeadlineLevel.section)`.

## Boas práticas
- `accessibilityHeading(.h2)` para `.section`, `.h3` para `.subSection`.

## Referências
- [iOS `ZodiakHeadlineSection.swift`](../../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/Typographic/ZodiakHeadlineSection.swift)

## DoD
- [ ] Heading semântico.
- [ ] Ver [README família](README.md).


## Boas práticas — React/Web

### Importação
```tsx
import { HeadlineSection } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `text` | `string` | — | Texto do headline (obrigatório) |
| `eyebrow` | `string \| ReactNode` | — | Label Eyebrow acima do headline |
| `description` | `string \| ReactNode` | — | Texto de apoio abaixo do headline |
| `layout` | `'plain' \| 'withFilter'` | `'plain'` | Modo de layout |
| `align` | `'left' \| 'center'` | `'left'` | Alinhamento (center somente para plain) |
| `headingTag` | `'h1' \| 'h2'` | `'h2'` | Elemento heading semântico |
| `background` | `'page' \| 'surfaceFog'` | `'page'` | Contexto de superfície |

### Acessibilidade
- Use `headingTag="h1"` apenas para o heading principal da página.

### Storybook
- `AllOptions`: layouts × alinhamentos × fundos
- `Playground`: controles interativos
