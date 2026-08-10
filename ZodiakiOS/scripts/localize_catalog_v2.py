#!/usr/bin/env python3
"""
Script de localização corrigido.
Usa o manifest pre-transformação para gerar os mapeamentos de chave,
preenche os .strings files, e aplica apenas as substituições de subtitle
(que falharam no primeiro run) nos arquivos Swift.
"""

import re, json
from pathlib import Path
from collections import defaultdict

MANIFEST_PATH = Path("/tmp/catalog_strings_manifest.json")
CATALOG_ROOT = Path("/Users/mrocha/Developer/ZodiakiOS/ZodiakiOS/App/Catalog")
EN_STRINGS = Path("/Users/mrocha/Developer/ZodiakiOS/ZodiakiOS/en.lproj/Localizable.strings")
PTBR_STRINGS = Path("/Users/mrocha/Developer/ZodiakiOS/ZodiakiOS/pt-BR.lproj/Localizable.strings")

# ──────────────────────────────────────────────────────────────────────────────
# PT-BR → EN translation table (uses UNESCAPED strings as keys)
# ──────────────────────────────────────────────────────────────────────────────
PT_TO_EN: dict[str, str] = {
    # Header subtitles
    "Formulário multi-etapas com barra de progresso persistente":
        "Multi-step form with persistent progress bar",
    "Marcador de localização para imagens, mapas e canvas":
        "Location marker for images, maps, and canvas",
    "4 layouts de página prontos — ZodiakActivityTemplate, ZodiakInputOutputTemplate, ZodiakListTemplate e ZodiakAdaptiveTemplate.":
        "4 ready-made page layouts — ZodiakActivityTemplate, ZodiakInputOutputTemplate, ZodiakListTemplate and ZodiakAdaptiveTemplate.",
    "4 variantes · radius XS (4pt) · Ubuntu Caption 12pt.":
        "4 variants · radius XS (4pt) · Ubuntu Caption 12pt.",
    "5 variantes com pill shape (radius 999pt), Ubuntu Regular 16pt e altura 48pt (medium).":
        "5 variants with pill shape (radius 999pt), Ubuntu Regular 16pt and 48pt height (medium).",
    "8 componentes de texto — de Headline até Caption.":
        "8 text components — from Headline to Caption.",
    "12 logos Capgemini. Wordmark mínimo 175pt de largura. Símbolo espada mínimo 24pt de altura.":
        "12 Capgemini logos. Wordmark minimum 175pt wide. Sword symbol minimum 24pt tall.",
    "ZodiakChip — pill shape (radius 999pt) com estado ativo/inativo. Ideal para filtros e tags.":
        "ZodiakChip — pill shape (radius 999pt) with active/inactive state. Ideal for filters and tags.",
    "ZodiakCounterControl — controle de incremento/decremento com min, max e step configuráveis.":
        "ZodiakCounterControl — increment/decrement control with configurable min, max and step.",
    "ZodiakFormWrapper (simples) e ZodiakFormContainer (adaptativo iPad/iPhone).":
        "ZodiakFormWrapper (simple) and ZodiakFormContainer (adaptive iPad/iPhone).",
    "ZodiakInfoRow — linha de label | valor para exibir dados em pares.":
        "ZodiakInfoRow — label | value row for displaying data in pairs.",
    "ZodiakList · Não-ordenada e ordenada com headline opcional":
        "ZodiakList · Unordered and ordered with optional headline",
    "ZodiakLoginForm · email/senha · SSO · logins alternativos · auth progressiva":
        "ZodiakLoginForm · email/password · SSO · alternative logins · progressive auth",
    "ZodiakMultiselect · seleção múltipla com chips de resumo":
        "ZodiakMultiselect · multiple selection with summary chips",
    "ZodiakResultCard e ZodiakResultCardWithBadge — exibem resultado com título, valor grande e subtítulo opcional.":
        "ZodiakResultCard and ZodiakResultCardWithBadge — display result with title, large value and optional subtitle.",
    "ZodiakTabs (Small e Medium) e ZodiakTabContainer — máximo 7 tabs, barra inferior indicadora.":
        "ZodiakTabs (Small and Medium) and ZodiakTabContainer — maximum 7 tabs, bottom indicator bar.",
    "ZodiakTextField · ZodiakNumericField — 4 tipos de helper text tipado.":
        "ZodiakTextField · ZodiakNumericField — 4 typed helper text variants.",
    "ZodiakToggle — switch com label em bold e tint actionPrimary.":
        "ZodiakToggle — switch with bold label and actionPrimary tint.",
    "ZodiakCombobox · busca inline + seleção única":
        "ZodiakCombobox · inline search + single selection",
    "ZodiakDropdown · seleção única sem busca":
        "ZodiakDropdown · single selection without search",
    "ZodiakFormInDrawer · formulário em drawer lateral com estados":
        "ZodiakFormInDrawer · form in side drawer with states",
    "ZodiakSliderCounter · navegação de carrosseis — 2 a 9 itens":
        "ZodiakSliderCounter · carousel navigation — 2 to 9 items",
    "ZodiakShare · botão de compartilhamento com sheet de opções":
        "ZodiakShare · share button with options sheet",
    "ZodiakMediaButton · play/pause/stop · volume · skip · 3 variantes":
        "ZodiakMediaButton · play/pause/stop · volume · skip · 3 variants",
    "ZodiakMenuButton — menu de múltiplas ações":
        "ZodiakMenuButton — multi-action menu",
    "ZodiakVideoPreviewButton · pause/resume auto-play com anel de progresso":
        "ZodiakVideoPreviewButton · pause/resume auto-play with progress ring",

    # Section titles
    "Especificações": "Specifications",
    "Variantes": "Variants",
    "Variantes de conteúdo": "Content Variants",
    "Variantes de cor": "Color Variants",
    "Variantes de total": "Total Variants",
    "Variantes por estilo": "Variants by Style",
    "Exemplos": "Examples",
    "Exemplos interativos": "Interactive Examples",
    "Exemplo básico": "Basic Example",
    "Exemplo em contexto": "In-context Example",
    "Demonstração": "Demo",
    "Demo — Agendar reunião": "Demo — Schedule Meeting",
    "Estilos": "Styles",
    "Estados": "States",
    "Todos os estados": "All States",
    "Todos os helper states": "All Helper States",
    "Estado de erro": "Error State",
    "Estado desabilitado": "Disabled State",
    "Estado de seleção": "Selection State",
    "Estado vazio": "Empty State",
    "Estados de cada step": "States per Step",
    "Comportamento": "Behavior",
    "Comportamentos": "Behaviors",
    "Configuração": "Configuration",
    "Como usar": "How to Use",
    "Quando usar": "When to Use",
    "Quando usar vs. ZodiakButton": "When to Use vs. ZodiakButton",
    "Tamanhos": "Sizes",
    "Desabilitado": "Disabled",
    "Casos de uso": "Use Cases",
    "Contextos de uso": "Usage Contexts",
    "Contextos comuns": "Common Contexts",
    "Combinações de uso": "Usage Combinations",
    "Legenda de variantes": "Variants Legend",
    "Alinhamento": "Alignment",
    "Conteúdo do pin": "Pin Content",
    "Escritórios Capgemini": "Capgemini Offices",
    "Componentes": "Components",
    "Primitivos": "Primitives",
    "Cores de texto": "Text Colors",
    "Anatomia do card": "Card Anatomy",
    "Seleção simples": "Single Selection",
    "Seleção múltipla": "Multiple Selection",
    "Seleção única — interativo": "Single Selection — Interactive",
    "Multi-seleção — interativo": "Multi-selection — Interactive",
    "Busca com lista longa": "Search with Long List",
    "Botões individuais": "Individual Buttons",
    "Lista curta": "Short List",
    "Lista de registros": "Records List",
    "Máximo de seleções (máx. 3)": "Maximum Selections (max. 3)",
    "Chips para filtros (input)": "Filter Chips (input)",
    "Não-ordenada (unordered)": "Unordered",
    "Ordenada (ordered)": "Ordered",
    "Sem headline": "Without Headline",
    "Sem anel de progresso": "Without Progress Ring",
    "Com anel de progresso": "With Progress Ring",
    "Com botão de ação (CTA)": "With Action Button (CTA)",
    "Com contador numérico": "With Numeric Counter",
    "Sem contador numérico": "Without Numeric Counter",
    "Com valor pré-selecionado": "With Pre-selected Value",
    "Com ícone e subtítulo": "With Icon and Subtitle",
    "Descartável (isDismissible)": "Dismissible (isDismissible)",
    "Podcast Grande": "Large Podcast",
    "Sem checkbox de compliance": "Without Compliance Checkbox",
    "Seção de Título": "Title Section",
    "Bloco de Texto": "Text Block",
    "Imagem e Texto Simétrico": "Symmetric Image and Text",
    "Hero Tipográfico": "Typographic Hero",
    "Hero Fullscreen": "Fullscreen Hero",
    "Vídeo e Texto": "Video and Text",
    "Grid de cards": "Cards Grid",
    "Rating interativo": "Interactive Rating",
    "Radio Group — plano de assinatura": "Radio Group — Subscription Plan",
    "Integrado com carrossel": "Integrated with Carousel",
    "Em lista — Tabuada do 7": "In List — 7× Multiplication Table",
    "Uso comum — com ZodiakAuthor": "Common Usage — with ZodiakAuthor",
    "Uso nos Exemplos": "Usage in Examples",
    "Compartilhamento padrão": "Default Sharing",
    "Label customizado": "Custom Label",
    "Múltiplas opções — abre bottom sheet": "Multiple Options — Opens Bottom Sheet",
    "Opção única — download direto": "Single Option — Direct Download",
    "Spinner indeterminado": "Indeterminate Spinner",
    "Playground — Validação": "Playground — Validation",
    "Playground — dispare um toast": "Playground — Fire a Toast",
    "Playground — pressione e segure": "Playground — Press and Hold",
    "Apenas título": "Title Only",
    "Auth progressiva": "Progressive Auth",
    "5 steps — todos concluídos": "5 steps — all done",
    "Display (read-only)": "Display (read-only)",

    # InfoRow labels
    "Animação": "Animation",
    "Altura": "Height",
    "Altura da imagem": "Image Height",
    "Altura total": "Total Height",
    "Anel externo": "Outer Ring",
    "Anterior": "Previous",
    "Ativação": "Activation",
    "Barra": "Bar",
    "Borda": "Border",
    "Botões": "Buttons",
    "Colunas": "Columns",
    "Componente": "Component",
    "Compositions implementadas": "Implemented Compositions",
    "Compostos": "Composites",
    "Contador": "Counter",
    "Conteúdo": "Content",
    "Controles": "Controls",
    "Cor base": "Base Color",
    "Dependência": "Dependency",
    "Descrição": "Description",
    "Duas colunas": "Two Columns",
    "Duração": "Duration",
    "Entrada": "Entry",
    "Estado ativo": "Active State",
    "Estado inativo": "Inactive State",
    "Estado padrão": "Default State",
    "Estrela cheia": "Full Star",
    "Família": "Family",
    "Fechar": "Close",
    "Filtro": "Filter",
    "Foco": "Focus",
    "Forma": "Shape",
    "Fundo": "Background",
    "Imagem": "Image",
    "Interação": "Interaction",
    "Largura": "Width",
    "Linha decorativa": "Decorative Line",
    "Meia estrela": "Half Star",
    "Navegação": "Navigation",
    "Número": "Number",
    "Orientação": "Orientation",
    "Parâmetros": "Parameters",
    "Ponto interno": "Inner Dot",
    "Posição": "Position",
    "Prefixo": "Prefix",
    "Progresso": "Progress",
    "Página ativa": "Active Page",
    "Repouso": "Rest",
    "Responsividade": "Responsiveness",
    "Revelado": "Revealed",
    "Seletor": "Selector",
    "Seleção": "Selection",
    "Separador": "Separator",
    "Tamanhos": "Sizes",
    "Teclado": "Keyboard",
    "Tecnologia": "Technology",
    "Texto": "Text",
    "Tipografia": "Typography",
    "Transição": "Transition",
    "Título": "Title",
    "Uso": "Usage",
    "Variante": "Variant",
    "Vazia": "Empty",
    "Ícone": "Icon",
    "Ícone container": "Icon Container",
    "Ícone leading": "Leading Icon",
    "Ícone thumb": "Thumb Icon",
    "Ícone trigger": "Trigger Icon",

    # InfoRow values
    "(() -> Void)? — nil oculta seção SSO": "(() -> Void)? — nil hides SSO section",
    "@ViewBuilder genérico por step": "@ViewBuilder generic per step",
    "Adaptativa (wraps 2 linhas)": "Adaptive (wraps 2 lines)",
    "Adaptativa ao conteúdo de texto": "Adaptive to text content",
    "Aparece quando options.count > 1": "Appears when options.count > 1",
    "Aparece quando text não vazio": "Appears when text is not empty",
    "Ativo apenas em iPad (horizontalSizeClass == .regular)": "Active only on iPad (horizontalSizeClass == .regular)",
    "Ativo quando alternativeLogins.count > 3": "Active when alternativeLogins.count > 3",
    "Barra + dots numerados persistentes no header": "Bar + numbered dots persistent in header",
    "Barra 32×2 pt em actionPrimary": "32×2pt bar in actionPrimary",
    'Bool — "1 / N" label opcional': 'Bool — optional "1 / N" label',
    'Bool — desabilita CTA + label "Entrando…"': 'Bool — disables CTA + "Signing in…" label',
    "Bool — exibe apenas email até confirmação": "Bool — shows only email until confirmed",
    "Bool — exibe checkbox GDPR (padrão: true)": "Bool — shows GDPR checkbox (default: true)",
    "Borda actionPrimary + texto actionPrimary": "actionPrimary border + actionPrimary text",
    "Borda actionPrimary 1.5pt + ícone animado": "1.5pt actionPrimary border + animated icon",
    "Borda borderPrimary 1pt": "1pt borderPrimary",
    "Bottom sheet com busca (searchable)": "Bottom sheet with search (searchable)",
    "Botão Voltar (steps 2+) + Próximo/Concluir": "Back button (steps 2+) + Next/Done",
    "Botão integrado quando items > initialCount": "Built-in button when items > initialCount",
    "Catálogo, editorial, marketing e blocos de conteúdo": "Catalog, editorial, marketing and content blocks",
    "Configurável: 1 ou 2 (mobile)": "Configurable: 1 or 2 (mobile)",
    "Círculo actionWarningSecondary com contagem": "actionWarningSecondary circle with count",
    "Círculo com SF Symbol, label ou dot": "Circle with SF Symbol, label or dot",
    "Decorativo — sem assets externos": "Decorative — no external assets",
    "Empilhado verticalmente": "Vertically stacked",
    "Eyebrow + título + descrição sobre imagem": "Eyebrow + title + description over image",
    "Fonte headline — iPhone usa title1": "Headline font — iPhone uses title1",
    "Fundo actionPrimary + textInverse": "actionPrimary background + textInverse",
    "Fundo de página · Superfície névoa": "Page background · Fog surface",
    "Gradiente escuro centro → base": "Dark gradient center → base",
    "Gradiente escuro para legibilidade": "Dark gradient for readability",
    "Grid 2 colunas · flexível": "2-column grid · flexible",
    "Grid 2 colunas · sem imagem": "2-column grid · no image",
    "Hero, tipográfico, headline, text block, listings, media e image compositions":
        "Hero, typographic, headline, text block, listings, media and image compositions",
    "Imagem 200pt de altura": "200pt image height",
    "Imagem 280pt de altura": "280pt image height",
    "Indicador de navegação à direita": "Navigation indicator on the right",
    "Lado a lado 50/50": "Side by side 50/50",
    "Leading (padrão) · Center": "Leading (default) · Center",
    "LinearGradient bottom→top 0.55→0.15 opacidade": "LinearGradient bottom→top 0.55→0.15 opacity",
    "LinearGradient branco 0.35 deslizando": "White 0.35 LinearGradient sliding",
    "ListRow, Card (combinam primitivos)": "ListRow, Card (combine primitives)",
    '"Nenhum resultado" inline': '"No results" inline',
    'Mostra itens ocultos: "Mostrar mais (6)"': 'Shows hidden items: "Show more (6)"',
    "Mínimo 44pt via frame": "Minimum 44pt via frame",
    "Numerados · concluído = checkmark verde": "Numbered · done = green checkmark",
    "Número de itens visíveis inicialmente": "Number of initially visible items",
    "Opcional — show/hide via parâmetro": "Optional — show/hide via parameter",
    "Overlay preto 72% + texto expandido": "72% black overlay + expanded text",
    "SF Symbol — escala 38% do diâmetro": "SF Symbol — 38% of diameter scale",
    "Sem conteúdo — apenas bolha colorida": "No content — colored bubble only",
    "Sempre bottom-right do vídeo": "Always bottom-right of the video",
    "Slide horizontal entre steps (.easeInOut 0.25s)": "Horizontal slide between steps (.easeInOut 0.25s)",
    "Split 50/50 lado a lado": "Split 50/50 side by side",
    "String — headline do drawer": "String — drawer headline",
    "String — label do botão de submit": "String — submit button label",
    'String — padrão: "Compartilhar"': 'String — default: "Share"',
    "String? — texto introdutório opcional": "String? — optional introductory text",
    'String? — ícone decorativo no header': "String? — decorative icon in header",
    "Só tokens e SF Symbols locais": "Only local tokens and SF Symbols",
    "Tag + título + subtítulo + descrição": "Tag + title + subtitle + description",
    "Tamanho base · sem ring": "Base size · no ring",
    "Texto curto · máx. 1 linha": "Short text · max. 1 line",
    "Texto do botão de expansão": "Expansion button label",
    "Toque no mesmo star = desseleciona": "Tap same star = deselects",
    "Toque · Trackpad/Mouse · Teclado ← →": "Tap · Trackpad/Mouse · Keyboard ← →",
    "Triângulo apontando para baixo": "Triangle pointing down",
    "Título + ícone + no fundo gradiente": "Title + icon + gradient background",
    "Vídeo à esquerda · Vídeo à direita": "Video on left · Video on right",
    "Wrap content (não max .infinity)": "Wrap content (not max .infinity)",
    "XS — 4pt (não é pill)": "XS — 4pt (not a pill)",
    "e-mail · telefone · LinkedIn opcionais": "email · phone · LinkedIn optional",
    "6 tipos de pin · ver secção Legenda de variantes": "6 pin types · see Variants Legend section",
    "iPhone e iPad com layouts fluidos": "iPhone and iPad with fluid layouts",
    "30% do diâmetro + borda surface 1.5pt": "30% of diameter + 1.5pt surface border",
    "todos os demais controles": "all other controls",
    "tap backdrop · botão X · drag down": "tap backdrop · X button · drag down",
    "Scale 1.15 · ring branco interno · borda actionPrimary": "Scale 1.15 · white inner ring · actionPrimary border",
    "ZodiakDivider hierarquia primária + secundária": "ZodiakDivider primary + secondary hierarchy",
    "ZodiakColors.borderSecondary · cornerRadius S": "ZodiakColors.borderSecondary · cornerRadius S",

    # Text() descriptions
    "Toque no header para expandir/colapsar.": "Tap the header to expand/collapse.",
    "O Zodiak DS é o sistema de design oficial da Capgemini. Ele fornece um conjunto de componentes, tokens de design e diretrizes para criar experiências digitais consistentes e acessíveis.":
        "Zodiak DS is Capgemini's official design system. It provides a set of components, design tokens and guidelines for creating consistent and accessible digital experiences.",
    "Use sempre os tokens semânticos em vez de cores primitivas:":
        "Always use semantic tokens instead of primitive colors:",
    "• ZodiakColors.textPrimary (não use #171a22 direto)":
        "• ZodiakColors.textPrimary (don't use #171a22 directly)",
    "• ZodiakColors.actionPrimary para interações":
        "• ZodiakColors.actionPrimary for interactions",
    "Isso garante suporte automático a dark mode.":
        "This ensures automatic dark mode support.",
    "• Contraste mínimo 4.5:1 para texto normal":
        "• Minimum contrast 4.5:1 for normal text",
    "• Touch targets mínimos de 44×44pt":
        "• Minimum touch targets of 44×44pt",
    "• Use .accessibilityLabel() para ícones sem texto":
        "• Use .accessibilityLabel() for icons without text",
    "Todos os tokens de espaçamento seguem a base 8pt. Use ZodiakSpacing._3XS (4pt) a ZodiakSpacing._8XL (176pt).":
        "All spacing tokens follow the 8pt base. Use ZodiakSpacing._3XS (4pt) to ZodiakSpacing._8XL (176pt).",
    "Empilhamento de múltiplos avatares com contagem de overflow.":
        "Stack of multiple avatars with overflow count.",
    "Tira horizontal de links de navegação rápida. Ideal para rodapés, sidebars e seções.":
        "Horizontal strip of quick navigation links. Ideal for footers, sidebars and sections.",
    "Card de contato profissional com avatar, nome, cargo, empresa e ações de comunicação.":
        "Professional contact card with avatar, name, role, company and communication actions.",
    "Composição para promover e compartilhar uma história ou notícia nas redes.":
        "Composition for promoting and sharing a story or news on social networks.",
    "Toque no × para dispensar o alerta.": "Tap × to dismiss the alert.",
    "Toque no × para dispensar.": "Tap × to dismiss.",
    "Segure por 0.3s para exibir o tooltip. Dispensa após 2.5s.":
        "Hold for 0.3s to show the tooltip. Dismisses after 2.5s.",
    "Toque para expandir a lista. Seleção fecha automaticamente.":
        "Tap to expand the list. Selection closes automatically.",
    "Toque no código do país para abrir o seletor.":
        "Tap the country code to open the selector.",
    "Chips mostram as opções selecionadas. Expanda para adicionar ou remover.":
        "Chips show selected options. Expand to add or remove.",
    "Após 3 seleções, chips adicionais são bloqueados.":
        "After 3 selections, additional chips are blocked.",
    "Toque em uma estrela para selecionar. Toque novamente para desmarcar.":
        "Tap a star to select. Tap again to deselect.",
    "Exibe avaliações de double com suporte a meias estrelas.":
        "Displays Double ratings with half-star support.",
    "Toque nas setas ou números para navegar.":
        "Tap the arrows or numbers to navigate.",
    "Anel animado indica o tempo restante da prévia. Toque para pausar/retomar.":
        "Animated ring indicates the remaining preview time. Tap to pause/resume.",
    "Quando não há restrição técnica para implementar a animação, omita o anel.":
        "When there is no technical constraint to implement the animation, omit the ring.",
    "CTAs de navegação com seta direcional. Sem fundo — hierarquia mínima.":
        "Navigation CTAs with directional arrow. No background — minimal hierarchy.",
    "Botão dedicado para fechar overlays, modais e banners.":
        "Dedicated button for closing overlays, modals and banners.",
    "Primary (play/pause/stop): fundo preenchido. Tertiary: ghost com borda.":
        "Primary (play/pause/stop): filled background. Tertiary: ghost with border.",
    "Controles de playback em variante onLite.":
        "Playback controls in onLite variant.",
    "Card full-width com imagem grande e texto sobreposto na base.":
        "Full-width card with large image and text overlaid at the bottom.",
    "Card com texto escondido revelado ao toque. Toque para expandir/colapsar.":
        "Card with hidden text revealed on tap. Tap to expand/collapse.",
    "Sem foto de fundo — tipografia e shape geométrico são os protagonistas. 5 variantes de forma.":
        "No background photo — typography and geometric shape are the protagonists. 5 shape variants.",
    "Sem imagem. Hierarquia tipográfica com linha de destaque colorida.":
        "No image. Typographic hierarchy with a colored accent line.",
    "Imagem à esquerda, texto à direita. Layout compacto para feeds e listas.":
        "Image on the left, text on the right. Compact layout for feeds and lists.",
    "Grid de autores — avatar + nome + cargo + data + tópico.":
        "Author grid — avatar + name + role + date + topic.",
    "Grid de estatísticas compactas com ícone colorido, valor e rótulo.":
        "Compact statistics grid with colored icon, value and label.",
    "Cabeçalho reutilizável que encabeça card grids, key figures e demais composições.":
        "Reusable header that tops card grids, key figures and other compositions.",
    "Preenche toda a área disponível com overlay escuro para máximo impacto visual.":
        "Fills the entire available area with a dark overlay for maximum visual impact.",
    "Estrutura de conteúdo textual com heading opcional em dois níveis.":
        "Textual content structure with optional heading at two levels.",
    "Layout 50/50 entre imagem e texto. Lado-a-lado em iPad, empilhado em iPhone.":
        "50/50 layout between image and text. Side-by-side on iPad, stacked on iPhone.",
    "Player full-width com imagem de topo, descrição longa e controles de playback.":
        "Full-width player with top image, long description and playback controls.",
    "Vídeo com título e descrição. Lado-a-lado em iPad, empilhado em iPhone.":
        "Video with title and description. Side-by-side on iPad, stacked on iPhone.",
    "Toque no botão para abrir o sheet de opções de compartilhamento.":
        "Tap the button to open the sharing options sheet.",
    "O Share é tipicamente usado junto ao Author em páginas de artigo.":
        "Share is typically used alongside Author on article pages.",
    "Quando há apenas uma opção, o download é disparado diretamente sem abrir sheet.":
        "When there is only one option, the download is triggered directly without opening a sheet.",
    "O formulário mostra um ZodiakAlert inline quando o submit falha.":
        "The form shows an inline ZodiakAlert when submission fails.",
    "Com SSO, 4 logins alternativos (show more ativo) e links de criar conta e esqueceu senha.":
        "With SSO, 4 alternative logins (show more active) and links for create account and forgot password.",
    "Sem SSO e sem logins alternativos — caso mínimo.":
        "No SSO and no alternative logins — minimal case.",
    "Exibe apenas o campo de e-mail inicialmente. Ao confirmar, revela o campo de senha.":
        "Displays only the email field initially. On confirmation, reveals the password field.",
    "Formulário com campos obrigatórios, checkbox de compliance e estados idle → submitting → success.":
        "Form with required fields, compliance checkbox and idle → submitting → success states.",
    "Adapta o 'Form in drawer' (desktop = direita) para iOS (bottom = baixo).":
        "Adapts the 'Form in drawer' (desktop = right) for iOS (bottom = below).",
    "Conteúdo do modal. Adicione qualquer view SwiftUI aqui.":
        "Modal content. Add any SwiftUI view here.",
    "Esta é uma mensagem informativa apresentada em um modal com título e botão de fechar.":
        "This is an informational message presented in a modal with a title and close button.",
    "Esta ação é permanente e não pode ser desfeita.":
        "This action is permanent and cannot be undone.",
    "Tap no backdrop fecha o modal. Botão X é opcional.":
        "Tapping the backdrop closes the modal. The X button is optional.",
    "O toast aparece na parte inferior e é dispensado automaticamente após 3s.":
        "The toast appears at the bottom and is automatically dismissed after 3s.",
    "Inclui um botão de ação inline (ex: Desfazer).":
        "Includes an inline action button (e.g., Undo).",
    "1. Declare @State var toast: ZodiakToastConfig?":
        "1. Declare @State var toast: ZodiakToastConfig?",
    "2. Aplique .zodiakToast($toast) na View raiz":
        "2. Apply .zodiakToast($toast) to the root View",
    "3. Atribua toast = ZodiakToastConfig(...) para disparar":
        "3. Assign toast = ZodiakToastConfig(...) to fire",
    "Mostrar skeleton (simulação de loading)": "Show skeleton (loading simulation)",
    "Nenhum filtro aplicado — toque para ativar.": "No filter applied — tap to activate.",
    "Nenhum filtro ativo — toque no botão acima.": "No active filter — tap the button above.",
    "Selecione os filtros": "Select filters",
    "Como avalia sua experiência?": "How do you rate your experience?",
    "Ação confirmada via slide.": "Action confirmed via slide.",
    "Digite para filtrar as opções. A lista se expande ao focar.":
        "Type to filter options. The list expands on focus.",
    "Usar quando a ordem dos itens não importa.": "Use when item order does not matter.",
    "Usar para sequências, passos ou hierarquia de prioridade.":
        "Use for sequences, steps or priority hierarchy.",
    "Usar quando o progresso é desconhecido.": "Use when progress is unknown.",
    "Para ações destrutivas em interfaces de produto digital.":
        "For destructive actions in digital product interfaces.",
    "Use para ações que exigem confirmação intencional do usuário — prevenindo cliques acidentais.":
        "Use for actions that require intentional user confirmation — preventing accidental clicks.",
    "O Slider Counter controla qual slide está visível e reflete o progresso.":
        "The Slider Counter controls which slide is visible and reflects the progress.",
    "Trilha de navegação hierárquica.": "Hierarchical navigation trail.",
    "Campo obrigatório — erro de validação": "Required field — validation error",
    "Valor fora do intervalo permitido": "Value out of allowed range",
    "Wizard concluído!": "Wizard complete!",
    "Ativo (2)": "Active (2)",
    "Ativo (9)": "Active (9)",
    "Padrão": "Default",
    "Artigo · 5 min": "Article · 5 min",
    "Analista · Capgemini": "Analyst · Capgemini",
    "Repouso (sem foco)": "Rest (unfocused)",
    "Com conteúdo + botão clear": "With content + clear button",
    "Tam.": "Size",
    "Esquerda (padrão)": "Left (default)",
}

# ──────────────────────────────────────────────────────────────────────────────
# Helpers
# ──────────────────────────────────────────────────────────────────────────────

def unescape_swift(s: str) -> str:
    """Unescape Swift string escape sequences."""
    result = []
    i = 0
    while i < len(s):
        if s[i] == '\\' and i + 1 < len(s):
            c = s[i + 1]
            if c == '"':   result.append('"');  i += 2
            elif c == '\\': result.append('\\'); i += 2
            elif c == 'n':  result.append('\n'); i += 2
            elif c == 't':  result.append('\t'); i += 2
            elif c == 'r':  result.append('\r'); i += 2
            else:            result.append(s[i:i+2]); i += 2
        else:
            result.append(s[i]); i += 1
    return ''.join(result)

def has_interpolation(s: str) -> bool:
    return '\\(' in s

def translate_en(unescaped_pt: str) -> str:
    return PT_TO_EN.get(unescaped_pt, unescaped_pt)

def to_snake(s: str, max_len: int = 40) -> str:
    import unicodedata
    s = unicodedata.normalize('NFKD', s)
    s = ''.join(c for c in s if not unicodedata.combining(c))
    s = re.sub(r'[^\w\s\-]', '', s, flags=re.UNICODE)
    s = re.sub(r'[\s\-]+', '_', s.strip())
    s = re.sub(r'_+', '_', s)
    return s.lower().strip('_')[:max_len].strip('_')

# ──────────────────────────────────────────────────────────────────────────────
# Key registries (global dedup)
# Keyed by UNESCAPED string → semantic key
# ──────────────────────────────────────────────────────────────────────────────
SECTION_KEYS: dict[str, str] = {}   # unescaped title → key
SUBTITLE_KEYS: dict[tuple, str] = {}  # (vk, unescaped subtitle) → key
LABEL_KEYS: dict[str, str] = {}     # unescaped label → key
VALUE_KEYS: dict[str, str] = {}     # unescaped value → key
DESC_KEYS: dict[tuple, str] = {}    # (vk, unescaped text) → key
_desc_counters: dict[str, int] = defaultdict(int)

def _unique_key(base: str, existing: set) -> str:
    k = base
    i = 1
    while k in existing:
        k = f"{base}_{i}"; i += 1
    return k

def reg_section(unescaped: str) -> str:
    if unescaped not in SECTION_KEYS:
        SECTION_KEYS[unescaped] = _unique_key(
            f"catalog.section.{to_snake(unescaped)}", set(SECTION_KEYS.values()))
    return SECTION_KEYS[unescaped]

def reg_subtitle(vk: str, unescaped: str) -> str:
    k = (vk, unescaped)
    if k not in SUBTITLE_KEYS:
        SUBTITLE_KEYS[k] = f"catalog.{vk}.subtitle"
    return SUBTITLE_KEYS[k]

def reg_label(unescaped: str) -> str:
    if unescaped not in LABEL_KEYS:
        LABEL_KEYS[unescaped] = _unique_key(
            f"catalog.spec.lbl.{to_snake(unescaped)}", set(LABEL_KEYS.values()))
    return LABEL_KEYS[unescaped]

def reg_value(unescaped: str) -> str:
    if unescaped not in VALUE_KEYS:
        VALUE_KEYS[unescaped] = _unique_key(
            f"catalog.spec.val.{to_snake(unescaped)}", set(VALUE_KEYS.values()))
    return VALUE_KEYS[unescaped]

def reg_desc(vk: str, unescaped: str) -> str:
    k = (vk, unescaped)
    if k not in DESC_KEYS:
        n = _desc_counters[vk]
        _desc_counters[vk] += 1
        DESC_KEYS[k] = f"catalog.{vk}.desc_{n}"
    return DESC_KEYS[k]

# ──────────────────────────────────────────────────────────────────────────────
# Phase 1 — Build key registries from manifest
# ──────────────────────────────────────────────────────────────────────────────

def build_registries_from_manifest():
    manifest = json.loads(MANIFEST_PATH.read_text(encoding='utf-8'))
    for file_rel, data in manifest.items():
        vk = data['prefix'].replace('catalog.', '')
        for entry in data['strings']:
            raw = entry['original']
            if has_interpolation(raw):
                continue
            unescaped = unescape_swift(raw)
            pattern = entry['pattern']
            if pattern == 'section.title':
                reg_section(unescaped)
            elif pattern == 'header.subtitle':
                reg_subtitle(vk, unescaped)
            elif pattern == 'text':
                if re.fullmatch(r'[A-Z][a-zA-Z]+', unescaped):
                    continue
                if len(unescaped) < 3:
                    continue
                reg_desc(vk, unescaped)
            elif pattern == 'info_row.label':
                reg_label(unescaped)
            elif pattern == 'info_row.value':
                reg_value(unescaped)

# ──────────────────────────────────────────────────────────────────────────────
# Phase 2 — Update subtitle replacements in Swift files (only missing part)
# ──────────────────────────────────────────────────────────────────────────────

def fix_subtitles_in_swift_files():
    manifest = json.loads(MANIFEST_PATH.read_text(encoding='utf-8'))
    count = 0
    for file_rel, data in manifest.items():
        vk = data['prefix'].replace('catalog.', '')
        swift_path = Path("/Users/mrocha/Developer/ZodiakiOS") / file_rel
        if not swift_path.exists():
            continue
        src = swift_path.read_text(encoding='utf-8')
        modified = False

        for entry in data['strings']:
            if entry['pattern'] != 'header.subtitle':
                continue
            raw = entry['original']
            if has_interpolation(raw):
                continue
            unescaped = unescape_swift(raw)
            key = SUBTITLE_KEYS.get((vk, unescaped))
            if not key:
                continue

            # Replace subtitle: "original_raw" → subtitle: "key"
            # Be careful to match the raw string (with Swift escapes)
            escaped_raw = re.escape(raw)
            pattern = f'(subtitle:\\s*)"{escaped_raw}"'
            replacement = f'\\1"{key}"'
            new_src = re.sub(pattern, replacement, src)
            if new_src != src:
                src = new_src
                modified = True
                count += 1

        if modified:
            swift_path.write_text(src, encoding='utf-8')

    print(f"Updated {count} subtitle replacements in Swift files")

# ──────────────────────────────────────────────────────────────────────────────
# Phase 3 — Generate and append .strings entries
# ──────────────────────────────────────────────────────────────────────────────

def escape_strings_value(s: str) -> str:
    """Escape a string value for .strings format."""
    return s.replace('\\', '\\\\').replace('"', '\\"').replace('\n', '\\n').replace('\r', '\\r')

def generate_and_append_strings():
    en_entries: dict[str, str] = {}
    pt_entries: dict[str, str] = {}

    def add(key: str, pt_unescaped: str):
        en_entries[key] = translate_en(pt_unescaped)
        pt_entries[key] = pt_unescaped

    for pt_val, key in SECTION_KEYS.items():
        add(key, pt_val)
    for (vk, pt_val), key in SUBTITLE_KEYS.items():
        add(key, pt_val)
    for pt_val, key in LABEL_KEYS.items():
        add(key, pt_val)
    for pt_val, key in VALUE_KEYS.items():
        add(key, pt_val)
    for (vk, pt_val), key in DESC_KEYS.items():
        add(key, pt_val)

    def format_block(entries: dict[str, str]) -> str:
        lines = []
        for k in sorted(entries):
            v = escape_strings_value(entries[k])
            lines.append(f'"{k}" = "{v}";')
        return '\n'.join(lines)

    def append(path: Path, entries: dict[str, str]):
        existing = path.read_text(encoding='utf-8') if path.exists() else ''
        existing_keys = set(re.findall(r'"(catalog\.[^"]+)"\s*=', existing))
        new = {k: v for k, v in entries.items() if k not in existing_keys}
        if not new:
            print(f"  No new entries for {path.name}"); return
        block = format_block(new)
        with path.open('a', encoding='utf-8') as f:
            f.write(f"\n\n// MARK: - Catalog Gallery\n{block}\n")
        print(f"  Appended {len(new)} entries to {path.name}")

    append(EN_STRINGS, en_entries)
    append(PTBR_STRINGS, pt_entries)

# ──────────────────────────────────────────────────────────────────────────────
# Main
# ──────────────────────────────────────────────────────────────────────────────

def main():
    print("Phase 1: Building key registries from manifest...")
    build_registries_from_manifest()
    print(f"  Section keys: {len(SECTION_KEYS)}")
    print(f"  Subtitle keys: {len(SUBTITLE_KEYS)}")
    print(f"  Label keys: {len(LABEL_KEYS)}")
    print(f"  Value keys: {len(VALUE_KEYS)}")
    print(f"  Desc keys: {len(DESC_KEYS)}")
    total = len(SECTION_KEYS) + len(SUBTITLE_KEYS) + len(LABEL_KEYS) + len(VALUE_KEYS) + len(DESC_KEYS)
    print(f"  Total: {total}")

    print("\nPhase 2: Fixing subtitle replacements in Swift files...")
    fix_subtitles_in_swift_files()

    print("\nPhase 3: Generating .strings entries...")
    generate_and_append_strings()

    print("\nDone.")

if __name__ == "__main__":
    main()
