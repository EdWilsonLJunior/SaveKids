# SlideToSubmit

> **Categoria**: Molecule · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Controle de confirmação por swipe — usuário arrasta um handle até o final para confirmar uma ação (ex.: "Deslize para pagar"). Previne toques acidentais.

## História de usuário
Como **usuário**, quero **confirmar ação crítica por swipe** para **evitar disparos acidentais**.

## Critérios de aceite

### Cenário 1 — Swipe completo
**Dado** arrasto handle 100% do trilho
**Então** `onCommit` chamado; estado visual "loading" → "success".

### Cenário 2 — Swipe parcial
**Dado** solto antes do final
**Então** handle volta ao início com animação.

### Cenário 3 — Estados
**Dado** `idle/dragging/loading/success/error/disabled`
**Então** estados corretos.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** anuncia como botão alternativo "Confirmar pagamento, deslize, ou toque duplo para ativar"; toque duplo dispara `onCommit` direto (sem exigir swipe — a11y override).

### Cenário 5 — Reduce Motion
**Dado** Reduce Motion ativo
**Então** sem animação de retorno suave; corte direto.

## Spec técnica

### APIs públicas
- `ZodiakSlideToSubmit(label: String, onCommit: () async -> Void, state: ZodiakSlideState = ZodiakSlideState.idle, surface: ZodiakSurface = ZodiakSurface.onLite, accessibilityHint: String = "Toque duplo para confirmar")`.

### Tokens
- Trilho: `colors.actionPrimary` background, `actionOnPrimary` texto.
- Handle: `colors.surface` com `shadows.level2`.

## Boas práticas — iOS
- `DragGesture` em `Circle` + offset binding.
- `.accessibilityAction { onCommit() }` para override de gesto.

## Boas práticas — Android
- Compose: `Modifier.draggable(state, orientation = Horizontal)`.
- `Modifier.semantics { onClick("Confirmar") { onCommit(); true } }` para a11y.

## Acessibilidade
- Override gesto: toque duplo confirma sem swipe.
- Estado loading anunciado.
- Não usar como única forma — fornecer alternativa em a11y settings ou botão regular.

## Referências
- [iOS `Molecules/SlideToSubmit/ZodiakSlideToSubmit.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Molecules/SlideToSubmit/ZodiakSlideToSubmit.swift)

## Gaps & dúvidas para o time de Design
- [ ] Spec oficial (threshold de %, animação)?
- [ ] Variante destructive (vermelho)?

## DoD
- [ ] Estados completos.
- [ ] A11y override.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
