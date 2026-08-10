# LabelledField (InputField)

> **Categoria**: Molecule · **Prioridade**: P0 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Wrapper que combina **label externo** + qualquer atom de input (`ZodiakTextField`, `ZodiakDropdown`, `ZodiakCombobox`, etc.) + helper + error. Padroniza disposição vertical de label/campo/mensagem para forms inteiros.

## História de usuário
Como **desenvolvedor**, quero **padronizar a estrutura de campos de formulário** com **label, input e mensagens em ordem consistente**.

## Critérios de aceite

### Cenário 1 — Composição
**Dado** label + child (input) + helper/error
**Então** vertical: Label / Input / Mensagem.

### Cenário 2 — Estado de erro
**Dado** `error` definido
**Então** label e mensagem em `statusError`; child propaga erro.

### Cenário 3 — Required
**Dado** `isRequired: true`
**Então** asterisco visual + a11y "obrigatório".

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** label + helper são associados semânticamente ao input pela a11y nativa da plataforma.

### Cenário 5 — Light/Dark
**Dado** dark
**Então** tokens resolvem.

## Spec técnica

### APIs públicas
- `ZodiakLabelledField(label: String, helper: String? = none, error: String? = none, isRequired: Bool = false, content: Slot)`.

### Implementação
- Compoe sem duplicar lógica do input filho — apenas envolve.

### Tokens
- Tipografia: label `labelMedium`, helper `labelSmall`.
- Cor: label `textPrimary`, helper `textSecondary` / `statusError`.
- Gap: `spacing.s4` entre label-input, `spacing.s4` input-helper.

## Boas práticas — iOS
- `VStack(alignment: .leading) { Text(label); content(); Text(helper) }`.
- `.accessibilityElement(children: .combine)` quando atom já não fornece label próprio.

## Boas práticas — Android
- `Column { Text(label); content(); Text(helper) }`.
- `Modifier.semantics(mergeDescendants = true)` para grupo.

## Acessibilidade
- Label sempre visível.
- Error anunciado via `liveRegion`.

## Referências
- [iOS `Molecules/InputField/ZodiakInputField.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Molecules/InputField/ZodiakInputField.swift)

## Gaps & dúvidas para o time de Design
- [ ] Variante horizontal (label ao lado) — necessária?
- [ ] Quando usar label interno (floating no `ZodiakTextField`) vs externo (`ZodiakLabelledField`)?

## DoD
- [ ] API com slot content.
- [ ] Snapshot estados.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
