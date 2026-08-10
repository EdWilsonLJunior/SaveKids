# Button Warning

> **Categoria**: Atom (Button) · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não documentado isoladamente

## Contexto
Versão do botão regular para **ações destrutivas / atenção** (ex.: Excluir, Cancelar assinatura). Três APIs públicas — `Primary`, `Secondary`, `Tertiary` — equivalentes ao regular, mas com paleta `statusError` (ou tons "warning"/"destructive").

## História de usuário
Como **usuário**, quero **identificar ações destrutivas visualmente** para **evitar erros irreversíveis**.

## Critérios de aceite

### Cenário 1 — Variantes
**Dado** `ZodiakWarningButtonPrimary/Secondary/Tertiary`
**Então** cada uma renderiza em paleta error.

### Cenário 2 — Estados
**Dado** `default/pressed/disabled/loading`
**Então** corretos; AA mesmo em pressed.

### Cenário 3 — Superfícies
**Dado** `surface: ZodiakSurface.onLite/ZodiakSurface.onHeavy/ZodiakSurface.onPhoto`
**Então** tokens resolvem.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** anuncia papel `button`; com semântica destructive quando suportado pela plataforma (detalhes em Boas práticas).

### Cenário 5 — Hit-target & confirmação
**Dado** ação irreversível
**Então** botão exige confirmação adicional (não responsabilidade do atom — chamador deve apresentar `ZodiakModal`/alert).

## Spec técnica

### APIs públicas
- `ZodiakWarningButtonPrimary(...)`, `Secondary(...)`, `Tertiary(...)`. Mesma assinatura do regular, sem `Ghost` (avaliação de design).

### Implementação
- Wrapper sobre `ZodiakButtonImpl` fixando estilo + `tone: .error`.

### Tokens
- Cor: `colors.statusError` (Primary fill), `statusErrorContainer` (Secondary bg), `statusError` outline (Tertiary).
- Demais herda regular.

## Boas práticas — iOS
- SwiftUI: `Button("Excluir", role: .destructive)` para alerts nativos.
- `ZodiakWarningButton*` é a versão custom standalone (fora de alert).
- HIG: [Buttons](https://developer.apple.com/design/human-interface-guidelines/buttons) — destructive guidance.

## Boas práticas — Android
- Material 3: usar `Button`/`OutlinedButton`/`TextButton` com `colors = ButtonDefaults.buttonColors(containerColor = MaterialTheme.colorScheme.error)`.
- M3 Expressive sinaliza destructive via shape morphing distinto (opcional).

## Acessibilidade
- Cor não é único sinal (texto explícito).
- AA mesmo em pressed.
- Foco visível.

## Referências
- [iOS `Atoms/Button/ZodiakWarningButtons.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Atoms/Button/ZodiakWarningButtons.swift)

## Gaps & dúvidas para o time de Design
- [ ] **Ghost warning** existe?
- [ ] Diferença visual entre **warning** (atenção) e **destructive** (irreversível)?

## DoD
- [ ] 3 APIs + Impl reusando regular impl.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Importação
```tsx
import { ButtonRegular } from '@cg-groupit/zodiak-design-system';
```

### Uso (variante warning)
```tsx
<ButtonRegular label="Excluir" isWarning={true} hierarchy="primary" />
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `label` | `string` | — | Texto do botão |
| `isWarning` | `boolean` | `false` | Ativa tratamento visual de aviso |
| `hierarchy` | `'primary' \| 'secondary' \| 'tertiary'` | `'primary'` | Hierarquia visual |
| `background` | `'onLite' \| 'onHeavy' \| 'onPhoto'` | `'onLite'` | Contexto de superfície |
| `disabled` | `boolean` | `false` | Estado desabilitado |

### Acessibilidade
- O `label` deve comunicar claramente a ação destrutiva (ex.: "Excluir conta").
- Considere exibir um diálogo de confirmação antes de executar ações irreversíveis.

### Storybook
- `AllOptions`: hierarquias × superfícies com `isWarning`
- `Playground`: controles interativos
