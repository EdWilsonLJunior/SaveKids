# FlagView

> **Categoria**: Atom · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Exibe bandeira de país (formato circular ou retangular) a partir de código ISO 3166-1 alpha-2. Usado em country picker, phone input, listas internacionais.

## História de usuário
Como **desenvolvedor**, quero **mostrar uma bandeira pelo código do país** para que **assets, tamanho e fallback sigam o DS**.

## Critérios de aceite

### Cenário 1 — Código válido
**Dado** `ZodiakFlagView(code: "BR")`
**Então** renderiza bandeira do Brasil.

### Cenário 2 — Código inválido
**Dado** `code: "XX"`
**Então** mostra placeholder (mundo cinza) sem crash.

### Cenário 3 — Formas
**Dado** `shape: .circle` e `.rect`
**Então** renderiza com shape correto e clipping AA-safe.

### Cenário 4 — Acessibilidade
**Dado** bandeira do Brasil
**Então** VoiceOver/TalkBack anuncia "Brasil"; bandeira sem contexto é decorativa.

### Cenário 5 — RTL
**Dado** locale RTL
**Então** bandeira NÃO é espelhada (símbolos nacionais preservados).

## Spec técnica

### APIs públicas
- `ZodiakFlagView(code: String, shape: ZodiakFlagShape = ZodiakFlagShape.circle, size: ZodiakSize = ZodiakSize.md)`.

### Tokens
- Tamanho: `sizing.flag*` (mapeado para iconXs/Sm/Md/Lg).
- Raio (rect): `radii.xs`.

## Boas práticas — iOS
- Assets em Asset Catalog (`flag_br`, `flag_us`, …). Pré-cache lookup `code → asset`.
- `.accessibilityLabel(Locale.current.localizedString(forRegionCode: code))`.

## Boas práticas — Android
- Drawables em `res/drawable-nodpi/` (SVG ou WebP) ou `res/raw/` (SVG). Mapping via enum.
- `Image(painter, contentDescription = Locale("", code).displayCountry)`.
- Suporte a tablet: garantir SVG vetorial.

## Acessibilidade
- Label = nome localizado do país (`Locale.current.localizedString(forRegionCode:)` / `Locale("", code).displayCountry`).
- Sem contexto adicional, é decorativa.

## Referências
- [iOS `Atoms/Flag/ZodiakFlagView.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Atoms/Flag/ZodiakFlagView.swift)
- [Foundation: flags](../00-foundations/flags.md)

## Gaps & dúvidas para o time de Design
- [ ] Lista oficial de países suportados (ISO list completo)?

## DoD
- [ ] Mapping ISO → asset.
- [ ] Fallback testado.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
