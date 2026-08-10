# AuthorCard

> **Categoria**: Organism (Card Variants) · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog

## Contexto
Card de destaque para autor: avatar grande + nome + bio + lista de artigos / botão "Ver perfil".

## Critérios de aceite
- **Composição**: avatar + nome + role + bio + CTA.
- **Acessibilidade**: bloco coeso; CTA acessível separado.
- **Light/Dark**: tokens.

## APIs públicas
- `ZodiakAuthorCard(name: String, role: String? = none, bio: String? = none, avatar: ZodiakAvatarSource? = none, cta: ZodiakAlertAction? = none)`.

## Referências
- [iOS `ZodiakAuthorCard.swift`](../../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/CardVariants/ZodiakAuthorCard.swift)

## DoD
- [ ] Ver [README família](README.md).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
