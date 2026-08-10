package com.zodiak.android.feature.savekids.view

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.Image
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowBack
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import coil3.compose.AsyncImage
import com.zodiak.android.design_system.atoms.ZodiakIconView
import com.zodiak.android.design_system.organisms.ZodiakSegmentedTabItem
import com.zodiak.android.design_system.organisms.ZodiakSegmentedTabs
import com.zodiak.android.design_system.theme.zodiakHitTarget
import com.zodiak.android.R
import com.zodiak.android.feature.savekids.navigation.SaveKidsTabItem

@Composable
fun SaveKidsTabs(
    tabs: List<SaveKidsTabItem>,
    currentRoute: Any,
    onNavigate: (Any) -> Unit,
) {
    val dsTabs = tabs.map {
        ZodiakSegmentedTabItem(
            label = it.label,
            selected = it.route::class == currentRoute::class,
            onClick = { onNavigate(it.route) },
        )
    }
    ZodiakSegmentedTabs(items = dsTabs)
}

@Composable
fun SaveKidsBackButton(onBack: () -> Unit) {
    Row(
        modifier = Modifier.fillMaxWidth(),
        horizontalArrangement = Arrangement.Start,
    ) {
        IconButton(onClick = onBack, modifier = Modifier.zodiakHitTarget()) {
            ZodiakIconView(
                imageVector = Icons.AutoMirrored.Filled.ArrowBack,
                contentDescription = "Voltar",
            )
        }
    }
}

@Composable
fun SaveKidsPokemonAvatar(
    imageUrl: String?,
    contentDescription: String,
    size: Dp = 96.dp,
) {
    Box(
        modifier = Modifier
            .size(size)
            .clip(RoundedCornerShape(18.dp))
            .background(MaterialTheme.colorScheme.surfaceVariant)
            .border(1.dp, MaterialTheme.colorScheme.outlineVariant, RoundedCornerShape(18.dp)),
        contentAlignment = Alignment.Center,
    ) {
        if (!imageUrl.isNullOrBlank()) {
            AsyncImage(
                model = imageUrl,
                contentDescription = contentDescription,
                modifier = Modifier.fillMaxSize(),
                contentScale = ContentScale.Fit,
            )
        } else {
            Image(
                painter = painterResource(id = R.drawable.ic_launcher_foreground),
                contentDescription = null,
                modifier = Modifier.size(size * 0.52f),
                contentScale = ContentScale.Fit,
                alpha = 0.45f,
            )
        }
    }
}
