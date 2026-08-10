# Hit-target (tokens)

> **Categoria**: Foundation · **Prioridade**: P0 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não (derivado de HIG + Material)

## Contexto
Tokens dedicados de área de toque mínima — referência única para todos os componentes interativos. Substitui literais `44pt`/`48dp` em código e stories.

## História de usuário
Como **desenvolvedor**, quero **um token único de hit-target** para que **nenhum componente interativo precise repetir `44pt`/`48dp` e a conformidade WCAG seja garantida por construção**.

## Critérios de aceite

### Cenário 1 — Token mínimo
**Dado** `Zodiak.hitTarget.minimum`
**Então** resolve para 44pt (iOS) e 48dp (Android) — o **único** lugar onde esses números aparecem.

### Cenário 2 — Token confortável
**Dado** `Zodiak.hitTarget.comfortable`
**Então** valor maior recomendado para mão única (mobile portrait).

### Cenário 3 — Uso
**Dado** botão de qualquer tamanho visual
**Então** padding ou `frame(minWidth/minHeight:)` usa o token.

### Cenário 4 — Acessibilidade
**Dado** sistema com Accessibility Touch Target ativo (iOS) / Material `minimumInteractiveComponentSize` (Android)
**Então** componente respeita o maior entre o sistema e o token.

### Cenário 5 — Light/Dark
**Sem impacto.**

## Spec técnica

### APIs públicas
- **iOS**: `Zodiak.hitTarget.minimum`/`comfortable` → `CGFloat`. Helper `.zodiakHitTarget(.standard)` (ver [accessibility-helpers](../06-utils/accessibility-helpers.md)).
- **Android**: `ZodiakTheme.hitTarget.minimum`/`comfortable` → `Dp`. Modifier `Modifier.minimumInteractiveComponentSize()` é o caminho M3 padrão; modifier custom `Modifier.zodiakHitTarget(...)` usa o token.

### Tokens
- `Zodiak.hitTarget.minimum`
- `Zodiak.hitTarget.comfortable`

## Boas práticas — iOS
- HIG: [Layout — Hit targets](https://developer.apple.com/design/human-interface-guidelines/layout).
- `.frame(minWidth: Zodiak.hitTarget.minimum, minHeight: Zodiak.hitTarget.minimum)`.
- `.contentShape(.rect)` para incluir área de padding no hit-test.

## Boas práticas — Android
- Material 3: [Accessibility — Touch targets](https://m3.material.io/foundations/accessible-design/accessibility-basics).
- `Modifier.minimumInteractiveComponentSize()` para componentes M3 < 48dp.
- `Modifier.heightIn(min = ZodiakTheme.hitTarget.minimum)`.

## Acessibilidade
- WCAG 2.5.5 (AAA — 44×44) e 2.5.8 (AA — 24×24 mínimo): Zodiak adota AAA por padrão via `minimum`.

## Referências
- Implícito no iOS hoje — gap G-060 para extrair em `ZodiakSizing.swift` ou `ZodiakHitTarget.swift`.

## Gaps & dúvidas para o time de Design
- [ ] G-060 — Centralizar em token nomeado (hoje espalhado em components).

## DoD
- [ ] Token único exposto.
- [ ] Todos componentes interativos consomem via token (nunca literal).
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
