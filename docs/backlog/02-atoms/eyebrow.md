# Eyebrow

> **Categoria**: Atom · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Sim

## Contexto
Eyebrow é um rótulo curto, em caps, exibido acima de um título (ex.: "ARTIGO · TECNOLOGIA"). Indica categoria, seção ou tag de conteúdo editorial.

## História de usuário
Como **editor / desenvolvedor**, quero **destacar a categoria de um conteúdo via `ZodiakEyebrow`** para que **estilo (caps, tracking, peso) siga o DS**.

## Critérios de aceite

### Cenário 1 — Variantes
**Dado** Supernova [`Overview - Eyebrow.md`](../../ZodiakiOS/docs/zodiak-pdf/Overview%20-%20Eyebrow.md)
**Então** suporta variantes com/sem ícone, com/sem divider (·), e cores `onLite`/`onHeavy`/`onPhoto`.

### Cenário 2 — Caixa
**Dado** texto em caixa baixa fornecido
**Então** componente renderiza em caixa alta (uppercase aplicada via style).

### Cenário 3 — Light/Dark
**Dado** dark
**Então** cor resolve corretamente.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** texto é lido em pronúncia natural (não letra-por-letra, pois é fragmento curto); `accessibilityHeading(.h6)` quando apropriado.

### Cenário 5 — Superfícies
**Dado** `surface: ZodiakSurface.onPhoto`
**Então** cor e (opcional) backdrop garantem AA.

## Spec técnica

### APIs públicas
- `ZodiakEyebrow(_ text: String, items: [String] = [], surface: ZodiakSurface = ZodiakSurface.onLite, leadingIcon: ZodiakIcon? = none)`.
- Multiple itens são separados por bullet `·` automaticamente.

### Tokens
- Tipografia: `typography.labelSmall` com `letterSpacing` ampliado.
- Cor: `colors.textSecondary` (onLite) / `textInverse` (onHeavy/onPhoto).

## Boas práticas — iOS
- `Text(...).textCase(.uppercase).tracking(...)`.
- `.accessibilityLabel` com texto naturalizado (sem caps).

## Boas práticas — Android
- `Text(text, style = ZodiakTheme.typography.labelSmall.copy(letterSpacing = ...))`, texto já em uppercase.
- `Modifier.semantics { contentDescription = textOriginal }`.

## Acessibilidade
- TalkBack/VoiceOver lê texto natural; uppercase é visual apenas.
- Não usar como único cabeçalho de seção (combinar com `headline*`).

## Referências
- [iOS `Atoms/Eyebrow/ZodiakEyebrow.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Atoms/Eyebrow/ZodiakEyebrow.swift)
- [Supernova: Overview](../../ZodiakiOS/docs/zodiak-pdf/Overview%20-%20Eyebrow.md)
- [Supernova: Guidelines](../../ZodiakiOS/docs/zodiak-pdf/Guidelines%20-%20Eyebrow.md)
- [Supernova: Specs](../../ZodiakiOS/docs/zodiak-pdf/Specs%20-%20Eyebrow.md)

## Gaps & dúvidas para o time de Design
- [ ] Eyebrow clicável (filtra por categoria) — está no escopo?

## DoD
- [ ] API única com superfícies.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Importação
```tsx
import { Eyebrow } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `text` | `string` | — | Texto do eyebrow (obrigatório) |
| `size` | `'medium' \| 'small'` | `'medium'` | Escala tipográfica |
| `bg` | `'onLite' \| 'onHeavy'` | `'onLite'` | Contexto de superfície |

### Acessibilidade
- A linha decorativa ao lado do texto é renderizada com `aria-hidden="true"`.
- Mantenha o texto do eyebrow conciso (1 linha).

### Storybook
- `AllOptions`: grade de tamanhos × superfícies
- `Playground`: controles interativos
