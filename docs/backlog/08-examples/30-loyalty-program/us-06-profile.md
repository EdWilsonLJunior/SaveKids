# Atualizar Dados do Perfil

> **Épico**: Programa Fidelidade
> **US-ID**: US-30.06
> **Tela nº**: 6 de 8
> **Prioridade**: P1
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Formulário para o cliente atualizar e-mail, nome e preferências de notificação. Dados persistidos em `@AppStorage` como JSON encoded. Validação em tempo real com feedback inline via `ZodiakNotice`.

---

## História de usuário

Como **cliente**, quero **atualizar meus dados de perfil**, para que **o programa de fidelidade use informações corretas para comunicação**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Fluxo principal (happy path)
**Dado** que preenchi nome e e-mail válidos
**Quando** toco em "Salvar"
**Então** dados são persistidos em `@AppStorage("lp.profile")`
**E** exibo `ZodiakNotice` de sucesso "Dados atualizados com sucesso"

### Cenário 2 — Validação de e-mail em tempo real
**Dado** que estou preenchendo o campo de e-mail
**Quando** o campo perde o foco com um e-mail inválido
**Então** `ZodiakNotice` inline exibe "E-mail inválido"

### Cenário 3 — Dados pré-preenchidos
**Dado** que já salvei dados anteriormente
**Quando** acesso a tela Perfil
**Então** os campos são pré-preenchidos com os dados de `@AppStorage("lp.profile")`

### Cenário 4 — Cancelamento sem salvar
**Dado** que alterei algum campo sem salvar
**Quando** toco no botão "Cancelar" ou volto
**Então** exibo `ZodiakModal` "Deseja descartar as alterações?"
**Quando** confirmo
**Então** os dados locais são restaurados ao estado original

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** cada campo anuncia label, hint e estado de erro quando inválido
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push de `LPHomeScreen` (ícone perfil na toolbar)
- **Saída**: ← back para Home
- **Parâmetros**: nenhum

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Perfil do usuário | `@AppStorage("lp.profile")` decoded como `LPProfile` | UserDefaults |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakFormContainer` | Container do formulário |
| `ZodiakLabelledField` | Campos nome e e-mail |
| `ZodiakSwitch` | Preferências de notificação (e-mail, push) |
| `ZodiakNotice` | Erros de validação e sucesso |
| `ZodiakButton` | "Salvar" |
| `ZodiakSecondaryButton` | "Cancelar" |
| `ZodiakModal` | Confirmação de descarte |

### Estados da tela
- `idle`, `dirty(hasErrors)`, `saving`, `success`, `error`

### Validações
- Nome: mínimo 2 caracteres
- E-mail: formato válido (`@` + domínio)

---

## Referências

- [finalBacklog.md — Projeto 2](../../raw_pdf/finalBacklog.md)
- [US-30.02 — Home](us-02-home.md)

---

## Definition of Done

- [ ] História revisada, critérios aprovados, componentes mapeados
- [ ] Strings: `lp.profile.title`, `lp.profile.field_name`, `lp.profile.field_email`, `lp.profile.toggle_email_notif`, `lp.profile.toggle_push_notif`, `lp.profile.action_save`, `lp.profile.action_cancel`, `lp.profile.error_email`, `lp.profile.error_name`, `lp.profile.success`, `lp.profile.discard_title`, `lp.profile.discard_confirm`
- [ ] Schema de `LPProfile` definido
- [ ] Implementação pode começar sem ambiguidades
