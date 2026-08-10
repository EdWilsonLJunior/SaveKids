# StepIndicator

> **Categoria**: Molecule · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Indicador de progresso em fluxo multi-step (ex.: checkout, onboarding). Mostra passos como círculos numerados com conectores.

## História de usuário
Como **usuário**, em um **fluxo multi-step**, quero **saber em qual etapa estou** e **quantas faltam**.

## Critérios de aceite

### Cenário 1 — Estados de step
**Dado** `currentIndex: 1` em 4 steps
**Então** step 0 = completed (check), step 1 = current (highlight), 2-3 = upcoming (muted).

### Cenário 2 — Orientações
**Dado** `orientation: .horizontal | .vertical`
**Então** layout correto.

### Cenário 3 — Tap
**Dado** `allowTapBack: true`
**Então** steps completed são clicáveis para voltar; upcoming não.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** anuncia "Passo 2 de 4: <título>, em andamento"; passos anteriores "concluído".

### Cenário 5 — Light/Dark
**Dado** dark
**Então** tokens resolvem.

## Spec técnica

### APIs públicas
- `ZodiakStepIndicator(steps: [String], currentIndex: Int, orientation: ZodiakStepOrientation = ZodiakStepOrientation.horizontal, allowTapBack: Bool = false, onTap: ((Int) -> Void)? = none)`.

### Tokens
- Cores: completed `actionPrimary`, current `actionPrimary` + ring, upcoming `borderDefault`.
- Tipografia: `labelSmall`.
- Tamanho círculo: `sizing.iconLg`.

## Boas práticas — iOS
- SwiftUI: `HStack { ForEach steps { Circle + label; Connector } }`.

## Boas práticas — Android
- Compose: `Row { steps.forEachIndexed { ... } }`.
- M3 não tem step indicator nativo — implementação custom.

## Acessibilidade
- Anunciar progresso ("2 de 4").
- LiveRegion ao mudar step.

## Referências
- [iOS `Molecules/StepIndicator/ZodiakStepIndicator.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Molecules/StepIndicator/ZodiakStepIndicator.swift)

## Gaps & dúvidas para o time de Design
- [ ] Especificação oficial (cores, tamanhos, conectores)?

## DoD
- [ ] Horizontal + vertical.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
