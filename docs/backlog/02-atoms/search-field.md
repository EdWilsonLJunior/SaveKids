# SearchField

> **Categoria**: Atom · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Campo de busca — variação de `ZodiakTextField` com leading icon = lupa, trailing icon = clear (quando há texto), submit via tecla Search.

## História de usuário
Como **usuário**, quero **buscar conteúdo** com **um campo dedicado e ações rápidas (limpar, submeter)**.

## Critérios de aceite

### Cenário 1 — Aparência
**Dado** `ZodiakSearchField(value:)`
**Então** lupa à esquerda, placeholder "Buscar..."; com texto, clear (×) à direita.

### Cenário 2 — Clear
**Quando** toco no clear
**Então** value = ""; foco mantém-se no campo.

### Cenário 3 — Submit
**Quando** pressiono tecla Search / Enter
**Então** `onSubmit` é chamado com value atual.

### Cenário 4 — Debounce
**Dado** `onChange` configurado com debounce
**Então** chamadas espaçadas para não sobrecarregar busca live.

### Cenário 5 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** "Buscar, campo de pesquisa, <valor>"; clear = "Limpar busca"; submit anuncia "Buscar".

## Spec técnica

### APIs públicas
- `ZodiakSearchField(value: Binding<String>, placeholder: String = "Buscar", onSubmit: Action = {}, onClear: Action? = none)`.

### Implementação
- Wrapper sobre `ZodiakTextFieldImpl` com leading `.search`, trailing dinâmico (clear quando `value.isNotEmpty`), `submitLabel: .search` / `imeAction = ImeAction.Search`.

### Tokens
- Herda de [text-field](text-field.md). Raio pode ser `radii.full` (pílula) ou `radii.sm` (configurável via design).

## Boas práticas — iOS
- **Assinatura concreta**: `ZodiakSearchField(value: Binding<String>, placeholder: String = "Buscar", onSubmit: Action = {}, onClear: Action? = none)`.

- iOS 15+: `.searchable(text:)` integra com Navigation (pesquisa de tela inteira).
- `ZodiakSearchField` deve cobrir uso inline (não-navigation); para navigation usar `.searchable` nativo.
- HIG: [Search fields](https://developer.apple.com/design/human-interface-guidelines/search-fields).

## Boas práticas — Android
- **Assinatura concreta**: `@Composable fun ZodiakSearchField(value: String, onValueChange: (String) -> Unit, placeholder: String = "Buscar", onSearch: () -> Unit = {}, modifier: Modifier = Modifier)`.

- Material 3: `SearchBar` (`androidx.compose.material3`) — composable rico com hist./sugestões.
- Para inline simples (sem expansão), `OutlinedTextField` com leading/trailing icons.
- `KeyboardOptions(imeAction = ImeAction.Search)` + `KeyboardActions(onSearch = ...)`.

## Acessibilidade
- Papel `searchField` (iOS `.searchField` trait; Android nas semantics).
- Botão clear acessível.
- Resultados de busca anunciados via `LiveRegion` (quando aplicável).

## Referências
- [iOS `Atoms/TextField/ZodiakSearchField.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Atoms/TextField/ZodiakSearchField.swift)

## Gaps & dúvidas para o time de Design
- [ ] Forma do campo (pílula vs retangular)?
- [ ] Variante com voz (mic) integrada?

## DoD
- [ ] Clear + submit.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
