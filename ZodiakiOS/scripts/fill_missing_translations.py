#!/usr/bin/env python3
"""
Fill missing en + pt-BR translations for all 194 Phase-3 keys.
Run: python3 scripts/fill_missing_translations.py
"""
import json
from pathlib import Path

XCSTRINGS_PATH = Path("/Users/mrocha/Developer/ZodiakiOS/ZodiakiOS/Localizable.xcstrings")

# (key) → (en_value, ptbr_value)
TRANSLATIONS = {
    # ── shared.action ────────────────────────────────────────────────────────
    "shared.action.advance":           ("Advance",                     "Avançar"),
    "shared.action.archive":           ("Archive",                     "Arquivar"),
    "shared.action.clear_all":         ("Clear All",                   "Limpar tudo"),
    "shared.action.clear_filters":     ("Clear Filters",               "Limpar filtros"),
    "shared.action.close_player":      ("Close Player",                "Fechar player"),
    "shared.action.decrease":          ("Decrease",                    "Diminuir"),
    "shared.action.delete":            ("Delete",                      "Excluir"),
    "shared.action.duplicate":         ("Duplicate",                   "Duplicar"),
    "shared.action.edit":              ("Edit",                        "Editar"),
    "shared.action.expand":            ("Expand",                      "Expandir"),
    "shared.action.forward_15s":       ("Skip Forward 15s",            "Avançar 15 segundos"),
    "shared.action.hide":              ("Hide",                        "Ocultar"),
    "shared.action.increase":          ("Increase",                    "Aumentar"),
    "shared.action.login":             ("Log In",                      "Entrar"),
    "shared.action.more_options":      ("More Options",                "Mais opções"),
    "shared.action.mute":              ("Mute",                        "Silenciar"),
    "shared.action.next_track":        ("Next Track",                  "Próxima faixa"),
    "shared.action.ok":                ("OK",                          "OK"),
    "shared.action.pause":             ("Pause",                       "Pausar"),
    "shared.action.pause_preview":     ("Pause Preview",               "Pausar prévia"),
    "shared.action.play":              ("Play",                        "Reproduzir"),
    "shared.action.play_preview":      ("Play Preview",                "Reproduzir prévia"),
    "shared.action.previous_track":    ("Previous Track",              "Faixa anterior"),
    "shared.action.reset":             ("Reset",                       "Resetar"),
    "shared.action.rewind":            ("Rewind",                      "Rebobinar"),
    "shared.action.rewind_15s":        ("Skip Back 15s",               "Voltar 15 segundos"),
    "shared.action.save":              ("Save",                        "Salvar"),
    "shared.action.schedule_meeting":  ("Schedule Meeting",            "Agendar reunião"),
    "shared.action.shuffle":           ("Shuffle",                     "Aleatório"),
    "shared.action.stop":              ("Stop",                        "Parar"),
    "shared.action.submit_rating":     ("Submit Rating",               "Enviar avaliação"),
    "shared.action.tap_for_details":   ("Tap to View Details",         "Toque para ver detalhes"),
    "shared.action.understood":        ("Got It",                      "Entendido"),
    "shared.action.volume_max":        ("Maximum Volume",              "Volume máximo"),
    "shared.action.volume_min":        ("Minimum Volume",              "Volume mínimo"),
    # ── shared.state ─────────────────────────────────────────────────────────
    "shared.state.active":              ("Active",       "Ativo"),
    "shared.state.attention":           ("Attention",    "Atenção"),
    "shared.state.completed":           ("Completed",    "Concluído"),
    "shared.state.confirmed":           ("Confirmed!",   "Confirmado!"),
    "shared.state.contact_soon":        ("We'll be in touch soon.",                          "Em breve entraremos em contato."),
    "shared.state.error_label":         ("Error",        "Erro"),
    "shared.state.in_progress":         ("In Progress",  "Em andamento"),
    "shared.state.info_label":          ("Info",         "Informação"),
    "shared.state.logging_in":          ("Logging in…",  "Entrando…"),
    "shared.state.login_failed":        ("Login Failed", "Falha no login"),
    "shared.state.new_badge":           ("New",          "Novo"),
    "shared.state.operation_success":   ("Operation completed successfully",  "Operação realizada com sucesso"),
    "shared.state.process_error":       ("Processing Error",                  "Erro ao processar"),
    "shared.state.registration_success":("Registration completed successfully","Cadastro realizado com sucesso"),
    "shared.state.review":              ("Review",       "Revisão"),
    "shared.state.save_failed":         ("Could not save changes. Please try again later.",
                                         "Não foi possível salvar as alterações. Tente novamente mais tarde."),
    "shared.state.send_error":          ("Send Error",   "Erro ao enviar"),
    "shared.state.sending":             ("Sending…",     "Enviando…"),
    "shared.state.sent_success":        ("Sent Successfully!", "Enviado com sucesso!"),
    "shared.state.session_expiring":    ("Session expiring in 5 minutes", "Sessão expirando em 5 minutos"),
    "shared.state.success_label":       ("Success",      "Sucesso"),
    "shared.state.warning_label":       ("Warning",      "Aviso"),
    # ── shared.validation ────────────────────────────────────────────────────
    "shared.validation.attention_check_value": ("Attention: check the entered value.",
                                                "Atenção: verifique o valor inserido."),
    "shared.validation.check_format":          ("Check that the value is in the correct format.",
                                                "Verifique se o valor está no formato correto."),
    "shared.validation.email_valid":           ("Valid email.",        "E-mail válido."),
    "shared.validation.enter_valid_value":     ("Enter a valid value.", "Digite um valor válido."),
    "shared.validation.field_between":         ("'%1$@' must be between %2$@ and %3$@",
                                                "'%1$@' deve estar entre %2$@ e %3$@"),
    "shared.validation.field_empty":           ("Field '%@' cannot be empty",
                                                "Campo '%@' não pode estar vazio"),
    "shared.validation.field_invalid_number":  ("Field '%@' must contain a valid number",
                                                "Campo '%@' deve conter um número válido"),
    "shared.validation.form_has_errors":       ("Form has errors — check required fields",
                                                "Formulário com erros — verifique os campos obrigatórios"),
    "shared.validation.min_3_chars":           ("Minimum 3 characters.", "Mínimo 3 caracteres."),
    "shared.validation.required":              ("Required field.",        "Campo obrigatório."),
    "shared.validation.required_fields_notice":("* Required fields",      "* Campos obrigatórios"),
    "shared.validation.required_or_invalid":   ("Required or invalid field.", "Campo obrigatório ou inválido."),
    "shared.validation.this_field_required":   ("This field is required.",  "Este campo é obrigatório."),
    "shared.validation.value_accepted":        ("Value accepted successfully.", "Valor aceito com sucesso."),
    "shared.validation.value_out_of_range":    ("Value out of allowed range.",  "Valor fora do range permitido."),
    # ── shared.label ─────────────────────────────────────────────────────────
    "shared.label.ellipsis":         ("…",   "…"),
    "shared.label.or":               ("or",  "ou"),
    "shared.label.required_marker":  ("*",   "*"),
    # ── shared.format ────────────────────────────────────────────────────────
    "shared.format.slide_of": ("Slide %1$d of %2$d", "Slide %1$d de %2$d"),
    # ── catalog.component ────────────────────────────────────────────────────
    "catalog.component.buttons":        ("Buttons",          "Botões"),
    "catalog.component.chip_group":     ("Chip Group",       "Grupo de Chips"),
    "catalog.component.counter":        ("Counter",          "Contador"),
    "catalog.component.download_button":("Download Button",  "Botão de Download"),
    "catalog.component.filter_button":  ("Filter Button",    "Botão de Filtro"),
    "catalog.component.icon_buttons":   ("Icon Buttons",     "Botões de Ícone"),
    "catalog.component.labelled_fields":("Labelled Fields",  "Campos com Label"),
    "catalog.component.menu_button":    ("Menu Button",      "Botão de Menu"),
    "catalog.component.password_field": ("Password Field",   "Campo de Senha"),
    "catalog.component.phone_field":    ("Phone Field",      "Campo de Telefone"),
    "catalog.component.radii_shadows":  ("Radii and Shadows","Raios e Sombras"),
    "catalog.component.result_cards":   ("Result Cards",     "Cards de Resultado"),
    "catalog.component.spacing":        ("Spacing",          "Espaçamento"),
    "catalog.component.system_buttons": ("System Buttons",   "Botões de Sistema"),
    "catalog.component.texts":          ("Texts",            "Textos"),
    "catalog.component.typography":     ("Typography",       "Tipografia"),
    # ── catalog.component_name ───────────────────────────────────────────────
    "catalog.component_name.combobox":              ("Combobox",             "Combobox"),
    "catalog.component_name.dropdown":              ("Dropdown",             "Dropdown"),
    "catalog.component_name.form_in_drawer":        ("Form in Drawer",       "Formulário em Drawer"),
    "catalog.component_name.login_form":            ("Login Form",           "Formulário de Login"),
    "catalog.component_name.media_button":          ("Media Button",         "Botão de Mídia"),
    "catalog.component_name.multiselect":           ("Multiselect",          "Multisseleção"),
    "catalog.component_name.share":                 ("Share",                "Compartilhar"),
    "catalog.component_name.slider_counter":        ("Slider Counter",       "Contador Deslizante"),
    "catalog.component_name.video_preview_button":  ("Video Preview Button", "Botão de Prévia de Vídeo"),
    # ── catalog.spec ─────────────────────────────────────────────────────────
    "catalog.spec.add_owners_hint":      ("Add the project owners.",                  "Adicione os responsáveis pelo projeto."),
    "catalog.spec.apply_label %@":       ("Apply %@",                                 "Aplicar %@"),
    "catalog.spec.badge_default":        ("Badge",                                     "Badge"),
    "catalog.spec.basic_info":           ("Basic Info",                               "Informações básicas"),
    "catalog.spec.breadcrumb":           ("Breadcrumb",                               "Breadcrumb"),
    "catalog.spec.button_danger":        ("Danger Button",                            "Botão Perigo"),
    "catalog.spec.button_default":       ("Button",                                   "Botão"),
    "catalog.spec.button_primary":       ("Primary Button",                           "Botão Primário"),
    "catalog.spec.button_secondary":     ("Secondary Button",                         "Botão Secundário"),
    "catalog.spec.button_small":         ("Small Button",                             "Botão Small"),
    "catalog.spec.button_small_alt":     ("Small Button",                             "Botão Pequeno"),
    "catalog.spec.button_tertiary":      ("Tertiary Button",                          "Botão Terciário"),
    "catalog.spec.centered":             ("Centered",                                 "Centralizado"),
    "catalog.spec.color_azure":          ("Azure",                                    "Azur"),
    "catalog.spec.color_ink":            ("Ink",                                      "Ink"),
    "catalog.spec.color_marine":         ("Marine",                                   "Marine"),
    "catalog.spec.confirm_before_create":("Confirm data before creating the project.", "Confirme os dados antes de criar o projeto."),
    "catalog.spec.decrement_10pct":      ("−10%",                                     "−10%"),
    "catalog.spec.design_system":        ("Design System",                            "Design System"),
    "catalog.spec.disabled_danger":      ("Disabled — Danger",                        "Desabilitado — Perigo"),
    "catalog.spec.disabled_secondary":   ("Disabled — Secondary",                     "Desabilitado — Secundário"),
    "catalog.spec.example_text %@":      ("Example text · %@",                        "Texto de exemplo · %@"),
    "catalog.spec.fill_name_desc_hint":  ("Fill in the project name and description.", "Preencha o nome e a descrição do projeto."),
    "catalog.spec.format_csv":           ("CSV",                                      "CSV"),
    "catalog.spec.format_excel":         ("Excel",                                    "Excel"),
    "catalog.spec.format_pdf":           ("PDF",                                      "PDF"),
    "catalog.spec.helper_guidance":      ("Use to guide the user in filling out the form.", "Use para orientar o usuário no preenchimento."),
    "catalog.spec.helper_optional":      ("Helper text (optional)",                   "Helper text (opcional)"),
    "catalog.spec.helper_state":         ("Helper state",                             "Helper state"),
    "catalog.spec.hq_capgemini":         ("Global HQ — Capgemini SE",                "Sede Global — Capgemini SE"),
    "catalog.spec.increment_10pct":      ("+10%",                                    "+10%"),
    "catalog.spec.info_alert_desc":      ("This is an informational alert. Use to communicate neutral context to the user.",
                                          "Este é um alerta informativo. Use para comunicar contexto neutro ao usuário."),
    "catalog.spec.initials_label %lld":  ("Initials: %lld",   "Iniciais: %lld"),
    "catalog.spec.irreversible_warning": ("This process is irreversible. Review before confirming.",
                                          "Este processo é irreversível. Revise antes de confirmar."),
    "catalog.spec.label_action":         ("Action",           "Ação"),
    "catalog.spec.label_columns":        ("Columns",          "Colunas"),
    "catalog.spec.label_creation_date":  ("Creation Date",    "Data de criação"),
    "catalog.spec.label_disabled":       ("Disabled",         "Disabled"),
    "catalog.spec.label_error":          ("Error",            "Error"),
    "catalog.spec.label_info":           ("Info",             "Info"),
    "catalog.spec.label_last_update":    ("Last Update",      "Última atualização"),
    "catalog.spec.label_size":           ("Size",             "Tamanho"),
    "catalog.spec.label_style":          ("Style",            "Estilo"),
    "catalog.spec.label_success":        ("Success",          "Success"),
    "catalog.spec.label_team":           ("Team",             "Equipe"),
    "catalog.spec.label_warning":        ("Warning",          "Warning"),
    "catalog.spec.label_weight":         ("Weight",           "Peso"),
    "catalog.spec.lbl.background":       ("Background",       "Fundo"),
    "catalog.spec.lbl.eyebrow":          ("Eyebrow",          "Eyebrow"),
    "catalog.spec.lbl.gradiente":        ("Gradient",         "Gradiente"),
    "catalog.spec.lbl.quote":            ("Quote",            "Citação"),
    "catalog.spec.lbl.spacing":          ("Spacing",          "Espaçamento"),
    "catalog.spec.modal_confirm":        ("Confirmation Modal", "Modal de confirmação"),
    "catalog.spec.modal_with_title":     ("Modal with Title",   "Modal com título"),
    "catalog.spec.new_project":          ("New Project",         "Novo Projeto"),
    "catalog.spec.normal_danger":        ("Normal — Danger",     "Normal — Perigo"),
    "catalog.spec.normal_secondary":     ("Normal — Secondary",  "Normal — Secundário"),
    "catalog.spec.open_bottom_sheet":    ("Open Bottom Sheet",   "Abrir Bottom Sheet"),
    "catalog.spec.open_no_compliance":   ("Open without compliance", "Abrir sem compliance"),
    "catalog.spec.open_simple_modal":    ("Open Simple Modal",   "Abrir modal simples"),
    "catalog.spec.open_with_error":      ("Open with predefined error", "Abrir com erro pré-definido"),
    "catalog.spec.pagination":           ("Pagination",          "Pagination"),
    "catalog.spec.quality_hq":           ("HQ",                  "HQ"),
    "catalog.spec.runoff_badge":         ("⚠ Runoff",            "⚠ Segundo Turno"),
    "catalog.spec.set_deadline_hint":    ("Set deadline and target platforms.", "Defina prazo e plataformas alvo."),
    "catalog.spec.share_options":        ("Opens sharing options", "Abre opções de compartilhamento"),
    "catalog.spec.size_large":           ("Large",               "Large"),
    "catalog.spec.size_medium":          ("Medium",              "Medium"),
    "catalog.spec.size_small":           ("Small",               "Small"),
    "catalog.spec.small_button_note":    ("Small — 38pt height, but 44pt touch target",
                                          "Small — 38pt altura, mas 44pt de touch"),
    "catalog.spec.sort_name_asc":        ("Name (A–Z)",          "Nome (A–Z)"),
    "catalog.spec.sort_name_desc":       ("Name (Z–A)",          "Nome (Z–A)"),
    "catalog.spec.state_active_lower":   ("active",              "ativo"),
    "catalog.spec.state_inactive_lower": ("inactive",            "inativo"),
    "catalog.spec.style_ghost":          ("Ghost",               "Ghost"),
    "catalog.spec.style_normal":         ("Normal",              "Normal"),
    "catalog.spec.style_primary":        ("Primary",             "Primary"),
    "catalog.spec.style_secondary":      ("Secondary",           "Secondary"),
    "catalog.spec.symbol_min_size":      ("symbol · min 24pt",   "símbolo · mín 24pt"),
    "catalog.spec.tag_ios_dev":          ("iOS Dev",             "iOS Dev"),
    "catalog.spec.trigger_toast_action": ("Trigger toast with action", "Disparar toast com ação"),
    "catalog.spec.val.zodiakspacing_xs": ("ZodiakSpacing.xs · 16pt", "ZodiakSpacing.xs · 16pt"),
    "catalog.spec.warning_badge":        ("⚠ Warning",           "⚠ Atenção"),
    "catalog.spec.wordmark_min_size":    ("wordmark · min 175pt", "wordmark · mín 175pt"),
    # ── catalog.toast ────────────────────────────────────────────────────────
    "catalog.toast.changes_saved":   ("Your changes have been saved and are now visible to everyone.",
                                      "Suas alterações foram salvas e já estão visíveis para todos."),
    "catalog.toast.new_available":   ("New update available",
                                      "Novidade disponível"),
    "catalog.toast.version_update":  ("Zodiak DS version 2.4.0 is now available. Check out the new features.",
                                      "A versão 2.4.0 do Zodiak DS já está disponível. Confira as novidades."),
    # ── feature ──────────────────────────────────────────────────────────────
    "feature.accessibility.activated":   ("✅ Activated",           "✅ Ativado"),
    "feature.accessibility.deactivated": ("⬜ Deactivated",         "⬜ Desativado"),
    "feature.pix.discount_applied":      ("✓ 5% discount applicable", "✓ 5% de desconto aplicável"),
    "feature.voting.finished_badge":     ("✓ Voting Finished",      "✓ Votação Finalizada"),
    "feature.voting.runoff_warning":     ("⚠️ Runoff",              "⚠️ Segundo Turno"),
    "feature.voting.winner_name":        ("%@",                     "%@"),
}

def make_entry(en_val, ptbr_val):
    return {
        "localizations": {
            "en": {"stringUnit": {"state": "translated", "value": en_val}},
            "pt-BR": {"stringUnit": {"state": "translated", "value": ptbr_val}},
        }
    }

def main():
    with open(XCSTRINGS_PATH, "r", encoding="utf-8") as f:
        data = json.load(f)

    strings = data["strings"]
    filled = 0
    en_only_added = 0
    ptbr_only_added = 0
    skipped = 0

    for key, (en_val, ptbr_val) in TRANSLATIONS.items():
        if key not in strings:
            print(f"  NOT IN XCSTRINGS (will add): {repr(key)}")
            strings[key] = make_entry(en_val, ptbr_val)
            filled += 1
            continue

        entry = strings[key]
        locs = entry.setdefault("localizations", {})

        en_missing = "en" not in locs
        ptbr_missing = "pt-BR" not in locs

        if not en_missing and not ptbr_missing:
            # both exist — don't overwrite
            skipped += 1
            continue

        if en_missing:
            locs["en"] = {"stringUnit": {"state": "translated", "value": en_val}}
            en_only_added += 1

        if ptbr_missing:
            locs["pt-BR"] = {"stringUnit": {"state": "translated", "value": ptbr_val}}
            ptbr_only_added += 1

        filled += 1

    # Fix shared.format.slide_of en value (was wrong — contained pt-BR text)
    slide_entry = strings.get("shared.format.slide_of", {})
    slide_locs = slide_entry.get("localizations", {})
    slide_en = slide_locs.get("en", {}).get("stringUnit", {}).get("value", "")
    if "de" in slide_en:  # still has the Portuguese value
        slide_locs["en"] = {"stringUnit": {"state": "translated", "value": "Slide %1$d of %2$d"}}
        print("  Fixed shared.format.slide_of en value")

    with open(XCSTRINGS_PATH, "w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
        f.write("\n")

    print(f"\nDone. Entries updated: {filled}, en-only added: {en_only_added}, "
          f"pt-BR-only added: {ptbr_only_added}, skipped (already complete): {skipped}")

    # Report remaining missing
    missing = [
        k for k, v in strings.items()
        if not v.get("localizations", {}).get("pt-BR")
    ]
    print(f"Remaining keys without pt-BR: {len(missing)}")
    for k in sorted(missing):
        print(f"  {repr(k)}")

if __name__ == "__main__":
    main()
