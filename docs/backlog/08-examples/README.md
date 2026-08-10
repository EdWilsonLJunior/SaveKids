# 08 — Examples (Projetos Finais iOS)

Backlog de planejamento para os **8 projetos finais** da turma iOS. Cada épico representa um mini-app completo com 8 telas, arquitetura MVVM, API REST (real ou mock), persistência local e DS Zodiak.

> **Referência primária**: [`docs/backlog/raw_pdf/finalBacklog.md`](../raw_pdf/finalBacklog.md)
> **Template de US**: [`docs/backlog/_template/COMPONENT_TEMPLATE.md`](../_template/COMPONENT_TEMPLATE.md) — adaptado para features de produto.
> **Fase**: Planejamento — nenhum código Swift é produzido nesta seção.

---

## Convenções desta seção

- **Categoria**: `Feature` (em vez de Atom / Molecule / Organism).
- **Prioridade**:
  - **P0** — Telas obrigatórias do estrutura mínima (telas 1–5 de cada projeto).
  - **P1** — Telas opcionais 6–8 e fluxos alternativos.
  - **P2** — Melhorias, polimentos e diferenciais avançados.
- **Persona padrão**: `estudante iOS` (desenvolvedor em formação que implementa o projeto).
- **Idioma**: pt-BR.
- **Diagramas**: todos em MermaidJS (`flowchart LR` para navegação, `sequenceDiagram` para dados).
- **Sem código** nas histórias — apenas contratos, critérios, componentes DS e decisões de design.
- **Notação DS**: referenciar componentes pelo nome (`ZodiakSlideToSubmit`) e tokens pelo alias (`Zodiak.spacing.s16`), nunca por valor literal.

---

## Índice de épicos

| # | Épico | Telas | API | Persistência |
|---|---|---|---|---|
| [29](29-withdrawal-provisioning/README.md) | Provisionamento de Saque | 8 | Mock JSON (unidades) | `@AppStorage` |
| [30](30-loyalty-program/README.md) | Programa Fidelidade | 8 | Mock JSON (promoções, recompensas) | `@AppStorage` |
| [31](31-card-manager/README.md) | Gerenciador de Cartões | 8 | Mock JSON (cartões, compras) | `@AppStorage` |
| [32](32-splitpay/README.md) | SplitPay | 8 | Mock JSON (grupos, usuários) | SwiftData |
| [33](33-safevault/README.md) | SafeVault | 8 | Mock JSON (backup) | SwiftData |
| [34](34-pocketbank-kids/README.md) | PocketBank Kids | 8 | Mock JSON (missões, recompensas) | SwiftData |
| [35](35-crypto-wallet/README.md) | Crypto Wallet Fake | 8 | **CoinGecko API (real)** + fallback JSON | SwiftData |
| [36](36-payflow/README.md) | PayFlow | 8 | Mock JSON (serviços, preços) | SwiftData |

---

## Checklist mínimo por épico (requisitos de finalBacklog.md)

- [ ] Interface com `NavigationStack` + rotas, modais e fluxos condicionais
- [ ] Mínimo 5 telas — máximo 8 telas (todos os épicos têm 8)
- [ ] Consumo de pelo menos uma API REST com URLSession + Codable + tratamento de erros + loading
- [ ] Persistência local (SwiftData, `@AppStorage` ou cache)
- [ ] Arquitetura MVVM com separação View / ViewModel / Repositório / Modelo
- [ ] Strings via `String(localized:)` + `Localizable.xcstrings`
- [ ] Dark mode sem hardcode de cor
- [ ] Acessibilidade: `accessibilityLabel` em todos os elementos interativos

---

## Relação com o app ZodiakiOS

Os 8 épicos serão registrados como `ExampleItem` (IDs 29–36) em `CatalogModel.swift` e roteados a partir de `ExamplesListView.swift`. A implementação Swift é fase posterior e separada deste backlog.
