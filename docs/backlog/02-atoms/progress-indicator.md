# ProgressIndicator

> **Categoria**: Atom · **Prioridade**: P0 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Indicador de progresso linear ou circular. Variantes: `determinate` (com valor 0..1), `indeterminate` (animação contínua).

## História de usuário
Como **usuário**, quero **ver o progresso de uma operação** para **saber que algo está em andamento e quanto falta**.

## Critérios de aceite

### Cenário 1 — Determinado
**Dado** `ZodiakProgressIndicator(value: 0.6, kind: .linear)`
**Então** barra preenche 60%; transições suaves entre valores.

### Cenário 2 — Indeterminado
**Dado** `kind: .circular` sem value
**Então** animação contínua (não para até remover ou setar value).

### Cenário 3 — Light/Dark
**Dado** dark
**Então** tokens resolvem.

### Cenário 4 — Acessibilidade
**Dado** progresso 60%
**Então** VoiceOver/TalkBack anuncia "Carregando, 60 por cento"; em modo indeterminate anuncia "Carregando".

### Cenário 5 — Reduce Motion
**Dado** Reduce Motion ativo
**Então** indeterminate usa fade pulse em vez de spin contínuo.

## Spec técnica

### APIs públicas
- `ZodiakProgressIndicator(value: Float? = none, kind: ZodiakProgressKind = ZodiakProgressKind.linear, size: ZodiakSize = ZodiakSize.md, color: ZodiakColor = ZodiakColor.actionPrimary)`.
- Enum `ZodiakProgressKind { linear, circular }`.

### Tokens
- Cor: `actionPrimary` (track ativa), `surfaceVariant` (track inativa).
- Espessura linear: `Zodiak.borders.thick`; circular size via `Zodiak.sizing.iconMd`.

## Boas práticas — iOS
- SwiftUI: `ProgressView(value:total:)` (linear/circular automático conforme `progressViewStyle`).
- HIG: [Progress indicators](https://developer.apple.com/design/human-interface-guidelines/progress-indicators).
- `.progressViewStyle(.linear | .circular)`.
- `.accessibilityValue("60 %")` quando determinate.

## Boas práticas — Android
- Material 3: `LinearProgressIndicator` e `CircularProgressIndicator` (`androidx.compose.material3`).
- `LinearProgressIndicator(progress = { value })` (M3 Expressive lambda API).
- Indeterminate: chamar sem `progress`.

## Acessibilidade
- Valor anunciado em mudanças via a11y nativa de progresso da plataforma.
- Modo indeterminate: label "Carregando" no parent.

## Referências
- [iOS `Atoms/ProgressIndicator/ZodiakProgressIndicator.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Atoms/ProgressIndicator/ZodiakProgressIndicator.swift)

## Gaps & dúvidas para o time de Design
- [ ] Buffer (loading + buffered) — necessário?
- [ ] Step progress (segmentado) — variante separada?

## DoD
- [ ] Linear + circular, determinate + indeterminate.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
