# Author

> **Categoria**: Molecule · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Bloco editorial que apresenta autor de conteúdo: avatar + nome + (opcional) papel/role, data, leitura estimada. Usado em artigos, notícias, vídeos.

## História de usuário
Como **leitor**, quero **ver quem escreveu/produziu um conteúdo** e **metadados rápidos**.

## Critérios de aceite

### Cenário 1 — Composição
**Dado** avatar + nome + role + date + readTime
**Então** layout horizontal padrão.

### Cenário 2 — Variantes
**Dado** `size: .compact/.regular`
**Então** compact omite role; regular mostra tudo.

### Cenário 3 — Light/Dark + superfícies
**Dado** `surface: ZodiakSurface.onPhoto`
**Então** tokens text inverse + backdrop opcional.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** lido como bloco único ("Por João Silva, repórter, 5 min de leitura").

### Cenário 5 — Tap
**Dado** `onTap` configurado
**Então** bloco inteiro é botão (hit-target combinado).

## Spec técnica

### APIs públicas
- `ZodiakAuthor(name: String, avatar: ZodiakAvatarSource? = none, role: String? = none, date: Date? = none, readTime: Int? = none, size: ZodiakAuthorSize = ZodiakAuthorSize.regular, surface: ZodiakSurface = ZodiakSurface.onLite, onTap: Action? = none)`.

### Tokens
- Tipografia: nome `bodyMedium` semibold; meta `labelSmall`.
- Cor: nome `textPrimary`, meta `textSecondary`.

## Boas práticas — iOS
- `RelativeDateTimeFormatter` ou `Date.FormatStyle` para data localizada.

## Boas práticas — Android
- `DateTimeFormatter` (`java.time`) ou `DateUtils.getRelativeTimeSpanString`.

## Acessibilidade
- Filhos mesclados em um único nó de a11y (anunciado como uma autoridade só).

## Referências
- [iOS `Molecules/Author/ZodiakAuthor.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Molecules/Author/ZodiakAuthor.swift)

## Gaps & dúvidas para o time de Design
- [ ] Multi-autor (lista) — variante necessária?

## DoD
- [ ] Composição + opcional onTap.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Importação
```tsx
import { Author } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `type` | `'byline' \| 'profile'` | `'byline'` | Layout e conjunto de informações |
| `size` | `'small' \| 'large'` | `'small'` | Tamanho (byline) |
| `name` | `string` | — | Nome do autor |
| `avatarSrc` | `string` | — | URL da foto do avatar |
| `date` | `string` | — | Data (byline) |
| `readingTime` | `string` | — | Tempo de leitura (byline) |
| `title` | `string` | — | Cargo (profile) |
| `additionalInfo` | `string` | — | Empresa / organização (profile) |

### Acessibilidade
- O avatar é decorativo por padrão; forneça `alt` descritivo em `avatarSrc` se o avatar tiver significado semântico.

### Storybook
- `AllOptions`: byline × profile × tamanhos
- `Playground`: controles interativos
