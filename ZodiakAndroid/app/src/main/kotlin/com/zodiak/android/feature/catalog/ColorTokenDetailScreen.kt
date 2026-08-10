package com.zodiak.android.feature.catalog

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.material3.Icon
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowBack
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.toArgb
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.unit.dp
import com.zodiak.android.design_system.theme.ZodiakTheme
import com.zodiak.android.feature.catalog.models.ColorTokenDetail
import com.zodiak.android.feature.catalog.models.ColorTokenMetadata
import com.zodiak.android.design_system.theme.LocalZodiakColors
import com.zodiak.android.design_system.theme.ZodiakSemanticColors

@androidx.compose.material3.ExperimentalMaterial3Api
@Composable
fun ColorTokenDetailScreen(
    tokenId: String,
    onBack: () -> Unit
) {
    val token = ColorTokenMetadata.all[tokenId] ?: return
    
    androidx.compose.material3.Scaffold(
        topBar = {
            androidx.compose.material3.TopAppBar(
                title = { Text(token.name) },
                navigationIcon = {
                    androidx.compose.material3.IconButton(onClick = onBack) {
                        Icon(
                            imageVector = androidx.compose.material.icons.Icons.AutoMirrored.Filled.ArrowBack,
                            contentDescription = "Back"
                        )
                    }
                },
                colors = androidx.compose.material3.TopAppBarDefaults.topAppBarColors(
                    containerColor = ZodiakTheme.colors.background,
                    titleContentColor = ZodiakTheme.colors.textPrimary,
                    navigationIconContentColor = ZodiakTheme.colors.textPrimary
                )
            )
        },
        containerColor = ZodiakTheme.colors.background
    ) { paddingValues ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(paddingValues)
                .verticalScroll(rememberScrollState())
                .padding(horizontal = 16.dp, vertical = 8.dp),
            verticalArrangement = Arrangement.spacedBy(24.dp)
        ) {
        TokenHeroSection(token)
        SwatchSection(token)
        TokenSpecsSection(token)
        UsagesSection(token)
        DosDontsSection(token)
        GuidelineSection(token)
        }
    }
}


@Composable
private fun stringResourceByName(name: String): String {
    val context = androidx.compose.ui.platform.LocalContext.current
    val resId = context.resources.getIdentifier(
        name.replace(".", "_"),
        "string",
        context.packageName
    )
    return if (resId != 0) {
        androidx.compose.ui.res.stringResource(id = resId)
    } else {
        name
    }
}

@Composable
private fun TokenHeroSection(token: ColorTokenDetail) {
    Column {
        Text(
            text = "— ${stringResourceByName(token.category.titleKey).uppercase()}",
            style = MaterialTheme.typography.labelSmall,
            color = ZodiakTheme.colors.textSecondary
        )
        Spacer(modifier = Modifier.height(8.dp))
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically
        ) {
            Text(
                text = token.name,
                style = MaterialTheme.typography.displaySmall.copy(fontFamily = FontFamily.Monospace),
                color = ZodiakTheme.colors.textPrimary
            )
            Box(
                modifier = Modifier
                    .background(ZodiakTheme.colors.surfaceSmoke, RoundedCornerShape(4.dp))
                    .padding(horizontal = 8.dp, vertical = 4.dp)
            ) {
                Text(
                    text = if (token.isAdaptive) "Adaptável" else "Fixo",
                    style = MaterialTheme.typography.labelSmall,
                    color = ZodiakTheme.colors.textSecondary
                )
            }
        }
        Spacer(modifier = Modifier.height(8.dp))
        Text(
            text = token.intent,
            style = MaterialTheme.typography.bodyLarge,
            color = ZodiakTheme.colors.textSecondary
        )
        Spacer(modifier = Modifier.height(4.dp))
        Text(
            text = token.primitiveRef,
            style = MaterialTheme.typography.bodyMedium.copy(fontFamily = FontFamily.Monospace),
            color = ZodiakTheme.colors.textSecondary
        )
    }
}

@Composable
private fun SwatchSection(token: ColorTokenDetail) {
    // A simulação de swatches light e dark usando as funções fixas
    val lightColors = ZodiakSemanticColors.light()
    val darkColors = ZodiakSemanticColors.dark()
    
    val lightColor = token.colorSelector(lightColors)
    val darkColor = token.colorSelector(darkColors)
    
    Row(
        modifier = Modifier.fillMaxWidth(),
        horizontalArrangement = Arrangement.spacedBy(16.dp)
    ) {
        Column(modifier = Modifier.weight(1f)) {
            Box(
                modifier = Modifier
                    .fillMaxWidth()
                    .aspectRatio(1f)
                    .clip(RoundedCornerShape(16.dp))
                    .background(lightColor)
                    .border(1.dp, ZodiakTheme.colors.surfaceSmoke, RoundedCornerShape(16.dp))
            )
            Spacer(modifier = Modifier.height(8.dp))
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween
            ) {
                Text(text = "Claro", style = MaterialTheme.typography.bodySmall, color = ZodiakTheme.colors.textSecondary)
                Text(text = "#%06X".format(lightColor.toArgb() and 0xFFFFFF), style = MaterialTheme.typography.bodySmall.copy(fontFamily = FontFamily.Monospace), color = ZodiakTheme.colors.textPrimary)
            }
        }
        Column(modifier = Modifier.weight(1f)) {
            Box(
                modifier = Modifier
                    .fillMaxWidth()
                    .aspectRatio(1f)
                    .clip(RoundedCornerShape(16.dp))
                    .background(darkColor)
                    .border(1.dp, ZodiakTheme.colors.surfaceSmoke, RoundedCornerShape(16.dp))
            )
            Spacer(modifier = Modifier.height(8.dp))
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween
            ) {
                Text(text = "Escuro", style = MaterialTheme.typography.bodySmall, color = ZodiakTheme.colors.textSecondary)
                Text(text = "#%06X".format(darkColor.toArgb() and 0xFFFFFF), style = MaterialTheme.typography.bodySmall.copy(fontFamily = FontFamily.Monospace), color = ZodiakTheme.colors.textPrimary)
            }
        }
    }
}

@Composable
private fun TokenSpecsSection(token: ColorTokenDetail) {
    Column(
        modifier = Modifier
            .fillMaxWidth()
            .clip(RoundedCornerShape(16.dp))
            .background(ZodiakTheme.colors.surface)
            .padding(16.dp)
    ) {
        Text(text = "Token", style = MaterialTheme.typography.titleLarge, color = ZodiakTheme.colors.textPrimary)
        Spacer(modifier = Modifier.height(16.dp))
        SpecRow("Primitivo", token.primitiveRef)
        SpecRow("Modo", if(token.isAdaptive) "Adaptável" else "Fixo")
        SpecRow("Categoria", stringResourceByName(token.category.titleKey))
    }
}

@Composable
private fun SpecRow(label: String, value: String) {
    Row(modifier = Modifier.padding(vertical = 4.dp)) {
        Text(
            text = label,
            style = MaterialTheme.typography.bodyMedium,
            color = ZodiakTheme.colors.textSecondary,
            modifier = Modifier.width(100.dp)
        )
        Text(
            text = value,
            style = MaterialTheme.typography.bodyMedium,
            color = ZodiakTheme.colors.textPrimary
        )
    }
}

@Composable
private fun UsagesSection(token: ColorTokenDetail) {
    if (token.usageKeys.isEmpty()) return
    Column(
        modifier = Modifier
            .fillMaxWidth()
            .clip(RoundedCornerShape(16.dp))
            .background(ZodiakTheme.colors.surface)
            .padding(16.dp)
    ) {
        Text(text = "Usos", style = MaterialTheme.typography.titleLarge, color = ZodiakTheme.colors.textPrimary)
        Spacer(modifier = Modifier.height(16.dp))
        token.usageKeys.forEach { key ->
            Row(modifier = Modifier.padding(vertical = 4.dp)) {
                Text("›", style = MaterialTheme.typography.bodyMedium, color = ZodiakTheme.colors.textSecondary)
                Spacer(modifier = Modifier.width(8.dp))
                Text(text = stringResourceByName(key), style = MaterialTheme.typography.bodyMedium, color = ZodiakTheme.colors.textPrimary)
            }
        }
    }
}

@Composable
private fun DosDontsSection(token: ColorTokenDetail) {
    if (token.doKeys.isEmpty() && token.dontKeys.isEmpty()) return
    Column(
        modifier = Modifier
            .fillMaxWidth()
            .clip(RoundedCornerShape(16.dp))
            .background(ZodiakTheme.colors.surface)
            .padding(16.dp)
    ) {
        Text(text = "Boas práticas", style = MaterialTheme.typography.titleLarge, color = ZodiakTheme.colors.textPrimary)
        Spacer(modifier = Modifier.height(16.dp))
        Row(modifier = Modifier.fillMaxWidth()) {
            Column(modifier = Modifier.weight(1f)) {
                Text("Faça", style = MaterialTheme.typography.titleMedium, color = ZodiakTheme.colors.textPrimary)
                token.doKeys.forEach { key ->
                    Text("• ${stringResourceByName(key)}", style = MaterialTheme.typography.bodyMedium, color = ZodiakTheme.colors.textSecondary)
                }
            }
            Column(modifier = Modifier.weight(1f)) {
                Text("Evite", style = MaterialTheme.typography.titleMedium, color = ZodiakTheme.colors.textPrimary)
                token.dontKeys.forEach { key ->
                    Text("• ${stringResourceByName(key)}", style = MaterialTheme.typography.bodyMedium, color = ZodiakTheme.colors.textSecondary)
                }
            }
        }
    }
}

@Composable
private fun GuidelineSection(token: ColorTokenDetail) {
    Column(
        modifier = Modifier
            .fillMaxWidth()
            .clip(RoundedCornerShape(16.dp))
            .background(ZodiakTheme.colors.surface)
            .padding(16.dp)
    ) {
        Text(text = "Google Material & Stitch", style = MaterialTheme.typography.titleLarge, color = ZodiakTheme.colors.textPrimary)
        Spacer(modifier = Modifier.height(8.dp))
        Text(text = stringResourceByName(token.guideline.sectionKey), style = MaterialTheme.typography.titleMedium, color = ZodiakTheme.colors.textPrimary)
        Spacer(modifier = Modifier.height(8.dp))
        Text(text = stringResourceByName(token.guideline.excerptKey), style = MaterialTheme.typography.bodyMedium, color = ZodiakTheme.colors.textSecondary)
    }
}
