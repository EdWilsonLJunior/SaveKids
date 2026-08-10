#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# flatten-modules.sh
#
# Migra a estrutura atual (24 módulos) para 3 módulos:
#   :design-system   (Android lib, Compose) — inalterado
#   :core            (Kotlin JVM puro)      — models + services + tests
#   :app             (Android application)  — datastore + 19 features + UI
#
# Como é seguro:
#   - Usa `git mv` para preservar histórico
#   - Falha imediatamente em qualquer erro (set -euo pipefail)
#   - Refuse-to-run se a estrutura nova já existir parcialmente
#   - NÃO sobrescreve arquivos Gradle: gera-os em scripts/.flatten-templates/
#     e você copia manualmente quando quiser
#
# Uso:
#   1) Garanta árvore limpa:                   git status
#   2) Crie um branch:                          git checkout -b chore/flatten-modules
#   3) Execute (dry-run primeiro):              ./scripts/flatten-modules.sh --dry-run
#   4) Execute de verdade:                      ./scripts/flatten-modules.sh
#   5) Copie os templates Gradle gerados:       ./scripts/flatten-modules.sh --apply-gradle
#   6) Atualize settings.gradle.kts manualmente (instruções no final do script)
#   7) Rode `./gradlew :app:assembleDebug`
#   8) Resolva eventuais conflitos de R.string.* (mensagem ao final)
# ─────────────────────────────────────────────────────────────────────────────

set -euo pipefail

# Resolve repo root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$ROOT"

DRY_RUN=0
APPLY_GRADLE=0
for arg in "$@"; do
  case "$arg" in
    --dry-run)       DRY_RUN=1 ;;
    --apply-gradle)  APPLY_GRADLE=1 ;;
    -h|--help)
      sed -n '1,40p' "$0"; exit 0 ;;
    *) echo "Argumento desconhecido: $arg"; exit 2 ;;
  esac
done

say()  { printf '\033[1;36m[flatten]\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m[flatten]\033[0m %s\n' "$*"; }
err()  { printf '\033[1;31m[flatten]\033[0m %s\n' "$*" >&2; }

run() {
  if [[ $DRY_RUN -eq 1 ]]; then
    printf '  DRY: %s\n' "$*"
  else
    eval "$@"
  fi
}

# Move file/dir using git mv if tracked, else regular mv. Creates parent.
gmv() {
  local src="$1" dst="$2"
  [[ ! -e "$src" ]] && { warn "skip (não existe): $src"; return 0; }
  local dst_parent
  dst_parent="$(dirname "$dst")"
  run "mkdir -p '$dst_parent'"
  if [[ $DRY_RUN -eq 1 ]]; then
    printf '  DRY MV: %s  ->  %s\n' "$src" "$dst"
    return 0
  fi
  if git ls-files --error-unmatch "$src" >/dev/null 2>&1; then
    git mv -k "$src" "$dst" 2>/dev/null || mv "$src" "$dst"
  else
    mv "$src" "$dst"
  fi
}

# ─── pré-checagens ───────────────────────────────────────────────────────────
[[ -d .git ]] || { err "Rode na raiz do repo (não encontrei .git)."; exit 1; }

if ! git diff --quiet || ! git diff --cached --quiet; then
  err "Working tree suja. Commit/stash antes de rodar."
  exit 1
fi

if [[ -d core/src ]]; then
  err "core/src já existe — script parece ter sido rodado. Aborto."
  exit 1
fi

# ─── apply-gradle mode (só copia templates) ──────────────────────────────────
TEMPLATES="$ROOT/scripts/.flatten-templates"
if [[ $APPLY_GRADLE -eq 1 ]]; then
  say "Copiando templates Gradle para o repo…"
  [[ -d $TEMPLATES ]] || { err "Templates não gerados ainda. Rode primeiro sem --apply-gradle."; exit 1; }
  run "cp '$TEMPLATES/core.build.gradle.kts' core/build.gradle.kts"
  run "cp '$TEMPLATES/app.build.gradle.kts'  app/build.gradle.kts"
  run "cp '$TEMPLATES/settings.gradle.kts'   settings.gradle.kts"
  run "cp '$TEMPLATES/zodiak.android.application.gradle.kts' build-logic/src/main/kotlin/zodiak.android.application.gradle.kts"
  run "cp '$TEMPLATES/zodiak.android.library.gradle.kts'     build-logic/src/main/kotlin/zodiak.android.library.gradle.kts"
  say "Templates aplicados. Confira o diff e ajuste se preciso."
  exit 0
fi

say "Iniciando migração (dry-run=$DRY_RUN)…"

# ─── 1. :core (Kotlin JVM puro) ───────────────────────────────────────────────
say "Consolidando :core (models + services)…"
gmv core/models/src/main/kotlin              core/src/main/kotlin
# core/services pode coexistir? não — diretórios já têm subpastas com mesmo prefixo de pacote
# (com/zodiak/android/core/services) mas em destinos diferentes. Solução: mover conteúdo merge.
if [[ -d core/services/src/main/kotlin/com/zodiak/android/core/services ]]; then
  run "mkdir -p core/src/main/kotlin/com/zodiak/android/core/services"
  for f in core/services/src/main/kotlin/com/zodiak/android/core/services/*; do
    [[ -e "$f" ]] || continue
    gmv "$f" "core/src/main/kotlin/com/zodiak/android/core/services/$(basename "$f")"
  done
fi
# tests do services
if [[ -d core/services/src/test/kotlin ]]; then
  gmv core/services/src/test/kotlin           core/src/test/kotlin
fi

# ─── 2. :app absorve datastore ────────────────────────────────────────────────
say "Movendo core/datastore para :app…"
if [[ -d core/datastore/src/main/kotlin/com/zodiak/android/core/datastore ]]; then
  run "mkdir -p app/src/main/kotlin/com/zodiak/android/core/datastore"
  for f in core/datastore/src/main/kotlin/com/zodiak/android/core/datastore/*; do
    [[ -e "$f" ]] || continue
    gmv "$f" "app/src/main/kotlin/com/zodiak/android/core/datastore/$(basename "$f")"
  done
fi

# ─── 3. :app absorve core/testing (MainDispatcherExtension etc.) ──────────────
say "Movendo core/testing para app/src/test…"
if [[ -d core/testing/src/main/kotlin/com/zodiak/android/core/testing ]]; then
  run "mkdir -p app/src/test/kotlin/com/zodiak/android/core/testing"
  for f in core/testing/src/main/kotlin/com/zodiak/android/core/testing/*; do
    [[ -e "$f" ]] || continue
    gmv "$f" "app/src/test/kotlin/com/zodiak/android/core/testing/$(basename "$f")"
  done
fi

# ─── 4. :app absorve features ─────────────────────────────────────────────────
say "Absorvendo features…"
shopt -s nullglob
for feat_dir in features/feature-*; do
  feat="$(basename "$feat_dir")"             # ex: feature-grades
  short="${feat#feature-}"                    # ex: grades
  say "  • $feat -> :app/.../feature/$short"

  # Kotlin main
  if [[ -d "$feat_dir/src/main/kotlin/com/zodiak/android/feature/$short" ]]; then
    run "mkdir -p app/src/main/kotlin/com/zodiak/android/feature/$short"
    for f in "$feat_dir/src/main/kotlin/com/zodiak/android/feature/$short/"*; do
      [[ -e "$f" ]] || continue
      gmv "$f" "app/src/main/kotlin/com/zodiak/android/feature/$short/$(basename "$f")"
    done
  fi

  # Kotlin test
  if [[ -d "$feat_dir/src/test/kotlin/com/zodiak/android/feature/$short" ]]; then
    run "mkdir -p app/src/test/kotlin/com/zodiak/android/feature/$short"
    for f in "$feat_dir/src/test/kotlin/com/zodiak/android/feature/$short/"*; do
      [[ -e "$f" ]] || continue
      gmv "$f" "app/src/test/kotlin/com/zodiak/android/feature/$short/$(basename "$f")"
    done
  fi

  # Resources — values
  if [[ -f "$feat_dir/src/main/res/values/strings.xml" ]]; then
    gmv "$feat_dir/src/main/res/values/strings.xml" "app/src/main/res/values/strings_${short}.xml"
  fi
  # Outros XMLs em values (raros)
  if [[ -d "$feat_dir/src/main/res/values" ]]; then
    for x in "$feat_dir/src/main/res/values/"*.xml; do
      [[ -e "$x" ]] || continue
      bn="$(basename "$x")"
      [[ "$bn" == "strings.xml" ]] && continue # já tratado
      gmv "$x" "app/src/main/res/values/${short}_${bn}"
    done
  fi

  # Resources — values-b+pt+BR (locale Android)
  for locdir in "$feat_dir/src/main/res/"values-* ; do
    [[ -d "$locdir" ]] || continue
    locname="$(basename "$locdir")"
    if [[ -f "$locdir/strings.xml" ]]; then
      run "mkdir -p app/src/main/res/$locname"
      gmv "$locdir/strings.xml" "app/src/main/res/$locname/strings_${short}.xml"
    fi
    for x in "$locdir/"*.xml; do
      [[ -e "$x" ]] || continue
      bn="$(basename "$x")"
      [[ "$bn" == "strings.xml" ]] && continue
      run "mkdir -p app/src/main/res/$locname"
      gmv "$x" "app/src/main/res/$locname/${short}_${bn}"
    done
  done

  # AndroidManifest — só preserva se tiver conteúdo customizado
  if [[ -f "$feat_dir/src/main/AndroidManifest.xml" ]]; then
    # heurística simples: se contém <application> ou <activity> ou <permission>, alerta
    if grep -qE '<(application|activity|service|receiver|provider|uses-permission)' "$feat_dir/src/main/AndroidManifest.xml" 2>/dev/null; then
      warn "    manifesto não-trivial em $feat — revise manualmente: $feat_dir/src/main/AndroidManifest.xml"
    fi
  fi
done
shopt -u nullglob

# ─── 5. Remove diretórios antigos ─────────────────────────────────────────────
say "Removendo módulos antigos…"
for old in core/models core/services core/datastore core/testing features; do
  if [[ -d "$old" ]]; then
    if [[ $DRY_RUN -eq 1 ]]; then
      printf '  DRY RM: %s\n' "$old"
    else
      git rm -rf --quiet "$old" 2>/dev/null || rm -rf "$old"
    fi
  fi
done

# ─── 6. Geração de templates Gradle ──────────────────────────────────────────
say "Gerando templates Gradle em scripts/.flatten-templates/ …"
mkdir -p "$TEMPLATES"

cat > "$TEMPLATES/core.build.gradle.kts" <<'EOF'
// :core — Kotlin JVM puro (sem AGP). Build muito mais rápido que Android library.
plugins {
    alias(libs.plugins.kotlin.jvm)
}

dependencies {
    testImplementation(libs.junit5.api)
    testRuntimeOnly(libs.junit5.engine)
    testImplementation(libs.junit5.params)
}

tasks.withType<Test>().configureEach {
    useJUnitPlatform()
}

java {
    sourceCompatibility = JavaVersion.VERSION_17
    targetCompatibility = JavaVersion.VERSION_17
}

kotlin {
    jvmToolchain(17)
}
EOF

cat > "$TEMPLATES/app.build.gradle.kts" <<'EOF'
plugins {
    alias(libs.plugins.zodiak.android.application)
    alias(libs.plugins.kotlin.compose)
    alias(libs.plugins.kotlin.serialization)
    alias(libs.plugins.hilt)
    alias(libs.plugins.ksp)
}

android {
    namespace  = "com.zodiak.android"
    defaultConfig {
        applicationId = "com.zodiak.android"
        versionCode   = 1
        versionName   = "1.0"
    }
    buildFeatures {
        compose = true
    }
    testOptions {
        unitTests.all { it.useJUnitPlatform() }
    }
}

dependencies {
    implementation(project(":core"))
    implementation(project(":design-system"))

    // AndroidX
    implementation(libs.androidx.core.ktx)
    implementation(libs.androidx.lifecycle.runtime)
    implementation(libs.androidx.lifecycle.viewmodel)
    implementation(libs.androidx.activity.compose)

    // Compose
    implementation(platform(libs.compose.bom))
    implementation(libs.compose.ui)
    implementation(libs.compose.ui.graphics)
    implementation(libs.compose.ui.tooling.preview)
    implementation(libs.compose.material3)
    implementation(libs.compose.material3.nav.suite)
    debugImplementation(libs.compose.ui.tooling)
    debugImplementation(libs.compose.ui.test.manifest)

    // Navigation + Serialization (type-safe routes)
    implementation(libs.navigation.compose)
    implementation(libs.kotlinx.serialization.json)
    implementation(libs.hilt.navigation.compose)

    // Hilt
    implementation(libs.hilt.android)
    ksp(libs.hilt.compiler)

    // DataStore (absorvido aqui)
    implementation(libs.datastore.preferences)

    // Coroutines + Immutable collections
    implementation(libs.kotlinx.coroutines.android)
    implementation(libs.kotlinx.collections.immutable)

    // Testing
    testImplementation(libs.junit5.api)
    testRuntimeOnly(libs.junit5.engine)
    testImplementation(libs.junit5.params)
    testImplementation(libs.mockk)
    testImplementation(libs.turbine)
    testImplementation(libs.kotlinx.coroutines.test)
}
EOF

cat > "$TEMPLATES/settings.gradle.kts" <<'EOF'
pluginManagement {
    includeBuild("build-logic")
    repositories {
        google {
            content {
                includeGroupByRegex("com\\.android.*")
                includeGroupByRegex("com\\.google.*")
                includeGroupByRegex("androidx.*")
            }
        }
        mavenCentral()
        gradlePluginPortal()
    }
}
plugins {
    id("org.gradle.toolchains.foojay-resolver-convention") version "0.10.0"
}

dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.name = "ZodiakAndroid"

include(":core")
include(":design-system")
include(":app")
EOF

cat > "$TEMPLATES/zodiak.android.application.gradle.kts" <<'EOF'
import org.gradle.api.JavaVersion
import com.android.build.gradle.ProguardFiles.getDefaultProguardFile
import org.gradle.kotlin.dsl.configure

// zodiak.android.application — aplicado apenas no módulo :app
plugins {
    id("org.jetbrains.kotlin.android")
    id("com.android.application")
}

android {
    namespace = "com.zodiak.android"
    compileSdk = 35

    defaultConfig {
        applicationId = "com.zodiak.android"
        minSdk = 26
        targetSdk = 35
        versionCode = 1
        versionName = "1.0.0"

        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
        vectorDrawables { useSupportLibrary = true }
    }

    buildTypes {
        release {
            isMinifyEnabled = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
        debug {
            applicationIdSuffix = ".debug"
            isDebuggable = true
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions { jvmTarget = "17" }

    packaging {
        resources { excludes += "/META-INF/{AL2.0,LGPL2.1}" }
    }
}
EOF

cat > "$TEMPLATES/zodiak.android.library.gradle.kts" <<'EOF'
// zodiak.android.library — aplicado apenas em :design-system
plugins {
    id("org.jetbrains.kotlin.android")
    id("com.android.library")
}

android {
    compileSdk = 35

    defaultConfig {
        minSdk = 26
        consumerProguardFiles("consumer-rules.pro")
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions { jvmTarget = "17" }

    buildTypes {
        release { isMinifyEnabled = false }
    }
}
EOF

say "Templates Gradle gerados em: scripts/.flatten-templates/"

# ─── 7. Resumo final ─────────────────────────────────────────────────────────
cat <<'POST'

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 Próximos passos (manuais):

 1) Revise o resultado:
      git status
      git diff --stat

 2) Aplique os templates Gradle gerados:
      ./scripts/flatten-modules.sh --apply-gradle

 3) Adicione ao libs.versions.toml (se ainda não houver):
      [plugins]
      kotlin-jvm = { id = "org.jetbrains.kotlin.jvm", version.ref = "kotlin" }

 4) Atualize design-system/build.gradle.kts:
      • troque a dependência (project(":core:models")) por (project(":core"))
        se houver alguma.
      • adicione plugin kotlin-compose se ainda não estiver via convention.

 5) Delete plugins de build-logic não usados:
      rm build-logic/src/main/kotlin/zodiak.android.feature.gradle.kts
      rm build-logic/src/main/kotlin/zodiak.android.hilt.gradle.kts
      rm build-logic/src/main/kotlin/zodiak.android.compose.gradle.kts
      rm build-logic/src/main/kotlin/zodiak.android.test.gradle.kts

 6) Pare o daemon e builde:
      ./gradlew --stop
      ./gradlew :app:assembleDebug

 7) Se houver colisão de R.string.* entre features (duas features usavam o
    mesmo nome, ex: "button_calculate"), prefixe a chave conflitante:
      • renomeie em app/src/main/res/values{,-b+pt+BR}/strings_<feature>.xml
      • atualize R.string.X -> R.string.<feature>_X nos .kt da feature

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
POST
