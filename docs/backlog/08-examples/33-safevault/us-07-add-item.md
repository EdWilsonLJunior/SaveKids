# Adicionar Item ao Cofre

> **Épico**: SafeVault
> **US-ID**: US-33.07
> **Tela nº**: 7 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Wizard step-by-step para adicionar um novo item ao cofre. O usuário seleciona o tipo de item (Cartão, Documento, Senha, Chave Pix) e os campos são apresentados dinamicamente conforme o tipo escolhido.

---

## História de usuário

Como **usuário**, quero **adicionar um novo item ao cofre**, para que **todos meus dados sensíveis sejam centralizados e protegidos**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Adicionar cartão (happy path)
**Dado** que selecionei tipo "Cartão"
**Então** exibo campos: número (com máscara), nome no cartão, validade, CVV e bandeira
**Quando** preencho todos e toco "Salvar"
**Então** `SVVaultItem(type: .card)` é inserido no SwiftData
**E** retorno para a tela correspondente

### Cenário 2 — Campos dinâmicos por tipo
**Dado** que seleciono "Senha"
**Então** exibo campos: nome do serviço, login/e-mail, senha (com toggle reveal) e botão "Gerar senha"
**Dado** que seleciono "Chave Pix"
**Então** exibo `ZodiakDropdown` para tipo da chave + campo correspondente

### Cenário 3 — Campo obrigatório vazio
**Dado** que deixei campo obrigatório em branco
**Quando** toco "Salvar"
**Então** `ZodiakNotice` exibe "Este campo é obrigatório"

### Cenário 4 — Cancelamento
**Dado** que editei algum campo
**Quando** toco "Cancelar"
**Então** exibo `ZodiakModal` "Descartar alterações?"
**Quando** confirmo
**Então** retorno sem persistir

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** `ZodiakDropdown` de tipo anuncia seleção atual
**E** campos obrigatórios anunciam erro quando inválidos
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push de qualquer tela de categoria (Cards, Documents, Passwords, PixKeys) via FAB +
- **Saída**: ← back para a tela de origem após salvar ou cancelar
- **Parâmetros opcionais**: `preselectedType: SVItemType?`

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Tipo selecionado | `@State var selectedType: SVItemType` | em memória |
| Campos preenchidos | `@State var fields: [SVField]` | em memória |
| Item criado | SwiftData `insert(SVVaultItem)` | SwiftData |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakDropdown` | Seleção de tipo |
| `ZodiakInputWizard` | Step-by-step de campos por tipo |
| `ZodiakLabelledField` | Campos de texto |
| `ZodiakPasswordField` | Campo senha com toggle |
| `ZodiakNotice` | Erros de validação |
| `ZodiakButton` | "Salvar" e "Gerar senha" (tipo password) |
| `ZodiakSecondaryButton` | "Cancelar" |
| `ZodiakModal` | Confirmação de descarte |

### Validações
- Campos obrigatórios por tipo: definidos no mapeamento de `SVItemType → [SVFieldSpec]`

---

## Definition of Done

- [ ] Strings: `sv.add.title`, `sv.add.field_type`, `sv.add.action_save`, `sv.add.action_cancel`, `sv.add.error_required`, `sv.add.discard_title`, `sv.add.success`
- [ ] Mapeamento de campos por tipo documentado
- [ ] Implementação pode começar sem ambiguidades
