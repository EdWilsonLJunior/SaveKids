# Flags (tokens)

> **Categoria**: Foundation · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não — Swift é fonte primária

## Contexto
Tokens de bandeiras de países — usados em pickers de país (telefone, idioma, moeda). Recursos em `ZodiakiOS/visual-assets/flags/`.

## História de usuário
Como **desenvolvedor**, quero **renderizar bandeira por ISO code** para que **flag pickers e phone inputs mostrem visual consistente**.

## Critérios de aceite

### Cenário 1 — Catálogo
**Dado** [`ZodiakFlag.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakFlag.swift) e os assets em `ZodiakiOS/visual-assets/flags/`
**Então** existem bandeiras para todos os ISO-3166-1 alpha-2 cobertos pelo produto.

### Cenário 2 — Resolução por código
**Dado** `ZodiakFlagView(country: "BR")`
**Então** resolve a bandeira correta (case-insensitive).

### Cenário 3 — Fallback
**Dado** um código inválido
**Então** mostra um placeholder neutro (globo) e não crasha.

### Cenário 4 — Aspect ratio
**Dado** uma bandeira renderizada
**Então** mantém razão 4:3 ou 1:1 (round) conforme variante.

### Cenário 5 — Paridade
**Dado** o mesmo ISO
**Então** existe em ambas as plataformas com o mesmo asset.

## Spec técnica

### APIs públicas
- **iOS**: `ZodiakFlagView(country: String, shape: ZodiakFlagShape = .rectangle, size: ZodiakSize = .md)`. Enum `ZodiakFlagShape { rectangle, rounded, circle }`.
- **Android**: composable `ZodiakFlagView(countryIso: String, shape: ZodiakFlagShape = ..., modifier: Modifier = Modifier)`.

### Comportamento
- Assets em PDF (iOS) e SVG/XML vetorial (Android) — escaláveis.
- `circle` aplica clip circular.
- Fallback: `_default` asset.

## Boas práticas — iOS
- Carregar via `Image("flag_br", bundle: .module)` com Asset Catalog `Vector` ticked.
- `.aspectRatio(4/3, contentMode: .fit)` para razão correta.

## Boas práticas — Android
- VectorDrawable em `res/drawable/flag_br.xml`.
- `painterResource(id = R.drawable.flag_br)` + `Modifier.aspectRatio(4f/3f)`.
- Para nomes dinâmicos: `LocalContext.current.resources.getIdentifier("flag_$iso", "drawable", packageName)` — cuidado com ProGuard/R8 (keep rule).

## Acessibilidade
- `accessibilityLabel` = nome do país localizado (`Locale.current.localizedString(forRegionCode:)`).
- Ícone decorativo apenas quando próximo do nome textual (evitar redundância no leitor de tela).

## Referências
- [iOS `ZodiakFlag.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakFlag.swift)
- [iOS `Atoms/Flag/ZodiakFlagView.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Atoms/Flag/ZodiakFlagView.swift) — ver história [flag-view](../02-atoms/flag-view.md)
- Assets: `ZodiakiOS/visual-assets/flags/`

## Gaps & dúvidas para o time de Design
- [ ] Sem doc Supernova — pedir lista oficial de países suportados e variantes (rectangle/rounded/circle).
- [ ] Política para territórios disputados.

## DoD
- [ ] 100% das bandeiras do produto disponíveis.
- [ ] Snapshot por forma × tamanho.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
