# InputWizard

> **Categoria**: Molecule · **Prioridade**: P2 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Wizard de input que apresenta perguntas **uma de cada vez**, focando atenção e simplificando UX em formulários longos. Inclui `ZodiakStepIndicator` + atom de input + botões nav.

## História de usuário
Como **usuário**, quero **preencher formulários longos passo a passo** sem **me sentir sobrecarregado**.

## Critérios de aceite

### Cenário 1 — Step único
**Dado** wizard exibe step N
**Então** apenas pergunta N visível; previous/next habilitados conforme posição.

### Cenário 2 — Validação
**Dado** step com input inválido
**Então** next desabilitado; erro inline.

### Cenário 3 — Step indicator sync
**Dado** mudança de step
**Então** indicator atualiza.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** ao mudar step, foco vai para pergunta nova; LiveRegion anuncia "Passo N de M".

### Cenário 5 — Navegação
**Dado** previous/next
**Então** anima slide (respeitando Reduce Motion).

## Spec técnica

### APIs públicas
- `ZodiakInputWizard(steps: [ZodiakWizardStep], currentIndex: Binding<Int>, onComplete: Action)`.
- `ZodiakWizardStep(title, question, content: Slot, isValid: () -> Bool)`.

### Implementação
- Compoe `ZodiakStepIndicator` + slot content + bar inferior com `ZodiakButton`s.

### Tokens
- Herda tokens dos children.

## Boas práticas — iOS
- `TabView(.page)` + custom step indicator.

## Boas práticas — Android
- `HorizontalPager(state, userScrollEnabled = false)` + control via state.

## Acessibilidade
- Foco no novo step ao trocar.
- LiveRegion para anunciar progresso.

## Referências
- [iOS `Molecules/InputWizard/ZodiakInputWizard.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Molecules/InputWizard/ZodiakInputWizard.swift)

## Gaps & dúvidas para o time de Design
- [ ] Botão skip — incluso?
- [ ] Validação síncrona vs assíncrona — padrão?

## DoD
- [ ] Fluxo + step indicator integrado.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
