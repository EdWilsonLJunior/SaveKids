// Root build file — no code here; all config lives in convention plugins and modules.
plugins {
    alias(libs.plugins.android.application)    apply false
    alias(libs.plugins.android.library)        apply false
    alias(libs.plugins.kotlin.android)         apply false
    alias(libs.plugins.kotlin.compose)         apply false
    alias(libs.plugins.kotlin.serialization)   apply false
    alias(libs.plugins.hilt)                   apply false
    alias(libs.plugins.ksp)                    apply false
    alias(libs.plugins.paparazzi.plugin)       apply false
    alias(libs.plugins.detekt)
}

detekt {
    buildUponDefaultConfig = true
    allRules = false
    source.setFrom(
        fileTree(rootDir) {
            include("**/*.kt", "**/*.kts")
            exclude("**/build/**", "**/.gradle/**", "**/build-logic/**")
        }
    )
}
