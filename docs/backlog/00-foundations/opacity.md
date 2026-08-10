# Opacity (tokens)

> **Categoria**: Foundation · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não (gap)

## Contexto
Valores de opacidade reutilizáveis — scrims, disabled, pressed/hover overlays, dim, ghost. Substitui literais como `0.3f`, `0.5`, `0.12` em componentes.

## História de usuário
Como **desenvolvedor**, quero **opacidades por token** para que **estados (disabled, pressed, scrim) sigam a escala oficial**.

## Critérios de aceite

### Cenário 1 — Catálogo
**Dado** `Zodiak.opacity.*`
**Então** existem ao menos: `full`, `high`, `medium`, `low`, `scrim`, `disabled`, `pressed`, `hover`, `focus`.

### Cenário 2 — Uso
**Dado** botão disabled
**Então** consome `Zodiak.opacity.disabled` (nunca literal).

### Cenário 3 — Scrim
**Dado** modal/sheet
**Então** backdrop usa `Zodiak.opacity.scrim` sobre `Zodiak.colors.scrimBase`.

### Cenário 4 — Acessibilidade
**Dado** texto sobre opacidade reduzida
**Então** contraste resultante ≥ AA.

### Cenário 5 — Reduce Transparency
**Dado** preferência ativa
**Então** opacities translúcidas viram sólidas (override).

## Spec técnica

### APIs públicas
- **iOS**: `Zodiak.opacity.<token>` → `Double` (0.0..1.0).
- **Android**: `ZodiakTheme.opacity.<token>` → `Float`.

### Tokens
- `Zodiak.opacity.full` (1.0)
- `Zodiak.opacity.high`
- `Zodiak.opacity.medium`
- `Zodiak.opacity.low`
- `Zodiak.opacity.scrim`
- `Zodiak.opacity.disabled`
- `Zodiak.opacity.pressed`
- `Zodiak.opacity.hover`
- `Zodiak.opacity.focus`

> Valores numéricos só em `Tokens/ZodiakOpacity.swift` (a criar).

## Boas práticas — iOS
- `.opacity(Zodiak.opacity.disabled)`.
- `.background(Color.black.opacity(Zodiak.opacity.scrim))` — preferir `Color(.scrim)` ou Material vidro.
- Respeitar `@Environment(\.accessibilityReduceTransparency)`.

## Boas práticas — Android
- `Modifier.alpha(ZodiakTheme.opacity.disabled)`.
- Material 3: `LocalContentColor.current.copy(alpha = ZodiakTheme.opacity.disabled)`.
- Scrim: `Scaffold(...)` / `ModalBottomSheet(scrimColor = ...)`.

## Acessibilidade
- Em `disabled`, garantir que o contraste ainda seja perceptível (Material recomenda ≥ 38% para texto desabilitado em fundo claro).
- Em `Reduce Transparency`, scrims viram cor sólida equivalente.

## Referências
- Sem fonte iOS hoje — gap G-058.
- Consumidores: [button-regular](../02-atoms/button-regular.md), [modal](../04-organisms/modal.md), [toast](../04-organisms/toast.md), [button-media](../02-atoms/button-media.md).

## Gaps & dúvidas para o time de Design
- [ ] G-058 — Tokens de opacidade não existem hoje no iOS; criar `ZodiakOpacity.swift`.
- [ ] Valores oficiais para disabled/pressed/hover/focus (M3 default vs Zodiak brand)?

## DoD
- [ ] Tokens expostos.
- [ ] Reduce Transparency tratado.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Disponibilidade
Tokens disponibilizados como **CSS Custom Properties** via `ThemeProvider`. Não há componente React dedicado — os valores são resolvidos automaticamente pela classe de tema no elemento raiz.

### Uso
```tsx
import { ThemeProvider } from '@cg-groupit/zodiak-design-system';

<ThemeProvider defaultTheme="light">
  {/* --zodiak-opacity-disabled fica disponível em todo o subárvore */}
  <div style={{ opacity: 'var(--zodiak-opacity-disabled)' }} />
</ThemeProvider>
```

### Acessibilidade
- Use sempre tokens semânticos (ex.: `--zodiak-action-primary-default`) em vez de valores primitivos ou hardcoded.
