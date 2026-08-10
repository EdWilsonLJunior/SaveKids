# Sizing (tokens)

> **Categoria**: Foundation · **Prioridade**: P0 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Sim

## Contexto
Tokens de tamanho fixo — alturas de botão, ícone, avatar, campo, hit-target. Distintos de spacing por intenção (medida de componente, não gap).

## História de usuário
Como **desenvolvedor**, quero **dimensionar componentes via tokens** para que **alturas e larguras canônicas sejam consistentes (botão, ícone, avatar, campo) sem números mágicos**.

## Critérios de aceite

### Cenário 1 — Catálogo
**Dado** [`ZodiakSizing.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakSizing.swift) e Supernova [`Sizing.md`](../../ZodiakiOS/docs/zodiak-pdf/Sizing.md)
**Então** existe token para cada categoria: hit target, ícone, avatar, campo, botão, slot de ação.

### Cenário 2 — Hit-target mínimo
**Dado** o token `Zodiak.hitTarget.minimum` (ver [hit-target.md](hit-target.md))
**Então** resolve para 44pt (iOS) / 48dp (Android) e é a única referência válida — nunca o número literal.

### Cenário 3 — Variantes por tamanho
**Dado** size enums (`small`, `medium`, `large`) em componentes
**Então** mapeiam diretamente para tokens (`buttonHeightSmall`, `buttonHeightMedium`, `buttonHeightLarge`).

### Cenário 4 — Ícones e avatares
**Dado** as famílias `Zodiak.sizing.iconXs/Sm/Md/Lg/Xl` e `Zodiak.sizing.avatarXs/Sm/Md/Lg/Xl/Xxl`
**Então** todos os tamanhos têm token nomeado — nenhum valor literal aceito em componentes.

### Cenário 5 — Paridade
**Dado** o mesmo token
**Então** pt = dp.

## Spec técnica

### APIs públicas
- **iOS**: `Zodiak.sizing.<token>` → `CGFloat`.
- **Android**: `ZodiakTheme.sizing.<token>` → `Dp`.

### Famílias (consultar Swift para canônica)
- `hitTargetMin`, `hitTargetComfortable`
- `iconXs/Sm/Md/Lg/Xl`
- `avatarXs/Sm/Md/Lg/Xl/Xxl`
- `buttonHeightSm/Md/Lg`
- `fieldHeight`
- `chipHeight`
- `dividerThickness`

## Boas práticas — iOS
- `.frame(width:height:)`, `.frame(minHeight: Zodiak.sizing.hitTargetMin)`.
- HIG: [Layout — Hit targets](https://developer.apple.com/design/human-interface-guidelines/layout) (44pt mínimo).
- Usar `contentShape(.rect)` para garantir hit-target em conteúdo com padding negativo.

## Boas práticas — Android
- `Modifier.size(ZodiakTheme.sizing.iconMd)`, `Modifier.heightIn(min = ZodiakTheme.sizing.hitTargetMin)`.
- Material 3: [Accessibility — Touch targets](https://m3.material.io/foundations/accessible-design/accessibility-basics) (48dp).
- `Modifier.minimumInteractiveComponentSize()` para componentes < 48dp.

## Acessibilidade
- `hitTargetMin` nunca é override-able sem violar AA.
- FontScale alto pode requerer `buttonHeight*` escalar — discutir com Design.

## Referências
- [iOS `ZodiakSizing.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakSizing.swift)
- [Supernova: Sizing](../../ZodiakiOS/docs/zodiak-pdf/Sizing.md)

## Gaps & dúvidas para o time de Design
- [ ] Tokens para `fieldHeight` em FontScale alto (escala ou cresce o padding interno?).
- [ ] Tamanho de hit-target em densidade `compact`.

## DoD
- [ ] 100% dos tokens expostos.
- [ ] Snapshot da sizing sheet.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Disponibilidade
Tokens disponibilizados como **CSS Custom Properties** via `ThemeProvider`. Não há componente React dedicado — os valores são resolvidos automaticamente pela classe de tema no elemento raiz.

### Uso
```tsx
import { ThemeProvider } from '@cg-groupit/zodiak-design-system';

<ThemeProvider defaultTheme="light">
  {/* --zodiak-sizing-button-height-md fica disponível em todo o subárvore */}
  <div style={{ height: 'var(--zodiak-sizing-button-height-md)' }} />
</ThemeProvider>
```

### Acessibilidade
- Use sempre tokens semânticos (ex.: `--zodiak-action-primary-default`) em vez de valores primitivos ou hardcoded.
