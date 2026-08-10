# Combobox

> **Categoria**: Molecule · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Campo de texto editável com lista de sugestões filtráveis. **Duas APIs públicas** — `ZodiakCombobox` (genérico) e `ZodiakCountryCombobox` (especializado com bandeiras + códigos de país) — sobre primitivo `ZodiakComboboxImpl`.

## História de usuário
Como **usuário**, quero **escolher de uma lista com busca rápida** sem **rolar manualmente todas as opções**.

## Critérios de aceite

### Cenário 1 — Filtragem
**Dado** digito "br"
**Então** lista filtra para itens cujo label/value contém "br".

### Cenário 2 — Seleção
**Dado** seleciono item
**Então** lista fecha; campo preenche label do item.

### Cenário 3 — Estados
**Dado** `default/focused/error/disabled`
**Então** estados via tokens (herda text-field).

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** anuncia "Combobox, <valor>, <i> de <n> sugestões"; setas teclado navegam lista.

### Cenário 5 — Variante Country
**Dado** `ZodiakCountryCombobox`
**Então** cada item mostra bandeira (`ZodiakFlagView`) + nome + código discado.

## Spec técnica

### APIs públicas
- `ZodiakCombobox<T>(value: Binding<T?>, items: [T], itemLabel: (T) -> String, label: String, helper/error..., onSearch: ((String) -> [T])? = none)`.
- `ZodiakCountryCombobox(value: Binding<Country?>, ...)` — pre-popula items com lista oficial.

### Primitivo interno
- `ZodiakComboboxImpl<T>` consumido por ambas APIs.

### Tokens
- Herda text-field. Lista: `surface`, `shadows.level3`.

## Boas práticas — iOS
- SwiftUI: `TextField` + `.popover` ou `.sheet` para lista; `@FocusState`.
- iOS 17+ `MenuPickerStyle` quando dataset pequeno.

## Boas práticas — Android
- Material 3: `ExposedDropdownMenuBox + ExposedDropdownMenu`.
- `ExposedDropdownMenuBox(expanded, onExpandedChange) { OutlinedTextField(...); ExposedDropdownMenu(...) }`.

## Acessibilidade
- Papel semântico `combobox` exposto ao leitor de tela (mapeamento nativo por plataforma).
- Anúncio de quantidade de sugestões filtradas (LiveRegion).

## Referências
- [iOS `Molecules/Combobox/ZodiakCombobox.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Molecules/Combobox/ZodiakCombobox.swift)
- [iOS `Molecules/Combobox/ZodiakCountryCombobox.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Molecules/Combobox/ZodiakCountryCombobox.swift)

## Gaps & dúvidas para o time de Design
- [ ] Especificação visual oficial (altura da lista, max items visíveis)?
- [ ] Multi-select combobox — variante separada (ver `Multiselect`)?

## DoD
- [ ] 2 APIs + Impl genérico.
- [ ] Ver [ARCHITECTURE.md § 2](../ARCHITECTURE.md#2-padrão-arquitetural-primitivo-interno--apis-dedicadas-públicas) e [§ 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Implementação parcial em React.** O componente está em progresso no pacote `@cg-groupit/zodiak-design-system`.
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar completamente, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
