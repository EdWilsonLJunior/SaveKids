# LogoView

> **Categoria**: Atom · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Exibe a marca Zodiak nas variantes wordmark, symbol (apenas ícone), lockup (símbolo + wordmark). Adapta para light/dark/mono.

## História de usuário
Como **designer / desenvolvedor**, quero **exibir o logo Zodiak via `ZodiakLogoView`** para que **versões e safe area sigam o DS**.

## Critérios de aceite

### Cenário 1 — Variantes
**Dado** `ZodiakLogoView(variant: .wordmark | .symbol | .lockup)`
**Então** asset correto é exibido.

### Cenário 2 — Modos
**Dado** `mode: .auto | .light | .dark | .mono`
**Então** asset alterna conforme color scheme; `.mono` força versão única.

### Cenário 3 — Tamanhos
**Dado** `size: ZodiakSize`
**Então** logo escala mantendo aspect ratio.

### Cenário 4 — Acessibilidade
**Dado** logo em header
**Então** VoiceOver/TalkBack anuncia "Zodiak" (uma vez por tela); decorativo em rodapés.

### Cenário 5 — Safe area
**Dado** logo dentro de container
**Então** padding mínimo (safe area) preservado conforme guideline.

## Spec técnica

### APIs públicas
- `ZodiakLogoView(variant: ZodiakLogoVariant = ZodiakLogoVariant.lockup, mode: ZodiakLogoMode = ZodiakLogoMode.auto, size: ZodiakSize = ZodiakSize.md)`.

### Tokens
- Tamanho: `Zodiak.sizing.logoXs/Sm/Md/Lg`.
- Asset paths: ver [logo foundation](../00-foundations/logo.md).

## Boas práticas — iOS
- SVG/PDF em Asset Catalog com **Preserve Vector Data**.
- `Image("zodiak-lockup").renderingMode(.template)` quando `.mono`.
- HIG: [App Icons](https://developer.apple.com/design/human-interface-guidelines/app-icons) (não usar logo como app icon).

## Boas práticas — Android
- Vetor em `res/drawable/` (`zodiak_lockup.xml`).
- `Image(painterResource(...), contentDescription = "Zodiak")`.
- Themed icons (Android 13+) quando aplicável.

## Acessibilidade
- Label "Zodiak" (apenas em header de marca, não em decoração repetida).
- Safe area garante toque seguro quando logo for botão (link para home).

## Referências
- [iOS `Atoms/Logo/ZodiakLogoView.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Atoms/Logo/ZodiakLogoView.swift)
- [Foundation: logo](../00-foundations/logo.md)

## Gaps & dúvidas para o time de Design
- [ ] Versão **mono** existe oficialmente?
- [ ] Safe area mínima — token dedicado (`Zodiak.spacing.logoSafeArea`) precisa ser definido?

## DoD
- [ ] Variantes e modos.
- [ ] Asset vetorial em ambos OS.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
