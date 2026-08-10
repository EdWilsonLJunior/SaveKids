# InfoRow

> **Categoria**: Organism · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Row de informação para exibição (não-editável): label à esquerda, value à direita. Comum em telas de detalhes/configurações. Atende como atom de "definition list".

## História de usuário
Como **usuário**, quero **ver pares label/valor padronizados** em **telas de detalhes**.

## Critérios de aceite

### Cenário 1 — Layout
**Dado** label + value
**Então** label à esquerda truncável, value à direita com `numberOfLines` configurável.

### Cenário 2 — Variantes
**Dado** `style: .default/.emphasized/.muted`
**Então** peso/tom do value variam.

### Cenário 3 — Tap opcional
**Dado** `onTap`
**Então** row inteira é tocável; chevron trailing.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** lê "<label>: <value>".

### Cenário 5 — Light/Dark
**Dado** dark
**Então** tokens resolvem.

## Spec técnica

### APIs públicas
- `ZodiakInfoRow(label: String, value: String, style: ZodiakInfoRowStyle = ZodiakInfoRowStyle.default, trailing: Slot? = none, onTap: Action? = none)`.

### Tokens
- Tipografia: label `labelMedium`, value `bodyMedium`.
- Padding: `spacing.s16`.
- Divider opcional.

## Boas práticas — iOS
- `HStack { Text(label); Spacer; Text(value) }`.
- Em `List`, usar `LabeledContent` (iOS 16+).

## Boas práticas — Android
- `Row { Text(label, modifier = Modifier.weight(1f)); Text(value) }`.

## Acessibilidade
- `accessibilityElement(children: .combine)` + label "<label>: <value>".

## Referências
- [iOS `Organisms/ZodiakInfoRow.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/ZodiakInfoRow.swift)

## Gaps & dúvidas para o time de Design
- [ ] Variante "stacked" (label sobre value) — necessária?

## DoD
- [ ] Styles + tap.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
