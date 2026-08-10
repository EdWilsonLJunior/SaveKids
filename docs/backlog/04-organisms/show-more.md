# ShowMore

> **Categoria**: Organism · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Texto longo truncado com botão "Ver mais"/"Ver menos" para expandir/colapsar.

## História de usuário
Como **usuário**, quero **ler resumos longos** com **opção de expandir sem sair da tela**.

## Critérios de aceite

### Cenário 1 — Truncamento
**Dado** texto > N linhas (`collapsedLines: 3`)
**Então** mostra "..." + botão "Ver mais".

### Cenário 2 — Expansão
**Quando** toco "Ver mais"
**Então** revela texto completo + botão "Ver menos"; animação suave.

### Cenário 3 — Sem truncamento
**Dado** texto curto
**Então** botão não aparece.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** anuncia texto completo (não truncado para a11y); botão "Expandir" / "Recolher".

### Cenário 5 — Reduce Motion
**Dado** Reduce Motion ativo
**Então** sem animação de expansão suave.

## Spec técnica

### APIs públicas
- `ZodiakShowMore(text: String, collapsedLines: Int = Zodiak.defaults.showMore.collapsedLines, style: ZodiakTextStyle = ZodiakTextStyle.bodyMedium, expandLabel: String = "Ver mais", collapseLabel: String = "Ver menos")`.

### Tokens
- Botão: `colors.actionPrimary`, `labelMedium`.

## Boas práticas — iOS
- `Text(...).lineLimit(isExpanded ? nil : 3)` + medição com `GeometryReader` + `PreferenceKey` para detectar truncate.

## Boas práticas — Android
- `Text(maxLines = if (expanded) Int.MAX_VALUE else 3, onTextLayout = { result -> hasOverflow = result.hasVisualOverflow })`.

## Acessibilidade
- Texto completo disponível em `accessibilityLabel` mesmo quando colapsado (ou expor "Ver mais" como ação).

## Referências
- [iOS `Organisms/ShowMore/`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/ShowMore/)

## Gaps & dúvidas para o time de Design
- [ ] Posição do botão (inline no final do texto vs nova linha)?
- [ ] Estratégia a11y (texto completo sempre vs ação expand)?

## DoD
- [ ] Detecção de overflow.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Importação
```tsx
import { ButtonShowMore } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `label` | `string` | `'Show More'` | Texto do botão |
| `hierarchy` | `'secondary' \| 'tertiary'` | `'secondary'` | Hierarquia visual |
| `background` | `'onLite' \| 'onHeavy' \| 'onPhoto'` | `'onLite'` | Contexto de superfície |
| `fullWidth` | `boolean` | `false` | Ocupa toda a largura |
| `url` | `string` | — | Renderiza como `<a>` quando fornecido |
| `disabled` | `boolean` | `false` | Estado desabilitado |

### Acessibilidade
- Quando o botão carrega mais conteúdo dinamicamente, use `aria-expanded` ou `aria-live` para anunciar o resultado.

### Storybook
- `AllOptions`: hierarquias × superfícies × fullWidth
- `Playground`: controles interativos
