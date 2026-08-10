# Logo (tokens)

> **Categoria**: Foundation · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não — Swift é fonte primária

## Contexto
Tokens de logo Zodiak — variantes (full / symbol / wordmark), tamanhos, modos (light / dark / monochrome). Recursos em `ZodiakiOS/visual-assets/logo/`.

## História de usuário
Como **desenvolvedor**, quero **renderizar o logo via componente token** para que **versões e modos sigam padrões oficiais (sem distorção, espaçamento mínimo, light/dark correto)**.

## Critérios de aceite

### Cenário 1 — Variantes
**Dado** [`ZodiakLogo.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakLogo.swift)
**Então** existem `full` (símbolo + nome), `symbol`, `wordmark` (somente texto).

### Cenário 2 — Modos
**Dado** light/dark/monochrome
**Então** cada variante tem versão correta (cor do brand em light, branco em dark, monocromática para impressão/single-tone).

### Cenário 3 — Clear space
**Dado** o logo renderizado
**Então** respeita clear space mínimo (padding intrínseco ao asset ou enforcement via wrapper).

### Cenário 4 — Aspect ratio
**Dado** o logo escalado por largura
**Então** preserva razão; nunca distorce.

### Cenário 5 — Paridade
**Dado** o mesmo modo e variante
**Então** existe nas duas plataformas com mesmo asset vetorial.

## Spec técnica

### APIs públicas
- **iOS**: `ZodiakLogoView(variant: .full, mode: .auto, height: CGFloat)`. Enum `ZodiakLogoVariant`, `ZodiakLogoMode { auto, light, dark, mono }`.
- **Android**: `ZodiakLogoView(variant, mode, modifier)`.

### Comportamento
- `mode = .auto` resolve para light/dark conforme tema.
- `height` é a única dimensão controlável; largura derivada da razão.

## Boas práticas — iOS
- Asset PDF/SVG vetorial. Carregar `Image("zodiak_logo_full", bundle: .module)`.
- HIG: brand assets respeitam guidelines da marca; nunca usar como decoração genérica.

## Boas práticas — Android
- VectorDrawable em `res/drawable/`.
- `painterResource(R.drawable.zodiak_logo_full)`.
- Não aplicar `tint` em logos coloridos.

## Acessibilidade
- `accessibilityLabel = "Zodiak"` quando é o único elemento clicável; senão `accessibilityHidden(true)`.

## Referências
- [iOS `ZodiakLogo.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakLogo.swift)
- [iOS `Atoms/Logo/ZodiakLogoView.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Atoms/Logo/ZodiakLogoView.swift)
- Assets: `ZodiakiOS/visual-assets/logo/`

## Gaps & dúvidas para o time de Design
- [ ] Sem doc Supernova — pedir brand guidelines (clear space, tamanho mínimo, no-no's).
- [ ] Logo animado (Lottie) — fora de escopo?

## DoD
- [ ] Todas as variantes/modos disponíveis em ambas as plataformas.
- [ ] Snapshot por variante × modo.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
