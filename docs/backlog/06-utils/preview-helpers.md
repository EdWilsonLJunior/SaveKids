# Preview Helpers

> **Categoria**: Utils · **Prioridade**: P2 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Helpers para previews dos componentes — wrap automático em `ZodiakTheme`, variantes de tema, locale, FontScale, RTL, e device sizes. Cada componente do DS recebe previews ricos via esses helpers. Expressão concreta usa a anotação de preview nativa de cada plataforma (ver Boas práticas).

## História de usuário
Como **desenvolvedor**, quero **previews padronizados** para **ver componentes em todos os temas/locales/tamanhos sem boilerplate**.

## Critérios de aceite

### Cenário 1 — Tema dual
**Dado** um wrapper `ZodiakPreview { ... }` aplicado em um componente
**Então** renderiza light + dark lado a lado.

### Cenário 2 — Locale
**Dado** `.locales([.ptBR, .en])`
**Então** previews em cada locale.

### Cenário 3 — FontScale / Dynamic Type
**Dado** `.fontScale(2.0)`
**Então** preview escalado.

### Cenário 4 — Device
**Dado** uma lista de devices configurada no helper
**Então** previews são gerados para cada device declarado.

### Cenário 5 — RTL
**Dado** `.layoutDirection(.rightToLeft)`
**Então** preview em RTL.

## Spec técnica

### APIs públicas
- `ZodiakPreview { content }` — wrapper que aplica tema, locale, fontScale, layoutDirection e device matrix. Assinatura concreta em Boas práticas.

## Boas práticas — iOS
- `#Preview("...", traits: ...) { ... }` (Xcode 15+).
- **Assinatura concreta**: `struct ZodiakPreviewLayout: ViewModifier` + `extension View { func zodiakPreview(...) -> some View }`.

## Boas práticas — Android
- `@Preview(showBackground = true)` + `@Preview(uiMode = UI_MODE_NIGHT_YES)` combinados via `MultiPreview` annotations.
- **Assinatura concreta**: `@Composable fun ZodiakPreviewSurface(content: @Composable () -> Unit)`.

## Referências
- [iOS `Foundation/ZodiakPreview.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Foundation/ZodiakPreview.swift)

## DoD
- [ ] API + uso em todo componente.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).
