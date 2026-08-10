# ShareStory

> **Categoria**: Organism (Action Compositions) · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog

## Contexto
Bloco visual para "compartilhar story" — preview de conteúdo + botão `ZodiakShareButton` integrado.

## Critérios de aceite
- **Preview**: imagem/título do conteúdo.
- **Botão**: aciona sheet nativa (ver [share](../share.md)).
- **Acessibilidade**: preview decorativo; botão semântico.
- **Light/Dark**: tokens.

## APIs públicas
- `ZodiakShareStory(content: ZodiakShareContent, previewImage: ZodiakImageSource? = none, title: String? = none)`.

## Boas práticas
- Reusa `ZodiakShareButton` internamente.

## Referências
- [iOS `ZodiakActionCompositions.swift` (ZodiakShareStory)](../../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/ActionCompositions/ZodiakActionCompositions.swift)

## DoD
- [ ] Preview + share.
- [ ] Ver [README família](README.md) e [ARCHITECTURE.md § 8](../../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
