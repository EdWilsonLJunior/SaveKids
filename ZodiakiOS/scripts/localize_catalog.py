#!/usr/bin/env python3
"""
Localização dos gallery views do catálogo Zodiak DS.

Estratégia de chaves:
  catalog.section.{snake}          → títulos de seção compartilhados
  catalog.{view}.subtitle          → subtítulo do galleryHeader
  catalog.{view}.desc_{n}          → Text("...") descritivo por view (índice 0-based)
  catalog.spec.lbl.{snake}         → labels de ZodiakInfoRow (global)
  catalog.spec.val.{snake}         → values de ZodiakInfoRow (global, dedup por conteúdo)

Strings com interpolação \(...) são ignoradas (dinâmicas, não localizáveis estaticamente).
"""

import re, json, os
from pathlib import Path
from collections import defaultdict, OrderedDict

ROOT = Path("/Users/mrocha/Developer/ZodiakiOS/ZodiakiOS/App/Catalog")
EN_STRINGS = Path("/Users/mrocha/Developer/ZodiakiOS/ZodiakiOS/en.lproj/Localizable.strings")
PTBR_STRINGS = Path("/Users/mrocha/Developer/ZodiakiOS/ZodiakiOS/pt-BR.lproj/Localizable.strings")

# ---------------------------------------------------------------------------
# Translations: PT-BR → EN
# Format: { "pt_string": "en_string" }
# Strings that are the same in both languages don't need an entry here
# (the EN key will default to the same value).
# ---------------------------------------------------------------------------

PT_TO_EN: dict[str, str] = {
    # ── Header subtitles ────────────────────────────────────────────────────
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
    "ZodiakLabelledField · ZodiakLabelledNumericField · ZodiakLabelledCheckbox.":
        "ZodiakLabelledField · ZodiakLabelledNumericField · ZodiakLabelledCheckbox.",
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
    "ZodiakFilterButton · Filter inputs":
        "ZodiakFilterButton · Filter inputs",
    "ZodiakFormInDrawer · formulário em drawer lateral com estados":
        "ZodiakFormInDrawer · form in side drawer with states",
    "ZodiakSliderCounter · navegação de carrosseis — 2 a 9 itens":
        "ZodiakSliderCounter · carousel navigation — 2 to 9 items",
    "ZodiakChipGroup · ZodiakFlowLayout":
        "ZodiakChipGroup · ZodiakFlowLayout",
    "ZodiakShare · botão de compartilhamento com sheet de opções":
        "ZodiakShare · share button with options sheet",
    "ZodiakDownloadButton · ZodiakDownloadOption":
        "ZodiakDownloadButton · ZodiakDownloadOption",
    "ZodiakMediaButton · play/pause/stop · volume · skip · 3 variantes":
        "ZodiakMediaButton · play/pause/stop · volume · skip · 3 variants",
    "ZodiakMenuButton — menu de múltiplas ações":
        "ZodiakMenuButton — multi-action menu",
    "ZodiakVideoPreviewButton · pause/resume auto-play com anel de progresso":
        "ZodiakVideoPreviewButton · pause/resume auto-play with progress ring",
    "ZodiakSystemButton · ZodiakSystemWarningButton":
        "ZodiakSystemButton · ZodiakSystemWarningButton",
    "ZodiakPasswordField":
        "ZodiakPasswordField",
    "ZodiakPhoneInput":
        "ZodiakPhoneInput",
    "ZodiakRadioButton · ZodiakRadioGroup":
        "ZodiakRadioButton · ZodiakRadioGroup",
    "ZodiakRating · ZodiakRatingDisplay":
        "ZodiakRating · ZodiakRatingDisplay",
    "ZodiakProgressBar · ZodiakProgressRing · ZodiakSpinner":
        "ZodiakProgressBar · ZodiakProgressRing · ZodiakSpinner",
    "ZodiakBreadcrumb · ZodiakPagination":
        "ZodiakBreadcrumb · ZodiakPagination",
    "ZodiakCardGrid · ZodiakCard":
        "ZodiakCardGrid · ZodiakCard",
    "ZodiakSkeletonLine · ZodiakSkeletonCircle · ZodiakSkeletonRect · ZodiakSkeletonListRow · ZodiakSkeletonCard":
        "ZodiakSkeletonLine · ZodiakSkeletonCircle · ZodiakSkeletonRect · ZodiakSkeletonListRow · ZodiakSkeletonCard",
    "ZodiakToastConfig · .zodiakToast()":
        "ZodiakToastConfig · .zodiakToast()",
    "Hero · Tipográfico · Headline · Text Block · Listings · Media · Image compositions":
        "Hero · Typographic · Headline · Text Block · Listings · Media · Image compositions",
    "Link Ribbon · Professional Contact · Share Story":
        "Link Ribbon · Professional Contact · Share Story",
    "Author · Horizontal · Tall · Typographic · Reveal · Short Facts":
        "Author · Horizontal · Tall · Typographic · Reveal · Short Facts",
    "Button icon · Button close · Button arrow":
        "Button icon · Button close · Button arrow",

    # ── Section titles ───────────────────────────────────────────────────────
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
    "4 steps": "4 steps",
    "5 steps — todos concluídos": "5 steps — all done",
    "2 a 9 itens": "2 to 9 items",
    "Display (read-only)": "Display (read-only)",
    "Não-ordenada (unordered)": "Unordered",
    "Ordenada (ordered)": "Ordered",

    # ── InfoRow labels ───────────────────────────────────────────────────────
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
    "Estado vazio": "Empty State",
    "Estados": "States",
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
    "Variantes": "Variants",
    "Vazia": "Empty",
    "Ícone": "Icon",
    "Ícone container": "Icon Container",
    "Ícone leading": "Leading Icon",
    "Ícone thumb": "Thumb Icon",
    "Ícone trigger": "Trigger Icon",
    "show more": "show more",

    # ── InfoRow values ───────────────────────────────────────────────────────
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
    "ZodiakColors.textPrimary (não use #171a22 direto)": "ZodiakColors.textPrimary (don't use #171a22 directly)",

    # ── Text() descriptions ──────────────────────────────────────────────────
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
    "top": "top",
    "bottom": "bottom",
    "trailing": "trailing",
}

# ---------------------------------------------------------------------------
# Key generation helpers
# ---------------------------------------------------------------------------

def to_snake(s: str, max_len: int = 40) -> str:
    """Convert a string to a safe snake_case key fragment."""
    # Remove non-alphanumeric chars except spaces and hyphens
    s = re.sub(r'[^\w\s\-]', '', s, flags=re.UNICODE)
    s = re.sub(r'[\s\-]+', '_', s.strip())
    s = re.sub(r'_+', '_', s)
    s = s.lower().strip('_')
    # Transliterate common accented chars
    import unicodedata as _ud
    s = _ud.normalize('NFKD', s)
    s = ''.join(c for c in s if not _ud.combining(c))
    return s[:max_len].strip('_')

def view_key(file_stem: str) -> str:
    """ActionCompositionsGalleryView → action_compositions"""
    name = file_stem.replace("GalleryView", "").replace("Gallery", "")
    return to_snake(name)

def has_interpolation(s: str) -> bool:
    return '\\(' in s

def translate_en(s: str) -> str:
    return PT_TO_EN.get(s, s)

# ---------------------------------------------------------------------------
# Key registries (global dedup)
# ---------------------------------------------------------------------------

# section titles → key
SECTION_KEYS: dict[str, str] = {}
# info_row label → key
LABEL_KEYS: dict[str, str] = {}
# info_row value → key
VALUE_KEYS: dict[str, str] = {}

def get_section_key(title: str) -> str | None:
    """Return key for a section title, registering it if new. None if interpolated."""
    if has_interpolation(title):
        return None
    if title not in SECTION_KEYS:
        snake = to_snake(title)
        candidate = f"catalog.section.{snake}"
        # Dedup by suffix
        existing_vals = set(SECTION_KEYS.values())
        i, base = 1, candidate
        while candidate in existing_vals:
            candidate = f"{base}_{i}"
            i += 1
        SECTION_KEYS[title] = candidate
    return SECTION_KEYS[title]

def get_label_key(label: str) -> str | None:
    if has_interpolation(label):
        return None
    if label not in LABEL_KEYS:
        snake = to_snake(label)
        candidate = f"catalog.spec.lbl.{snake}"
        existing_vals = set(LABEL_KEYS.values())
        i, base = 1, candidate
        while candidate in existing_vals:
            candidate = f"{base}_{i}"
            i += 1
        LABEL_KEYS[label] = candidate
    return LABEL_KEYS[label]

def get_value_key(value: str) -> str | None:
    if has_interpolation(value):
        return None
    if value not in VALUE_KEYS:
        snake = to_snake(value)
        candidate = f"catalog.spec.val.{snake}"
        existing_vals = set(VALUE_KEYS.values())
        i, base = 1, candidate
        while candidate in existing_vals:
            candidate = f"{base}_{i}"
            i += 1
        VALUE_KEYS[value] = candidate
    return VALUE_KEYS[value]

# ---------------------------------------------------------------------------
# Per-view subtitle + desc registries
# ---------------------------------------------------------------------------

# (view_key, subtitle) → key
SUBTITLE_KEYS: dict[tuple, str] = {}
# (view_key, desc_text) → key
DESC_KEYS: dict[tuple, str] = {}

def get_subtitle_key(vk: str, subtitle: str) -> str | None:
    if has_interpolation(subtitle):
        return None
    k = (vk, subtitle)
    if k not in SUBTITLE_KEYS:
        SUBTITLE_KEYS[k] = f"catalog.{vk}.subtitle"
    return SUBTITLE_KEYS[k]

_desc_counters: dict[str, int] = defaultdict(int)

def get_desc_key(vk: str, text: str) -> str | None:
    if has_interpolation(text):
        return None
    k = (vk, text)
    if k not in DESC_KEYS:
        n = _desc_counters[vk]
        _desc_counters[vk] += 1
        DESC_KEYS[k] = f"catalog.{vk}.desc_{n}"
    return DESC_KEYS[k]

# ---------------------------------------------------------------------------
# String replacement in Swift source
# ---------------------------------------------------------------------------

def escape_for_replacement(s: str) -> str:
    """Escape backslash and double-quote for regex replacement."""
    return re.escape(s)

def replace_section_card_titles(src: str) -> str:
    """Replace gallerySectionCard(title: "...") literals."""
    def repl(m: re.Match) -> str:
        orig = m.group(1)
        key = get_section_key(orig)
        if key is None:
            return m.group(0)
        return m.group(0).replace(f'"{orig}"', f'"{key}"')

    return re.sub(r'gallerySectionCard\s*\(\s*title:\s*"((?:[^"\\]|\\.)*)"', repl, src)

def replace_header_subtitles(src: str, vk: str) -> str:
    """Replace galleryHeader(... subtitle: "...") literals."""
    def repl(m: re.Match) -> str:
        full, subtitle = m.group(0), m.group(1)
        key = get_subtitle_key(vk, subtitle)
        if key is None:
            return full
        return full.replace(f'"{subtitle}"', f'"{key}"', 1)

    # Match subtitle parameter specifically (not title)
    return re.sub(r'(subtitle:\s*)"((?:[^"\\]|\\.)*)"', repl, src)

def replace_text_literals(src: str, vk: str) -> str:
    """Replace Text("...") with Text("key") for non-interpolated descriptive strings."""
    def repl(m: re.Match) -> str:
        text = m.group(1)
        if has_interpolation(text):
            return m.group(0)
        # Skip pure technical tokens — single CamelCase word, pure code, very short
        if re.fullmatch(r'[A-Z][a-zA-Z]+', text):
            return m.group(0)
        if len(text) < 3:
            return m.group(0)
        key = get_desc_key(vk, text)
        if key is None:
            return m.group(0)
        return f'Text("{key}")'

    # Only match Text("literal") — not Text(someVariable)
    return re.sub(r'\bText\("((?:[^"\\]|\\.)*)"\)', repl, src)

def replace_info_rows(src: str) -> str:
    """Replace ZodiakInfoRow("label", value: "value", ...) literals."""
    def repl(m: re.Match) -> str:
        lbl, val, rest = m.group(1), m.group(2), m.group(3)
        lk = get_label_key(lbl)
        vk_ = get_value_key(val)
        new_lbl = f'"{lk}"' if lk else f'"{lbl}"'
        new_val = f'"{vk_}"' if vk_ else f'"{val}"'
        return f'ZodiakInfoRow({new_lbl}, value: {new_val}{rest})'

    return re.sub(
        r'ZodiakInfoRow\("((?:[^"\\]|\\.)*)",\s*value:\s*"((?:[^"\\]|\\.)*)"((?:[^)]*)?)\)',
        repl, src
    )

# ---------------------------------------------------------------------------
# Process a single file
# ---------------------------------------------------------------------------

def process_file(path: Path) -> str:
    vk = view_key(path.stem)
    src = path.read_text(encoding='utf-8')

    src = replace_section_card_titles(src)
    src = replace_header_subtitles(src, vk)
    src = replace_text_literals(src, vk)
    src = replace_info_rows(src)

    return src

# ---------------------------------------------------------------------------
# Generate .strings entries
# ---------------------------------------------------------------------------

def build_strings_entries() -> tuple[dict[str, str], dict[str, str]]:
    """Return (en_entries, ptbr_entries) dicts mapping key → value."""
    en: dict[str, str] = {}
    pt: dict[str, str] = {}

    def add(key: str, pt_val: str):
        en_val = translate_en(pt_val)
        en[key] = en_val
        pt[key] = pt_val

    for pt_val, key in SECTION_KEYS.items():
        add(key, pt_val)
    for (vk, subtitle), key in SUBTITLE_KEYS.items():
        add(key, subtitle)
    for (vk, text), key in DESC_KEYS.items():
        add(key, text)
    for pt_val, key in LABEL_KEYS.items():
        add(key, pt_val)
    for pt_val, key in VALUE_KEYS.items():
        add(key, pt_val)

    return en, pt

def format_strings_block(entries: dict[str, str]) -> str:
    lines = []
    for key in sorted(entries.keys()):
        val = entries[key].replace('"', '\\"').replace('\n', '\\n')
        lines.append(f'"{key}" = "{val}";')
    return '\n'.join(lines)

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main():
    swift_files = sorted(ROOT.rglob("*.swift"))
    gallery_files = [f for f in swift_files
                     if "GalleryView" in f.stem or f.stem == "ZodiakGalleryShell"]

    print(f"Processing {len(gallery_files)} files...")

    # First pass: build key registries by processing all files (but don't write yet)
    results: dict[Path, str] = {}
    for f in gallery_files:
        results[f] = process_file(f)

    # Build strings entries
    en_entries, pt_entries = build_strings_entries()
    print(f"Keys generated: {len(en_entries)}")

    # Write transformed Swift files
    for f, new_src in results.items():
        f.write_text(new_src, encoding='utf-8')

    # Append to .strings files (avoiding duplicates)
    def append_to_strings(path: Path, entries: dict[str, str]):
        existing_src = path.read_text(encoding='utf-8') if path.exists() else ""
        # Find already-declared keys
        existing_keys = set(re.findall(r'"(catalog\.[^"]+)"\s*=', existing_src))
        new_entries = {k: v for k, v in entries.items() if k not in existing_keys}
        if not new_entries:
            print(f"  No new entries for {path.name}")
            return
        block = format_strings_block(new_entries)
        separator = "\n\n// MARK: - Catalog Gallery\n"
        with path.open('a', encoding='utf-8') as fh:
            fh.write(f"{separator}{block}\n")
        print(f"  Appended {len(new_entries)} entries to {path.name}")

    append_to_strings(EN_STRINGS, en_entries)
    append_to_strings(PTBR_STRINGS, pt_entries)

    print("\nDone. Run build to verify.")

if __name__ == "__main__":
    main()
