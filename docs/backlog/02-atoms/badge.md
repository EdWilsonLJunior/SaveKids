# Badge

> **Categoria**: Atom · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Indicador compacto (pílula colorida ou número) para destacar status, contagem ou categoria.

## História de usuário
Como **desenvolvedor**, quero **exibir um `ZodiakBadge` com tom semântico** para que **status (sucesso, aviso, erro, info, neutro) sigam o DS**.

## Critérios de aceite

### Cenário 1 — Variantes (tom)
**Dado** `ZodiakBadge("Novo", tone: .success)` em todos os tons (`success`, `warning`, `error`, `info`, `neutral`)
**Então** cada um renderiza com cor de fundo e texto corretos via tokens `status*Container` / `status*OnContainer`.

### Cenário 2 — Tipo (dot / count / label)
**Dado** os tipos `dot` (sem conteúdo), `count` (Int), `label` (texto)
**Então** componente renderiza adequadamente; `count > 99` mostra "99+".

### Cenário 3 — Light/Dark
**Dado** dark mode
**Então** tons resolvem para variantes dark dos tokens.

### Cenário 4 — Acessibilidade
**Dado** badge "3" em ícone de sino
**Então** VoiceOver/TalkBack anuncia "Notificações, 3 não lidas".

### Cenário 5 — Hit-target
**Dado** badge não interativo
**Então** não exige hit-target; quando interativo, herda do wrapper.

## Spec técnica

### APIs públicas
- `ZodiakBadge(label: String? = none, count: Int? = none, tone: ZodiakBadgeTone = ZodiakBadgeTone.neutral, size: ZodiakSize = ZodiakSize.small)`.
  - Enum `ZodiakBadgeTone { success, warning, error, info, neutral }`.
  - Quando `label == none && count == none` → renderiza dot.

### Tokens
- Background: `colors.status<Tone>Container`.
- Texto: `colors.status<Tone>OnContainer`.
- Tipografia: `typography.labelSmall`.
- Raio: `radii.full`.
- Padding: `spacing.s4` horizontal, `spacing.s2` vertical.

## Boas práticas — iOS
- SwiftUI: `Capsule().fill(color).overlay(Text(...))`. Modifier extra `.badge(_:)` (iOS 15+) para listas/tabs.
- HIG: [Activity Indicators / Status](https://developer.apple.com/design/human-interface-guidelines/activity-indicators).
- `.accessibilityLabel("3 notificações não lidas")` no parent.

## Boas práticas — Android
- Material 3: `Badge` e `BadgedBox` em `androidx.compose.material3`.
- Compose: `BadgedBox(badge = { Badge { Text("3") } }) { Icon(...) }` é o padrão para badges atreladas a ícones.
- `Modifier.semantics { contentDescription = "..." }` no parent (badge sozinho não dá contexto).

## Acessibilidade
- Badge nunca é única fonte de info — sempre acompanhada de label textual ou descrição do parent.
- Contraste AA garantido por tokens `*Container`/`*OnContainer`.

## Referências
- [iOS `Atoms/Badge/ZodiakBadge.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Atoms/Badge/ZodiakBadge.swift)
- Material 3 Badge: https://m3.material.io/components/badges/overview

## Gaps & dúvidas para o time de Design
- [ ] Tipo `dot` vs `count` documentado oficialmente?
- [ ] Tom adicional `brand`?

## DoD
- [ ] API única com enum.
- [ ] Snapshot por tom × tipo × tema.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
