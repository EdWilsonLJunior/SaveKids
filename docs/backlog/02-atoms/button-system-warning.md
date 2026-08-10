# Button System Warning

> **Categoria**: Atom (Button) · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Variante warning de `ZodiakSystemButton` — usada em alertas/banners de erro ou aviso para a ação principal (ex.: "Tentar novamente", "Reabrir").

## História de usuário
Como **usuário**, em **contexto de erro/aviso**, quero **resolver via botão claramente associado ao alerta**.

## Critérios de aceite

### Cenário 1 — Cor
**Dado** `ZodiakSystemWarningButton("Tentar novamente")`
**Então** texto em `colors.statusError` (em alerta error) ou `statusWarning` (alerta warning).

### Cenário 2 — Estados
**Dado** `default/pressed/disabled`
**Então** visual correto.

### Cenário 3 — Em alertas
**Dado** uso em `ZodiakAlert.error`
**Então** ação destacada em pé com o conteúdo do alerta.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** "<label>, botão"; semântica nativa de destructive quando aplicável (ver Boas práticas por plataforma).

### Cenário 5 — Hit-target
**Dado** botão small
**Então** ≥ `Zodiak.hitTarget.minimum`.

## Spec técnica

### APIs públicas
- `ZodiakSystemWarningButton(label: String, tone: ZodiakStatusTone = ZodiakStatusTone.error, surface: ZodiakSurface = ZodiakSurface.onLite, size: ZodiakButtonSize = ZodiakButtonSize.medium, action: Action)`.
- Enum `ZodiakStatusTone { error, warning }`.

### Implementação
- Wrapper sobre `ZodiakButtonImpl` (ghost) com cor mapeada para `statusError`/`statusWarning`.

### Tokens
- Cor: `colors.statusError`/`statusWarning`.

## Boas práticas — iOS
- SwiftUI: `.tint(.red)` ou `.foregroundStyle(...)`.
- `.alert(...)` quando contexto for nativo (não usar `ZodiakSystemWarningButton` dentro de `.alert` — use `Button(role: .destructive)`).

## Boas práticas — Android
- `TextButton(colors = ButtonDefaults.textButtonColors(contentColor = MaterialTheme.colorScheme.error))`.

## Acessibilidade
- Cor não é único sinal de erro — texto/ícone também.
- AA garantido por token `statusError`.

## Referências
- [iOS `Atoms/Button/ZodiakSystemWarningButton.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Atoms/Button/ZodiakSystemWarningButton.swift)

## Gaps & dúvidas para o time de Design
- [ ] Tom warning vs error em system button — quando usar cada?

## DoD
- [ ] API com tone.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Importação
```tsx
import { ButtonSystem } from '@cg-groupit/zodiak-design-system';
```

### Uso (variante warning)
```tsx
<ButtonSystem label="Atenção" warning={true} hierarchy="primary" />
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `label` | `string` | — | Texto do botão (obrigatório) |
| `warning` | `boolean` | `false` | Aplica ícone e cores de aviso |
| `size` | `'small' \| 'medium'` | `'small'` | Tamanho |
| `hierarchy` | `'primary' \| 'secondary'` | `'primary'` | Hierarquia visual |
| `disabled` | `boolean` | `false` | Estado desabilitado |

### Acessibilidade
- O ícone de aviso é decorativo (`aria-hidden`); o `label` deve transmitir o contexto completo.

### Storybook
- `AllOptions`: variante warning × hierarquias × tamanhos
- `Playground`: controles interativos
