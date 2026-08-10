#!/usr/bin/env python3
"""
Phase 3 Localization Migration
Renames the remaining 194 natural-language keys to dot-notation in Localizable.xcstrings
and updates Swift call sites.

Run: python3 scripts/migrate_localization_phase3.py
"""

import json
import os
import re
from pathlib import Path

XCSTRINGS_PATH = Path("/Users/mrocha/Developer/ZodiakiOS/ZodiakiOS/Localizable.xcstrings")
SWIFT_ROOT = Path("/Users/mrocha/Developer/ZodiakiOS/ZodiakiOS")

# ─── PURE STRING MAPPING ─────────────────────────────────────────────────────
# For each (old_key → new_key): rename in xcstrings + replace literal in Swift files.
MAPPING = {
    # == Actions ==
    "Salvar": "shared.action.save",
    "Editar": "shared.action.edit",
    "Excluir": "shared.action.delete",
    "Arquivar": "shared.action.archive",
    "Duplicar": "shared.action.duplicate",
    "Entrar": "shared.action.login",
    "Expandir": "shared.action.expand",
    "Ocultar": "shared.action.hide",
    "Resetar": "shared.action.reset",
    "Avançar": "shared.action.advance",
    "Avançar 15 segundos": "shared.action.forward_15s",
    "Voltar 15 segundos": "shared.action.rewind_15s",
    "Limpar filtros": "shared.action.clear_filters",
    "Limpar tudo": "shared.action.clear_all",
    "Mais opções": "shared.action.more_options",
    "OK": "shared.action.ok",
    "Entendido": "shared.action.understood",
    "Enviar avaliação": "shared.action.submit_rating",
    "Aumentar": "shared.action.increase",
    "Diminuir": "shared.action.decrease",
    "Silenciar": "shared.action.mute",
    "Parar": "shared.action.stop",
    "Pausar": "shared.action.pause",
    "Reproduzir": "shared.action.play",
    "Faixa anterior": "shared.action.previous_track",
    "Próxima faixa": "shared.action.next_track",
    "Rebobinar": "shared.action.rewind",
    "Fechar player": "shared.action.close_player",
    "Reproduzir prévia": "shared.action.play_preview",
    "Pausar prévia": "shared.action.pause_preview",
    "Volume máximo": "shared.action.volume_max",
    "Volume mínimo": "shared.action.volume_min",
    "Toque para ver detalhes": "shared.action.tap_for_details",
    "Aleatório": "shared.action.shuffle",
    "Agendar reunião": "shared.action.schedule_meeting",
    # == States ==
    "Ativo": "shared.state.active",
    "Em andamento": "shared.state.in_progress",
    "Concluído": "shared.state.completed",
    "Confirmado!": "shared.state.confirmed",
    "Sucesso": "shared.state.success_label",
    "Erro": "shared.state.error_label",
    "Aviso": "shared.state.warning_label",
    "Informação": "shared.state.info_label",
    "Atenção": "shared.state.attention",
    "Novo": "shared.state.new_badge",
    "Revisão": "shared.state.review",
    "Enviado com sucesso!": "shared.state.sent_success",
    "Enviando…": "shared.state.sending",
    "Entrando…": "shared.state.logging_in",
    "Falha no login": "shared.state.login_failed",
    "Erro ao enviar": "shared.state.send_error",
    "Erro ao processar": "shared.state.process_error",
    "Operação realizada com sucesso": "shared.state.operation_success",
    "Cadastro realizado com sucesso": "shared.state.registration_success",
    "Não foi possível salvar as alterações. Tente novamente mais tarde.": "shared.state.save_failed",
    "Em breve entraremos em contato.": "shared.state.contact_soon",
    "Sessão expirando em 5 minutos": "shared.state.session_expiring",
    # == Validation ==
    "Campo obrigatório.": "shared.validation.required",
    "Campo obrigatório ou inválido.": "shared.validation.required_or_invalid",
    "Formulário com erros — verifique os campos obrigatórios": "shared.validation.form_has_errors",
    "E-mail válido.": "shared.validation.email_valid",
    "Valor aceito com sucesso.": "shared.validation.value_accepted",
    "Valor fora do range permitido.": "shared.validation.value_out_of_range",
    "Digite um valor válido.": "shared.validation.enter_valid_value",
    "Mínimo 3 caracteres.": "shared.validation.min_3_chars",
    "Este campo é obrigatório.": "shared.validation.this_field_required",
    "Atenção: verifique o valor inserido.": "shared.validation.attention_check_value",
    "Verifique se o valor está no formato correto.": "shared.validation.check_format",
    "* Campos obrigatórios": "shared.validation.required_fields_notice",
    # == Shared labels ==
    "ou": "shared.label.or",
    "*": "shared.label.required_marker",
    "…": "shared.label.ellipsis",
    # == Toasts ==
    "A versão 2.4.0 do Zodiak DS já está disponível. Confira as novidades.": "catalog.toast.version_update",
    "Novidade disponível": "catalog.toast.new_available",
    "Suas alterações foram salvas e já estão visíveis para todos.": "catalog.toast.changes_saved",
    # == Catalog spec / demo ==
    "Abre opções de compartilhamento": "catalog.spec.share_options",
    "Abrir Bottom Sheet": "catalog.spec.open_bottom_sheet",
    "Abrir com erro pré-definido": "catalog.spec.open_with_error",
    "Abrir modal simples": "catalog.spec.open_simple_modal",
    "Abrir sem compliance": "catalog.spec.open_no_compliance",
    "Adicione os responsáveis pelo projeto.": "catalog.spec.add_owners_hint",
    "Defina prazo e plataformas alvo.": "catalog.spec.set_deadline_hint",
    "Confirme os dados antes de criar o projeto.": "catalog.spec.confirm_before_create",
    "Preencha o nome e a descrição do projeto.": "catalog.spec.fill_name_desc_hint",
    "Informações básicas": "catalog.spec.basic_info",
    "Design System": "catalog.spec.design_system",
    "Modal com título": "catalog.spec.modal_with_title",
    "Modal de confirmação": "catalog.spec.modal_confirm",
    "Disparar toast com ação": "catalog.spec.trigger_toast_action",
    "Badge": "catalog.spec.badge_default",
    "Botão": "catalog.spec.button_default",
    "Botão Primário": "catalog.spec.button_primary",
    "Botão Secundário": "catalog.spec.button_secondary",
    "Botão Terciário": "catalog.spec.button_tertiary",
    "Botão Perigo": "catalog.spec.button_danger",
    "Botão Small": "catalog.spec.button_small",
    "Botão Pequeno": "catalog.spec.button_small_alt",
    "Normal — Perigo": "catalog.spec.normal_danger",
    "Normal — Secundário": "catalog.spec.normal_secondary",
    "Desabilitado — Perigo": "catalog.spec.disabled_danger",
    "Desabilitado — Secundário": "catalog.spec.disabled_secondary",
    "Breadcrumb": "catalog.spec.breadcrumb",
    "Pagination": "catalog.spec.pagination",
    "Primary": "catalog.spec.style_primary",
    "Secondary": "catalog.spec.style_secondary",
    "Ghost": "catalog.spec.style_ghost",
    "Normal": "catalog.spec.style_normal",
    "Small": "catalog.spec.size_small",
    "Medium": "catalog.spec.size_medium",
    "Large": "catalog.spec.size_large",
    "Error": "catalog.spec.label_error",
    "Success": "catalog.spec.label_success",
    "Disabled": "catalog.spec.label_disabled",
    "Info": "catalog.spec.label_info",
    "Small — 38pt altura, mas 44pt de touch": "catalog.spec.small_button_note",
    "Centralizado": "catalog.spec.centered",
    "Estilo": "catalog.spec.label_style",
    "Tamanho": "catalog.spec.label_size",
    "Colunas": "catalog.spec.label_columns",
    "Peso": "catalog.spec.label_weight",
    "Equipe": "catalog.spec.label_team",
    "Data de criação": "catalog.spec.label_creation_date",
    "Última atualização": "catalog.spec.label_last_update",
    "HQ": "catalog.spec.quality_hq",
    "CSV": "catalog.spec.format_csv",
    "Excel": "catalog.spec.format_excel",
    "PDF": "catalog.spec.format_pdf",
    "Helper state": "catalog.spec.helper_state",
    "Helper text (opcional)": "catalog.spec.helper_optional",
    "Ação": "catalog.spec.label_action",
    "Nome (A–Z)": "catalog.spec.sort_name_asc",
    "Nome (Z–A)": "catalog.spec.sort_name_desc",
    "Azur": "catalog.spec.color_azure",
    "Marine": "catalog.spec.color_marine",
    "Ink": "catalog.spec.color_ink",
    "Este processo é irreversível. Revise antes de confirmar.": "catalog.spec.irreversible_warning",
    "Este é um alerta informativo. Use para comunicar contexto neutro ao usuário.": "catalog.spec.info_alert_desc",
    "Use para orientar o usuário no preenchimento.": "catalog.spec.helper_guidance",
    "Sede Global — Capgemini SE": "catalog.spec.hq_capgemini",
    "símbolo · mín 24pt": "catalog.spec.symbol_min_size",
    "wordmark · mín 175pt": "catalog.spec.wordmark_min_size",
    "iOS Dev": "catalog.spec.tag_ios_dev",
    "ativo": "catalog.spec.state_active_lower",
    "inativo": "catalog.spec.state_inactive_lower",
    "+10%": "catalog.spec.increment_10pct",
    "−10%": "catalog.spec.decrement_10pct",
    # == Features ==
    "⚠ Atenção": "catalog.spec.warning_badge",
    "⚠ Segundo Turno": "catalog.spec.runoff_badge",
    "⚠️ Segundo Turno": "feature.voting.runoff_warning",
    "✅ Ativado": "feature.accessibility.activated",
    "⬜ Desativado": "feature.accessibility.deactivated",
    "✓ 5% de desconto aplicável": "feature.pix.discount_applied",
    "✓ Votação Finalizada": "feature.voting.finished_badge",
}

# ─── FORMAT STRING PREFIX MAPPING ────────────────────────────────────────────
# For each (old_literal_prefix → new_literal_prefix): the Swift source uses
# LocalizedStringKey("old \(var)") or Text("old \(var)").
# xcstrings key changes from "old %@" to "new %@".
# The xcstrings rename is from OLD to NEW (both with %@ suffix appended by Xcode).
FORMAT_PREFIX_MAPPING = {
    # old_xcstrings_key: (new_xcstrings_key, old_swift_prefix, new_swift_prefix)
    "Velocidade %@": (
        "shared.format.playback_speed %@",
        "Velocidade \\(",
        "shared.format.playback_speed \\(",
    ),
    "Aviso: %@": (
        "shared.format.warning_colon %@",
        "Aviso: \\(",
        "shared.format.warning_colon \\(",
    ),
    "Mostrar mais (%lld)": (
        "shared.format.show_more_count %lld",
        "Mostrar mais (",
        "shared.format.show_more_count ",
    ),
    "Mostrar mais, %lld itens ocultos": (
        "shared.format.show_more_hidden %lld",
        "Mostrar mais, ",
        "shared.format.show_more_hidden ",
    ),
    "Iniciais: %lld": (
        "catalog.spec.initials_label %lld",
        "Iniciais: \\(",
        "catalog.spec.initials_label \\(",
    ),
    "Texto de exemplo · %@": (
        "catalog.spec.example_text %@",
        "Texto de exemplo · \\(",
        "catalog.spec.example_text \\(",
    ),
    "Aplicar %@": (
        "catalog.spec.apply_label %@",
        "Aplicar \\(",
        "catalog.spec.apply_label \\(",
    ),
}

# ─── KEYS TO REMOVE ENTIRELY (convert sources to verbatim or remove) ──────────
# These keys are removed from xcstrings. Sources are updated in targeted edits below.
KEYS_TO_REMOVE = {
    "",                     # empty string key
    "AA",                   # AccessibilityGalleryView – static WCAG label
    "3:1",                  # AccessibilityGalleryView – static contrast ratio
    "4.5:1",                # AccessibilityGalleryView – static contrast ratio
    "ZodiakCloseButton",    # IconButtonsGalleryView – component API name (verbatim)
    "ZodiakSkeletonLine",   # SkeletonLoaderGalleryView – component API name (verbatim)
    "ZodiakSkeletonCircle", # SkeletonLoaderGalleryView – component API name (verbatim)
    "ZodiakSkeletonRect",   # SkeletonLoaderGalleryView – component API name (verbatim)
    "ZodiakCard(item: item)\n    .zodiakSkeleton(active: isLoading)",  # code sample
    "ZodiakTypography.%@",  # AccordionGalleryView – token name display (verbatim)
    "ZodiakRadii.%@",       # RadiiShadowGalleryView – token name display (verbatim)
    "stroke %@px",          # IconsGalleryView – spec display (verbatim)
    "%lldpt",               # size display in catalog (verbatim)
    ".%@",                  # token name display (verbatim)
    "%lld",                 # pure integer display in components (verbatim)
    "0%lld",                # zero-padded integer display (verbatim, if present)
    "%lld / %lld",          # fraction display (verbatim)
    "%lld%%",               # percentage display (verbatim)
    "+%lld",                # overflow count display (verbatim)
    "%@ · %@",              # format-and-size display (verbatim)
    "%@, %@",               # city/country display (verbatim)
    "%@  %@",               # double-space pair (verbatim)
    "%@ (%lld)",            # label with count (verbatim)
    "Flag of %@, %@",       # accessibility label for flags (handled below)
}

# ─── MODELS.SWIFT FORMAT STRING REMAPPING ────────────────────────────────────
# Keys that come from LocalizedStringKey("Campo '\(field)' ...") in Models.swift.
# New xcstrings keys use pure dot-notation with %@ in the VALUE.
MODELS_FORMAT_MAPPING = {
    "Campo '%@' não pode estar vazio": "shared.validation.field_empty",
    "Campo '%@' deve conter um número válido": "shared.validation.field_invalid_number",
    "'%@' deve estar entre %@ e %@": "shared.validation.field_between",
    # Flag accessibility – special: replaced with String(format:) in source
    "Flag of %@, %@": "shared.format.flag_of",
    # Slide counter – already uses String(localized:)
    "Slide %d de %d": "shared.format.slide_of",
}

# ─── HELPERS ─────────────────────────────────────────────────────────────────

def load_xcstrings():
    with open(XCSTRINGS_PATH, "r", encoding="utf-8") as f:
        return json.load(f)

def save_xcstrings(data):
    with open(XCSTRINGS_PATH, "w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
        f.write("\n")

def get_swift_files():
    return list(SWIFT_ROOT.rglob("*.swift"))

def escape_for_regex(s):
    return re.escape(s)

def replace_in_file(path, old, new):
    """Replace exact string `old` with `new` in file. Returns number of replacements."""
    try:
        content = path.read_text(encoding="utf-8")
        if old in content:
            new_content = content.replace(old, new)
            path.write_text(new_content, encoding="utf-8")
            return content.count(old)
    except Exception as e:
        print(f"  ERROR reading {path}: {e}")
    return 0

# ─── STEP 1: Rename pure string keys in xcstrings ────────────────────────────

def rename_xcstrings_keys(data, mapping):
    strings = data["strings"]
    renamed = 0
    skipped_existing = 0
    not_found = 0
    for old_key, new_key in mapping.items():
        if old_key in strings:
            if new_key in strings:
                # Merge: keep the existing new_key entry (already migrated)
                # Just remove the old one
                del strings[old_key]
                skipped_existing += 1
            else:
                strings[new_key] = strings.pop(old_key)
                renamed += 1
        else:
            not_found += 1
    print(f"  Renamed: {renamed}, Skipped (new key exists): {skipped_existing}, Not found: {not_found}")
    return data

# ─── STEP 2: Remove verbatim keys from xcstrings ─────────────────────────────

def remove_verbatim_keys(data, keys_to_remove):
    strings = data["strings"]
    removed = 0
    for key in keys_to_remove:
        if key in strings:
            del strings[key]
            removed += 1
    print(f"  Removed {removed} verbatim keys from xcstrings")
    return data

# ─── STEP 3: Rename format prefix keys in xcstrings ──────────────────────────

def rename_format_prefix_keys(data, format_prefix_mapping):
    strings = data["strings"]
    renamed = 0
    for old_key, (new_key, _, _) in format_prefix_mapping.items():
        if old_key in strings:
            if new_key not in strings:
                strings[new_key] = strings.pop(old_key)
                renamed += 1
            else:
                del strings[old_key]  # merge: new key already exists
    print(f"  Renamed {renamed} format-prefix keys in xcstrings")
    return data

# ─── STEP 4: Handle Models.swift format keys ─────────────────────────────────

def rename_models_format_keys(data, models_format_mapping):
    strings = data["strings"]
    renamed = 0
    for old_key, new_key in models_format_mapping.items():
        if old_key in strings:
            if new_key not in strings:
                strings[new_key] = strings.pop(old_key)
                renamed += 1
            else:
                del strings[old_key]
    print(f"  Renamed {renamed} Models.swift format keys in xcstrings")
    return data

# ─── STEP 5: Replace string literals in Swift files ──────────────────────────

def replace_swift_literals(mapping):
    """
    For each (old → new) pair, replace all quoted occurrences in Swift files.
    Uses simple string replacement of `"old_key"` → `"new_key"`.
    Only replaces when the string is used as a localization key (in quotes).
    """
    swift_files = get_swift_files()
    total_replacements = 0
    for old_key, new_key in mapping.items():
        old_quoted = f'"{old_key}"'
        new_quoted = f'"{new_key}"'
        for swift_file in swift_files:
            count = replace_in_file(swift_file, old_quoted, new_quoted)
            if count > 0:
                total_replacements += count
                print(f"    {swift_file.relative_to(SWIFT_ROOT.parent)}: {count}x '{old_key}' → '{new_key}'")
    print(f"  Total Swift literal replacements: {total_replacements}")
    return total_replacements

# ─── STEP 6: Replace format prefix literals in Swift files ───────────────────

def replace_format_prefix_literals(format_prefix_mapping):
    """
    For keys like "Velocidade \(v)" → "shared.format.playback_speed \(v)":
    Replace the string literal prefix inside quotes.
    """
    swift_files = get_swift_files()
    total_replacements = 0
    for old_key, (new_key, old_prefix, new_prefix) in format_prefix_mapping.items():
        # old_prefix is already an unescaped string like "Velocidade \("
        # We need to find `"Velocidade \(` and replace with `"shared.format.playback_speed \(`
        old_quoted_prefix = f'"{old_prefix}'
        new_quoted_prefix = f'"{new_prefix}'
        for swift_file in swift_files:
            count = replace_in_file(swift_file, old_quoted_prefix, new_quoted_prefix)
            if count > 0:
                total_replacements += count
                print(f"    {swift_file.relative_to(SWIFT_ROOT.parent)}: {count}x prefix '{old_prefix}' → '{new_prefix}'")
    print(f"  Total format-prefix Swift replacements: {total_replacements}")
    return total_replacements

# ─── STEP 7: Update Models.swift validation format strings ────────────────────

def update_models_swift():
    """
    Change LocalizedStringKey("Campo '\(field)' não pode estar vazio") to use
    String(format: String(localized: "shared.validation.field_empty"), field) pattern.
    """
    models_path = SWIFT_ROOT / "Models" / "Models.swift"
    if not models_path.exists():
        print("  Models.swift not found!")
        return

    content = models_path.read_text(encoding="utf-8")
    original = content

    # Replacement 1: emptyField
    content = content.replace(
        'return LocalizedStringKey("Campo \'\\(field)\' não pode estar vazio")',
        'let msg = String(format: String(localized: "shared.validation.field_empty"), field)\n            return LocalizedStringKey(msg)'
    )

    # Replacement 2: invalidNumber
    content = content.replace(
        'return LocalizedStringKey("Campo \'\\(field)\' deve conter um número válido")',
        'let msg = String(format: String(localized: "shared.validation.field_invalid_number"), field)\n            return LocalizedStringKey(msg)'
    )

    # Replacement 3: outOfRange
    old_out = (
        '            let minStr = String(Int(min))\n'
        '            let maxStr = String(Int(max))\n'
        '            return LocalizedStringKey("\'\\(field)\' deve estar entre \\(minStr) e \\(maxStr)")'
    )
    new_out = (
        '            let minStr = String(Int(min))\n'
        '            let maxStr = String(Int(max))\n'
        '            let msg = String(format: String(localized: "shared.validation.field_between"), field, minStr, maxStr)\n'
        '            return LocalizedStringKey(msg)'
    )
    content = content.replace(old_out, new_out)

    if content != original:
        models_path.write_text(content, encoding="utf-8")
        print("  Models.swift: updated 3 validation format strings")
    else:
        print("  Models.swift: no changes (already migrated or patterns not found)")

# ─── STEP 8: Update ZodiakSliderCounter.swift ────────────────────────────────

def update_slider_counter():
    path = SWIFT_ROOT / "Shared/DesignSystem/Atoms/Navigation/ZodiakSliderCounter.swift"
    if not path.exists():
        return
    content = path.read_text(encoding="utf-8")
    original = content
    content = content.replace(
        'String(localized: "Slide %d de %d", locale: locale)',
        'String(localized: "shared.format.slide_of", locale: locale)'
    )
    if content != original:
        path.write_text(content, encoding="utf-8")
        print("  ZodiakSliderCounter.swift: updated Slide %d de %d → shared.format.slide_of")

# ─── STEP 9: Update ZodiakFlagView.swift ────────────────────────────────────

def update_flag_view():
    path = SWIFT_ROOT / "Shared/DesignSystem/Atoms/Flag/ZodiakFlagView.swift"
    if not path.exists():
        return
    content = path.read_text(encoding="utf-8")
    original = content
    # Change .accessibilityLabel("Flag of \(country.displayName), \(label)")
    # to use String(format:) with the new key
    content = content.replace(
        '.accessibilityLabel("Flag of \\(country.displayName), \\(label)")',
        '.accessibilityLabel(Text(verbatim: String(format: String(localized: "shared.format.flag_of"), country.displayName, label)))'
    )
    if content != original:
        path.write_text(content, encoding="utf-8")
        print("  ZodiakFlagView.swift: updated flag accessibility label")
    else:
        print("  ZodiakFlagView.swift: pattern not found (check manually)")

# ─── STEP 10: Update verbatim sources ────────────────────────────────────────

VERBATIM_REPLACEMENTS = [
    # (file_relative_path, old_snippet, new_snippet)
    # AccessibilityGalleryView
    ("App/Catalog/Tokens/AccessibilityGalleryView.swift",
     'Text("AA")', 'Text(verbatim: "AA")'),
    ("App/Catalog/Tokens/AccessibilityGalleryView.swift",
     'Text("4.5:1")', 'Text(verbatim: "4.5:1")'),
    ("App/Catalog/Tokens/AccessibilityGalleryView.swift",
     'Text("3:1")', 'Text(verbatim: "3:1")'),
    # IconButtonsGalleryView
    ("App/Catalog/Components/Atoms/IconButtonsGalleryView.swift",
     'Text("ZodiakCloseButton")', 'Text(verbatim: "ZodiakCloseButton")'),
    # SkeletonLoaderGalleryView
    ("App/Catalog/Components/Organisms/SkeletonLoaderGalleryView.swift",
     'Text("ZodiakSkeletonLine")', 'Text(verbatim: "ZodiakSkeletonLine")'),
    ("App/Catalog/Components/Organisms/SkeletonLoaderGalleryView.swift",
     'Text("ZodiakSkeletonCircle")', 'Text(verbatim: "ZodiakSkeletonCircle")'),
    ("App/Catalog/Components/Organisms/SkeletonLoaderGalleryView.swift",
     'Text("ZodiakSkeletonRect")', 'Text(verbatim: "ZodiakSkeletonRect")'),
    ("App/Catalog/Components/Organisms/SkeletonLoaderGalleryView.swift",
     'Text("ZodiakCard(item: item)\\n    .zodiakSkeleton(active: isLoading)")',
     'Text(verbatim: "ZodiakCard(item: item)\\n    .zodiakSkeleton(active: isLoading)")'),
    # AccordionGalleryView — ZodiakTypography token display
    ("App/Catalog/Components/Molecules/AccordionGalleryView.swift",
     'Text("ZodiakTypography.\\(style.lowercased().replacingOccurrences(of: " ", with: ""))").font(ZodiakTypography.caption).foregroundColor(ZodiakColors.textDisabled)',
     'Text(verbatim: "ZodiakTypography.\\(style.lowercased().replacingOccurrences(of: " ", with: ""))").font(ZodiakTypography.caption).foregroundColor(ZodiakColors.textDisabled)'),
    # RadiiShadowGalleryView — ZodiakRadii token display
    ("App/Catalog/Tokens/RadiiShadowGalleryView.swift",
     'Text("ZodiakRadii.\\(token.name)")',
     'Text(verbatim: "ZodiakRadii.\\(token.name)")'),
    # IconsGalleryView — stroke display
    ("App/Catalog/VisualAssets/IconsGalleryView.swift",
     'Text("stroke \\(String(format: "%.1f", size.strokeWidth))px")',
     'Text(verbatim: "stroke \\(String(format: "%.1f", size.strokeWidth))px")'),
    # SpacingGalleryView — token name and pt display
    ("App/Catalog/Tokens/SpacingGalleryView.swift",
     'Text(".\\(name)")', 'Text(verbatim: ".\\(name)")'),
    # ZodiakProgressIndicator — percentage display
    ("Shared/DesignSystem/Atoms/ProgressIndicator/ZodiakProgressIndicator.swift",
     'Text("\\(Int(progress * 100))%")',
     'Text(verbatim: "\\(Int(progress * 100))%")'),
    # ZodiakAvatar — overflow count display
    ("Shared/DesignSystem/Atoms/Avatar/ZodiakAvatar.swift",
     'Text("+\\(overflow)")',
     'Text(verbatim: "+\\(overflow)")'),
    # ZodiakListings — format · size display
    ("Shared/DesignSystem/Organisms/Listings/ZodiakListings.swift",
     'Text("\\(item.format) · \\(item.size)")',
     'Text(verbatim: "\\(item.format) · \\(item.size)")'),
    # TypographyGalleryView — size · weight display
    ("App/Catalog/Tokens/TypographyGalleryView.swift",
     'Text("\\(style.size) · \\(style.weight)")',
     'Text(verbatim: "\\(style.size) · \\(style.weight)")'),
    # TextsGalleryView — already handled in FORMAT_PREFIX_MAPPING but just in case
    # ZodiakCounterControl — pure number display
    ("Shared/DesignSystem/Molecules/CounterControl/ZodiakCounterControl.swift",
     'Text("\\(value)")',
     'Text(verbatim: "\\(value)")'),
    # ZodiakBreadcrumbPagination — page number display
    ("Shared/DesignSystem/Atoms/Navigation/ZodiakBreadcrumbPagination.swift",
     'Text("\\(page)")',
     'Text(verbatim: "\\(page)")'),
    # ZodiakSliderCounter — "N / M" display
    ("Shared/DesignSystem/Atoms/Navigation/ZodiakSliderCounter.swift",
     'Text("\\(currentIndex + 1) / \\(totalItems)")',
     'Text(verbatim: "\\(currentIndex + 1) / \\(totalItems)")'),
    # PinGalleryView — "N / M" display
    ("App/Catalog/Components/Organisms/PinGalleryView.swift",
     'ZodiakText("\\(focusedIndex + 1) / \\(offices.count)"',
     'ZodiakText(verbatim: "\\(focusedIndex + 1) / \\(offices.count)"'),
    # ZodiakSystemButtons — filter count badge
    ("Shared/DesignSystem/Atoms/Button/ZodiakSystemButtons.swift",
     'Text("\\(activeFilterCount)")',
     'Text(verbatim: "\\(activeFilterCount)")'),
    # CatalogHomeView — "+N" overflow badge  
    ("App/Catalog/CatalogHomeView.swift",
     'LocalizedStringKey("+\\(section.items.count - 4)")',
     '"catalog.spec.overflow_badge"'),
]

def apply_verbatim_replacements():
    count = 0
    for rel_path, old_snippet, new_snippet in VERBATIM_REPLACEMENTS:
        path = SWIFT_ROOT / rel_path
        if not path.exists():
            print(f"  File not found: {rel_path}")
            continue
        n = replace_in_file(path, old_snippet, new_snippet)
        if n > 0:
            count += n
            print(f"  {rel_path}: {n}x verbatim conversion")
        else:
            print(f"  {rel_path}: pattern not found – '{old_snippet[:60]}'")
    print(f"  Total verbatim replacements: {count}")

# ─── STEP 11: Add overflow badge key to xcstrings if not present ─────────────

def add_overflow_badge_key(data):
    strings = data["strings"]
    if "catalog.spec.overflow_badge" not in strings:
        strings["catalog.spec.overflow_badge"] = {
            "localizations": {
                "en": {
                    "stringUnit": {"state": "translated", "value": "+%lld"}
                },
                "pt-BR": {
                    "stringUnit": {"state": "translated", "value": "+%lld"}
                }
            }
        }
        print("  Added catalog.spec.overflow_badge to xcstrings")
    return data

# ─── STEP 12: Add new xcstrings values for Models.swift format keys ──────────

def add_models_format_values(data):
    strings = data["strings"]
    # These values will be filled in here; pt-BR and en values both provided.
    new_keys = {
        "shared.validation.field_empty": {
            "localizations": {
                "en": {"stringUnit": {"state": "translated", "value": "Field '%@' cannot be empty"}},
                "pt-BR": {"stringUnit": {"state": "translated", "value": "Campo '%@' não pode estar vazio"}}
            }
        },
        "shared.validation.field_invalid_number": {
            "localizations": {
                "en": {"stringUnit": {"state": "translated", "value": "Field '%@' must contain a valid number"}},
                "pt-BR": {"stringUnit": {"state": "translated", "value": "Campo '%@' deve conter um número válido"}}
            }
        },
        "shared.validation.field_between": {
            "localizations": {
                "en": {"stringUnit": {"state": "translated", "value": "'%@' must be between %@ and %@"}},
                "pt-BR": {"stringUnit": {"state": "translated", "value": "'%@' deve estar entre %@ e %@"}}
            }
        },
        "shared.format.flag_of": {
            "localizations": {
                "en": {"stringUnit": {"state": "translated", "value": "Flag of %@, %@"}},
                "pt-BR": {"stringUnit": {"state": "translated", "value": "Bandeira de %@, %@"}}
            }
        },
        "shared.format.slide_of": {
            "localizations": {
                "en": {"stringUnit": {"state": "translated", "value": "Slide %d of %d"}},
                "pt-BR": {"stringUnit": {"state": "translated", "value": "Slide %d de %d"}}
            }
        },
    }
    added = 0
    for key, value in new_keys.items():
        if key not in strings:
            strings[key] = value
            added += 1
        # If key already exists (was renamed there), keep existing - don't overwrite
    print(f"  Added {added} new format key entries to xcstrings")
    return data

# ─── MAIN ─────────────────────────────────────────────────────────────────────

def main():
    print("=== Phase 3 Localization Migration ===\n")

    print("[1/10] Loading xcstrings...")
    data = load_xcstrings()
    total_before = len(data["strings"])
    print(f"  Keys before: {total_before}")

    print("\n[2/10] Renaming pure string keys in xcstrings...")
    data = rename_xcstrings_keys(data, MAPPING)

    print("\n[3/10] Removing verbatim keys from xcstrings...")
    data = remove_verbatim_keys(data, KEYS_TO_REMOVE)

    print("\n[4/10] Renaming format-prefix keys in xcstrings...")
    data = rename_format_prefix_keys(data, FORMAT_PREFIX_MAPPING)

    print("\n[5/10] Renaming Models.swift format keys in xcstrings...")
    data = rename_models_format_keys(data, MODELS_FORMAT_MAPPING)

    print("\n[6/10] Adding new format key values to xcstrings...")
    data = add_models_format_values(data)
    data = add_overflow_badge_key(data)

    print("\n[7/10] Saving xcstrings...")
    save_xcstrings(data)
    total_after = len(data["strings"])
    print(f"  Keys after: {total_after} (delta: {total_after - total_before:+d})")

    print("\n[8/10] Replacing string literals in Swift files...")
    replace_swift_literals(MAPPING)

    print("\n[9/10] Replacing format-prefix literals in Swift files...")
    replace_format_prefix_literals(FORMAT_PREFIX_MAPPING)

    print("\n[10/10] Applying verbatim conversions in Swift sources...")
    apply_verbatim_replacements()

    print("\n[MODELS.SWIFT] Updating validation format strings...")
    update_models_swift()

    print("\n[SLIDER] Updating ZodiakSliderCounter...")
    update_slider_counter()

    print("\n[FLAG] Updating ZodiakFlagView...")
    update_flag_view()

    print("\n✅ Phase 3 migration complete.")
    print("Next steps:")
    print("  1. xcodebuild ... build")
    print("  2. swiftlint lint --config .swiftlint.yml")
    print("  3. Fix any remaining errors")

if __name__ == "__main__":
    main()
