> **Platform**: Android

# ZodiakTextField ✅ Ported

```kotlin
@Composable
fun ZodiakTextField(
    value: String,
    onValueChange: (String) -> Unit,
    label: String,
    modifier: Modifier = Modifier,
    placeholder: String? = null,
    isPassword: Boolean = false,
    isError: Boolean = false,
    supportingText: String? = null,
    keyboardType: KeyboardType = KeyboardType.Text,
    imeAction: ImeAction = ImeAction.Next,
    keyboardActions: KeyboardActions = KeyboardActions.Default,
    singleLine: Boolean = true,
    maxLines: Int = 1,
    readOnly: Boolean = false,
    trailingIcon: @Composable (() -> Unit)? = null,
)
```

**When to use:** Primitive text input. In feature screens, prefer `ZodiakInputField` (molecule) which adds error state handling.

**Built-in capabilities:**
- Password toggle via `isPassword = true` (no separate `ZodiakPasswordField` needed)
- Error state via `isError = true` + `supportingText` for the message
- Custom trailing icon via `trailingIcon` (use for search icon, clear button, etc.)

```kotlin
// ✅ In feature screen — prefer ZodiakInputField
ZodiakInputField(
    value = uiState.name,
    onValueChange = viewModel::onNameChange,
    label = stringResource(R.string.shared_label_name),
    errorMessage = uiState.nameError?.let { stringResource(R.string.shared_validation_blank_field) },
)

// ✅ ZodiakTextField directly when full control is needed
ZodiakTextField(
    value = uiState.search,
    onValueChange = viewModel::onSearchChange,
    label = stringResource(R.string.shared_placeholder_search),
    keyboardType = KeyboardType.Text,
    imeAction = ImeAction.Search,
    trailingIcon = { Icon(Icons.Default.Search, contentDescription = null) },
)
```

---
