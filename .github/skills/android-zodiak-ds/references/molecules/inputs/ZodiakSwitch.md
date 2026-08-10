> **Platform**: Android

# ZodiakSwitch ✅ Ported

```kotlin
@Composable
fun ZodiakSwitch(
    label: String,
    checked: Boolean,
    onCheckedChange: (Boolean) -> Unit,
    modifier: Modifier = Modifier,
    enabled: Boolean = true,
)
```

iOS equivalent: `ZodiakSwitch`

<rules>
**When to use:** Binary toggle with label and immediate effect. No Save button required.
</rules>

```kotlin
// ✅ Remember email toggle
ZodiakSwitch(
    label = stringResource(R.string.feature_login_remember_email),
    checked = uiState.rememberEmail,
    onCheckedChange = viewModel::onRememberEmailChange,
)
```

---
