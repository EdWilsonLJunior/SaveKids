# SkeletonLoader

> **Categoria**: Organism · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Placeholder animado (shimmer) que indica conteúdo carregando. Replica forma do conteúdo real para reduzir percepção de espera.

## História de usuário
Como **usuário**, quero **visualizar que conteúdo está carregando** com **placeholders que prevêem o layout**.

## Critérios de aceite

### Cenário 1 — Shapes
**Dado** `ZodiakSkeleton(shape: .rect | .circle | .text(lines))`
**Então** placeholder com shape correto.

### Cenário 2 — Animação
**Dado** skeleton ativo
**Então** shimmer linear translada em loop (~1.5s).

### Cenário 3 — Reduce Motion
**Dado** Reduce Motion ativo
**Então** pulse simples (fade in/out) em vez de translate.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** skeleton anuncia "Carregando" (LiveRegion) mas elementos individuais são `accessibilityHidden`.

### Cenário 5 — Light/Dark
**Dado** dark
**Então** tokens shimmer resolvem (`surfaceVariant` → `surface`).

## Spec técnica

### APIs públicas
- `ZodiakSkeleton(shape: ZodiakSkeletonShape = ZodiakSkeletonShape.rect, size: CGSize? = none)`.
- Exposto como **modifier/extensão** aplicável a qualquer view-host: `.zodiakSkeleton(isActive: Bool)` substitui o conteúdo pelo placeholder enquanto ativo.

### Tokens
- Cores: `colors.surfaceVariant` (base), `colors.surface` (shimmer highlight).
- Raio: `radii.sm`.

## Boas práticas — iOS
- `LinearGradient` animado em `Rectangle` com `.mask(content)`.
- Reduce Motion: `@Environment(\.accessibilityReduceMotion)`.

## Boas práticas — Android
- Lib `accompanist-placeholder` (`Modifier.placeholder(visible, shimmer = PlaceholderHighlight.shimmer())`) ou custom com `infiniteRepeatable`.

## Acessibilidade
- Container pai anuncia "Carregando" como live region polite enquanto o skeleton estiver ativo.

## Referências
- [iOS `Organisms/SkeletonLoader/`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/SkeletonLoader/)

## Gaps & dúvidas para o time de Design
- [ ] Velocidade oficial do shimmer?

## DoD
- [ ] Modifier/extensão aplicável.
- [ ] Reduce motion.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
