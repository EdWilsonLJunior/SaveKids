# Dropdown

> **Categoria**: Molecule · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Seleção de uma opção entre várias via lista que abre ao toque. Diferente de `Combobox` por **não permitir digitação livre**.

## História de usuário
Como **usuário**, quero **escolher uma opção fixa** de uma **lista predefinida**.

## Critérios de aceite

### Cenário 1 — Abertura
**Dado** toco no campo
**Então** lista aparece abaixo (ou acima se sem espaço); item atual destacado.

### Cenário 2 — Seleção
**Dado** seleciono item
**Então** campo mostra label; lista fecha.

### Cenário 3 — Estados
**Dado** `default/focused/error/disabled`
**Então** estados corretos (herda text-field).

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** "Dropdown, <valor>, toque duplo para abrir"; lista anuncia "item N de M".

### Cenário 5 — Light/Dark
**Dado** dark
**Então** tokens resolvem.

## Spec técnica

### APIs públicas
- `ZodiakDropdown<T>(value: Binding<T?>, items: [T], itemLabel: (T) -> String, label: String, helper/error..., enabled: Bool = true)`.

### Tokens
- Herda text-field; trailing icon `chevron.down`.
- Lista: `surface`, `shadows.level3`, `radii.md`.

## Boas práticas — iOS
- SwiftUI nativo: `Picker(...).pickerStyle(.menu)` para casos simples.
- Custom: `Button { ... } label: { TextFieldLook }` + `.confirmationDialog` ou `.popover`.

## Boas práticas — Android
- Material 3: `ExposedDropdownMenuBox + ExposedDropdownMenu` com `readOnly = true` no TextField.

## Acessibilidade
- Papel `dropdown` / `combobox` (readonly).

## Referências
- [iOS `Molecules/Dropdown/ZodiakDropdown.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Molecules/Dropdown/ZodiakDropdown.swift)

## Gaps & dúvidas para o time de Design
- [ ] Diferença visual com combobox — apenas presença de ícone chevron?

## DoD
- [ ] API genérica `<T>`.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
