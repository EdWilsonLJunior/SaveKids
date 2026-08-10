# ProfessionalContact

> **Categoria**: Organism (Action Compositions) · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog

## Contexto
Cartão de contato profissional: avatar + nome + cargo + contatos (telefone, email, link) com ações diretas (call, mail, browse).

## Critérios de aceite
- **Composição**: `ZodiakAvatar` + nome + role + lista de `ZodiakContactItem`.
- **Ações**: cada contato abre app correspondente (tel:, mailto:, https:).
- **Acessibilidade**: cada item de contato é botão com label semântico.
- **Light/Dark**: tokens.
- **Hit-target**: cada ação ≥ `Zodiak.hitTarget.minimum`.

## APIs públicas
- `ZodiakProfessionalContact(name: String, role: String, avatar: ZodiakAvatarSource? = none, contacts: [ZodiakContactItem])`.
- `ZodiakContactItem(kind: ZodiakContactKind, value: String, label: String? = none)`.

## Boas práticas
- **iOS**: `Link(destination: URL(string: "tel:..."))` ou `UIApplication.shared.open`.
- **Android**: `Intent(Intent.ACTION_DIAL, Uri.parse("tel:..."))` + `context.startActivity`.

## Referências
- [iOS `ZodiakActionCompositions.swift` (ZodiakProfessionalContact)](../../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/ActionCompositions/ZodiakActionCompositions.swift)

## DoD
- [ ] Ações tel/mail/web.
- [ ] Ver [README família](README.md) e [ARCHITECTURE.md § 8](../../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
