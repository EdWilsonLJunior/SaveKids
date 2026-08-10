# Configurações de Segurança

> **Épico**: SafeVault
> **US-ID**: US-33.08
> **Tela nº**: 8 de 8
> **Prioridade**: P1
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Configurações avançadas de segurança do cofre: timeout de auto-lock e bloqueio de captura de tela. Acesso ao sub-fluxo de alteração de PIN/biometria via link para `SVProfileSecurityScreen`.

---

## História de usuário

Como **usuário**, quero **configurar o tempo de auto-lock e outras preferências de segurança**, para que **o cofre seja bloqueado automaticamente no intervalo que considero seguro**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Configurar auto-lock
**Dado** que estou nas Configurações de Segurança
**Quando** seleciono "5 minutos" no `ZodiakDropdown` auto-lock
**Então** `@AppStorage("sv.autolock_timeout") = 300` (segundos)
**E** exibo `ZodiakNotice` "Configuração salva"

### Cenário 2 — Bloqueio de captura de tela (mock)
**Dado** que aciono `ZodiakSwitch` "Bloquear capturas de tela"
**Então** `@AppStorage("sv.screenshot_protection") = true`
**E** exibo `ZodiakNotice` "Esta configuração é simulada nesta versão demo"

### Cenário 3 — Navegar para PIN e biometria
**Dado** que toco em "Alterar PIN e Biometria"
**Então** navego para `SVProfileSecurityScreen`

### Cenário 4 — Limpar todos os dados
**Dado** que toco em "Limpar cofre"
**Então** exibo `ZodiakModal` com `ZodiakWarningButton` "Confirmar limpeza"
**Quando** confirmo
**Então** todos os `SVVaultItem` são excluídos do SwiftData
**E** `@AppStorage("sv.pin")` é resetado
**E** retorno para `SVPinAuthScreen`

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** `ZodiakDropdown` anuncia opção selecionada de auto-lock
**E** `ZodiakSwitch` anuncia estado de cada toggle
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push de `SVHomeScreen` (ícone de configuração)
- **Saída**: → `SVProfileSecurityScreen` · ← back · popToRoot após "Limpar cofre"

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Timeout auto-lock | `@AppStorage("sv.autolock_timeout")` | UserDefaults |
| Proteção de tela | `@AppStorage("sv.screenshot_protection")` | UserDefaults |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakDropdown` | Timeout de auto-lock (Imediato, 1min, 5min, 15min, 30min) |
| `ZodiakSwitch` | Bloqueio de captura de tela |
| `ZodiakArrowButton` | "Alterar PIN e Biometria" |
| `ZodiakNotice` | Confirmações e avisos |
| `ZodiakModal` | Confirmação de limpeza |
| `ZodiakWarningButton` | "Confirmar limpeza" |
| `ZodiakEyebrow` | Seções: Auto-Lock / Privacidade / Dados |
| `ZodiakDivider` | Separação de seções |

---

## Definition of Done

- [ ] Strings: `sv.settings.section_autolock`, `sv.settings.dropdown_autolock`, `sv.settings.section_privacy`, `sv.settings.toggle_screenshot`, `sv.settings.notice_demo`, `sv.settings.action_change_pin`, `sv.settings.action_clear_vault`, `sv.settings.clear_title`, `sv.settings.clear_confirm`
- [ ] Opções de timeout documentadas com valores em segundos
- [ ] Implementação pode começar sem ambiguidades
