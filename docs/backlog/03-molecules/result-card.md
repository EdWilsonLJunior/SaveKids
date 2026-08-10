# ResultCard

> **Categoria**: Molecule · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Card de resultado (ex.: resumo de cálculo, KPI). Mostra título + valor destacado + (opcional) status chip + ação.

## História de usuário
Como **usuário**, quero **ver resultados destacados** em **cards visuais para escaneamento rápido**.

## Critérios de aceite

### Cenário 1 — Composição
**Dado** title + value + supporting + statusChip + action
**Então** layout: cabeçalho (title + status), corpo (value), rodapé (supporting + action).

### Cenário 2 — Variantes
**Dado** `tone: .neutral/.success/.error`
**Então** acento de cor (borda lateral ou ícone).

### Cenário 3 — Light/Dark
**Dado** dark
**Então** tokens resolvem.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** lido como bloco coeso.

### Cenário 5 — Tap
**Dado** `onTap` configurado
**Então** card inteiro é botão.

## Spec técnica

### APIs públicas
- `ZodiakResultCard(title: String, value: String, supporting: String? = none, statusChip: ZodiakStatusChip? = none, action: ZodiakAlertAction? = none, tone: ZodiakResultTone = ZodiakResultTone.neutral, onTap: Action? = none)`.

### Tokens
- Background: `surface`. Raio: `radii.md`. Sombra: `shadows.level1`.
- Tipografia: title `labelMedium`, value `headlineLarge`, supporting `bodySmall`.

## Boas práticas — iOS
- `VStack` em `RoundedRectangle().fill(.surface).shadow(...)`.

## Boas práticas — Android
- Material 3: `Card(elevation = CardDefaults.cardElevation(...))`.

## Acessibilidade
- `accessibilityElement(children: .combine)` quando informativo.

## Referências
- [iOS `Molecules/ResultCard/ZodiakResultCard.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Molecules/ResultCard/ZodiakResultCard.swift)

## Gaps & dúvidas para o time de Design
- [ ] Layout oficial (vertical vs horizontal)?

## DoD
- [ ] Tons + tap.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
