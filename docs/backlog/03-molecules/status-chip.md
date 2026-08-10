# StatusChip

> **Categoria**: Molecule · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Chip não-interativo que comunica status (Ativo, Pendente, Concluído, Falhou). Visualmente similar a `ZodiakBadge` mas com proporções de chip e (opcional) ícone.

## História de usuário
Como **usuário**, quero **identificar status de itens rapidamente** via **chip colorido e padronizado**.

## Critérios de aceite

### Cenário 1 — Tons
**Dado** `tone: .neutral/.info/.success/.warning/.error`
**Então** cor de fundo + texto + ícone seguem tokens `status*Container` / `status*OnContainer`.

### Cenário 2 — Ícone opcional
**Dado** `icon: .check`
**Então** ícone leading; sem ícone, apenas texto.

### Cenário 3 — Tamanhos
**Dado** `size: .small/.medium`
**Então** padding e tipografia escalam.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** anunciado como bloco ("Status: Concluído"); ícone decorativo.

### Cenário 5 — Light/Dark
**Dado** dark
**Então** tokens resolvem.

## Spec técnica

### APIs públicas
- `ZodiakStatusChip(label: String, tone: ZodiakStatusTone = ZodiakStatusTone.neutral, icon: ZodiakIcon? = none, size: ZodiakSize = ZodiakSize.medium)`.

### Tokens
- Background: `status<Tone>Container`.
- Texto/Ícone: `status<Tone>OnContainer`.
- Raio: `radii.full`. Padding: `spacing.s8 / s12`.

## Boas práticas — iOS
- `Capsule().fill(...)` + overlay com `HStack { Icon; Text }`.

## Boas práticas — Android
- Material 3 `AssistChip`/`InputChip` desabilitado (`enabled = false` mas visualmente "ativo") OU custom `Surface`.

## Acessibilidade
- Label deve incluir contexto ("Status: ...").

## Referências
- [iOS `Molecules/StatusChip/ZodiakStatusChip.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Molecules/StatusChip/ZodiakStatusChip.swift)

## Gaps & dúvidas para o time de Design
- [ ] Lista canônica de status?

## DoD
- [ ] Tons + ícones.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
