# Preamble

> **Categoria**: Organism (Typographic) · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog

## Contexto
Parágrafo de abertura / lead em artigos. Tipografia mais larga e weight intermediário.

## Critérios de aceite
- **Tipografia**: `bodyLargePlus` ou `titleMedium` (definir).
- **Posição**: tipicamente após headline.
- **Acessibilidade**: lido normalmente.
- **Light/Dark**: tokens.

## APIs públicas
- `ZodiakPreamble(text: String)`.

## Referências
- [iOS `ZodiakPreamble.swift`](../../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/Typographic/ZodiakPreamble.swift)

## DoD
- [ ] Tipografia específica.
- [ ] Ver [README família](README.md).


## Boas práticas — React/Web

### Importação
```tsx
import { Preamble } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `title` | `string` | — | Título do preamble |
| `subtitle` | `string` | — | Subtítulo ou lead text |
| `headingTag` | `'h1'…'h6'` | `'h1'` | Elemento heading semântico |
| `layout` | `PreambleLayoutVariant` | — | Variante de layout |
| `author` | `BylineAuthorProps` | — | Dados do autor (opcional) |
| `downloadProps` | `ButtonDownloadProps` | — | Props de download (opcional) |

### Acessibilidade
- O `headingTag` deve refletir a hierarquia real da página.
- Inclua `alt` descritivo no logo se for informativo.

### Storybook
- `AllOptions`: variantes de layout × presença de autor/download
- `Playground`: controles interativos
