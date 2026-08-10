# Resumo Mensal

> **Épico**: PayFlow
> **US-ID**: US-36.06
> **Tela nº**: 6 de 8
> **Prioridade**: P0
> **Plataforma**: iOS (SwiftUI)
> **Status**: Backlog

---

## Contexto

Relatório visual do gasto mensal com `PFBarChart` (Canvas, 6 meses) e breakdown por categoria via `ZodiakProgressIndicator`. Exportável via `ShareLink` como texto formatado.

---

## História de usuário

Como **usuário**, quero **ver um resumo visual dos meus gastos mensais**, para que **entenda minha evolução financeira e identifique tendências**.

---

## Critérios de aceite (Gherkin)

### Cenário 1 — Resumo com dados (happy path)
**Dado** que tenho pagamentos dos últimos 6 meses
**Quando** acesso a tela Resumo
**Então** exibo `PFBarChart` com 6 barras (um bar por mês)
**E** a barra do mês atual está destacada com cor primária
**E** exibo `ZodiakKeyFigures` com total do mês atual

### Cenário 2 — Breakdown por categoria
**Dado** que vejo o resumo
**Então** exibo lista de categorias com `ZodiakProgressIndicator` horizontal mostrando proporção do gasto
**E** cada item exibe: ícone, nome, valor e porcentagem

### Cenário 3 — Exportar relatório
**Dado** que toco em "Exportar"
**Então** exibo `ShareLink` com texto formatado do relatório
```
PayFlow — Resumo de [Mês/Ano]
Total: R$ X.XXX,XX
[Categoria]: R$ XXX,XX (XX%)
...
```

### Cenário 4 — Dados insuficientes
**Dado** que tenho menos de 2 meses de dados
**Então** exibo `ZodiakNotice` "Continue registrando pagamentos para ver tendências"
**E** o `PFBarChart` exibe as barras disponíveis (mesmo que seja 1)

### Cenário 5 — Acessibilidade e tema
**Dado** VoiceOver ativo
**Então** `PFBarChart` tem `accessibilityLabel` descrevendo o mês mais caro e mais barato
**E** em dark mode, todos os tokens respondem ao `colorScheme`

---

## Spec de tela

### Navegação
- **Entrada**: push da tela de Assinaturas
- **Saída**: ← back

### Dados e persistência
| Dado | Fonte | Persistência |
|---|---|---|
| Pagamentos dos últimos 6 meses | `@Query` filtrado por `paidAt >= Date.now - 6.months` | SwiftData |
| Categorias | `@Query var categories: [PFCategory]` | SwiftData |

### Componentes DS utilizados
| Componente | Uso |
|---|---|
| `ZodiakKeyFigures` | Total do mês atual |
| `ZodiakProgressIndicator` | Barra de proporção por categoria |
| `ZodiakNotice` | Dados insuficientes |
| `ZodiakSecondaryButton` | "Exportar" |
| `ZodiakEyebrow` | "Por categoria" / "Últimos 6 meses" |

### Componentes Customizados (a criar)
| Componente | Descrição |
|---|---|
| `PFBarChart` | 6 barras verticais via `Canvas` SwiftUI; barra ativa destacada; labels de mês abaixo |

---

## Definition of Done

- [ ] Strings: `pf.summary.title`, `pf.summary.eyebrow_chart`, `pf.summary.eyebrow_categories`, `pf.summary.action_export`, `pf.summary.notice_insufficient`, `pf.summary.export_template`
- [ ] `PFBarChart` especificado (dimensões, cores, espaçamento entre barras)
- [ ] Formato do texto de exportação documentado
- [ ] Implementação pode começar sem ambiguidades
