> **Platform**: Android

# ⏳ ZodiakActivityTemplate — Standard Screen

iOS init:
```swift
ZodiakActivityTemplate(
    title: String,
    eyebrow: String? = nil,
    intro: String? = nil,
    content: () -> Content
)
```

**Android pattern:**
```kotlin
// TODO: replace with ZodiakActivityTemplate when ported
@Composable
fun FeatureNameScreen(
    viewModel: FeatureNameViewModel = hiltViewModel(),
    onBack: () -> Unit = {},
) {
    val uiState by viewModel.uiState.collectAsStateWithLifecycle()

    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text(stringResource(R.string.feature_name_title)) },
                navigationIcon = {
                    IconButton(onClick = onBack) {
                        Icon(Icons.Default.ArrowBack, contentDescription = null)
                    }
                },
            )
        }
    ) { paddingValues ->
        LazyColumn(
            modifier = Modifier
                .fillMaxSize()
                .padding(paddingValues)
                .padding(horizontal = 16.dp),
            verticalArrangement = Arrangement.spacedBy(16.dp),
            contentPadding = PaddingValues(vertical = 16.dp),
        ) {
            // content items
        }
    }
}
```

---
