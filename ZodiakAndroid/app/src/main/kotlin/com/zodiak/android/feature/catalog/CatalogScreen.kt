package com.zodiak.android.feature.catalog

import androidx.annotation.StringRes
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Check
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.foundation.verticalScroll
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import com.zodiak.android.design_system.atoms.*
import com.zodiak.android.design_system.molecules.*
import com.zodiak.android.design_system.organisms.*
import com.zodiak.android.design_system.theme.ZodiakTheme
import com.zodiak.android.R

// ────────────────────────────────────────────────
// Catalog sections definition
// ────────────────────────────────────────────────

private enum class CatalogSection(@StringRes val labelRes: Int) {
    TOKENS(R.string.catalog_section_tokens),
    ATOMS(R.string.catalog_section_atoms),
    MOLECULES(R.string.catalog_section_molecules),
    ORGANISMS(R.string.catalog_section_organisms),
}

@Composable
fun CatalogScreen(onNavigateToToken: (String) -> Unit = {}) {
    var selectedSection by remember { mutableStateOf(CatalogSection.TOKENS) }

    Scaffold { padding ->
        Column(modifier = Modifier.fillMaxSize().padding(padding)) {
            // Section tabs
            ScrollableTabRow(selectedTabIndex = selectedSection.ordinal) {
                CatalogSection.entries.forEachIndexed { index, section ->
                    Tab(
                        selected  = selectedSection.ordinal == index,
                        onClick   = { selectedSection = section },
                        text      = { Text(stringResource(section.labelRes)) },
                    )
                }
            }

            when (selectedSection) {
                CatalogSection.TOKENS    -> TokensSection(onNavigateToToken)
                CatalogSection.ATOMS     -> AtomsSection()
                CatalogSection.MOLECULES -> MoleculesSection()
                CatalogSection.ORGANISMS -> OrganismsSection()
            }
        }
    }
}

// ─── TOKENS ──────────────────────────────────────

@Composable
private fun TokensSection(onNavigateToToken: (String) -> Unit) {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .verticalScroll(androidx.compose.foundation.rememberScrollState())
            .padding(16.dp),
        verticalArrangement = Arrangement.spacedBy(12.dp),
    ) {
        ZodiakColorGallery(onNavigateToToken)
        SectionHeader("Tipografia")
        TypographySamples()
        SectionHeader("Shapes")
        ShapeSamples()
    }
}


@Composable
private fun TypographySamples() {
    Column(verticalArrangement = Arrangement.spacedBy(4.dp)) {
        ZodiakHeadline("Headline")
        ZodiakTitle("Title")
        ZodiakBody("Body — Lorem ipsum dolor sit amet.")
        ZodiakLabel("Label")
        ZodiakCaption("Caption — smallest text style")
    }
}

@Composable
private fun ShapeSamples() {
    Row(horizontalArrangement = Arrangement.spacedBy(12.dp)) {
        listOf(
            "XS" to MaterialTheme.shapes.extraSmall,
            "SM" to MaterialTheme.shapes.small,
            "MD" to MaterialTheme.shapes.medium,
            "LG" to MaterialTheme.shapes.large,
        ).forEach { (label, shape) ->
            Column(horizontalAlignment = androidx.compose.ui.Alignment.CenterHorizontally) {
                Surface(color = MaterialTheme.colorScheme.primaryContainer, modifier = Modifier.size(48.dp), shape = shape) {}
                Text(label, style = MaterialTheme.typography.labelSmall)
            }
        }
    }
}

// ─── ATOMS ───────────────────────────────────────

@Composable
private fun AtomsSection() {
    LazyColumn(
        contentPadding = PaddingValues(16.dp),
        verticalArrangement = Arrangement.spacedBy(16.dp),
    ) {
        item { SectionHeader("Buttons") }
        item { ButtonSamples() }
        item { SectionHeader("Badges") }
        item { BadgeSamples() }
        item { SectionHeader("TextField") }
        item {
            var text by remember { mutableStateOf("") }
            ZodiakTextField(text, { text = it }, "Label de exemplo")
        }
    }
}

@Composable
private fun ButtonSamples() {
    Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
        ZodiakButton("Primary Button", {}, Modifier.fillMaxWidth())
        ZodiakTonalButton("Tonal Button", {}, Modifier.fillMaxWidth())
        ZodiakOutlinedButton("Outlined Button", {}, Modifier.fillMaxWidth())
        ZodiakTextButton("Text Button", {}, Modifier.fillMaxWidth())
        ZodiakDestructiveButton("Destructive", {}, Modifier.fillMaxWidth())
    }
}

@Composable
private fun BadgeSamples() {
    Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
        ZodiakBadgeVariant.entries.forEach { variant ->
            ZodiakBadge(variant.name, variant)
        }
    }
}

// ─── MOLECULES ───────────────────────────────────

@Composable
private fun MoleculesSection() {
    var text by remember { mutableStateOf("") }
    var alertVisible by remember { mutableStateOf(false) }
    var switchChecked by remember { mutableStateOf(false) }

    if (alertVisible) {
        ZodiakAlert(
            type  = ZodiakAlertType.INFO,
            title = "Informação",
            message = "Este é um alerta de demonstração.",
            onDismiss = { alertVisible = false },
            dismissLabel = "OK",
        )
    }

    LazyColumn(
        contentPadding = PaddingValues(16.dp),
        verticalArrangement = Arrangement.spacedBy(16.dp),
    ) {
        item { SectionHeader("InputField") }
        item { ZodiakInputField(text, { text = it }, "Campo com erro", errorMessage = if (text.isBlank()) "Obrigatório" else null) }
        item { SectionHeader("Alert") }
        item { ZodiakButton("Mostrar Alerta", { alertVisible = true }, Modifier.fillMaxWidth()) }
        item { SectionHeader("ChipGroup") }
        item {
            var selectedDay by remember { mutableStateOf("Seg") }
            ZodiakChipGroup(
                items = listOf("Seg", "Ter", "Qua", "Qui", "Sex"),
                selectedItem = selectedDay,
                onSelect = { selectedDay = it },
                label = { it },
            )
        }
        item { SectionHeader("Switch") }
        item { ZodiakSwitch("Ativar notificações", switchChecked, { switchChecked = it }) }
    }
}

// ─── ORGANISMS ───────────────────────────────────

@Composable
private fun OrganismsSection() {
    LazyColumn(
        contentPadding = PaddingValues(16.dp),
        verticalArrangement = Arrangement.spacedBy(16.dp),
    ) {
        item { SectionHeader("FormContainer") }
        item {
            ZodiakFormContainer("Título do Formulário") {
                ZodiakBody("Conteúdo dentro do container de formulário.")
            }
        }
        item { SectionHeader("InfoRow") }
        item {
            ZodiakFormContainer("Informações") {
                ZodiakInfoRow("Nome", "GitHub Copilot")
                ZodiakInfoRow("Versão", "2026", valueColor = MaterialTheme.colorScheme.primary)
                ZodiakInfoRow("Status", "Ativo", valueColor = MaterialTheme.colorScheme.tertiary)
            }
        }
        item { SectionHeader("EmptyState") }
        item {
            ZodiakEmptyState(
                title   = "Nenhum item",
                message = "Adicione itens para começar.",
                actionLabel = "Adicionar",
                onAction = {},
            )
        }
    }
}

// ─── Helper ──────────────────────────────────────

@Composable
private fun SectionHeader(title: String) {
    Text(
        title,
        style = MaterialTheme.typography.titleMedium,
        color = MaterialTheme.colorScheme.primary,
    )
    HorizontalDivider(Modifier.padding(top = 4.dp))
}
