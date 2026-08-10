# Cartão Virtual — CVV Dinâmico

> **Épico**: Gerenciador de Cartões
> **US-ID**: US-31.07
> **Tela nº**: 7 de 8
> **Prioridade**: P1
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Exibe o cartão virtual do usuário com CVV dinâmico que muda a cada 30 segundos. Um `ZodiakProgressIndicator` circular exibe o tempo restante antes da renovação. Implementado com `Timer.publish(every: 1, on: .main, in: .common)`.

---

## História de usuário

Como **correntista**, quero **ver o CVV dinâmico do meu cartão virtual**, para que **eu realize compras online com segurança adicional**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — CVV dinâmico (happy path)
**Dado** que estou na tela Cartão Virtual
**Quando** a tela é exibida
**Então** exibo CVV mock (3 dígitos) com countdown de 30 segundos via `ZodiakProgressIndicator` circular
**E** quando o Timer atinge zero, o CVV é substituído por novo valor e o countdown reinicia

### Cenário 2 — Notificação de expiração
**Dado** que restam 5 segundos para o CVV expirar
**Então** `ZodiakNotice` com `.warning` é exibido: "CVV expirando em 5 segundos"

### Cenário 3 — Copiar CVV
**Dado** que o CVV está visível
**Quando** toco no botão "Copiar CVV"
**Então** o valor é copiado para o clipboard
**E** exibo `ZodiakNotice` de sucesso "CVV copiado — válido por X segundos"

### Cenário 4 — Cartão virtual bloqueado
**Dado** que o cartão está bloqueado
**Quando** acesso a tela Cartão Virtual
**Então** o CVV não é exibido
**E** exibo `ZodiakNotice` com `.error`: "O cartão está bloqueado. Desbloqueie em Controles para usar o CVV."

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** o CVV anuncia "CVV dinâmico: 4 5 2. Expira em 18 segundos."
**E** `ZodiakProgressIndicator` anuncia progresso como porcentagem
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push de `CMCardDetailScreen`
- **Saída**: ← back para CardDetail
- **Parâmetros recebidos**: `card: CMCard`

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| CVV atual | gerado via `String(format: "%03d", Int.random(in: 100...999))` | em memória |
| Countdown | `@State var secondsRemaining: Int = 30` + Timer | em memória |
| Status de bloqueio | `@AppStorage("cm.card_{id}.blocked")` | UserDefaults |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakProgressIndicator` | Countdown circular 30s |
| `ZodiakText` | CVV em destaque (`.ZodiakTextStyle.displayLarge`) |
| `ZodiakNotice` | Aviso de expiração próxima + cartão bloqueado |
| `ZodiakButton` | "Copiar CVV" |
| `ZodiakInfoRow` | Número do cartão mascarado e validade |
| `ZodiakStatusChip` | "Ativo" / "Bloqueado" |

### Estados da tela
- `active(cvv, secondsRemaining)` — CVV válido
- `blocked` — cartão bloqueado, CVV oculto
- `expiringSoon(cvv, secondsRemaining)` — menos de 5 segundos

---

## Boas práticas — iOS

- `Timer.publish(every: 1, on: .main, in: .common).autoconnect()` — cancelado em `.onDisappear`
- CVV gerado no ViewModel, não na View
- `UIPasteboard.general.string = cvv` executado no ViewModel para não expor na View

---

## Definition of Done

- [ ] Strings: `cm.virtual_card.title`, `cm.virtual_card.cvv_label`, `cm.virtual_card.action_copy`, `cm.virtual_card.copied_notice`, `cm.virtual_card.expiring_notice`, `cm.virtual_card.blocked_notice`
- [ ] Lógica do Timer documentada (intervalo, cancelamento, reset)
- [ ] Implementação pode começar sem ambiguidades
