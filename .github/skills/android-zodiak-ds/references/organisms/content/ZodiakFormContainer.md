> **Platform**: Android

# ZodiakFormContainer ✅ Ported

```kotlin
@Composable
fun ZodiakFormContainer(
    title: String,
    modifier: Modifier = Modifier,
    content: @Composable ColumnScope.() -> Unit,
)
```

iOS equivalent: `ZodiakFormContainer`

**When to use:** Groups form fields inside a card with a title. Uses `MaterialTheme.colorScheme.surfaceVariant` background + `MaterialTheme.shapes.large` (16dp).

```kotlin
// ✅ Standard form
ZodiakFormContainer(
    title = stringResource(R.string.feature_grades_title),
    modifier = Modifier.fillMaxWidth(),
) {
    ZodiakInputField(
        value = uiState.studentName,
        onValueChange = viewModel::onNameChange,
        label = stringResource(R.string.feature_grades_student_name_label),
    )
    Spacer(Modifier.height(8.dp))
    ZodiakInputField(
        value = uiState.grade,
        onValueChange = viewModel::onGradeChange,
        label = stringResource(R.string.feature_grades_grade_label),
        keyboardType = KeyboardType.Decimal,
        imeAction = ImeAction.Done,
    )
}
```

**Layout structure:**
- Outer: `Card(colors = surfaceVariant, shape = large)`
- Inner: `Column(modifier = Modifier.padding(20.dp))`
- Header: `ZodiakHeadline(title)` + `Spacer(16.dp)`
- Content slot: receives the `@Composable ColumnScope.() -> Unit` block

---
