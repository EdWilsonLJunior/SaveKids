# FontModifier (utils)

> **Categoria**: Utils · **Prioridade**: P0 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Extensão/modifier que aplica `ZodiakTextStyle` consumindo tokens de tipografia. Substitui aplicação direta de fonte, garantindo Dynamic Type / FontScale corretos.

## História de usuário
Como **desenvolvedor**, quero **aplicar style tipográfico via modifier** para **não usar `.font` puro e respeitar tokens**.

## Critérios de aceite

### Cenário 1 — API
**Dado** uma view-host com `zodiakStyle(style: ZodiakTextStyle.bodyLarge)` aplicado
**Então** font, line-height, tracking e cor (opcional) são aplicados consumindo o token.

### Cenário 2 — Dynamic Type / FontScale
**Dado** sistema com FontScale 2.0
**Então** style escala respeitando max do token.

### Cenário 3 — Light/Dark
**Dado** dark
**Então** cor padrão herda `colors.textPrimary` (token).

### Cenário 4 — Acessibilidade
**Dado** style aplicado a heading
**Então** `accessibilityHeading` automático quando estilo é `headline*` (opcional).

### Cenário 5 — Composabilidade
**Dado** chain `.zodiakStyle(.title).zodiakColor(.textInverse)`
**Então** combinam corretamente.

## Spec técnica

### APIs públicas
- `zodiakStyle(style: ZodiakTextStyle)` — extensão/modifier aplicável a qualquer view-host de texto. Assinatura concreta por plataforma em Boas práticas.

### Tokens
- Consome `typography.*`.

## Boas práticas — iOS
- **Assinatura concreta**: `extension View { func zodiakStyle(_ style: ZodiakTextStyle) -> some View }`.

- Reutilizar para custom subviews que precisem aplicar style.
- `Font.custom(_:size:relativeTo:)`.

## Boas práticas — Android
- **Assinatura concreta**: `Modifier.zodiakStyle(style: ZodiakTextStyle)` — internamente atualiza `LocalTextStyle`.

- `CompositionLocalProvider(LocalTextStyle provides ...)`.

## Referências
- [iOS `Utils/ZodiakFontModifier.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Utils/ZodiakFontModifier.swift)

## Gaps & dúvidas para o time de Design
- [ ] Auto-heading para headline*?

## DoD
- [ ] Extensão/modifier API + chainability.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).
