# Controles do Cartão

> **Épico**: Gerenciador de Cartões
> **US-ID**: US-31.05
> **Tela nº**: 5 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Central de controles de um cartão: bloqueio/desbloqueio, ajuste de limite via slider, e cancelamento do cartão. Ações destrutivas (bloquear, cancelar) requerem confirmação via `ZodiakModal` com `ZodiakWarningButton`.

---

## História de usuário

Como **correntista**, quero **bloquear, desbloquear ou ajustar o limite do meu cartão**, para que **eu tenha controle rápido sobre a segurança e uso dos meus cartões**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Bloquear cartão
**Dado** que o cartão está ativo
**Quando** aciono o `ZodiakSwitch` "Bloquear cartão"
**Então** exibo `ZodiakModal` com `ZodiakWarningButton` "Confirmar bloqueio"
**Quando** confirmo
**Então** `@AppStorage("cm.card_{id}.blocked") = true`
**E** o `ZodiakSwitch` permanece acionado com `ZodiakStatusChip` "Bloqueado"

### Cenário 2 — Desbloquear cartão
**Dado** que o cartão está bloqueado
**Quando** aciono o `ZodiakSwitch` para desbloquear
**Então** exibo `ZodiakModal` de confirmação simples (não destrutiva)
**Quando** confirmo
**Então** `@AppStorage("cm.card_{id}.blocked") = false`

### Cenário 3 — Ajustar limite via slider
**Dado** que o limite atual é R$ 5.000,00 (intervalo: R$ 500,00 – R$ 15.000,00)
**Quando** ajusto o `ZodiakSliderCounter`
**Então** o valor exibido atualiza em tempo real
**E** toco em "Salvar limite"
**Então** `@AppStorage("cm.card_{id}.limit")` atualiza com novo valor

### Cenário 4 — Cancelar cartão
**Dado** que toco em "Cancelar cartão"
**Então** exibo `ZodiakModal` com `ZodiakWarningButton` "Confirmar cancelamento"
**E** campo de senha para confirmação adicional
**Quando** confirmo
**Então** cartão é marcado como cancelado em `@AppStorage`
**E** retorno para `CMCardListScreen`

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** `ZodiakSwitch` anuncia "Bloquear cartão, desligado. Toque duas vezes para ativar."
**E** `ZodiakSliderCounter` anuncia valor atual e range
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push de `CMCardDetailScreen`
- **Saída**: ← back para CardDetail · `popToRoot` após cancelamento de cartão
- **Parâmetros recebidos**: `card: CMCard`

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Status de bloqueio | `@AppStorage("cm.card_{id}.blocked")` | UserDefaults |
| Limite ajustado | `@AppStorage("cm.card_{id}.limit")` | UserDefaults |
| Cartão cancelado | `@AppStorage("cm.card_{id}.cancelled")` | UserDefaults |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakSwitch` | Toggle de bloqueio |
| `ZodiakSliderCounter` | Ajuste de limite (step R$ 500) |
| `ZodiakModal` | Confirmações de bloqueio e cancelamento |
| `ZodiakWarningButton` | "Confirmar bloqueio" / "Confirmar cancelamento" |
| `ZodiakInfoRow` | Limite atual e limites mínimo/máximo |
| `ZodiakButton` | "Salvar limite" |
| `ZodiakPasswordField` | Confirmação de senha para cancelamento |
| `ZodiakEyebrow` | Seções: Segurança / Limite / Cancelamento |
| `ZodiakDivider` | Separação de seções |

---

## Definition of Done

- [ ] Strings: `cm.controls.section_security`, `cm.controls.toggle_block`, `cm.controls.section_limit`, `cm.controls.action_save_limit`, `cm.controls.section_cancel`, `cm.controls.action_cancel_card`, `cm.controls.block_confirm_title`, `cm.controls.unblock_confirm_title`, `cm.controls.cancel_confirm_title`
- [ ] Limites de slider definidos (R$ 500 – R$ 15.000, step R$ 500)
- [ ] Implementação pode começar sem ambiguidades
