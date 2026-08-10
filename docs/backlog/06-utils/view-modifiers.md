# View Modifiers

> **Categoria**: Utils · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Catálogo de view modifiers gerais do DS: `zodiakCard`, `zodiakElevation`, `zodiakSurface`, `zodiakSafeAreaPadding`, etc.

## História de usuário
Como **desenvolvedor**, quero **modifiers reutilizáveis** para **aplicar tokens consistentemente em containers customizados**.

## Critérios de aceite

### Cenário 1 — `.zodiakCard()`
**Dado** view qualquer
**Então** background `surface` + raio + sombra `level1`.

### Cenário 2 — `.zodiakElevation(.level3)`
**Dado** view
**Então** sombra correspondente.

### Cenário 3 — `.zodiakSurface(ZodiakSurface.onLite)`
**Dado** view
**Então** background apropriado.

### Cenário 4 — Composabilidade
**Dado** chain de modifiers
**Então** combinam sem conflito.

### Cenário 5 — Light/Dark
**Dado** dark
**Então** tokens resolvem.

## Spec técnica

### APIs públicas
- `zodiakCard()`, `zodiakElevation(level: ZodiakElevation)`, `zodiakSurface(surface: ZodiakSurface)` — extensões/modifiers aplicáveis a qualquer view-host. Assinaturas concretas em Boas práticas.

## Boas práticas — iOS
- `ViewModifier` protocol para reuso.
- **Assinatura concreta**: `extension View { func zodiakCard() -> some View; func zodiakElevation(_ level: ZodiakElevation) -> some View; func zodiakSurface(_ surface: ZodiakSurface) -> some View }`.

## Boas práticas — Android
- Functions retornando `Modifier`.
- **Assinatura concreta**: `fun Modifier.zodiakCard(): Modifier; fun Modifier.zodiakElevation(level: ZodiakElevation): Modifier; fun Modifier.zodiakSurface(surface: ZodiakSurface): Modifier`.

## Referências
- [iOS `Utils/ZodiakViewModifiers.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Utils/ZodiakViewModifiers.swift)

## DoD
- [ ] Catálogo de modifiers básicos.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).
