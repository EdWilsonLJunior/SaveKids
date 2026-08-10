# FormInDrawer

> **Categoria**: Organism · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Formulário apresentado dentro de bottom-sheet/drawer — combina `ZodiakModal` (estilo sheet) + `ZodiakFormContainer`. Comum em apps móveis para edição rápida.

## História de usuário
Como **usuário**, quero **editar dados em drawer** sem **navegar para tela cheia**.

## Critérios de aceite

### Cenário 1 — Apresentação
**Dado** acionar abertura
**Então** drawer sobe do bottom; detents medium/large suportados.

### Cenário 2 — Teclado
**Dado** field focado
**Então** drawer ajusta altura para evitar overlap.

### Cenário 3 — Dismiss
**Dado** swipe down ou close
**Então** se há mudanças não salvas, confirma com alert.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** foco vai para drawer; back retorna.

### Cenário 5 — Light/Dark
**Dado** dark
**Então** tokens resolvem.

## Spec técnica

### APIs públicas
- `ZodiakFormInDrawer(isPresented: Binding<Bool>, title: String, content: Slot, onSubmit: Action, onCancel: Action? = none)`.

### Implementação
- Compõe `ZodiakModal(style: .sheet)` + `ZodiakFormContainer` + footer com botões.

### Tokens
- Herda modal + form.

## Boas práticas — iOS
- `.sheet` com `presentationDetents([.medium, .large])`.

## Boas práticas — Android
- `ModalBottomSheet` com `sheetState`.

## Acessibilidade
- Trap focus.
- Confirmar dismiss não-salvo.

## Referências
- [iOS `Organisms/FormInDrawer/`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/FormInDrawer/)

## Gaps & dúvidas para o time de Design
- [ ] Confirmação default (sempre ou só com dirty)?

## DoD
- [ ] Detents.
- [ ] Confirm leave dirty.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
