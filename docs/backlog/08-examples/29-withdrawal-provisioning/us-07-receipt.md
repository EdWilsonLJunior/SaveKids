# Comprovante

> **Épico**: Provisionamento de Saque
> **US-ID**: US-29.07
> **Tela nº**: 7 de 8
> **Prioridade**: P1
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Tela final do fluxo de reserva. Exibe o comprovante com número de protocolo, dados da operação e data/hora. Permite compartilhar o comprovante via `ZodiakShare` (sheet nativo de compartilhamento com texto formatado) e retornar ao Dashboard para uma nova operação.

---

## História de usuário

Como **correntista**, quero **visualizar e compartilhar o comprovante da minha reserva**, para que **eu tenha um registro da operação e possa apresentá-lo na unidade bancária**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Fluxo principal (happy path)
**Dado** que completei a confirmação com sucesso
**Quando** a tela Comprovante é exibida
**Então** exibo número de protocolo (mock: 8 caracteres alfanuméricos em uppercase)
**E** exibo resumo: valor reservado, unidade escolhida, data e hora da reserva, data estimada de saque
**E** exibo botão "Compartilhar" e botão "Voltar ao Início"

### Cenário 2 — Compartilhamento
**Dado** que estou na tela Comprovante
**Quando** toco em "Compartilhar"
**Então** `ZodiakShare` exibe a sheet nativa de compartilhamento do iOS
**E** o texto compartilhado contém: número de protocolo, valor, unidade e data no formato legível

### Cenário 3 — Retorno ao Dashboard
**Dado** que toco em "Voltar ao Início"
**Então** o `NavigationStack` faz `popToRoot` retornando ao Dashboard
**E** o `WPReserveViewModel` é resetado (amount = 0, selectedUnit = nil)

### Cenário 4 — Reload / reentrada
**Dado** que o usuário volta para esta tela via back (não esperado, mas possível)
**Então** o comprovante permanece visível com os dados da última reserva
**E** o protocolo não é gerado novamente (usa o valor já armazenado no ViewModel)

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** o número de protocolo é anunciado caractere por caractere ou como string completa com `accessibilityLabel` "Protocolo: ABC12345"
**E** os botões possuem `accessibilityLabel` descritivo
**E** em dark mode, todos os tokens respondem ao `colorScheme`
**E** o ícone de sucesso usa cor do token `Zodiak.colors.success` (sem hardcode)

---

## Spec de tela

### Navegação
- **Entrada**: push a partir de `WPConfirmationScreen` (após confirmação bem-sucedida)
- **Saída**: `popToRoot` → `WPDashboardScreen` (via "Voltar ao Início")
- **Parâmetros recebidos**: `WPReservation` completo via `WPReserveViewModel`

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Número de protocolo | `WPReserveViewModel.lastProtocol` | em memória (sessão) |
| Dados da reserva | `WPReserveViewModel.lastReservation` | em memória |
| Data/hora de emissão | `Date.now` formatada no ViewModel | em memória |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakInfoRow` | Linha por dado do comprovante (protocolo, valor, unidade, datas) |
| `ZodiakEyebrow` | Rótulo "Comprovante de Reserva" |
| `ZodiakText` | Número de protocolo em destaque (`ZodiakTextStyle.headline`) |
| `ZodiakSuccessBadge` | Ícone/indicador de sucesso no topo |
| `ZodiakShare` | Ação de compartilhamento via sheet nativa |
| `ZodiakButton` | "Compartilhar" (primário) |
| `ZodiakSecondaryButton` | "Voltar ao Início" |
| `ZodiakDivider` | Separação entre dados do comprovante |

### Estados da tela
- `success` — único estado possível (só alcançável após confirmação bem-sucedida)

### Validações
- Não há validações nesta tela — é puramente de apresentação

---

## Boas práticas — iOS

- `popToRoot` pode ser implementado com `@EnvironmentObject` de `NavigationPath` ou via `dismiss()` encadeado
- O texto para `ZodiakShare` é montado no `WPReceiptViewModel` como `String` formatada (não na View)
- Protocolo é gerado uma única vez no `WPConfirmationViewModel.confirmReservation()` e não é regerado

---

## Referências

- [finalBacklog.md — Projeto 1](../../raw_pdf/finalBacklog.md)
- [US-29.06 — Confirmação](us-06-confirmation.md) — tela anterior
- [US-29.08 — Histórico de Reservas](us-08-reservation-history.md) — destino alternativo do Dashboard

---

## Gaps e dúvidas

- Formato exato do comprovante para compartilhamento (texto plano ou rich text)?
- `ZodiakSuccessBadge` existe como componente autônomo ou é parte de outro organismo?

---

## Definition of Done

- [ ] História revisada pelo time
- [ ] Critérios de aceite aprovados
- [ ] Componentes DS mapeados
- [ ] Strings: `wp.receipt.title`, `wp.receipt.eyebrow`, `wp.receipt.protocol_label`, `wp.receipt.field_amount`, `wp.receipt.field_unit`, `wp.receipt.field_reservation_date`, `wp.receipt.field_withdrawal_date`, `wp.receipt.action_share`, `wp.receipt.action_home`, `wp.receipt.share_text`
- [ ] Formato do texto de compartilhamento definido
- [ ] Implementação pode começar sem ambiguidades
