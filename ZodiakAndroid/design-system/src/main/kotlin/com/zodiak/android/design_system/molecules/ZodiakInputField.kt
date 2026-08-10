package com.zodiak.android.design_system.molecules

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.height
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp
import com.zodiak.android.design_system.atoms.ZodiakTextField

/**
 * Campo de entrada com label obrigatório acima e mensagem de erro/suporte abaixo.
 * Encapsula ZodiakTextField com semântica de formulário.
 */
@Composable
fun ZodiakInputField(
    value: String,
    onValueChange: (String) -> Unit,
    label: String,
    modifier: Modifier = Modifier,
    placeholder: String? = null,
    errorMessage: String? = null,
    isPassword: Boolean = false,
    keyboardType: KeyboardType = KeyboardType.Text,
    imeAction: ImeAction = ImeAction.Next,
    singleLine: Boolean = true,
) {
    ZodiakTextField(
        value = value,
        onValueChange = onValueChange,
        label = label,
        modifier = modifier,
        placeholder = placeholder,
        isError = errorMessage != null,
        supportingText = errorMessage,
        isPassword = isPassword,
        keyboardType = keyboardType,
        imeAction = imeAction,
        singleLine = singleLine,
    )
}
