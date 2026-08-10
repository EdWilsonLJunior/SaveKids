#!/usr/bin/env python3
"""
Localization Migration Script — ZodiakiOS
Migrates all natural-language .strings keys to dot-notation semantic keys.
Also updates call sites in Swift files.

Usage:
    python3 scripts/migrate_localization.py [--dry-run]
"""

import os
import re
import sys
import argparse

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
EN_STRINGS = os.path.join(ROOT, "ZodiakiOS/en.lproj/Localizable.strings")
PTBR_STRINGS = os.path.join(ROOT, "ZodiakiOS/pt-BR.lproj/Localizable.strings")

SWIFT_ROOTS = [
    os.path.join(ROOT, "ZodiakiOS/Features"),
    os.path.join(ROOT, "ZodiakiOS/App"),
    os.path.join(ROOT, "ZodiakiOS/Models"),
    os.path.join(ROOT, "ZodiakiOS/Services"),
    os.path.join(ROOT, "ZodiakiOS/Shared"),
]

# ─────────────────────────────────────────────────────────────────────────────
# COMPLETE KEY MAPPING: old natural-language key → new dot-notation key
# Keys that already start with "catalog." are left unchanged.
# ─────────────────────────────────────────────────────────────────────────────
MAPPING = {
    # ── App / Catalog Home ────────────────────────────────────────────────────
    "Visão Geral": "app.tab.overview",
    "Design System · Capgemini": "catalog.home.title",
    "Catálogo completo de tokens, componentes e padrões do Zodiak Design System com demos interativas e exemplos de uso real.": "catalog.home.subtitle",
    "Visão geral de métricas": "catalog.home.metrics_overview",
    "Seções": "catalog.home.sections",
    "Cores semânticas": "catalog.home.semantic_colors",
    "Ramps primitivas": "catalog.home.primitive_ramps",
    "Estilos tipográficos": "catalog.home.typography_styles",
    "Tokens de espaçamento": "catalog.home.spacing_tokens",
    "Suporte Dark Mode": "catalog.home.dark_mode_support",
    "Ícones": "catalog.home.icons",
    "Bandeiras": "catalog.home.flags",
    "Logos": "catalog.home.logos",
    "Cores, tipografia, espaçamento e raios — a base de tudo.": "catalog.home.tokens_desc",
    "Átomos, moléculas, organismos e templates do Zodiak.": "catalog.home.components_desc",
    "10 exemplos de uso real do Design System em apps iOS.": "catalog.home.examples_desc",
    "Zodiak Design System — Capgemini · doc-zodiak.capgemini.com": "catalog.home.ds_link",
    "Pesquisar no catálogo...": "catalog.home.search_placeholder",
    "Resultados": "catalog.home.results",
    "Nenhum resultado para \"%@\"": "catalog.home.no_results",
    "Navega para a página inicial do catálogo": "catalog.home.nav_home_accessibility",
    "Tokens": "catalog.home.tab_tokens",
    "Componentes": "catalog.home.tab_components",
    "Exemplos Reais": "catalog.home.tab_examples",
    "Ver todos": "catalog.home.view_all",
    "Zodiak DS": "catalog.home.zodiak_ds_short",
    "Zodiak Design System": "catalog.home.zodiak_ds_full",
    "Ativar tema claro": "catalog.home.switch_light_theme",
    "Ativar tema escuro": "catalog.home.switch_dark_theme",
    "Selecionar idioma": "catalog.home.select_language",
    "Mudar idioma": "catalog.home.change_language",
    "Idioma": "app.settings.language_title",
    "Configurações": "app.settings.title",
    "Seguir sistema": "app.settings.follow_system",
    "Português (Brasil)": "app.settings.lang_pt_br",
    "Inglês": "app.settings.lang_en",
    "Cancelar": "shared.action.cancel",

    # ── Feature Eyebrows ──────────────────────────────────────────────────────
    "Atividade 1": "feature.grades.eyebrow",
    "Atividade 2": "feature.pix.eyebrow",
    "Atividade 3": "feature.voting.eyebrow",
    "Atividade 4": "feature.palindrome.eyebrow",
    "Atividade 5": "feature.guess.eyebrow",
    "Atividade 6": "feature.multiplication.eyebrow",
    "Atividade 7": "feature.person_manager.eyebrow",
    "Atividade 8": "feature.theme_toggle.eyebrow",
    "Atividade 9": "feature.temperature.eyebrow",
    "Atividade 10": "feature.task_manager.eyebrow",
    "Atividade 11": "feature.quiz_game.eyebrow",

    # ── Feature Short Titles ──────────────────────────────────────────────────
    "Média de Notas": "feature.grades.short_title",
    "Alternador de Tema": "feature.theme_toggle.short_title",
    "Jogo de Perguntas": "feature.quiz_game.short_title",

    # ── Feature Intros ────────────────────────────────────────────────────────
    "Informe até 4 notas e calcule a média final do aluno.": "feature.grades.intro",
    "Simule o desconto Pix em compras e veja o valor final.": "feature.pix.intro",
    "Vote em candidatos e acompanhe o resultado em tempo real.": "feature.voting.intro",
    "Verifique se uma palavra ou frase é igual de trás para frente.": "feature.palindrome.intro",
    "Tente adivinhar o número secreto usando as dicas de maior ou menor.": "feature.guess.intro",
    "Gere a tabuada de qualquer número e veja todas as multiplicações.": "feature.multiplication.intro",
    "Cadastre pessoas com nome e idade e gerencie a lista.": "feature.person_manager.intro",
    "Explore o design system nos modos claro e escuro.": "feature.theme_toggle.intro",
    "Converta temperaturas entre Celsius e Fahrenheit em tempo real.": "feature.temperature.intro",
    "Adicione tarefas, marque como concluídas e filtre a lista.": "feature.task_manager.intro",
    "Escolha um tema e responda perguntas para testar seu conhecimento.": "feature.quiz_game.intro",

    # ── Feature 1: Grades ─────────────────────────────────────────────────────
    "Atividade 1: Média de Notas": "feature.grades.title",
    "Nome": "shared.label.name",
    "Digite seu nome": "shared.placeholder.name",
    "Calcular Média": "feature.grades.calculate_action",
    "Acima da média": "feature.grades.above_average",
    "Abaixo da média": "feature.grades.below_average",
    "Aluno: %@": "feature.grades.student_label",
    "Aprovado": "shared.state.passed",
    "Reprovado": "shared.state.failed",
    "Limpar": "shared.action.clear",
    "0 a 10": "feature.grades.range_hint",
    "Nota 1": "feature.grades.grade_1",
    "Nota 2": "feature.grades.grade_2",
    "Nota 3": "feature.grades.grade_3",
    "Média Final": "feature.grades.final_average",

    # ── Feature 2: PIX Discount ───────────────────────────────────────────────
    "Atividade 2: Desconto Pix": "feature.pix.title",
    "Produto": "shared.label.product",
    "Nome do produto": "shared.placeholder.product_name",
    "Valor (R$)": "feature.pix.amount_label",
    "Pagar com Pix?": "feature.pix.pay_with_pix",
    "Calcular": "shared.action.calculate",
    "Valor Final": "feature.pix.final_amount",
    "Desconto: %@": "feature.pix.discount_label",
    "Pagar com PIX": "feature.pix.pay_with_pix_toggle",

    # ── Shared format strings (mixed with multiple features) ──────────────────
    "%d votos": "shared.format.vote_count",
    "%d anos": "shared.format.age_years",
    "Número secreto entre %d e %d": "feature.guess.secret_number_range",
    "%@ Você acertou em %d tentativas!": "feature.guess.success_message",
    "%@ Concluída": "feature.task_manager.task_completed",
    "Pergunta %d de %d": "feature.quiz_game.question_progress",
    "✓ %d": "feature.quiz_game.correct_count",
    "Tema %@": "feature.quiz_game.theme_label",
    "Toque duas vezes para jogar com o tema %@": "feature.quiz_game.theme_accessibility",
    "Opção %d de %d: %@": "feature.quiz_game.option_accessibility",

    # ── Feature 3: Voting ─────────────────────────────────────────────────────
    "Atividade 3: Sistema de Votação": "feature.voting.title",
    "Finalizar Votação": "feature.voting.finish_action",
    "Nova Votação": "feature.voting.new_action",
    "Resultado": "feature.voting.result",
    "Votos Finais": "feature.voting.final_votes",
    "Segundo turno entre: %@": "feature.voting.runoff_between",
    "Vencedor: %@ (%d votos)": "feature.voting.winner_label",
    "Vencedor: %@": "feature.voting.winner_name",
    "Candidato A": "feature.voting.candidate_a",
    "Candidato B": "feature.voting.candidate_b",
    "Candidato C": "feature.voting.candidate_c",

    # ── Feature 4: Palindrome ─────────────────────────────────────────────────
    "Atividade 4: Verificador de Palíndromo": "feature.palindrome.title",
    "Palavra ou Frase": "feature.palindrome.label",
    "Ex: arara, Ana, Socorram-me, subi no ônibus em Marrocos": "feature.palindrome.placeholder",
    "Verificar": "shared.action.verify",

    # ── Feature 5: Guess Game ─────────────────────────────────────────────────
    "Atividade 5: Adivinhe o Número": "feature.guess.title",
    "Número secreto entre 1 e 100": "feature.guess.secret_range_hint",
    "Seu Palpite": "feature.guess.guess_label",
    "Digite um número": "shared.placeholder.enter_number",
    "Enviar Palpite": "feature.guess.submit_action",
    "Jogar Novamente": "shared.action.play_again",
    "Dica": "feature.guess.hint_label",
    "Tentativas: %d": "feature.guess.attempts_label",
    "Digite um número entre %d e %d": "feature.guess.number_range_hint",

    # ── Feature 6: Multiplication Table ──────────────────────────────────────
    "Atividade 6: Tabuada": "feature.multiplication.title",
    "Número": "shared.label.number",
    "Gerar Tabuada": "feature.multiplication.generate_action",

    # ── Feature 7: Person Manager ─────────────────────────────────────────────
    "Atividade 7: Gerenciador de Pessoas": "feature.person_manager.title",
    "Digite o nome": "shared.placeholder.enter_name",
    "Digite a idade": "shared.placeholder.enter_age",
    "Idade": "shared.label.age",
    "Adicionar Pessoa": "feature.person_manager.add_action",
    "Nenhuma pessoa cadastrada": "feature.person_manager.empty_title",
    "Adicione pessoas pelo formulário acima.": "feature.person_manager.empty_desc",

    # ── Feature 8: Theme Toggle ───────────────────────────────────────────────
    "Atividade 8: Alternador de Tema": "feature.theme_toggle.title",
    "Ativar Tema Escuro": "feature.theme_toggle.enable_dark",
    "Cores": "feature.theme_toggle.colors_section",

    # ── Feature 9: Temperature Converter ─────────────────────────────────────
    "Atividade 9: Conversor de Temperatura": "feature.temperature.title",
    "Celsius (°C)": "feature.temperature.celsius_label",
    "Fahrenheit (°F)": "feature.temperature.fahrenheit_label",
    "Digite a temperatura": "feature.temperature.placeholder",
    "Conversão": "feature.temperature.conversion_section",
    "Conversão em tempo real": "feature.temperature.realtime_desc",

    # ── Feature 10: Task Manager ──────────────────────────────────────────────
    "Atividade 10: Gerenciador de Tarefas": "feature.task_manager.title",
    "Nova Tarefa": "feature.task_manager.new_task",
    "Digite uma tarefa": "feature.task_manager.placeholder",
    "Adicionar Tarefa": "feature.task_manager.add_action",
    "Filtrar tarefas...": "feature.task_manager.filter_placeholder",
    "Nenhuma tarefa": "feature.task_manager.empty_title",
    "Adicione uma tarefa pelo campo acima.": "feature.task_manager.empty_desc",
    "Sem resultados": "feature.task_manager.no_results_title",
    "Nenhuma tarefa encontrada para \"%@\".": "feature.task_manager.no_results_desc",
    "Limpar busca": "feature.task_manager.clear_search",
    "Marcar como pendente": "feature.task_manager.mark_pending",
    "Marcar como concluída": "feature.task_manager.mark_done",
    "Remover tarefa": "feature.task_manager.remove_action",

    # ── Feature 11: Quiz Game ─────────────────────────────────────────────────
    "Atividade 11: Jogo de Perguntas": "feature.quiz_game.title",
    "Escolha um Tema": "feature.quiz_game.choose_theme",
    "Confirmar": "shared.action.confirm",
    "Próxima": "shared.action.next_question",
    "Ver Resultado": "feature.quiz_game.view_result",
    "✓ Resposta Correta!": "feature.quiz_game.correct_feedback",
    "✗ Resposta Incorreta": "feature.quiz_game.wrong_feedback",
    "Resposta correta": "feature.quiz_game.correct_answer_label",
    "Resumo": "feature.quiz_game.summary",
    "Acertos": "feature.quiz_game.correct_count_label",
    "Erros": "feature.quiz_game.wrong_count_label",
    "Swift": "feature.quiz_game.theme_swift",
    "Filmes": "feature.quiz_game.theme_movies",
    "História": "feature.quiz_game.theme_history",
    "Geografia": "feature.quiz_game.theme_geography",

    # ── Shared Validation ─────────────────────────────────────────────────────
    "Campo '%@' não pode estar vazio": "shared.validation.empty_field",
    "Campo '%@' deve conter um número válido": "shared.validation.invalid_number",
    "'%@' deve estar entre %d e %d": "shared.validation.out_of_range_int",
    "'%@' deve estar entre %@ e %@": "shared.validation.out_of_range_decimal",
    "Idade deve ser um número positivo": "shared.validation.age_positive",
    "Nota deve estar entre 0 e 10": "shared.validation.grade_range",
    "Erro desconhecido": "shared.error.unknown",
    "Erro ao adicionar pessoa": "feature.person_manager.add_error",

    # ── Shared UI ─────────────────────────────────────────────────────────────
    "Não disponível": "shared.state.unavailable",
    "Aviso: %@": "shared.format.warning",
    "Ação irreversível — confirme antes de prosseguir": "shared.state.irreversible_action",
    "vazio": "shared.accessibility.empty",
    "marcado": "shared.accessibility.checked",
    "desmarcado": "shared.accessibility.unchecked",

    # ── Catalog Component Short Names (sidebar items) ─────────────────────────
    "Raios e Sombras": "catalog.component.radii_shadows",
    "Tipografia": "catalog.component.typography",
    "Espaçamento": "catalog.component.spacing",
    "Botões": "catalog.component.buttons",
    "Textos": "catalog.component.texts",
    "Campos Rotulados": "catalog.component.labelled_fields",
    "Cards de Resultado": "catalog.component.result_cards",
    "Contador": "catalog.component.counter",
    "Botões Ícone": "catalog.component.icon_buttons",
    "Campo Senha": "catalog.component.password_field",
    "Botão Filtro": "catalog.component.filter_button",
    "Botão Menu": "catalog.component.menu_button",
    "Botões Sistema": "catalog.component.system_buttons",
    "Campo Telefone": "catalog.component.phone_field",
    "Grupo de Chips": "catalog.component.chip_group",
    "Botão Download": "catalog.component.download_button",

    # ── Catalog Examples (Real World) ─────────────────────────────────────────
    "10 features funcionais que demonstram o Zodiak Design System em uso real — formulários, listas, jogos e muito mais.": "catalog.examples.subtitle",
    "Calculadora de Notas": "catalog.examples.grades.name",
    "Calcula a média de 3 notas e indica aprovação ou reprovação.": "catalog.examples.grades.desc",
    "Desconto PIX": "catalog.examples.pix.name",
    "Aplica 5% de desconto em compras com PIX acima de R$ 1.000.": "catalog.examples.pix.desc",
    "Sistema de Votação": "catalog.examples.voting.name",
    "Votação com 3 candidatos, detecção de empate e segundo turno.": "catalog.examples.voting.desc",
    "Verificador de Palíndromo": "catalog.examples.palindrome.name",
    "Verifica se uma palavra ou frase é um palíndromo.": "catalog.examples.palindrome.desc",
    "Adivinhe o Número": "catalog.examples.guess.name",
    "Jogo interativo: adivinhe um número entre 1 e 100.": "catalog.examples.guess.desc",
    "Tabuada": "catalog.examples.multiplication.name",
    "Gera a tabuada de qualquer número de 1 a 10.": "catalog.examples.multiplication.desc",
    "Gerenciador de Pessoas": "catalog.examples.person_manager.name",
    "CRUD simples: adiciona e remove pessoas com nome e idade.": "catalog.examples.person_manager.desc",
    "Conversor de Temperatura": "catalog.examples.temperature.name",
    "Conversão bidirecional entre Celsius e Fahrenheit em tempo real.": "catalog.examples.temperature.desc",
    "Gerenciador de Tarefas": "catalog.examples.task_manager.name",
    "To-do list simples: adiciona, marca como feita e remove tarefas.": "catalog.examples.task_manager.desc",
    "Quiz Game": "catalog.examples.quiz_game.name",
    "Quiz multi-fase com 4 temas, feedback instant e placar final.": "catalog.examples.quiz_game.desc",

    # ── Catalog Component Short Subtitles ─────────────────────────────────────
    "Trilha de navegação + controle de páginas": "catalog.component.breadcrumb.subtitle_short",
    "Seleção única — RadioButton e RadioGroup genérico": "catalog.component.radio_button.subtitle_short",
    "Hint contextual via longpress — 4 posições": "catalog.component.tooltip.subtitle_short",
    "Avaliação por estrelas — input e display read-only": "catalog.component.rating.subtitle_short",
    "Faixa full-width — brand, info, success, warning, error": "catalog.component.banner.subtitle_short",

    # ── Catalog Section Names ─────────────────────────────────────────────────
    "Átomos": "catalog.section_name.atoms",
    "Moléculas": "catalog.section_name.molecules",
    "Organismos": "catalog.section_name.organisms",
    "Utilitários": "catalog.section_name.utilities",
    "Templates": "catalog.section_name.templates",

    # ── Catalog Component Names (DS item list) ────────────────────────────────
    "Badges": "catalog.component_name.badges",
    "Text Fields": "catalog.component_name.text_fields",
    "Tabs": "catalog.component_name.tabs",
    "Toggle": "catalog.component_name.toggle",
    "Chip": "catalog.component_name.chip",
    "Modal": "catalog.component_name.modal",
    "Show More": "catalog.component_name.show_more",
    "Avatar": "catalog.component_name.avatar",
    "Search Field": "catalog.component_name.search_field",
    "Progress Indicator": "catalog.component_name.progress_indicator",
    "Alert": "catalog.component_name.alert",
    "Accordion": "catalog.component_name.accordion",
    "Step Indicator": "catalog.component_name.step_indicator",
    "Toast": "catalog.component_name.toast",
    "Empty State": "catalog.component_name.empty_state",
    "Skeleton Loader": "catalog.component_name.skeleton_loader",
    "Radio Button": "catalog.component_name.radio_button",
    "Tooltip": "catalog.component_name.tooltip",
    "Breadcrumb & Pagination": "catalog.component_name.breadcrumb_pagination",
    "Rating": "catalog.component_name.rating",
    "Banner": "catalog.component_name.banner",
    "Checkbox": "catalog.component_name.checkbox",
    "Pin": "catalog.component_name.pin",
    "Slide to Submit": "catalog.component_name.slide_to_submit",
    "Action Compositions": "catalog.composition_name.action_compositions",
    "Card Variants": "catalog.composition_name.card_variants",
    "Input Wizard": "catalog.composition_name.input_wizard",
    "Link Ribbon": "catalog.component_name.link_ribbon",
    "Professional Contact": "catalog.component_name.professional_contact",
    "Share Story": "catalog.component_name.share_story",

    # ── New DS Additions ──────────────────────────────────────────────────────
    "Concluir": "shared.action.finish",
    "Voltar": "shared.action.back",
    "Passo %d de %d": "shared.format.step_progress",
    "Passo %d%@": "shared.format.step_with_state",
    ", atual": "shared.accessibility.step_current",
    ", concluído": "shared.accessibility.step_completed",
    "Toque para colapsar": "shared.action.tap_to_collapse",
    "Toque para revelar detalhes": "shared.action.tap_to_reveal",
    "Marcador de localização para imagens, mapas e canvas": "catalog.component.pin.subtitle_short",
    "Author · Horizontal · Tall · Typographic · Reveal · Short Facts": "catalog.component.card_variants.subtitle_short",
    "Formulário multi-etapas com barra de progresso persistente": "catalog.component.input_wizard.subtitle_short",
    "Composição para promover e compartilhar uma história ou notícia nas redes.": "catalog.component.share_story.subtitle",
    "Wizard concluído!": "shared.state.wizard_completed",
    "Reiniciar": "shared.action.restart",
    "Criar Projeto": "shared.action.create_project",
    "Especificações": "catalog.section.specifications",

    # ── Missing Keys ──────────────────────────────────────────────────────────
    "Notícia": "shared.content.news",
    "Podcast": "shared.content.podcast",
    "Compartilhar": "shared.action.share",
    "Próximo": "shared.action.next",
    "Buscar país": "shared.placeholder.search_country",
    "Anterior": "shared.action.previous",
    "Subir": "shared.action.move_up",
    "Descer": "shared.action.move_down",
    "Mostrar mais": "shared.action.show_more",
    "Mostrar menos": "shared.action.show_less",
    "%@, %d itens ocultos": "shared.format.hidden_items",
    "Toque para recolher": "shared.action.tap_to_collapse_alt",
    "Toque para expandir": "shared.action.tap_to_expand",
    "Fechar notificação": "shared.action.close_notification",
    "Filtros": "shared.label.filters",
    "Filtros — %d ativo(s)": "shared.format.filters_active",
    "Toque para abrir os filtros": "shared.action.tap_to_open_filters",
    "Toque para ver as opções": "shared.action.tap_to_view_options",
    "Ação destrutiva": "shared.state.destructive_action",
    "Fechar": "shared.action.close",
    "Fechar menu": "shared.action.close_menu",
    "Abrir menu": "shared.action.open_menu",
    "00 00000-0000": "shared.placeholder.phone_number",
    "Código do País": "shared.label.country_code",
    "Selecione": "shared.action.select",
    "Erro: %@": "shared.format.error",
    "%d de %d estrelas": "shared.format.stars_rating",
    "Péssimo": "shared.rating.terrible",
    "Ruim": "shared.rating.poor",
    "Regular": "shared.rating.average",
    "Bom": "shared.rating.good",
    "Excelente": "shared.rating.excellent",
    "selecionado": "shared.accessibility.selected",
    "não selecionado": "shared.accessibility.not_selected",
    "ligado": "shared.accessibility.on",
    "desligado": "shared.accessibility.off",
    "Abre link externo": "shared.accessibility.opens_external_link",
    "Toque para ver as opções de download": "shared.action.tap_to_view_download",
    "Deslize para confirmar": "shared.action.slide_to_confirm",
    "Fechar aviso": "shared.action.close_notice",
    "%@: %@%@": "shared.format.label_value_suffix",
    "Figma: %@": "shared.format.figma_link",
    "Multi-select (%d selecionado(s))": "shared.format.multi_select_count",
    "Dias disponíveis (%d/3)": "shared.format.available_days",
    "Lista de projetos (%d itens, mostrando %d)": "shared.format.project_list",
    "Inicial: %d": "shared.format.initial_count",
    "Equipe (%d membros)": "shared.format.team_members",
    "Ver toda a equipe": "shared.action.view_full_team",
    "Recolher": "shared.action.collapse",
    "Usado em: %@": "shared.format.used_in",
    "Playground — %d cards, mostrando %d": "shared.format.playground_cards",
    "Playground — %d de %d": "shared.format.playground_progress",
    "Style: %@": "shared.format.style",
    "Size: %@": "shared.format.size",
    "Confirmado às %@": "shared.format.confirmed_at",
    "Pagination — %d de 12": "shared.format.pagination",
    "Query: \"%@\"": "shared.format.query",
    "Ação selecionada: \"%@\"": "shared.format.selected_action",
    "Avaliação: %d / 5": "shared.format.rating_value",
    "(%.1f)": "shared.format.decimal",
    "Playground — %d%%": "shared.format.playground_percent",
    "Selecionado: %@": "shared.format.selected",
    "Países disponíveis (%d)": "shared.format.available_countries",
    "Ocultar senha": "shared.action.hide_password",
    "Mostrar senha": "shared.action.show_password",
    "Nenhum resultado": "shared.state.no_results",
    "Brasil": "shared.country.brazil",
    "Estados Unidos": "shared.country.usa",
    "Portugal": "shared.country.portugal",
    "França": "shared.country.france",
    "Alemanha": "shared.country.germany",
    "Espanha": "shared.country.spain",
    "Itália": "shared.country.italy",
    "Reino Unido": "shared.country.uk",
    "Canadá": "shared.country.canada",
    "Argentina": "shared.country.argentina",
    "Chile": "shared.country.chile",
    "México": "shared.country.mexico",
    "Colômbia": "shared.country.colombia",
    "Japão": "shared.country.japan",
    "China": "shared.country.china",
    "Índia": "shared.country.india",
    "Austrália": "shared.country.australia",
    "Casos de uso": "catalog.section.use_cases",
    "Use para ações que exigem confirmação intencional do usuário — prevenindo cliques acidentais.": "catalog.slide_to_submit.use_case_desc",
    "Comportamentos": "catalog.section.behaviors",
    "Ação confirmada via slide.": "catalog.slide_to_submit.confirmed_desc",
    "Exemplos interativos": "catalog.section.interactive_examples",
    "Toque no código do país para abrir o seletor.": "catalog.phone_input.selector_hint",
    "Ex: Ana Silva": "shared.placeholder.ex_name",
    "usuario@email.com": "shared.placeholder.email",
    "Ex: 7.5": "shared.placeholder.ex_decimal",
    "Ex: 25": "shared.placeholder.ex_age",
    "Min. 3 caracteres": "shared.placeholder.min_chars",
    "Ativar notificações": "shared.label.enable_notifications",
    "Ex: Redesign Zodiak": "shared.placeholder.ex_project_name",
    "Breve resumo do projeto": "shared.placeholder.project_summary",
    "dd/mm/aaaa": "shared.placeholder.date",
    "iOS, Android, Web": "shared.placeholder.platforms",
    "0.00": "shared.placeholder.decimal_zero",
    "Variantes": "catalog.section.variants",
    "Descartável (isDismissible)": "catalog.section.dismissible",
    "Apenas título": "catalog.section.title_only",
    "Exemplo básico": "catalog.section.basic_example",
    "Com ícone e subtítulo": "catalog.section.with_icon_subtitle",
    "Todos os tokens de espaçamento seguem a base 8pt. Use ZodiakSpacing._3XS (4pt) a ZodiakSpacing._8XL (176pt).": "catalog.spacing.scale_desc",
    "• Contraste mínimo 4.5:1 para texto normal": "catalog.accessibility.contrast_hint",
    "• Touch targets mínimos de 44×44pt": "catalog.accessibility.touch_targets_hint",
    "• Use .accessibilityLabel() para ícones sem texto": "catalog.accessibility.icon_label_hint",
    "4 steps": "catalog.step_indicator.example_4steps",
    "5 steps — todos concluídos": "catalog.step_indicator.example_5steps_done",
    "Estados de cada step": "catalog.section.step_states",
    "Single-select": "catalog.section.single_select",
    "Máximo de seleções (máx. 3)": "catalog.chip_group.max_selections_label",
    "Após 3 seleções, chips adicionais são bloqueados.": "catalog.chip_group.max_selections_desc",
    "Chips para filtros (input)": "catalog.section.chips_for_filters",
    "Nenhum filtro aplicado — toque para ativar.": "catalog.filter_button.no_filter_desc",
    "Tamanhos": "catalog.section.sizes",
    "Variantes de conteúdo": "catalog.section.content_variants",
    "Iniciais": "catalog.section.initials",
    "Ícone padrão": "catalog.section.default_icon",
    "Empresa": "catalog.section.company",
    "Empilhamento de múltiplos avatares com contagem de overflow.": "catalog.avatar.group_desc",
    "Para ações destrutivas em interfaces de produto digital.": "catalog.system_button.warning_desc",
    "Quando usar vs. ZodiakButton": "catalog.section.when_to_use_vs_zodiak",
    "Trilha de navegação hierárquica.": "catalog.breadcrumb.desc",
    "Toque nas setas ou números para navegar.": "catalog.pagination.nav_hint",
    "Variantes de total": "catalog.section.total_variants",
    "5 páginas": "catalog.pagination.example_5pages",
    "100 páginas (página 50)": "catalog.pagination.example_100pages",
    "Digite aqui": "shared.placeholder.type_here",
    "Texto de ajuda": "catalog.text_field.helper_text",
    "Campo com atenção": "catalog.text_field.warning_state",
    "Campo obrigatório": "catalog.text_field.required_state",
    "Campo válido": "catalog.text_field.valid_state",
    "Não editável": "catalog.text_field.readonly_state",
    "O design é comunicação.": "catalog.typography.example_sentence",
    "Repouso (sem foco)": "catalog.section.resting_state",
    "Pesquisar...": "shared.placeholder.search",
    "Com conteúdo + botão clear": "catalog.section.with_content_clear",
    "Nenhum filtro ativo — toque no botão acima.": "catalog.filter_button.inactive_desc",
    "Padrão": "catalog.section.default",
    "Ativo (2)": "catalog.section.active_2",
    "Ativo (9)": "catalog.section.active_9",
    "Quando usar": "catalog.section.when_to_use",
    "Playground — pressione e segure": "catalog.section.playground_press_hold",
    "Segure por 0.3s para exibir o tooltip. Dispensa após 2.5s.": "catalog.tooltip.hold_hint",
    "Via .zodiakTooltip() modifier": "catalog.tooltip.api_note",
    "Variantes por estilo": "catalog.section.variants_by_style",
    "Botão dedicado para fechar overlays, modais e banners.": "catalog.icon_button.close_desc",
    "CTAs de navegação com seta direcional. Sem fundo — hierarquia mínima.": "catalog.icon_button.arrow_desc",
    "Campo obrigatório — erro de validação": "catalog.section.required_validation_error",
    "Valor fora do intervalo permitido": "catalog.section.out_of_range_error",
    "Toque no header para expandir/colapsar.": "catalog.accordion.expand_hint",
    "Tap no backdrop fecha o modal. Botão X é opcional.": "catalog.modal.backdrop_hint",
    "Adapta o 'Form in drawer' (desktop = direita) para iOS (bottom = baixo).": "catalog.modal.bottom_sheet_desc",
    "Conteúdo do modal. Adicione qualquer view SwiftUI aqui.": "catalog.modal.content_hint",
    "Esta é uma mensagem informativa apresentada em um modal com título e botão de fechar.": "catalog.modal.info_example",
    "Esta ação é permanente e não pode ser desfeita.": "catalog.modal.destructive_example",
    "Digite sua senha": "shared.placeholder.password",
    "Opção única — download direto": "catalog.download_button.single_option_desc",
    "Quando há apenas uma opção, o download é disparado diretamente sem abrir sheet.": "catalog.download_button.single_option_hint",
    "Múltiplas opções — abre bottom sheet": "catalog.download_button.multiple_options_desc",
    "Toque para abrir o seletor de formato. Figma: bottom sheet no mobile.": "catalog.download_button.multiple_options_hint",
    "Contextos de uso": "catalog.section.usage_contexts",
    "✓ Aprovado": "shared.state.passed_decorated",
    "✗ Reprovado": "shared.state.failed_decorated",
    "Playground": "catalog.section.playground",
    "Comportamento": "catalog.section.behavior",
    "Radio Group — plano de assinatura": "catalog.radio_button.group_example",
    "Desabilitado": "catalog.section.disabled",
    "Botões individuais": "catalog.section.individual_buttons",
    "Mínimo 8 caracteres": "shared.placeholder.min_password_chars",
    "Repita a senha acima": "shared.placeholder.repeat_password",
    "Todos os estados": "catalog.section.all_states",
    "Sem helper": "catalog.section.without_helper",
    "Rating interativo": "catalog.section.interactive_rating",
    "Toque em uma estrela para selecionar. Toque novamente para desmarcar.": "catalog.rating.interactive_hint",
    "Exemplo em contexto": "catalog.section.example_in_context",
    "Como avalia sua experiência?": "catalog.rating.context_question",
    "Exibe avaliações de double com suporte a meias estrelas.": "catalog.rating.display_desc",
    "Variantes de cor": "catalog.section.color_variants",
    "Spinner indeterminado": "catalog.section.indeterminate_spinner",
    "Use quando o progresso é desconhecido.": "catalog.progress.indeterminate_hint",
    "Selecione os filtros": "shared.label.select_filters",
    "Tira horizontal de links de navegação rápida. Ideal para rodapés, sidebars e seções.": "catalog.action_compositions.link_ribbon_desc",
    "Card de contato profissional com avatar, nome, cargo, empresa e ações de comunicação.": "catalog.action_compositions.contact_card_desc",
    "Com botão de ação (CTA)": "catalog.section.with_cta_button",
    "Toque no × para dispensar.": "catalog.banner.dismiss_hint",
    "Demonstração": "catalog.section.demonstration",
    "Mostrar skeleton (simulação de loading)": "catalog.skeleton_loader.show_simulation",
    "Lista de registros": "catalog.section.records_list",
    "Analista · Capgemini": "catalog.skeleton_loader.example_role",
    "Grid de cards": "catalog.section.card_grid",
    "Artigo · 5 min": "catalog.skeleton_loader.example_content",
    "Containers de Form": "catalog.section.form_containers",
    "Container que posiciona pins sobre uma imagem ou fundo. Toque num pin para exibir o callout.": "catalog.pin.container_desc",
    "Contextos comuns": "catalog.section.common_contexts",
    "O toast aparece na parte inferior e é dispensado automaticamente após 3s.": "catalog.toast.auto_dismiss_desc",
    "Toast com ação": "catalog.section.toast_with_action",
    "Inclui um botão de ação inline (ex: Desfazer).": "catalog.toast.action_desc",
    "Como usar": "catalog.section.how_to_use",
    "1 coluna": "catalog.card_grid.one_column",
    "2 colunas": "catalog.card_grid.two_columns",
    "Anatomia do card": "catalog.section.card_anatomy",
    "Grid de autores — avatar + nome + cargo + data + tópico.": "catalog.card_variants.author_card_desc",
    "Imagem à esquerda, texto à direita. Layout compacto para feeds e listas.": "catalog.card_variants.horizontal_card_desc",
    "Card full-width com imagem grande e texto sobreposto na base.": "catalog.card_variants.tall_card_desc",
    "Sem imagem. Hierarquia tipográfica com linha de destaque colorida.": "catalog.card_variants.typographic_card_desc",
    "Card com texto escondido revelado ao toque. Toque para expandir/colapsar.": "catalog.card_variants.reveal_card_desc",
    "Grid de estatísticas compactas com ícone colorido, valor e rótulo.": "catalog.card_variants.short_facts_desc",
    "Pesquisar componentes...": "catalog.component_search.placeholder",
    "Capgemini Blue principal": "catalog.color.capgemini_blue_primary",
    "Laranja Capgemini": "catalog.color.capgemini_orange",
    "Fundo de página": "catalog.color.page_background",
    "Cards e modais": "catalog.color.cards_modals",
    "Hover states": "catalog.color.hover_states",
    "Overlays escuros": "catalog.color.dark_overlays",
    "Azul escuro": "catalog.color.dark_blue",
    "Azul vibrante": "catalog.color.vibrant_blue",
    "Sucesso — verde": "catalog.color.success_green",
    "Erro — vermelho": "catalog.color.error_red",
    "Texto principal": "catalog.color.primary_text",
    "Texto secundário": "catalog.color.secondary_text",
    "Texto invertido": "catalog.color.inverse_text",
    "Links": "catalog.color.links",
    "Erro e alerta": "catalog.color.error_warning",
    "Botões, links — padrão": "catalog.color.buttons_links_default",
    "Conteúdo desabilitado": "catalog.color.disabled_content",
    "Active / selecionado": "catalog.color.active_selected",
    "Warning primário": "catalog.color.warning_primary",
    "Warning secundário": "catalog.color.warning_secondary",
    "Warning hover": "catalog.color.warning_hover",
    "Bordas normais": "catalog.color.default_borders",
    "Bordas sutis": "catalog.color.subtle_borders",
    "29 tokens semânticos com suporte automático a light/dark mode via Color Assets.": "catalog.color.token_count_desc",
    "Preview modo escuro": "catalog.color.dark_mode_preview",
    "Semânticos": "catalog.section.semantic",
    "Ramps primitivas — use apenas via tokens semânticos.": "catalog.color.primitive_ramps_desc",
    "Base unit 8pt · 14 tokens de escala + 9 aliases semânticos.": "catalog.spacing.token_count_desc",
    "Escala de tokens": "catalog.spacing.token_scale",
    "Escala horizontal": "catalog.spacing.horizontal_scale",
    "Cada barra tem a largura exata do token em pontos.": "catalog.spacing.horizontal_desc",
    "Escala vertical": "catalog.spacing.vertical_scale",
    "Cada coluna tem a altura exata do token em pontos.": "catalog.spacing.vertical_desc",
    "Aliases semânticos": "catalog.spacing.semantic_aliases",
    "Nomes de uso interno nos componentes — barras com tamanho exato.": "catalog.spacing.aliases_desc",
    "Padding mínimo — badge, chip": "catalog.spacing.alias_min_padding",
    "Padding interno de campo e card": "catalog.spacing.alias_field_padding",
    "Padding padrão de tela/seção": "catalog.spacing.alias_screen_padding",
    "Padding iPad/landscape": "catalog.spacing.alias_ipad_padding",
    "Gap entre botões em grupo": "catalog.spacing.alias_button_gap",
    "Altura de botão Small": "catalog.spacing.alias_button_small",
    "Altura de botão Medium": "catalog.spacing.alias_button_medium",
    "Altura de botão Large": "catalog.spacing.alias_button_large",
    "Altura padrão de TextField": "catalog.spacing.alias_textfield",
    "Typeface Ubuntu — Light (300) e Regular (400). Fallback: SF Pro.": "catalog.typography.typeface_desc",
    "Texto personalizado": "catalog.typography.custom_text_label",
    "Digite um texto": "catalog.typography.custom_text_placeholder",
    "Veja seu texto em todos os estilos abaixo →": "catalog.typography.preview_hint",
    "Escala tipográfica": "catalog.typography.scale_label",
    "4 tokens de corner radius + 1 shadow oficial do Zodiak.": "catalog.radii.token_count_desc",
    "Inputs, badges, chips — 4pt": "catalog.radii.xs_desc",
    "Cards, containers — 16pt": "catalog.radii.m_desc",
    "Modais, painéis grandes — 32pt": "catalog.radii.xl_desc",
    "Pill shape — todos os botões — 999pt": "catalog.radii.pill_desc",
    "O Zodiak usa um único shadow oficial — flat design.": "catalog.shadow.single_desc",
    "Mostrar shadow": "catalog.shadow.show_label",
    "Sem Shadow": "catalog.shadow.without_label",
    "Com Shadow Zodiak": "catalog.shadow.with_label",
    "Especificação": "catalog.section.specification",
    "ZodiakResultCard e ZodiakResultCardWithBadge — exibem resultado com título, valor grande e subtítulo opcional.": "catalog.result_card.desc",
    "Cor do badge": "catalog.section.badge_color",
    "Uso nos Exemplos": "catalog.section.usage_in_examples",
    "Este componente é usado em: Notas, PIX Desconto, Palíndromo, Adivinhe e Temperatura.": "catalog.result_card.usage_desc",
    "ZodiakChip — pill shape (radius 999pt) com estado ativo/inativo. Ideal para filtros e tags.": "catalog.chip.full_desc",
    "Seleção única — interativo": "catalog.section.single_select_interactive",
    "Toque em um chip para ativá-lo e desativar os demais.": "catalog.chip.single_select_hint",
    "Multi-seleção — interativo": "catalog.section.multi_select_interactive",
    "Toque para ativar/desativar filtros múltiplos.": "catalog.chip.multi_select_hint",
    "Moléculas que combinam label, input e mensagens de erro — ZodiakLabelledField, ZodiakLabelledNumericField e ZodiakLabelledCheckbox.": "catalog.labelled_field.desc",
    "Campo de texto com label e suporte a mensagem de erro.": "catalog.labelled_field.text_field_desc",
    "Campo numérico com validação de range embutida.": "catalog.labelled_field.numeric_field_desc",
    "Checkbox com label e feedback acessível.": "catalog.labelled_field.checkbox_desc",
    "Playground — Validação": "catalog.section.playground_validation",
    "ZodiakToggle — switch com label em bold e tint actionPrimary.": "catalog.toggle.desc",
    "Exemplos": "catalog.section.examples",
    "Receber notificações": "shared.label.receive_notifications",
    "ZodiakToggle é usado no PIX Desconto (ativar pagamento com Pix) e no catálogo (dark mode).": "catalog.toggle.usage_desc",
    "ZodiakCounterControl — controle de incremento/decremento com min, max e step configuráveis.": "catalog.counter.desc",
    "Configuração": "catalog.section.configuration",
    "ZodiakCounterControl é usado no jogo Adivinhe o Número para exibir e controlar o número de tentativas.": "catalog.counter.usage_desc",
    "ZodiakTextField e ZodiakNumericField com 4 tipos de helper text tipado.": "catalog.text_field.full_desc",
    "Playground — Helper State": "catalog.section.playground_helper",
    "Selecionar estado do helper": "catalog.text_field.select_helper_state",
    "Todos os helper states": "catalog.section.all_helper_states",
    "Estado desabilitado": "catalog.section.disabled_state",
    "Cores de texto": "catalog.section.text_colors",
    "Combinações de uso": "catalog.section.usage_combinations",
    "Habilitado": "catalog.section.enabled",
    "ZodiakTabs (Small e Medium) e ZodiakTabContainer — máximo 7 tabs, barra inferior indicadora.": "catalog.tabs.desc",
    "Usa ZodiakTypography.caption. Ideal para filtros e sub-seções.": "catalog.tabs.small_desc",
    "Usa ZodiakTypography.bodySmall. Ideal para navegação principal dentro de uma tela.": "catalog.tabs.medium_desc",
    "Combina ZodiakTabs com conteúdo em uma única view.": "catalog.tabs.container_desc",
    "Galeria de cores Zodiak.": "catalog.color.gallery_desc",
    "Lista de componentes disponíveis.": "catalog.component_list.desc",
    "ZodiakDisabledTabItem — read-only sem interação.": "catalog.tabs.disabled_desc",
    "Utilitários Zodiak: modificadores de view, button styles e extensões para acessibilidade e interação.": "catalog.utilities.desc",
    "Sem cardStyle": "catalog.section.without_card_style",
    "Com .cardStyle()": "catalog.section.with_card_style",
    "Texto normal": "catalog.section.normal_text",
    "ZodiakFormWrapper (simples) e ZodiakFormContainer (adaptativo iPad/iPhone) — agrupam campos com padding e background Zodiak.": "catalog.form_container.full_desc",
    "VStack com padding xs, fundo surface, radius S. Padrão para formulários em telas de features.": "catalog.form_container.wrapper_desc",
    "Aceitar termos": "shared.label.accept_terms",
    "Adaptativo: padding maior em iPad (regular width). Ideal para formulários complexos.": "catalog.form_container.adaptive_desc",
    "ZodiakInfoRow — linha de label | valor para exibir dados em pares. Fundo surface, radius S.": "catalog.info_row.desc",
    "Em lista — Tabuada do 7": "catalog.info_row.list_example",

    # ── List Gallery ──────────────────────────────────────────────────────────
    "Lista": "catalog.component_name.list",
    "Não-ordenada (unordered)": "catalog.list.unordered_label",
    "Usar quando a ordem dos itens não importa.": "catalog.list.unordered_hint",
    "Ordenada (ordered)": "catalog.list.ordered_label",
    "Usar para sequências, passos ou hierarquia de prioridade.": "catalog.list.ordered_hint",
    "Sem headline": "catalog.list.without_headline",
    "Manter itens curtos e escaneáveis": "catalog.list.guideline_short",
    "Preservar gramática paralela": "catalog.list.guideline_parallel",
    "Primeiro item sem headline": "catalog.list.example_first_item",
    "Segundo item sem headline": "catalog.list.example_second_item",
    "Esquerda (padrão)": "catalog.list.alignment_left",
    "Alinhado à esquerda": "catalog.list.aligned_left",
    "Linha decorativa": "catalog.list.decorative_line",
    "Opcional — show/hide via parâmetro": "catalog.list.optional_headline_hint",

    # ── Zodiak Compositions ───────────────────────────────────────────────────
    "Hero Fullscreen": "catalog.composition_name.hero_fullscreen",
    "Hero Tipográfico": "catalog.composition_name.hero_typographic",
    "Seção de Título": "catalog.composition_name.headline_section",
    "Bloco de Texto": "catalog.composition_name.text_block",
    "Podcast Grande": "catalog.composition_name.podcast_large",
    "Vídeo e Texto": "catalog.composition_name.video_text",
    "Imagem e Texto Simétrico": "catalog.composition_name.image_text_symmetric",
    "Preenche toda a área disponível com overlay escuro para máximo impacto visual.": "catalog.composition.hero_fullscreen_desc",
    "Sem foto de fundo — tipografia e shape geométrico são os protagonistas. 5 variantes de forma.": "catalog.composition.hero_typographic_desc",
    "Cabeçalho reutilizável que encabeça card grids, key figures e demais composições.": "catalog.composition.headline_section_desc",
    "Estrutura de conteúdo textual com heading opcional em dois níveis.": "catalog.composition.text_block_desc",
    "Player full-width com imagem de topo, descrição longa e controles de playback.": "catalog.composition.podcast_large_desc",
    "Vídeo com título e descrição. Lado-a-lado em iPad, empilhado em iPhone.": "catalog.composition.video_text_desc",
    "Layout 50/50 entre imagem e texto. Lado-a-lado em iPad, empilhado em iPhone.": "catalog.composition.image_text_symmetric_desc",
    "Ativas apenas em iPad (horizontalSizeClass == .regular)": "catalog.composition.ipad_only_hint",
    "Duas colunas: Ativo apenas em iPad (horizontalSizeClass == .regular)": "catalog.composition.two_columns_ipad_hint",
    "Ativo apenas em iPad (horizontalSizeClass == .regular)": "catalog.composition.ipad_active_hint",
    "Vídeo à esquerda · Vídeo à direita": "catalog.composition.video_orientation_label",
    "Vídeo à esquerda": "catalog.composition.video_left",
    "Vídeo à direita": "catalog.composition.video_right",
    "Split 50/50 lado a lado": "catalog.composition.split_side_by_side",
    "Empilhado verticalmente": "catalog.composition.stacked_vertically",
    "Adaptativa ao conteúdo de texto": "catalog.composition.adaptive_to_text",
    "Altura da imagem": "catalog.composition.image_height_label",
    "Altura mínima 560pt": "catalog.composition.min_height_560",
    "Altura mínima 420pt": "catalog.composition.min_height_420",
    "Lado a lado 50/50": "catalog.composition.side_by_side_50",
    "Imagem 280pt de altura": "catalog.composition.image_280pt",
    "Imagem 200pt de altura": "catalog.composition.image_200pt",
    "Shape: Decorativo — sem assets externos": "catalog.composition.shape_decorative_hint",
    "Fonte headline — iPhone usa title1": "catalog.composition.headline_font_hint",
    "Assistir": "shared.action.watch",

    # ── Common catalog labels still in natural language ────────────────────────
    "Superfície névoa": "catalog.color.surface_fog",
    "Com imagem": "catalog.section.with_image",
    "À esquerda": "catalog.section.left_aligned",
    "Duas colunas": "catalog.section.two_columns",
    "Orientação": "catalog.section.orientation",
    "Controles": "catalog.section.controls",
    "Variante": "catalog.section.variant",
    "Fundo": "catalog.section.background",
    "Posição": "catalog.section.position",
    "Aspecto": "catalog.section.aspect",
    "Navegação": "catalog.section.navigation",
    "Conteúdo": "catalog.section.content",
    "Progresso": "catalog.section.progress",

    # ── Misc catalog items still as natural-language ───────────────────────────
    "O Zodiak DS é o sistema de design oficial da Capgemini. Ele fornece um conjunto de componentes, tokens de design e diretrizes para criar experiências digitais consistentes e acessíveis.": "catalog.accordion.about_desc",
    "Use sempre os tokens semânticos em vez de cores primitivas:": "catalog.accordion.token_hint_title",
    "• ZodiakColors.textPrimary (não use #171a22 direto)": "catalog.accordion.token_hint_1",
    "• ZodiakColors.actionPrimary para interações": "catalog.accordion.token_hint_2",
    "Isso garante suporte automático a dark mode.": "catalog.accordion.token_hint_3",
    "Toque no × para dispensar o alerta.": "catalog.alert.dismiss_hint",
    "System Warning Button": "catalog.component_name.system_warning_button",
    "Quando usar vs. ZodiakButton": "catalog.section.when_to_use_vs",
    "Ler mais": "shared.action.read_more",
    "Página inicial": "shared.nav.home",
    "Sobre nós": "shared.nav.about",
    "Serviços": "shared.nav.services",
    "Contato": "shared.nav.contact",
    "Carreiras": "shared.nav.careers",
    "Estilos e tamanhos": "catalog.section.styles_and_sizes",
}

# ─────────────────────────────────────────────────────────────────────────────
# HELPERS
# ─────────────────────────────────────────────────────────────────────────────

def parse_strings_file(path):
    """Parse a .strings file into an ordered list of (key, value, raw_line) tuples.
    Comments and blank lines are preserved as (None, None, raw_line).
    """
    entries = []
    with open(path, "r", encoding="utf-8") as f:
        content = f.read()

    # Match "key" = "value"; with multi-line awareness
    pattern = re.compile(
        r'"((?:[^"\\]|\\.)*)"\s*=\s*"((?:[^"\\]|\\.)*)";\s*',
        re.DOTALL
    )
    # Process line by line to preserve comments
    lines = content.split("\n")
    i = 0
    while i < len(lines):
        line = lines[i]
        stripped = line.strip()
        if stripped.startswith("//") or stripped == "":
            entries.append((None, None, line))
            i += 1
            continue
        # Try to parse key = value
        m = pattern.match(stripped)
        if m:
            key = m.group(1)
            value = m.group(2)
            entries.append((key, value, line))
            i += 1
        else:
            # Multi-line value — accumulate
            collected = stripped
            j = i + 1
            while j < len(lines) and '";' not in collected:
                collected += "\n" + lines[j].strip()
                j += 1
            m2 = pattern.match(collected + " ")
            if m2:
                key = m2.group(1)
                value = m2.group(2)
                entries.append((key, value, "\n".join(lines[i:j])))
                i = j
            else:
                entries.append((None, None, line))
                i += 1
    return entries


def write_strings_file(path, entries, mapping, is_ptbr):
    """Write a new .strings file applying the key mapping.
    
    For en.lproj: key changes but value stays the same.
    For pt-BR.lproj: key changes AND if the old value == old key (mirror),
                     the value stays as the original Portuguese translation.
    """
    lines_out = []
    for key, value, raw in entries:
        if key is None:
            lines_out.append(raw)
            continue
        # If key is already dot-notation (starts with catalog. or contains .)
        # and not in mapping as an old key, keep as-is
        new_key = mapping.get(key)
        if new_key is None:
            # Keep unchanged
            lines_out.append(f'"{escape(key)}" = "{escape(value)}";')
        else:
            lines_out.append(f'"{new_key}" = "{escape(value)}";')
    return "\n".join(lines_out)


def escape(s):
    """Escape quotes and backslashes for .strings format."""
    return s.replace("\\", "\\\\").replace('"', '\\"')


def unescape(s):
    """Unescape a .strings value."""
    return s.replace('\\"', '"').replace("\\\\", "\\")


def find_swift_files(roots):
    swift_files = []
    for root in roots:
        for dirpath, _, filenames in os.walk(root):
            for fn in filenames:
                if fn.endswith(".swift"):
                    swift_files.append(os.path.join(dirpath, fn))
    return sorted(swift_files)


def replace_in_swift(content, mapping):
    """Replace old localization keys with new dot-notation keys in Swift source."""
    changes = []
    # Sort by length descending to match longer keys first (avoid partial matches)
    sorted_map = sorted(mapping.items(), key=lambda x: len(x[0]), reverse=True)

    for old_key, new_key in sorted_map:
        # Escape for regex: the old key may contain special chars
        # We look for the key inside double quotes in Swift string contexts
        escaped_old = re.escape(old_key)
        # Match the key as a complete string literal (surrounded by ")
        # We use a pattern that matches "old_key" but NOT inside comments
        pattern = f'"{escaped_old}"'
        replacement = f'"{new_key}"'
        if pattern in content or old_key in content:
            new_content = content.replace(f'"{old_key}"', replacement)
            if new_content != content:
                changes.append((old_key, new_key))
                content = new_content

    return content, changes


# ─────────────────────────────────────────────────────────────────────────────
# MAIN
# ─────────────────────────────────────────────────────────────────────────────

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--dry-run", action="store_true",
                        help="Print changes without writing files")
    args = parser.parse_args()
    dry_run = args.dry_run

    print("=" * 70)
    print("ZodiakiOS Localization Migration")
    print(f"Mode: {'DRY RUN' if dry_run else 'LIVE'}")
    print("=" * 70)

    # ── Step 1: Update en.lproj ───────────────────────────────────────────────
    print("\n[1/4] Updating en.lproj/Localizable.strings ...")
    en_entries = parse_strings_file(EN_STRINGS)
    en_lines_out = []
    en_changes = 0
    for key, value, raw in en_entries:
        if key is None:
            en_lines_out.append(raw)
            continue
        new_key = MAPPING.get(key)
        if new_key and not key.startswith("catalog.") and not key.startswith("shared.") and not key.startswith("feature.") and not key.startswith("app."):
            en_lines_out.append(f'"{new_key}" = "{value}";')
            en_changes += 1
        else:
            en_lines_out.append(f'"{key}" = "{value}";')

    if not dry_run:
        with open(EN_STRINGS, "w", encoding="utf-8") as f:
            f.write("\n".join(en_lines_out))
    print(f"  → {en_changes} keys renamed in en.lproj")

    # ── Step 2: Update pt-BR.lproj ────────────────────────────────────────────
    print("\n[2/4] Updating pt-BR.lproj/Localizable.strings ...")
    ptbr_entries = parse_strings_file(PTBR_STRINGS)
    ptbr_lines_out = []
    ptbr_changes = 0
    for key, value, raw in ptbr_entries:
        if key is None:
            ptbr_lines_out.append(raw)
            continue
        new_key = MAPPING.get(key)
        if new_key and not key.startswith("catalog.") and not key.startswith("shared.") and not key.startswith("feature.") and not key.startswith("app."):
            ptbr_lines_out.append(f'"{new_key}" = "{value}";')
            ptbr_changes += 1
        else:
            ptbr_lines_out.append(f'"{key}" = "{value}";')

    if not dry_run:
        with open(PTBR_STRINGS, "w", encoding="utf-8") as f:
            f.write("\n".join(ptbr_lines_out))
    print(f"  → {ptbr_changes} keys renamed in pt-BR.lproj")

    # ── Step 3: Update Swift files ────────────────────────────────────────────
    print("\n[3/4] Updating Swift files ...")
    swift_files = find_swift_files(SWIFT_ROOTS)
    total_swift_changes = 0
    files_changed = 0

    for swift_path in swift_files:
        with open(swift_path, "r", encoding="utf-8") as f:
            original = f.read()
        updated, changes = replace_in_swift(original, MAPPING)
        if changes:
            files_changed += 1
            total_swift_changes += len(changes)
            rel_path = os.path.relpath(swift_path, ROOT)
            print(f"  {rel_path}:")
            for old, new in changes:
                print(f"    \"{old}\" → \"{new}\"")
            if not dry_run:
                with open(swift_path, "w", encoding="utf-8") as f:
                    f.write(updated)

    print(f"\n  → {total_swift_changes} replacements in {files_changed} Swift files")

    # ── Step 4: Summary ───────────────────────────────────────────────────────
    print("\n[4/4] Summary")
    print(f"  .strings keys renamed : {en_changes}")
    print(f"  Swift replacements    : {total_swift_changes}")
    print(f"  Swift files modified  : {files_changed}")
    if dry_run:
        print("\n  DRY RUN complete — no files written.")
    else:
        print("\n  Migration complete. Run 'xcodebuild build' and 'swiftlint lint' to verify.")


if __name__ == "__main__":
    main()
