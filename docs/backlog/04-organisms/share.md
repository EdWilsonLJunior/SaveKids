# Share

> **Categoria**: Organism · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Organism que aciona compartilhamento nativo (ActivityViewController iOS / ShareSheet Android) com fallback custom para canais Zodiak.

## História de usuário
Como **usuário**, quero **compartilhar conteúdo via apps instalados** com **fluxo nativo**.

## Critérios de aceite

### Cenário 1 — Trigger
**Dado** `ZodiakShare(content:)` ou `ZodiakShareButton`
**Então** ao tocar, sheet nativa abre com conteúdo.

### Cenário 2 — Conteúdo
**Dado** texto, URL, imagem
**Então** sheet apresenta opções aplicáveis.

### Cenário 3 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** botão tem label "Compartilhar"; sheet nativa já é acessível.

### Cenário 4 — Light/Dark
**Dado** dark
**Então** sheet usa dark do SO.

### Cenário 5 — Fallback
**Dado** plataforma sem sheet nativa (raro)
**Então** custom drawer com botões.

## Spec técnica

### APIs públicas
- `ZodiakShareButton(content: ZodiakShareContent, label: String = "Compartilhar")`.
- `ZodiakShare.present(content:)` para invocação programática.
- `ZodiakShareContent(text: String? = none, url: URL? = none, image: Image? = none)`.

## Boas práticas — iOS
- SwiftUI: `ShareLink(item:)` (iOS 16+) — nativo, recomendado.
- `UIActivityViewController` para casos custom.

## Boas práticas — Android
- Compose: `Intent(Intent.ACTION_SEND).putExtra(...)` + `context.startActivity(Intent.createChooser(intent, "..."))`.
- Android 14+: `ShareController` API.

## Acessibilidade
- Botão com label semântico.
- Sheet nativa garante a11y.

## Referências
- [iOS `Organisms/Share/`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/Share/)

## Gaps & dúvidas para o time de Design
- [ ] Preview de conteúdo no botão (image thumb) — necessário?

## DoD
- [ ] ShareLink + Intent.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
