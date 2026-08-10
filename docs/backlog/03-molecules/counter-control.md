# CounterControl

> **Categoria**: Molecule · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Controle numérico com botões − / + para incrementar/decrementar quantidade (ex.: quantidade de produto). Limites configuráveis.

## História de usuário
Como **usuário**, quero **ajustar quantidades** com **botões claros e um campo numérico opcional**.

## Critérios de aceite

### Cenário 1 — Incremento
**Quando** toco em +
**Então** value += step (default 1).

### Cenário 2 — Limites
**Dado** `min: 0, max: 99`
**Então** − fica desabilitado em 0; + desabilitado em 99.

### Cenário 3 — Edição direta
**Dado** `editable: true`
**Então** campo numérico aceita digitação; valida no blur.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** "Quantidade, 3, ajustar"; usa accessibilityAdjustableAction iOS / `setProgress` Android.

### Cenário 5 — Hit-target
**Dado** botões em pequenas dimensões
**Então** padding garante ≥ `Zodiak.hitTarget.minimum`.

## Spec técnica

### APIs públicas
- `ZodiakCounterControl(value: Binding<Int>, min: Int = Zodiak.defaults.counter.minValue, max: Int = Int.max, step: Int = Zodiak.defaults.counter.step, editable: Bool = false, size: ZodiakSize = ZodiakSize.medium, enabled: Bool = true)`.

### Tokens
- Botões: ver [button-icon](../02-atoms/button-icon.md).
- Tipografia value: `bodyLargeBold`.

## Boas práticas — iOS
- `Stepper(value:, in:)` nativo (estilo discreto) + custom para visual Zodiak.

## Boas práticas — Android
- Compose: `Row { IconButton(−); Text; IconButton(+) }`.
- `Modifier.semantics { setProgress(...); stateDescription = ... }`.

## Acessibilidade
- Papel adjustable.
- Anunciar valor após cada mudança.

## Referências
- [iOS `Molecules/CounterControl/ZodiakCounterControl.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Molecules/CounterControl/ZodiakCounterControl.swift)

## Gaps & dúvidas para o time de Design
- [ ] Variante "tall" (vertical) — necessária?
- [ ] Step decimal — suportado?

## DoD
- [ ] Limites + editable.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
