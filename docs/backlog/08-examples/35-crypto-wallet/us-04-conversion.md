# Conversor de Moedas

> **Épico**: Crypto Wallet Fake
> **US-ID**: US-35.04
> **Tela nº**: 4 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Conversor em tempo real entre criptomoedas e entre cripto/USD. Usa as cotações em memória do Dashboard. Sem persistência — cálculo ao vivo.

---

## História de usuário

Como **usuário**, quero **converter valores entre criptomoedas e dólar**, para que **entenda o poder de compra dos meus ativos**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Conversão básica cripto → USD (happy path)
**Dado** que seleciono Bitcoin e digito 0.5 BTC
**Quando** a conversão é calculada
**Então** exibo o valor em USD com base na cotação atual
**E** o resultado é atualizado em tempo real conforme digito

### Cenário 2 — Conversão USD → cripto
**Dado** que ativo o modo inverso (botão ↕)
**Então** o campo de entrada passa a receber USD
**E** o resultado exibe a quantidade da cripto selecionada

### Cenário 3 — Trocar moeda de origem
**Dado** que toco no seletor de moeda
**Então** exibo `ZodiakDropdown` com a lista das 10 moedas do mercado
**Quando** seleciono outra moeda
**Então** a conversão é recalculada imediatamente

### Cenário 4 — Cotação desatualizada
**Dado** que o Timer não disparou há mais de 30s
**Então** exibo `ZodiakNotice` "Cotação pode estar desatualizada" com ícone de aviso

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** os campos anunciam rótulo, valor digitado e unidade
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: barra de abas ou push do Dashboard
- **Saída**: ← back

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Cotações | In-memory (compartilhadas via EnvironmentObject/ViewModel) | Nenhuma |
| Entrada do usuário | `@State` local | Nenhuma |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakLabelledNumericField` | Campo de valor de entrada |
| `ZodiakDropdown` | Seletor de moeda de origem |
| `ZodiakKeyFigures` | Resultado da conversão em destaque |
| `ZodiakSecondaryButton` | Botão ↕ para inverter direção |
| `ZodiakNotice` | Aviso de cotação desatualizada |
| `ZodiakEyebrow` | "Taxa atual" |
| `ZodiakInfoRow` | Detalhe da taxa de conversão usada |

---

## Definition of Done

- [ ] Strings: `cw.conversion.title`, `cw.conversion.field_amount`, `cw.conversion.result_label`, `cw.conversion.action_swap`, `cw.conversion.notice_stale`, `cw.conversion.rate_label`
- [ ] Lógica de cálculo (cripto→USD: `amount * price` | USD→cripto: `amount / price`)
- [ ] Critério de "cotação desatualizada" (>30s) definido
- [ ] Implementação pode começar sem ambiguidades
