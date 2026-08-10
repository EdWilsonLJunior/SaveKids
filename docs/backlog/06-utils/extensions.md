# Extensions

> **Categoria**: Utils · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Extensões utilitárias: Color/Image lookup por token, Date/Number formatters localizados, conversões Length (Dp/pt), helpers de plataforma. Expressão final em cada plataforma usa o idioma nativo (ver Boas práticas).

## História de usuário
Como **desenvolvedor**, quero **acesso conciso a tokens** via **extensions idiomáticas da plataforma**.

## Critérios de aceite

### Cenário 1 — Color
**Dado** acesso a uma cor por token via extensão idiomática da plataforma
**Então** retorna a cor resolvida.

### Cenário 2 — Image
**Dado** acesso a um asset por token via extensão idiomática da plataforma
**Então** asset correto.

### Cenário 3 — Formatadores
**Dado** `Date.zodiakFormatted(.relative)`
**Então** string localizada PT-BR/EN.

### Cenário 4 — Acessibilidade
**Dado** nenhum efeito direto
**Então** sem impacto.

### Cenário 5 — Light/Dark
**Dado** dark
**Então** Color extensions resolvem para dark token.

## Spec técnica

### APIs públicas
Extensões idiomáticas por plataforma que expõem tokens (cores, imagens, fontes, formatters) com uma chamada concisa. Expressão concreta detalhada em Boas práticas.

## Boas práticas — iOS
- Evitar `static` excessivo; preferir `Environment` quando precisa de theme.
- Exemplo: `extension Color { static var zodiak: ZodiakColorTokens { … } }`, similar para `Image`, `Font`, `Date`.

## Boas práticas — Android
- Top-level `@Composable` functions ou extension properties on `ZodiakTheme`.
- Composables que leem `LocalContext` ou `ZodiakTheme`.

## Referências
- [iOS `Utils/ZodiakExtensions.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Utils/ZodiakExtensions.swift)

## DoD
- [ ] Extensions com KDoc/DocC.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).
