# Gaps & Dúvidas — Zodiak Design System

Consolidação dos gaps, inconsistências e dúvidas levantados durante a (re)implementação do DS. Esta lista é alimentada por cada história do backlog (seção `Gaps & dúvidas para o time de Design`) e deve ser revisada periodicamente com o time de UI/UX.

> Para cada item, registrar: **componente**, **descrição**, **referência** (Swift + Supernova), **impacto** (P0/P1/P2), **proposta** (se houver) e **status** (Aberto / Em discussão / Resolvido).

---

## Tipos de gap

1. **Inconsistência Swift ↔ Supernova** — o fonte iOS diverge da spec oficial.
2. **Estado/variante faltando** — falta documentação para algum estado (loading, error, focus, pressed) ou superfície.
3. **Token faltando** — valor presente nos componentes que não tem token correspondente.
4. **A11y** — contraste insuficiente, hit-target abaixo do mínimo, falta de papel/label.
5. **Dark mode** — variante dark ausente ou incompleta.
6. **Plataforma** — comportamento não especificado para iPad/landscape/window-size class Medium+.
7. **Decisão pendente** — opção de design não tomada.

---

## Itens

> Preencher conforme as histórias forem sendo escritas e implementadas. Formato sugerido:

```
### G-001 — <Componente> — <Resumo curto>
- **Tipo**: <inconsistência | estado | token | a11y | dark | plataforma | decisão>
- **Impacto**: P0 | P1 | P2
- **Descrição**: ...
- **Referência iOS**: `ZodiakiOS/.../Zodiak<X>.swift` (linhas ...)
- **Referência Supernova**: `Specs - <X>.md` (seção ...)
- **Proposta**: ...
- **Status**: Aberto
```

---

## Lista

> Itens consolidados a partir das seções "Gaps & dúvidas" de cada história. Após implementação, cada gap deve ser fechado (status: Resolvido) ou virar issue formal no backlog técnico.

### G-001 — Tokens — Mapeamento Primitives → Semantic
- **Tipo**: token
- **Impacto**: P0
- **Descrição**: `ZodiakPrimitives.swift` define a paleta raw, mas a documentação Supernova só cobre tokens semânticos. Falta tabela oficial primitive → semantic (light + dark).
- **Referência iOS**: `Tokens/ZodiakPrimitives.swift`, `Tokens/ZodiakColors.swift`
- **ELI5**: A paleta de cores é como tinta numa caixa — você tem `blue.500`, `blue.700` etc. (primitivos). Mas a tela de erro usa "a cor de erro", não "blue-700" diretamente. Sem o dicionário que traduz "cor de erro → blue-700", cada dev faz essa escolha na intuição e o resultado é inconsistente entre telas.
- **Status**: Aberto

### G-002 — Cores — Variantes onLite/onHeavy/onPhoto
- **Tipo**: estado/superfície
- **Impacto**: P0
- **Descrição**: Componentes possuem variantes para 3 superfícies, mas Supernova só documenta default. Falta spec de contraste/cor para `onHeavy` e `onPhoto` por componente.
- **ELI5**: Um botão branco sobre fundo branco é invisível. As três superfícies (lite, heavy, photo) são como cenários de iluminação — o mesmo componente precisa se adaptar a cada um sem desaparecer ou ter contraste ruim. Sem a spec de cada cenário, o dev inventa e o resultado pode ser ilegível.
- **Status**: Aberto

### G-003 — Tipografia — Mapeamento DocC → Material Type Scale
- **Tipo**: plataforma
- **Impacto**: P0
- **Descrição**: Mapeamento explícito iOS `displayLarge/headlineMedium/...` → Compose `Typography.displayLarge/...` precisa de validação visual + tracking/line-height.
- **ELI5**: iOS e Android falam línguas diferentes de tipografia. Converter um estilo entre plataformas sem validação visual é como traduzir um poema — pode estar "certo" na teoria e errado na prática (tamanhos, espaçamento de linhas, tracking diferentes).
- **Status**: Aberto

### G-004 — Spacing — Token base 4 vs 8
- **Tipo**: token
- **Impacto**: P1
- **Descrição**: `ZodiakSpacing.swift` usa escala em 4pt; Material padrão usa 8dp. Confirmar se base 4 é correta para Android ou se mapear para 8dp.
- **ELI5**: iOS usa régua de 4pt, Android convencionalmente usa 8dp. Se não confirmarmos qual usar no Android, os espaçamentos nunca batem visualmente entre plataformas — sempre "quase certo" mas nunca idêntico.
- **Status**: Aberto

### G-005 — Shadows — Equivalência iOS shadow ↔ Compose elevation
- **Tipo**: plataforma
- **Impacto**: P1
- **Descrição**: Tokens iOS de sombra (offset/radius/opacity) não mapeiam 1:1 para `dp elevation` do Compose (que usa tonal + shadow). Definir tabela oficial.
- **ELI5**: Sombra no iOS é como desenhar uma sombra com lápis — você define cor, raio e offset. No Android, a sombra vem de "elevation" — uma altura abstrata que o sistema converte sozinho. Converter "offset 4, raio 8" para "elevation 2dp" sem uma tabela é puro chute.
- **Status**: Aberto

### G-006 — Radii — Token de pill (capsule)
- **Tipo**: token
- **Impacto**: P2
- **Descrição**: Componentes pill (chips, badges) usam `999` mas falta token nomeado (`radius.full`).
- **ELI5**: Escrever `999` como cornerRadius em 20 lugares é como escrever `3.14159` em vez de `π` em 20 equações. Um token `radius.full` tem nome, documenta a intenção ("arredondar completamente") e, se o valor mudar, basta mudar em um lugar.
- **Status**: Aberto

### G-007 — Grid — Spec oficial de colunas/gutters
- **Tipo**: decisão
- **Impacto**: P0
- **Descrição**: Falta documentação oficial de colunas (4/8/12) e gutters por breakpoint compact/medium/expanded.
- **ELI5**: Um grid sem spec é como construir prédios sem planta — cada dev estima a distância das paredes à sua maneira. Com a spec de colunas e calhas definida, todas as telas compartilham o mesmo "esqueleto" invisível e os alinhamentos batem.
- **Status**: Aberto

### G-008 — Icons — Versões filled vs outlined
- **Tipo**: estado
- **Impacto**: P1
- **Descrição**: Catálogo `ZodiakIcons.swift` mistura filled/outlined; precisa convenção (default outlined, filled para estado ativo?).
- **ELI5**: Ícone preenchido vs contorno funciona como semáforo: precisa ser consistente. Se em Tabs o ativo é preenchido mas em Bottom Bar o ativo é contorno, o usuário não sabe mais o que "selecionado" parece — os dois padrões se contradizem.
- **Status**: Aberto

### G-009 — Logo — Variantes oficiais (color/mono/inverse)
- **Tipo**: decisão
- **Impacto**: P1
- **ELI5**: O logo pode ser colorido, preto/branco (mono) ou invertido para fundos escuros. Usar o logo colorido original sobre foto escura pode fazê-lo desaparecer ou criar contraste insuficiente. Sem as variantes oficiais, cada uso é um improviso visual.
- **Status**: Aberto

### G-010 — Flags — Cobertura de países
- **Tipo**: decisão
- **Impacto**: P2
- **Descrição**: Lista de flags suportadas (ISO 3166) precisa ser confirmada para Phase 1 (PT-BR/EN, expansão internacional).
- **ELI5**: Flags de países têm muitas variações regionais e raridades. Definir o subset suportado antes de construir o componente evita carregar 200 SVGs quando o app só precisa de 20. É como só comprar os ingredientes do cardápio desta semana.
- **Status**: Aberto

---

### G-011 — Button Regular — Estados loading/success/error
- **Tipo**: estado
- **Impacto**: P0
- **Descrição**: Spec de animação loading (spinner inline), success (checkmark) e error (shake/icon) não documentada.
- **ELI5**: Um botão de "Pagar" que fica igual depois de clicado deixa o usuário sem saber se funcionou. Estados loading (spinner), success (✓) e error (shake/ícone) são a linguagem que o botão usa para contar o que está acontecendo — sem eles, o usuário clica de novo achando que falhou.
- **Status**: Aberto

### G-012 — Button Icon — Hit-target em densities pequenas
- **Tipo**: a11y
- **Impacto**: P0
- **Descrição**: Variantes `small` precisam validar 44pt/48dp via padding extra.
- **ELI5**: A ponta do dedo humano tem ~44pt de área de contato. Se um ícone é 20pt sem padding extra, o usuário erra o toque com frequência. Apple e WCAG exigem área mínima de 44pt — é o equivalente a fazer a tecla grande o suficiente para o dedão mais largo.
- **Status**: Aberto

### G-013 — Button Warning — Tokens de cor por nível
- **Tipo**: token
- **Impacto**: P1
- **ELI5**: O botão de aviso usa amarelo, mas qual amarelo exatamente em fundo claro? E em dark mode? E sobre foto? Sem tokens por superfície, o "amarelo de aviso" pode ter contraste insuficiente em algum dos três cenários — e ninguém percebe até uma auditoria de acessibilidade.
- **Status**: Aberto

### G-014 — Tabs — Comportamento scroll horizontal
- **Tipo**: plataforma
- **Impacto**: P1
- **Descrição**: Quando muitas tabs, comportamento (scrollable vs collapsable) precisa ser definido para mobile + tablet.
- **ELI5**: Com 3 tabs cabe tudo. Com 8 tabs em tela de 375pt, ou ficam minúsculas (impossível ler) ou somem. A decisão é: rola horizontalmente ou colapsa num menu? Sem spec, cada tela com muitas tabs resolve do seu próprio jeito.
- **Status**: Aberto

### G-015 — TextField — Estados focus/error/disabled com helper text
- **Tipo**: estado
- **Impacto**: P0
- **ELI5**: Um campo de texto conta uma história: neutro → com foco (borda azul) → com erro (borda vermelha + mensagem embaixo) → desabilitado (cinza). Sem a spec completa desses estados, o dev implementa só o estado normal — e o usuário não recebe feedback visual quando erra o preenchimento.
- **Status**: Aberto

### G-016 — Tooltip — Trigger touch (não há hover em mobile)
- **Tipo**: plataforma
- **Impacto**: P1
- **Descrição**: Spec original assume hover; em mobile, definir gatilho (long-press? info-icon tap?).
- **ELI5**: Tooltip no desktop aparece ao passar o mouse — simples. No celular não existe "passar o mouse". Precisamos decidir o trigger (long-press? tap em ícone ⓘ?) antes de implementar, porque cada abordagem tem implicações de descoberta e UX diferentes.
- **Status**: Aberto

### G-017 — Rating — Half-star e meia-precisão
- **Tipo**: decisão
- **Impacto**: P2
- **ELI5**: Dado um rating de 3,5 estrelas: mostro meia estrela preenchida? Arredondo para 3? Para 4? Sem spec, uma tela mostra 3 estrelas e outra mostra 4 para o mesmo produto — o usuário vê dados inconsistentes dependendo de onde navega.
- **Status**: Aberto

### G-018 — Slider Counter — Step e min/max defaults
- **Tipo**: decisão
- **Impacto**: P2
- **ELI5**: Um counter sem defaults vai de −∞ a +∞ em steps de 1 — o que raramente faz sentido. Definir `min=0, max=99, step=1` como padrão evita que o usuário incremente um contador de "número de filhos" para valores absurdos, e dá ao dev um ponto de partida seguro.
- **Status**: Aberto

### G-019 — Avatar — Tamanhos oficiais e badge composto
- **Tipo**: token
- **Impacto**: P1
- **ELI5**: Avatar de 24pt ao lado de um nome vs 64pt no header de perfil são contextos completamente diferentes. Sem tamanhos nomeados (small/medium/large), cada tela usa um número arbitrário — e o mesmo "avatar médio" tem 40pt numa tela e 44pt em outra.
- **Status**: Aberto

### G-020 — Progress Indicator — Variante determinate vs indeterminate
- **Tipo**: estado
- **Impacto**: P1
- **ELI5**: Barra que vai de 0% a 100% (determinate) vs barra que gira para sempre (indeterminate) passam mensagens opostas: "sei exatamente quanto falta" vs "não sei quando termina". Usar o errado faz o usuário subestimar ou superestimar a espera.
- **Status**: Aberto

---

### G-021 — Notice — Variantes Info/Success/Error tokens
- **Tipo**: token
- **Impacto**: P0
- **Descrição**: 3 APIs distintas implementadas; tokens de background/border/icon por variante precisam de spec oficial.
- **ELI5**: Sucesso é verde, erro é vermelho, info é azul — mas qual verde exatamente? Com qual opacidade de fundo? Qual cor de borda? Sem tokens oficiais por variante, cada Notice implementado tem um tom de verde diferente, e o usuário percebe que o app parece "feito em partes".
- **Status**: Aberto

### G-022 — Alert — Modal vs inline + ações destructive
- **Tipo**: decisão
- **Impacto**: P0
- **ELI5**: Alert como popup bloqueia tudo (ação urgente, difícil de ignorar). Alert inline não bloqueia (informativo, pode ser ignorado). Usar popup para algo trivial é irritante; usar inline para "você vai deletar sua conta" passa despercebido. A decisão precisa vir do Design, não do dev na hora.
- **Status**: Aberto

### G-023 — Combobox — Async loading + paginação
- **Tipo**: estado
- **Impacto**: P1
- **ELI5**: Combobox com 10 opções fixas é simples. Com 10.000 usuários buscáveis por API, precisa debounce, estado de loading, tratamento de erro de rede e paginação ao rolar. Sem spec desses estados, o componente trava, mostra dados incompletos ou dispara uma chamada de API por tecla digitada.
- **Status**: Aberto

### G-024 — Phone Input — Validação por país
- **Tipo**: plataforma
- **Impacto**: P1
- **ELI5**: Número brasileiro (+55) tem 11 dígitos. Americano (+1) tem 10. Francês local tem 9. Sem validação por país, o campo aceita qualquer quantidade de dígitos sem reclamar — e o erro só aparece no servidor, tarde demais para o usuário entender o que errou.
- **Status**: Aberto

### G-025 — Step Indicator — Step error/skipped
- **Tipo**: estado
- **Impacto**: P1
- **ELI5**: Num wizard de 5 passos: e se o passo 2 falhou? E se o passo 3 era opcional e o usuário pulou? Sem estados de erro/skipped no indicador, tudo parece verde mesmo quando há problemas — o usuário acha que completou o fluxo quando na verdade não completou.
- **Status**: Aberto

### G-026 — Accordion — Single-expand vs multi-expand
- **Tipo**: decisão
- **Impacto**: P2
- **ELI5**: Em accordion single-expand, abrir o item B fecha o item A automaticamente — força foco e simplifica a tela. No multi-expand, vários ficam abertos ao mesmo tempo — útil para comparação. A escolha muda fundamentalmente a UX e não pode ser deixada para cada dev decidir por instinto.
- **Status**: Aberto

### G-027 — Slide to Submit — Threshold de gesto
- **Tipo**: decisão
- **Impacto**: P2
- **ELI5**: Arrastar 10% do caminho e soltar — confirma? 80% e soltar — confirma? Threshold muito baixo = confirmações acidentais (frustrante). Muito alto = o usuário chega perto e nada acontece (também frustrante). Precisa de número definido pelo Design antes de implementar.
- **Status**: Aberto

### G-028 — Quick Access Bar — Layout em tablet (landscape)
- **Tipo**: plataforma
- **Impacto**: P1
- **ELI5**: No celular em portrait, a barra fica embaixo do polegar — perfeito. No iPad em landscape, "embaixo" é longe do centro de ação e sobra muito espaço lateral. Fica no fundo mesmo? Vira sidebar vertical? Sem spec por dispositivo, o componente parece deslocado em metade dos contextos de uso.
- **Status**: Aberto

### G-029 — Input Wizard — Persistência entre passos
- **Tipo**: decisão
- **Impacto**: P1
- **Descrição**: Spec não trata "back preserva valores" vs "reset".
- **ELI5**: Você está no passo 4 de um formulário, volta ao passo 2 para corrigir algo e avança de novo. O passo 3 ainda tem os dados? Sem regra explícita, metade das implementações mantém e metade limpa — e o usuário preenche tudo de novo sem entender por quê.
- **Status**: Aberto

### G-030 — Switch — On/Off labels + Haptic
- **Tipo**: a11y
- **Impacto**: P1
- **ELI5**: Um toggle deveria dar um "clique" háptico ao mudar de estado (feedback tátil confirma a ação) e ter label "On"/"Off" para o VoiceOver anunciar corretamente o estado atual. O dev que desconhece as convenções iOS omite os dois — e a experiência fica silenciosa e inacessível.
- **Status**: Aberto

---

### G-031 — Banner — Auto-dismiss vs persistent
- **Tipo**: decisão
- **Impacto**: P1
- **ELI5**: Banner de "Upload completo" some sozinho em 3s — ótimo. Banner de "Atenção: seu plano expira amanhã" some em 3s — o usuário provavelmente não viu. A regra de auto-dismiss deve vir da severidade da mensagem, não do componente decidindo sozinho para tudo.
- **Status**: Aberto

### G-032 — Toast — Pilha (queue) e prioridade
- **Tipo**: decisão
- **Impacto**: P1
- **ELI5**: Dois toasts chegam ao mesmo tempo: "Foto salva" e "Falha na rede". Qual aparece? Os dois empilham? O de erro tem prioridade? Sem política de fila, o segundo toast silenciosamente sobrescreve o primeiro — e notificações críticas somem sem o usuário ver.
- **Status**: Aberto

### G-033 — Modal — Sheet (bottom) vs Dialog (centered) por breakpoint
- **Tipo**: plataforma
- **Impacto**: P0
- **ELI5**: Bottom sheet (sobe do rodapé) é ergonômico no celular — o polegar alcança facilmente. Dialog centralizado no meio da tela é mais natural em tablets grandes onde "embaixo" fica longe dos olhos. Sem breakpoint definido, o mesmo modal parece estranho em metade dos dispositivos.
- **Status**: Aberto

### G-034 — Hero — Parallax / Collapse on scroll
- **Tipo**: decisão
- **Impacto**: P1
- **ELI5**: Um hero que colapsa lentamente ao rolar (parallax) dá sensação de profundidade e elegância. Um que simplesmente some ao rolar parece mais ágil mas menos sofisticado. Sem spec, cada tela com hero tem uma personalidade de scroll diferente — o app parece descosturado.
- **Status**: Aberto

### G-035 — Pin — Autosubmit ao completar dígitos
- **Tipo**: decisão
- **Impacto**: P1
- **ELI5**: Ao digitar o 6º dígito do PIN: submete na hora ou o usuário precisa clicar "Confirmar"? Auto-submit é mais rápido mas arrisca envio acidental se o usuário percebe que errou um dígito tarde demais. Sem spec, metade das telas de PIN auto-submetem e metade não — o usuário nunca sabe o que esperar.
- **Status**: Aberto

### G-036 — Login Form — Biometria (FaceID/Fingerprint)
- **Tipo**: plataforma
- **Impacto**: P1
- **ELI5**: FaceID ao abrir a tela (automático) é mais rápido mas pode assustar — a câmera ativa sem aviso visual explícito. Iniciar ao clicar num botão é mais explícito mas adiciona um passo. Sem spec, cada tela de login decide sozinha e o comportamento de autenticação fica inconsistente no app.
- **Status**: Aberto

### G-037 — Share — Native share sheet vs custom
- **Tipo**: plataforma
- **Impacto**: P1
- **Descrição**: Share organism usa custom UI; native (`UIActivityViewController`/`Intent.ACTION_SEND`) seria mais idiomático — confirmar com Design.
- **ELI5**: Share nativo (iOS share sheet) integra automaticamente com todos os apps instalados (WhatsApp, Mail, AirDrop) — de graça. Share customizado tem visual bonito mas precisa de integrações manuais para cada destino. Decidir antes de construir evita meses de retrabalho.
- **Status**: Aberto

### G-038 — Notification Banner — 3 APIs (Info/Positive/Negative) — auto-dismiss timing
- **Tipo**: decisão
- **Impacto**: P1
- **ELI5**: Banner de erro some em 3s, 5s, ou fica até o usuário fechar? Muito rápido e a mensagem não foi lida. Muito lento e atrapalha a navegação. Sem timing definido, cada banner tem sua própria contagem regressiva — e os de erro crítico podem sumir antes do usuário entender o que aconteceu.
- **Status**: Aberto

### G-039 — Empty State — Ilustrações oficiais
- **Tipo**: decisão
- **Impacto**: P2
- **ELI5**: Tela vazia sem ilustração parece bug. Com a ilustração e texto certos, vira oportunidade ("Nenhuma notificação — você está em dia!"). Sem ilustrações oficiais do DS, cada dev improvisa um empty state diferente — uns usam emoji, outros placeholder cinza, outros deixam em branco.
- **Status**: Aberto

### G-040 — Show More — Threshold de truncate (caracteres vs linhas)
- **Tipo**: decisão
- **Impacto**: P2
- **ELI5**: Truncar em 2 linhas pode cortar no meio de uma ideia. Truncar em 200 caracteres pode resultar em 2 ou 10 linhas dependendo da fonte e da largura da tela. Sem uma regra clara, o mesmo componente mostra mais texto em algumas telas e menos em outras — parece que são componentes diferentes.
- **Status**: Aberto

### G-041 — Skeleton Loader — Shimmer animation timing
- **Tipo**: decisão
- **Impacto**: P2
- **ELI5**: Shimmer muito rápido parece ansioso. Muito lento parece que o app travou. O timing certo comunica "estou carregando, aguarde" de forma tranquila. Sem token de duração, cada skeleton tem sua própria velocidade de brilho — uns parecem urgentes e outros parecem mortos.
- **Status**: Aberto

### G-042 — Card Grid — Spans e responsividade
- **Tipo**: plataforma
- **Impacto**: P1
- **ELI5**: Grid de cards em celular: 1 coluna. Em tablet portrait: 2 colunas. Em tablet landscape: 3 colunas? Sem breakpoints e spans definidos, o grid transborda ou deixa espaço em branco estranho em telas grandes — parece que o app não foi pensado para iPad.
- **Status**: Aberto

### G-043 — Card Variants — Token de aspect-ratio por variante
- **Tipo**: token
- **Impacto**: P1
- **ELI5**: Card de notícia usa foto 16:9. Card de perfil usa 1:1. Hardcodar `.frame(height: 200)` em vez de um aspect ratio faz o card aparecer distorcido em telas de densidades diferentes — a imagem vai parecer esticada num iPhone grande e comprimida num pequeno.
- **Status**: Aberto

### G-044 — Media Blocks — Player (in-app vs system)
- **Tipo**: plataforma
- **Impacto**: P1
- **ELI5**: Player nativo (`AVPlayerViewController`) suporta Picture-in-Picture, AirPlay e controles de acessibilidade de graça. Player customizado dá controle visual total mas exige implementar tudo isso manualmente. Decidir antes de construir evita jogar fora semanas de trabalho.
- **Status**: Aberto

### G-045 — Image Compositions — Carousel autoplay + a11y pause
- **Tipo**: a11y
- **Impacto**: P0
- **ELI5**: Carrossel que avança sozinho a cada 3s é um pesadelo para VoiceOver: o foco muda enquanto o usuário ainda está lendo o item anterior. WCAG 2.1 SC 2.2.2 exige que animações automáticas possam ser pausadas. Sem o botão de pausa, o app falha em qualquer auditoria formal de acessibilidade.
- **Status**: Aberto

### G-046 — Typographic Block — Quote attribution layout
- **Tipo**: decisão
- **Impacto**: P2
- **ELI5**: Citação com autor: o nome fica embaixo? À direita? Com avatar ao lado? Cada layout conta uma história visual diferente. Sem spec, blocos tipográficos com citações parecem montados de improviso — cada tela coloca o nome do autor num lugar diferente.
- **Status**: Aberto

### G-047 — Action Compositions — Share Story aspect ratio (Instagram 9:16)
- **Tipo**: decisão
- **Impacto**: P2
- **ELI5**: Instagram Stories exige proporção 9:16. A tela do app é 16:9. Compartilhar diretamente corta metade do conteúdo. Sem spec de como exportar (crop? letterbox? canvas 9:16?), a função de "compartilhar no story" produz resultados imprevisíveis — o usuário vê o conteúdo cortado no Stories.
- **Status**: Aberto

### G-048 — Listings — Empty/Loading/Error states unificados
- **Tipo**: estado
- **Impacto**: P0
- **ELI5**: Uma lista pode estar em 4 estados: com dados, carregando (skeleton), vazia ou com erro. Sem os quatro especificados, o dev implementa só "com dados" — e quando a API falha ou retorna vazio, o usuário vê uma tela em branco sem explicação ou opção de retry.
- **Status**: Aberto

### G-049 — Form Container — Validação inline vs on-submit
- **Tipo**: decisão
- **Impacto**: P1
- **ELI5**: Erro inline (aparece enquanto digita) é imediato mas pode ser irritante num campo de CPF ainda incompleto. On-submit mostra todos os erros de uma vez ao final. Sem regra, campos do mesmo formulário têm comportamentos diferentes — uns reclamam durante a digitação, outros só ao enviar.
- **Status**: Aberto

### G-050 — Form in Drawer — Bottom sheet height (peek/medium/full)
- **Tipo**: plataforma
- **Impacto**: P1
- **ELI5**: Bottom sheet em três alturas: peek (só o handle aparece), medium (meia tela) e full (tela inteira). Cada uma serve um contexto diferente — peek para confirmação rápida, full para formulários longos. Sem definição por contexto, sheets abrem em alturas aleatórias que não combinam com o conteúdo.
- **Status**: Aberto

---

### G-051 — Layout Grid — Spec de colunas/gutters oficial
- **Tipo**: decisão
- **Impacto**: P0
- **ELI5**: (mesma raiz que G-007) Colunas e calhas do grid ainda não têm spec oficial. Sem isso, cada implementação de grid é um improviso — e telas diferentes têm margens e espaçamentos incompatíveis entre si.
- **Status**: Aberto (mesma raiz que G-007)

### G-052 — Adaptive Template — Padrões oficiais (list-detail, supporting-pane)
- **Tipo**: decisão
- **Impacto**: P0
- **ELI5**: iPad e Mac têm tela grande o suficiente para mostrar lista + detalhe simultaneamente (list-detail). Sem patterns definidos, cada tela com suporte a iPad reinventa a roda — algumas empurram tudo numa coluna estreita, outras quebram o layout completamente.
- **Status**: Aberto

### G-053 — Activity Template — Collapse cover (parallax vs fade)
- **Tipo**: decisão
- **Impacto**: P1
- **ELI5**: A capa de uma atividade que colapsa ao scroll é o primeiro elemento visual que o usuário vê. Se colapsa com parallax (lento e elegante), passa uma sensação de profundidade. Se simplesmente some com fade, passa leveza. Sem spec, cada tela de atividade tem personalidade visual diferente.
- **Status**: Aberto

### G-054 — Viewport — Política edge-to-edge default
- **Tipo**: plataforma
- **Impacto**: P1
- **ELI5**: Edge-to-edge significa que o conteúdo vai até embaixo da câmera e da home indicator. Se algumas telas vão até a borda e outras não, a transição entre elas parece inconsistente — como passar de um app para outro dentro do mesmo app.
- **Status**: Aberto

### G-055 — Font Modifier — Auto-heading semantics para estilos headline*
- **Tipo**: a11y
- **Impacto**: P1
- **ELI5**: Se o estilo se chama `headline1`, semanticamente faz sentido que o VoiceOver anuncie "título" ao lê-lo. Sem auto-heading no modificador de fonte, o dev precisa lembrar de adicionar `.accessibilityAddTraits(.isHeader)` manualmente em cada `Text` — e frequentemente esquece.
- **Status**: Aberto

### G-056 — Global Scroll Input — Defaults oficiais (dismiss-on-scroll, indicators)
- **Tipo**: decisão
- **Impacto**: P2
- **ELI5**: Teclado some ao rolar? Indicadores de scroll visíveis ou ocultos? São defaults silenciosos que, sem definição, ficam diferentes em cada tela — o usuário aprende o comportamento de uma tela e fica surpreso quando outra age diferente.
- **Status**: Aberto

### G-057 — Aspect Ratios — Token foundation ausente
- **Tipo**: token
- **Impacto**: P1
- **Descrição**: Hoje componentes usariam `16/9`, `4/3`, `9/16` literais. Criar `ZodiakAspectRatios.swift` com `video16x9`, `widescreen21x9`, `photo4x3`, `photo3x2`, `square`, `portrait3x4`, `story9x16`.
- **Referência**: [aspect-ratios.md](00-foundations/aspect-ratios.md)
- **ELI5**: Sem token, você escreve `aspectRatio(16/9)` em 30 lugares. O Design decide mudar para 15:9? Você busca e substitui em 30 arquivos, esperando não errar nenhum. Um token `ZodiakAspectRatios.video` muda todos de uma vez — e ainda documenta a intenção ("este é o ratio de vídeo").
- **Status**: Aberto

### G-058 — Opacity — Token foundation ausente
- **Tipo**: token
- **Impacto**: P1
- **Descrição**: Hoje componentes precisariam de literais `0.3f`, `0.5`, `0.12` para scrim/disabled/pressed/hover/focus. Criar `ZodiakOpacity.swift`.
- **Referência**: [opacity.md](00-foundations/opacity.md)
- **ELI5**: Disabled a 30% ou 50% de opacidade — parece detalhe, mas afeta contraste e legibilidade. Sem token, um componente disabled pode ter 30% enquanto outro usa 50%, e o usuário percebe a inconsistência mesmo sem saber nomear o problema.
- **Status**: Aberto

### G-059 — Motion — Token foundation ausente
- **Tipo**: token
- **Impacto**: P1
- **Descrição**: Sem tokens de duração/easing. Criar `ZodiakMotion.swift` alinhado a Material 3 MotionTokens (`duration.short/medium/long/extraLong`, `easing.standard/emphasized/decelerated/accelerated`).
- **Referência**: [motion.md](00-foundations/motion.md)
- **ELI5**: Transição rápida (100ms) parece responsiva. Transição longa (500ms) parece pesada. Todas as animações do app usando o mesmo conjunto de durações e easings criam um ritmo coerente — como uma música bem produzida. Sem tokens de motion, cada animação tem seu próprio tempo e o app parece descosturado.
- **Status**: Aberto

### G-060 — Hit-target — Token único centralizado
- **Tipo**: token
- **Impacto**: P0
- **Descrição**: `44pt`/`48dp` hoje aparece literal em ≥ 30 componentes. Centralizar em `Zodiak.hitTarget.minimum` / `Zodiak.hitTarget.comfortable`.
- **Referência**: [hit-target.md](00-foundations/hit-target.md)
- **ELI5**: 44pt é o mínimo de área tocável recomendado pela Apple e pelo WCAG. Aparece em 30+ componentes como número mágico. Um token centralizado documenta a origem, e se precisarmos mudar para 48pt globalmente, muda em um lugar só — em vez de buscar e substituir em 30 arquivos esperando não errar nenhum.
- **Status**: Aberto

### G-061 — Component Defaults — Namespace `Zodiak.defaults.*`
- **Tipo**: token
- **Impacto**: P1
- **Descrição**: Defaults numéricos de comportamento (`Rating.maxValue=5`, `ShowMore.collapsedLines=3`, `Pagination.visibleRange=5`, `Counter.step=1`, `Counter.minValue=0`, `Filter.activeCount=0`) precisam de namespace dedicado para evitar literais em assinaturas.
- **Referência**: [defaults.md](00-foundations/defaults.md)
- **ELI5**: Quantas estrelas o Rating mostra por padrão? 5. Quantas linhas o ShowMore colapsa? 3. Esses valores aparecem como literais em cada uso do componente. Um namespace `Zodiak.defaults.*` funciona como manual de configuração — e mudar o default de todas as instâncias do app vira uma linha de código.
- **Status**: Aberto

---

## HIG Review — iOS (Audit Wave 1)

> Findings gerados por revisão sistemática contra as **Apple Human Interface Guidelines** usando as skills `raintree-technology/hig-doctor`. Skills consultadas por componente indicadas em cada item. Metodologia definida em [07-audit/hig-review-ios.md](07-audit/hig-review-ios.md).

### Componente auditado: `ZodiakModal` (Organisms/Modal/ZodiakModal.swift)

> **Skills consultadas**: `hig-components-dialogs` (sheets.md, alerts.md) · `hig-patterns` (modality.md) · `hig-foundations` (accessibility.md, motion.md)
>
> **Resultado**: 2 serious · 4 moderate · 2 suggestion

---

### G-062 — ZodiakModal — Falta `.accessibilityViewIsModal(true)` no card
- **Tipo**: a11y
- **Severidade HIG**: serious
- **Impacto**: P1
- **Skill**: `hig-foundations` (accessibility.md) — _"Describe your app's interface and content for VoiceOver"_
- **Descrição**: O card `VStack` de `ZodiakModal` não aplica `.accessibilityViewIsModal(true)`. Sem esse modificador, o VoiceOver continua percorrendo elementos da tela ao fundo do modal — o usuário pode focar e ativar controles escondidos atrás do overlay, quebrando o fluxo modal.
- **Referência iOS**: `Shared/DesignSystem/Organisms/Modal/ZodiakModal.swift` — corpo do card (linha ~40)
- **Recomendação**:
  ```swift
  VStack(alignment: .leading, spacing: 0) { ... }
      .accessibilityViewIsModal(true)   // ← adicionar
  ```
- **Nota**: Corrigido em `feature/ds-organisms-modal-ios` (PR #209, pendente de merge).
- **ELI5**: O VoiceOver lê a tela inteira como se fosse uma lista. `.accessibilityViewIsModal(true)` é como colocar uma cerca: "só leia o que está dentro do modal". Sem a cerca, o leitor de tela continua descrevendo botões e textos da tela por trás do overlay — o usuário cego pode interagir com elementos invisíveis.
- **Status**: Em progresso (PR #209)

---

### G-063 — ZodiakModal — Transição de escala não respeita Reduce Motion
- **Tipo**: a11y
- **Severidade HIG**: serious
- **Impacto**: P1
- **Skill**: `hig-foundations` (motion.md) — _"Make motion optional."_; accessibility.md — _"Be cautious with fast-moving and blinking animations"_
- **Descrição**: A transição `.scale(scale: 0.94).combined(with: .opacity)` e a animação spring são aplicadas sem verificar `@Environment(\.accessibilityReduceMotion)`. Usuários com vestibular disorders, epilepsia ou sensibilidade a movimento habilitam Reduce Motion exatamente para suprimir esse tipo de escala + spring. O HIG exige alternativa (crossfade simples).
- **Referência iOS**: `ZodiakModal.swift` — `.transition(.scale(scale: 0.94).combined(with: .opacity))` e `.animation(.spring(response: 0.3, dampingFraction: 0.8), value: isPresented)`
- **Recomendação**:
  ```swift
  @Environment(\.accessibilityReduceMotion) private var reduceMotion

  // No body, substituir:
  .transition(reduceMotion ? .opacity : .scale(scale: 0.94).combined(with: .opacity))
  .animation(
      reduceMotion
          ? .easeInOut(duration: 0.18)
          : .spring(response: 0.3, dampingFraction: 0.8),
      value: isPresented
  )
  ```
- **ELI5**: Pessoas com vestibular disorders, sensibilidade a movimento ou epilepsia ativam "Reduce Motion" no iOS. É como dizer ao app: "não me faça girar ou zoom". Uma animação de scale + spring sem respeitar essa configuração força essas pessoas a ver algo que pode causar desconforto físico real.
- **Status**: Aberto

---

### G-064 — ZodiakModal — VoiceOver não recebe foco inicial ao aparecer
- **Tipo**: a11y
- **Severidade HIG**: moderate
- **Impacto**: P1
- **Skill**: `hig-foundations` (accessibility.md) — _"Your interface uses familiar and consistent interactions that make tasks straightforward to perform"_; `hig-patterns` (modality.md) — _"Make it easy to identify a modal view's task"_
- **Descrição**: Quando `isPresented` passa para `true`, o VoiceOver não é redirecionado para o título ou primeiro elemento interativo do modal. O usuário com VoiceOver pode não perceber que um modal foi aberto — o foco permanece na tela anterior até que role pelo conteúdo manualmente.
- **Referência iOS**: `ZodiakModal.swift` — ausência de `.accessibilityFocused()` binding
- **Recomendação**:
  ```swift
  @AccessibilityFocusState private var isTitleFocused: Bool

  // No título:
  Text(LocalizedStringKey(title))
      .accessibilityFocused($isTitleFocused)

  // Ao apresentar:
  .onChange(of: isPresented) { _, newValue in
      if newValue { isTitleFocused = true }
  }
  ```
- **ELI5**: Imagina entrar numa sala com os olhos fechados (VoiceOver). Se ninguém te avisa que mudou de sala e onde está a porta, você fica parado no lugar. `.accessibilityFocused()` é o "olha aqui" — avisa ao usuário de VoiceOver que um modal abriu e onde o conteúdo começa.
- **Status**: Aberto

---

### G-065 — ZodiakModal — Sem atalho de teclado `Escape` para fechar (iPad + Magic Keyboard)
- **Tipo**: plataforma
- **Severidade HIG**: moderate
- **Impacto**: P1
- **Skill**: `hig-platforms` (iOS, iPadOS) · `hig-patterns` (modality.md) — _"Always give people an obvious way to dismiss a modal view"_
- **Descrição**: Em iPads com Magic Keyboard (e em Macs com Catalyst), a convenção de plataforma é que a tecla `Escape` fecha modais e dialogs. `ZodiakModal` não registra esse atalho — o usuário de teclado físico precisa usar o botão de fechar com o mouse/touch.
- **Referência iOS**: `ZodiakModal.swift` — sem `.keyboardShortcut`
- **Recomendação**:
  ```swift
  // No ZStack do modal card ou no botão de fechar:
  .keyboardShortcut(.escape, modifiers: [])
  ```
- **ELI5**: No iPad com teclado, Escape fecha janelas desde sempre — é uma convenção tão estabelecida quanto Cmd+C para copiar. Sem suporte a Escape, o usuário de teclado precisa tirar a mão do teclado, tocar na tela para fechar e voltar ao teclado — uma interrupção desnecessaria no fluxo.
- **Status**: Aberto

---

### G-066 — ZodiakModal — Parâmetro `title: String?` usa `LocalizedStringKey` internamente (API inconsistente)
- **Tipo**: inconsistência
- **Severidade HIG**: moderate
- **Impacto**: P1
- **Skill**: `hig-foundations` (writing.md) — _"Your interface uses familiar and consistent interactions"_
- **Descrição**: O parâmetro é declarado como `String?` mas o body faz `Text(LocalizedStringKey(title))`. Isso cria dois problemas: (1) uma String que não é uma chave de localização válida não será traduzida corretamente; (2) a API pública não deixa claro se o chamador deve passar uma chave (`"modal.title"`) ou texto verbatim (`"Confirmar"`). O padrão Zodiak adotado em outros componentes (`ZodiakAlert`, `ZodiakNotice`) usa dois inits explícitos: `LocalizedStringKey` e `verbatim`.
- **Referência iOS**: `ZodiakModal.swift` linha `var title: String?` e `Text(LocalizedStringKey(title))`
- **Recomendação**: Seguir o padrão adotado em `ZodiakAlert`:
  ```swift
  // Init localizado (chave de xcstrings):
  init(title: LocalizedStringKey?, ...) { ... }

  // Init verbatim (string dinâmica, e.g. nome do usuário):
  init(verbatimTitle: String?, ...) { ... }
  ```
- **ELI5**: Você passa `title: "Confirmar"` esperando que o texto apareça. Por dentro, o código trata isso como chave de localização e busca em `Localizable.xcstrings` — mas `"Confirmar"` não é uma chave válida. O texto aparece em português, mas nunca é traduzido para inglês. É um bug silencioso que só aparece quando o app muda de idioma.
- **Status**: Aberto

---

### G-067 — ZodiakModal — Sombra hardcoded `Color.black.opacity(0.18)` — sem token
- **Tipo**: token
- **Severidade HIG**: moderate
- **Impacto**: P1
- **Skill**: `hig-foundations` (dark-mode.md) — _"Prefer system-defined colors"_ ; (color.md) — _"Use semantic colors"_
- **Descrição**: A sombra do card usa `.shadow(color: Color.black.opacity(0.18), ...)` hardcoded. Em dark mode, `Color.black` não é a cor correta para sombras — o sistema usa variações de opacidade sobre a cor de superfície. Além disso, rompe a regra Zodiak de tokens-only. O valor correto deve ser `ZodiakShadows.level3` (ou equivalente) que resolve adaptado ao tema.
- **Referência iOS**: `ZodiakModal.swift` — `.shadow(color: Color.black.opacity(0.18), radius: 24, x: 0, y: 8)`
- **Recomendação**:
  ```swift
  // Substituir por shadow token (exemplo):
  .shadow(color: ZodiakShadows.overlay, radius: 24, x: 0, y: 8)
  // ou via modificador:
  .zodiakShadow(.overlay)
  ```
- **ELI5**: Sombra `Color.black.opacity(0.18)` sobre fundo escuro (dark mode) é quase invisível — preto sobre preto. Um token de sombra usa cores adaptativas que funcionam tanto no claro quanto no escuro. Hardcodar preto é o equivalente a "funciona só de dia".
- **Status**: Aberto

---

### G-068 — ZodiakModal — `.cornerRadius()` deprecated (iOS 16+)
- **Tipo**: plataforma
- **Severidade HIG**: moderate
- **Impacto**: P2
- **Skill**: `hig-platforms` (iOS)
- **Descrição**: `.cornerRadius(ZodiakRadii.m)` foi depreciado no iOS 16. O substituto recomendado é `.clipShape(RoundedRectangle(cornerRadius:style:))` com `style: .continuous` para o squircle nativo Apple. Além da deprecação, `.continuous` produz cantos mais suaves e alinhados ao design system Apple.
- **Referência iOS**: `ZodiakModal.swift` — `.cornerRadius(ZodiakRadii.m)`
- **Recomendação**:
  ```swift
  // Substituir:
  .clipShape(RoundedRectangle(cornerRadius: ZodiakRadii.m, style: .continuous))
  ```
- **ELI5**: `.cornerRadius()` ainda funciona mas produz arcos circulares simples. `.clipShape(RoundedRectangle(style: .continuous))` produz "squircles" — os cantos suaves que você vê nos ícones de apps do iOS desde o iPhone X. É a diferença entre um canto matemático e o canto "desenhado à mão" elegante do design Apple.
- **Status**: Aberto

---

### G-069 — ZodiakModal — Sem haptic feedback ao fechar
- **Tipo**: plataforma
- **Severidade HIG**: suggestion
- **Impacto**: P2
- **Skill**: `hig-inputs` · `hig-patterns` (feedback) — _"Strive for realistic feedback motion that follows people's gestures and expectations"_
- **Descrição**: Ao fechar o modal (tap no backdrop ou no botão close), não há haptic feedback. No iOS, o padrão Apple é fornecer um `UIImpactFeedbackGenerator(.light)` ao dispensar overlays modais, comunicando ao usuário que a ação foi registrada — especialmente útil quando a animação de saída é sutil.
- **Referência iOS**: `ZodiakModal.swift` — closures de dismiss no backdrop `.onTapGesture` e em `ZodiakCloseButton`
- **Recomendação**:
  ```swift
  private func dismiss() {
      UIImpactFeedbackGenerator(style: .light).impactOccurred()
      isPresented = false
      onDismiss?()
  }
  ```
- **ELI5**: Feedback tátil ao fechar um modal é como o "clique" de uma porta se fechando — confirma que a ação aconteceu sem precisar de som ou animação chamativa. Sem haptic, o tap no backdrop parece que não funcionou e o usuário toca de novo por insegurança.
- **Status**: Aberto

---

### G-070 — ZodiakBottomSheet — `navigationTitle` vazio quando `title == nil` gera barra de navegação desnecessária
- **Tipo**: plataforma
- **Severidade HIG**: suggestion
- **Impacto**: P2
- **Skill**: `hig-components-layout` · `hig-platforms` (iOS)
- **Descrição**: Em `ZodiakBottomSheet`, quando `title == nil` a expressão `Text(LocalizedStringKey(title ?? ""))` gera um título vazio mas a `NavigationStack` ainda exibe uma barra de navegação com o botão "Fechar" — consumindo espaço vertical desnecessariamente. A HIG instrui a não mostrar elementos de navegação quando não há navegação real.
- **Referência iOS**: `ZodiakModal.swift` — `ZodiakBottomSheet.body`, linha `.navigationTitle(Text(LocalizedStringKey(title ?? "")))`
- **Recomendação**: Usar `.toolbar` e `.navigationTitle` condicionalmente, ou remover `NavigationStack` quando não há título e usar um overlay manual para o botão de fechar.
- **ELI5**: `NavigationStack` com título vazio ainda reserva espaço para a barra de navegação no topo da sheet — uma faixa vazia que desperdiça altura de tela. É como ter a moldura de um quadro sem o quadro dentro. Se não há título, não deve haver barra.
- **Status**: Aberto

---

## Stitch Review — Android (Audit Wave 1)

> Findings gerados por revisão sistemática do componente `ZodiakAlert` (molecules) comparado
> contra as diretrizes de Material Design 3 e o checklist de 15 pontos definido em
> [07-audit/stitch-review-android.md](07-audit/stitch-review-android.md).
> Metodologia: cada ponto do checklist foi verificado contra `ZodiakAlert.kt` line-by-line.

### Componente auditado: `ZodiakAlert` — `design-system/molecules/ZodiakAlert.kt`

---

### G-071 — ZodiakAlert — `ZodiakAlertType` declarado mas nunca utilizado
- **Tipo**: estado
- **Plataforma**: Android
- **Severidade MD3**: serious
- **Impacto**: P0
- **Descrição**: O parâmetro `type: ZodiakAlertType` é aceite pela API mas completamente ignorado na renderização. Os quatro valores (`INFO`, `SUCCESS`, `WARNING`, `ERROR`) produzem um diálogo visualmente idêntico — sem diferença de cor, ícone ou tonalidade. O utilizador não recebe feedback semântico sobre o nível de severidade do alerta.
- **Referência Android**: `ZodiakAndroid/design-system/src/main/kotlin/com/zodiak/android/design_system/molecules/ZodiakAlert.kt` (parâmetro `type` ignorado)
- **Recomendação**:
  ```kotlin
  // Adicionar mapeamento type → icon e tint no corpo de ZodiakAlert:
  val (defaultIcon, iconTint) = when (type) {
      ZodiakAlertType.INFO    -> Icons.Outlined.Info to MaterialTheme.colorScheme.primary
      ZodiakAlertType.SUCCESS -> Icons.Outlined.CheckCircle to ZodiakTheme.colors.textPositive
      ZodiakAlertType.WARNING -> Icons.Outlined.Warning to ZodiakTheme.colors.actionWarning
      ZodiakAlertType.ERROR   -> Icons.Outlined.Error to MaterialTheme.colorScheme.error
  }
  val resolvedIcon = icon ?: defaultIcon
  AlertDialog(
      icon = { Icon(resolvedIcon, contentDescription = null, tint = iconTint) },
      ...
  )
  ```
- **ELI5**: Imagina um semáforo onde todas as luzes têm a mesma cor. O `ZodiakAlertType` é o semáforo — existe no código mas não está ligado à lâmpada. Um utilizador cego que usa TalkBack, ou com daltonismo, não consegue distinguir um erro crítico de uma mensagem informativa.
- **Ver também**: G-022 (Alert — Modal vs inline + ações destructive)
- **Status**: Aberto

---

### G-072 — ZodiakAlert — Ícone sem `contentDescription` semântico quando tipo != INFO
- **Tipo**: a11y
- **Plataforma**: Android
- **Severidade MD3**: serious
- **Impacto**: P0
- **Descrição**: O `Icon` recebe sempre `contentDescription = null`, tornando-o decorativo para o TalkBack. Quando o ícone comunica o tipo de alerta (erro, aviso), a descrição deve reflectir o nível de severidade para utilizadores de leitores de ecrã. Um ícone de erro sem descrição silencia a informação crítica.
- **Referência Android**: `ZodiakAlert.kt` linha `icon = icon?.let { { Icon(it, contentDescription = null) } }`
- **Recomendação**:
  ```kotlin
  val iconDescription = when (type) {
      ZodiakAlertType.INFO    -> "Informação"
      ZodiakAlertType.SUCCESS -> "Sucesso"
      ZodiakAlertType.WARNING -> "Aviso"
      ZodiakAlertType.ERROR   -> "Erro"
  }
  Icon(resolvedIcon, contentDescription = iconDescription, tint = iconTint)
  // Strings devem ser fornecidas via stringResource() na camada de UI
  ```
- **ELI5**: O TalkBack lê em voz alta o que está no ecrã. Se o ícone não tem descrição, o utilizador cego ouve o título e o texto — mas não ouve "Erro" ou "Aviso". É como enviar um email de alerta com um semáforo vermelho que a impressora imprime a cinzento.
- **Ver também**: G-071
- **Status**: Aberto

---

### G-073 — ZodiakAlert — Ausência de `semantics { paneTitle }` para TalkBack
- **Tipo**: a11y
- **Plataforma**: Android
- **Severidade MD3**: moderate
- **Impacto**: P1
- **Descrição**: MD3 recomenda que diálogos modais incluam `Modifier.semantics { paneTitle = title }` no container do `AlertDialog`. Sem este atributo, o TalkBack não anuncia "Dialog opened" ao entrar no alerta, deixando utilizadores de leitores de ecrã sem contexto de que um novo painel modal foi aberto.
- **Referência Android**: `ZodiakAlert.kt` — `AlertDialog(...)` sem `Modifier.semantics { paneTitle = ... }`
- **Recomendação**:
  ```kotlin
  AlertDialog(
      modifier = Modifier.semantics { paneTitle = title },
      onDismissRequest = onDismiss,
      ...
  )
  ```
- **ELI5**: Quando um diálogo abre, o TalkBack deve dizer "Caixa de diálogo aberta". Sem o `paneTitle`, o leitor de ecrã salta directamente para o conteúdo sem avisar o utilizador que está agora dentro de uma janela modal — como entrar numa sala sem que a porta faça barulho.
- **Ver também**: G-022
- **Status**: Aberto

---

### G-074 — ZodiakAlert — `confirmLabel` com default `"OK"` hardcoded (não localizável)
- **Tipo**: inconsistência
- **Plataforma**: Android
- **Severidade MD3**: suggestion
- **Impacto**: P1
- **Descrição**: O parâmetro `confirmLabel: String = "OK"` usa um literal inglês como valor por omissão. Em projectos com localização pt-BR (ou qualquer outra língua), o label do botão de confirmação não é traduzido automaticamente. A convenção Zodiak é expor tipos (`sealed class`, `enum`) ou `@StringRes` em vez de strings literais nas APIs de DS.
- **Referência Android**: `ZodiakAlert.kt` — `confirmLabel: String = "OK"`
- **Recomendação**:
  ```kotlin
  // Opção A — deixar obrigatório (sem default):
  fun ZodiakAlert(confirmLabel: String, ...)
  // Chamador usa: confirmLabel = stringResource(R.string.action_confirm)

  // Opção B — default via @StringRes + overload:
  @Composable
  fun ZodiakAlert(
      @StringRes confirmLabelRes: Int = R.string.action_ok,
      ...
  ) { val confirmLabel = stringResource(confirmLabelRes); ... }
  ```
- **ELI5**: Imagina um botão que sempre diz "OK" mesmo quando o utilizador tem o telemóvel em português. Não está errado, mas parece descuidado — e em certas culturas "OK" pode não ser a palavra certa para confirmar uma acção destrutiva. O DS deve fornecer textos localizados por omissão.
- **Ver também**: G-003 (tipografia), Android localization instructions
- **Status**: Aberto

---

## Resumo por prioridade

- **P0 (bloqueantes)**: G-001, G-002, G-003, G-007, G-011, G-012, G-015, G-021, G-022, G-033, G-045, G-048, G-051, G-052, G-060, G-071, G-072 — **17 itens**
- **P1**: G-004, G-005, G-008, G-009, G-013, G-014, G-016, G-019, G-020, G-023, G-024, G-025, G-028, G-029, G-030, G-031, G-032, G-034, G-035, G-036, G-037, G-038, G-042, G-043, G-044, G-049, G-050, G-053, G-054, G-055, G-057, G-058, G-059, G-061, G-073, G-074 — **36 itens**
- **P2**: G-006, G-010, G-017, G-018, G-026, G-027, G-039, G-040, G-041, G-046, G-047, G-056 — **12 itens**

Total: **65 gaps** (61 plataforma-agnósticos + 4 Android Wave 1).

> Recomenda-se workshop com Design + Eng (iOS+Android) para resolver os P0 antes de iniciar Phase 1 de implementação (foundations + theme + atoms simples).

