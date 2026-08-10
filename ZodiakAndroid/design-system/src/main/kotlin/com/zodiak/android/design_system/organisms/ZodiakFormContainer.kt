package com.zodiak.android.design_system.organisms

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ColumnScope
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import com.zodiak.android.design_system.atoms.ZodiakHeadline
import com.zodiak.android.design_system.theme.ZodiakRadii
import com.zodiak.android.design_system.theme.ZodiakSpacing

/**
 * Container de formulário com título e conteúdo dentro de um Card.
 * Equivale ao ZodiakFormContainer do iOS.
 */
@Composable
fun ZodiakFormContainer(
    title: String,
    modifier: Modifier = Modifier,
    content: @Composable ColumnScope.() -> Unit,
) {
    Card(
        modifier = modifier.fillMaxWidth(),
        colors = CardDefaults.cardColors(
            containerColor = MaterialTheme.colorScheme.surfaceVariant,
        ),
        shape = RoundedCornerShape(ZodiakRadii.s),
    ) {
        Column(
            modifier = Modifier.padding(ZodiakSpacing.s16),
        ) {
            ZodiakHeadline(title)
            Spacer(Modifier.height(ZodiakSpacing.s16))
            content()
        }
    }
}
