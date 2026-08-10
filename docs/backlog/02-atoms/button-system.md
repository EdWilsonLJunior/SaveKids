# Button System

> **Categoria**: Atom (Button) · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Botão de "sistema" — ação inline em alertas, banners, toasts, notification banners — visual reduzido, sem peso visual de regular button. Comumente como link textual com peso bold.

## História de usuário
Como **usuário**, quero **acionar respostas a alertas e mensagens** com **um botão discreto integrado ao container**.

## Critérios de aceite

### Cenário 1 — Aparência
**Dado** `ZodiakSystemButton("Ver detalhes")`
**Então** texto bold em `colors.actionPrimary`, sem fundo, padding mínimo.

### Cenário 2 — Estados
**Dado** `default / pressed / disabled`
**Então** estados corretos.

### Cenário 3 — Em contextos
**Dado** uso em `ZodiakAlert`, `ZodiakToast`, `ZodiakNotificationBanner`
**Então** cor adapta para `actionOnPrimary` / `textInverse` conforme superfície do container.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** "<label>, botão".

### Cenário 5 — Hit-target
**Dado** botão small
**Então** padding estende hit-target ≥ `Zodiak.hitTarget.minimum`.

## Spec técnica

### APIs públicas
- `ZodiakSystemButton(label: String, surface: ZodiakSurface = ZodiakSurface.onLite, size: ZodiakButtonSize = ZodiakButtonSize.medium, isEnabled: Bool = true, action: Action)`.

### Implementação
- Wrapper sobre `ZodiakButtonImpl` (ghost style) com tipografia bold.

### Tokens
- Tipografia: `typography.labelLargeBold`.
- Cor: `colors.actionPrimary` (onLite), `actionOnHeavy`/`actionOnPhoto` para outras superfícies.

## Boas práticas — iOS
- SwiftUI: `Button("...", action:).buttonStyle(.borderless)` + custom style.

## Boas práticas — Android
- Material 3: `TextButton` com `colors = ButtonDefaults.textButtonColors(contentColor = ...)`.

## Acessibilidade
- Hit-target.
- Foco visível.

## Referências
- [iOS `Atoms/Button/ZodiakSystemButton.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Atoms/Button/ZodiakSystemButton.swift)

## Gaps & dúvidas para o time de Design
- [ ] É o mesmo que `ZodiakButtonGhost`? Diferenciar ou unificar?

## DoD
- [ ] API + Impl.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Importação
```tsx
import { ButtonSystem } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `label` | `string` | — | Texto do botão (obrigatório) |
| `size` | `'small' \| 'medium'` | `'small'` | Tamanho |
| `hierarchy` | `'primary' \| 'secondary'` | `'primary'` | Hierarquia visual |
| `warning` | `boolean` | `false` | Aplica tratamento visual de aviso |
| `disabled` | `boolean` | `false` | Estado desabilitado |

### Acessibilidade
- Estilização inline (`style`) está bloqueada; use `className` para customizações necessárias.
- Sempre forneça `label` descritivo.

### Storybook
- `AllOptions`: grade de hierarquias × tamanhos
- `Playground`: controles interativos
