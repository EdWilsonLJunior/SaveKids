# TextBlock

> **Categoria**: Organism (Typographic) · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog

## Contexto
Bloco de texto longo com estilo editorial — usado para corpos de artigo. Suporta markdown (parágrafos, headers, listas, links inline).

## Critérios de aceite
- **Markdown**: renderiza paragraphs, h2/h3, ul/ol, bold/italic, links.
- **Tipografia**: `bodyLarge` (corpo), `titleMedium/Small` (headers).
- **Reading width**: max `60ch` em wide screens.
- **Acessibilidade**: headers como `accessibilityHeading`; links acessíveis.
- **Light/Dark**: tokens.

## APIs públicas
- `ZodiakTextBlock(markdown: String, maxReadingWidth: Length? = .infinity)`.

## Boas práticas
- **iOS**: `Text(AttributedString(markdown:))` (iOS 15+).
- **Android**: Lib markdown (Markwon/Compose markdown) → `AnnotatedString`.

## Referências
- [iOS `ZodiakTextBlock.swift`](../../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/Typographic/ZodiakTextBlock.swift)

## DoD
- [ ] Markdown completo.
- [ ] Ver [README família](README.md).


## Boas práticas — React/Web

### Importação
```tsx
import { TextBlockGroup, TextBlockSection } from '@cg-groupit/zodiak-design-system';
```

### Props principais — TextBlockGroup
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `columns` | `TextBlockSectionItem[]` | — | Itens de coluna |
| `headingTag` | `TextBlockHeadingTag` | `'h2'` | Tag do heading de cada coluna |

### Props principais — TextBlockSection
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `items` | `TextBlockSectionItem[]` | — | Itens de seção |
| `headingTag` | `TextBlockHeadingTag` | `'h3'` | Tag do heading de cada item |

### Acessibilidade
- Defina `headingTag` compatível com a hierarquia de headings do contexto de uso.

### Storybook
- `AllOptions`: variações de grupos e seções
- `Playground`: controles interativos
