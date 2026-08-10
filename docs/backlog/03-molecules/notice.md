# Notice

> **Categoria**: Molecule · **Prioridade**: P0 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Bloco compacto inline com ícone + mensagem — variação "leve" de `ZodiakAlert`, sem ação. **Três APIs públicas** — `ZodiakNoticeInfo`, `ZodiakNoticeSuccess`, `ZodiakNoticeError` — sobre primitivo `ZodiakNoticeImpl`.

## História de usuário
Como **usuário**, quero **feedback rápido e discreto** para **entender estado de um campo/seção sem interromper minha tarefa**.

## Critérios de aceite

### Cenário 1 — Variantes via APIs dedicadas
**Dado** `ZodiakNoticeInfo("..."), Success("..."), Error("...")`
**Então** cada um renderiza com tom correto.

### Cenário 2 — Estrutura
**Dado** ícone + texto compacto
**Então** layout horizontal: ícone (sm) + texto (bodySmall); padding compacto.

### Cenário 3 — Light/Dark
**Dado** dark
**Então** tokens resolvem.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** lido como bloco; ícone decorativo; live region polite quando dinâmico.

### Cenário 5 — Multiline
**Dado** texto longo
**Então** ícone alinha ao topo (não ao centro); texto quebra naturalmente.

## Spec técnica

### APIs públicas
- `ZodiakNoticeInfo(text: String)` / `Success(text:)` / `Error(text:)`.

### Primitivo interno
- `ZodiakNoticeImpl(text, tone, icon, ...)`.

### Tokens
- Tipografia: `bodySmall`.
- Cor: `status<Tone>` (ícone), `textPrimary` (texto), background nenhum ou `status<Tone>Container` discreto.

## Boas práticas — iOS
- `HStack(alignment: .top, spacing: tokens.s8) { Icon; Text }`.

## Boas práticas — Android
- `Row(verticalAlignment = Alignment.Top) { Icon; Spacer; Text }`.

## Acessibilidade
- LiveRegion para uso dinâmico.
- Não é alert assertive — é polite.

## Referências
- [iOS `Molecules/Notice/ZodiakNotice.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Molecules/Notice/ZodiakNotice.swift)

## Gaps & dúvidas para o time de Design
- [ ] Tom `warning` existe ou apenas info/success/error?
- [ ] Diferença vs `ZodiakAlert` — formalizar.

## DoD
- [ ] 3 APIs + Impl.
- [ ] Ver [ARCHITECTURE.md § 2](../ARCHITECTURE.md#2-padrão-arquitetural-primitivo-interno--apis-dedicadas-públicas) e [§ 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Importação
```tsx
import { Notification } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `variant` | `'information' \| 'positive' \| 'warning'` | `'information'` | Variante semântica |
| `title` | `string` | — | Título em negrito |
| `text` | `string` | — | Corpo da mensagem |
| `firstCTA` | `boolean` | `false` | Exibe botão CTA primário |
| `firstCtaProps` | `NotificationCtaProps` | — | Props do CTA (label, hierarchy, onClick) |

### Acessibilidade
- Notices persistentes: use `role="status"` (não intrusivo).
- Notices urgentes: use `role="alert"` (anuncia imediatamente).

### Storybook
- `AllOptions`: variantes × presença de CTA
- `Playground`: controles interativos
