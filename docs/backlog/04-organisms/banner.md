# Banner

> **Categoria**: Organism · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Bloco proeminente full-bleed/cards de destaque (CTAs promocionais ou educacionais). Combina mídia + título + texto + ações.

## História de usuário
Como **usuário**, quero **destacar mensagens importantes** que requerem atenção mas não bloqueiam a tela.

## Critérios de aceite

### Cenário 1 — Composição
**Dado** image + title + body + primary/secondary actions
**Então** layout vertical (mobile) ou horizontal (tablet) conforme breakpoint.

### Cenário 2 — Variantes de mídia
**Dado** `media: .image | .illustration | .none`
**Então** asset correto.

### Cenário 3 — Light/Dark + superfícies
**Dado** `surface: ZodiakSurface.onPhoto`
**Então** texto + actions garantem AA com backdrop.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** lido como bloco; mídia decorativa quando ilustração; semântica clara.

### Cenário 5 — Dismiss opcional
**Dado** `dismissible: true`
**Então** close button + persistência ao retornar (responsabilidade do chamador).

## Spec técnica

### APIs públicas
- `ZodiakBanner(title: String, body: String? = none, media: ZodiakBannerMedia? = none, primaryAction: ZodiakBannerAction? = none, secondaryAction: ZodiakBannerAction? = none, dismissible: Bool = false, onDismiss: Action? = none, surface: ZodiakSurface = ZodiakSurface.onLite)`.

### Tokens
- Raio: `radii.lg`. Padding: `spacing.s24`. Sombra: `shadows.level1`.

## Boas práticas — iOS
- Adaptar layout por `horizontalSizeClass`.

## Boas práticas — Android
- WindowSizeClass para responsivo.

## Acessibilidade
- Imagem decorativa sem label.
- Botões acessíveis independentes.

## Referências
- [iOS `Organisms/Banner/`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/Banner/)

## Gaps & dúvidas para o time de Design
- [ ] Spec oficial (medidas, paddings, max-lines)?

## DoD
- [ ] Adaptive layout.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
