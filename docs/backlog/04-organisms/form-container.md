# FormContainer

> **Categoria**: Organism · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Wrapper de formulário Zodiak — agrupa fields (`ZodiakLabelledField`), gerencia foco, valida e submete. Pode incluir footer com botões.

## História de usuário
Como **desenvolvedor**, quero **estrutura padrão de form** com **validação e navegação de teclado** consistentes.

## Critérios de aceite

### Cenário 1 — Composição
**Dado** filhos `ZodiakLabelledField`
**Então** spacing entre fields (`spacing.s24`), footer fixo opcional.

### Cenário 2 — Foco
**Dado** `next` no teclado
**Então** move para próximo field; último vira `done`/submit.

### Cenário 3 — Validação
**Dado** submit com errors
**Então** scrolla para primeiro field com erro + foco.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** sequência lógica; erros associados.

### Cenário 5 — Teclado
**Dado** teclado abre
**Então** scroll ajusta para field focado (KeyboardAvoidance).

## Spec técnica

### APIs públicas
- `ZodiakFormContainer(footer: Slot? = none, content: Slot)`.

### Tokens
- Spacing: `spacing.s24` entre fields.
- Footer: `surface`, divider top opcional.

## Boas práticas — iOS
- `ScrollView` + `KeyboardAvoidance` (iOS 14+ automático).
- `@FocusState<Field>` enum.

## Boas práticas — Android
- `Modifier.imePadding()` + `Modifier.verticalScroll(rememberScrollState())`.
- `FocusManager.moveFocus(FocusDirection.Next)`.

## Acessibilidade
- Foco programático em erro.
- Erros associados via accessibility relationships.

## Referências
- [iOS `Organisms/ZodiakFormContainer.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/ZodiakFormContainer.swift)

## Gaps & dúvidas para o time de Design
- [ ] Footer sticky padrão?

## DoD
- [ ] Foco + keyboard avoidance.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
