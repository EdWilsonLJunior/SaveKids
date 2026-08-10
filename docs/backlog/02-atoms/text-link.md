# TextLink

> **Categoria**: Atom · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não — Swift é fonte primária

## Contexto
Link textual inline ou standalone. Suporta navegação interna (rota) ou externa (URL), com sublinhado, cor `textLink` e estados pressed/visited.

## História de usuário
Como **desenvolvedor**, quero **renderizar links como `ZodiakTextLink`** para que **estilo, acessibilidade e tap target sigam o DS**.

## Critérios de aceite

### Cenário 1 — Standalone
**Dado** `ZodiakTextLink("Termos de Uso", url: "https://...")`
**Então** texto sublinhado em `colors.textLink`; toque abre URL.

### Cenário 2 — Inline (dentro de parágrafo)
**Dado** uso dentro de `ZodiakText` com `AttributedString`
**Então** apenas o trecho é clicável e estilizado.

### Cenário 3 — Estados
**Dado** pressed/focused
**Então** cor escurece e (opcional) underline mais espesso; disabled = sem clique.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** anuncia "Link, <texto>"; papel `link` (não button).

### Cenário 5 — Hit target
**Dado** texto pequeno (caption)
**Então** padding aumenta hit-target para `Zodiak.hitTarget.minimum`.

## Spec técnica

### APIs públicas
- `ZodiakTextLink(_ text: String, style: ZodiakTextStyle = ZodiakTextStyle.bodyMedium, action: Action)` ou overload `url: URL`.

### Tokens
- Cor: `colors.textLink`, `colors.textLinkPressed`.
- Tipografia: herda do `ZodiakText` parent.

## Boas práticas — iOS
- **Assinatura concreta**: `ZodiakTextLink(_ text: String, style: ZodiakTextStyle = .bodyMedium, action: Action)` ou overload `url: URL`.

- SwiftUI: `Text(.init("[text](url)"))` aceita markdown; ou `Link(_, destination:)` para URL nativa.
- `.accessibilityAddTraits(.isLink)`.
- Suportar **Pointer Interactions** no iPad (`.hoverEffect`).

## Boas práticas — Android
- **Assinatura concreta**: `@Composable fun ZodiakTextLink(text: String, style: TextStyle = ..., onClick: () -> Unit, modifier: Modifier = Modifier)`.

- Compose: `ClickableText` ou `BasicText` com `Modifier.clickable` (preferível para focus/ripple) + `Modifier.semantics { role = Role.Button; contentDescription = ... }`. (Role.Button aceitável; alternativamente `traversalIndex`.)
- Para inline em `AnnotatedString`: usar `UrlAnnotation` (preview API) ou `StringAnnotation` + handler de click.

## Acessibilidade
- Papel `link` (iOS `isLink` trait; Android `Role.Button` + label que termina em "link").
- Underline mantém-se mesmo com `Increase Contrast`.
- Foco visível via outline.

## Referências
- [iOS `Atoms/TextLink/ZodiakTextLink.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Atoms/TextLink/ZodiakTextLink.swift)

## Gaps & dúvidas para o time de Design
- [ ] Estado **visited** — existe no DS?
- [ ] Link em dark mode — token específico (`textLinkOnHeavy`)?

## DoD
- [ ] API única + overload `url` / `action`.
- [ ] Suporte inline e standalone.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Importação
```tsx
import { Link } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `href` | `string` | — | URL de destino (obrigatório) |
| `children` | `ReactNode` | — | Conteúdo do link (obrigatório) |
| `target` | `'_blank' \| '_self' \| '_parent' \| '_top'` | — | Alvo de abertura |

### Acessibilidade
- `target="_blank"` adiciona `rel="noopener noreferrer"` automaticamente.
- Use `aria-label` apenas quando o texto visível não descrever o destino (evite "Clique aqui").

### Storybook
- `AllOptions`: variações de destino e contexto de superfície
- `Playground`: controles interativos
