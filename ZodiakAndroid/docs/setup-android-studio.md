# Guia de Setup e Execucao (Android Studio)

Este guia foi feito para quem acabou de baixar o projeto e quer rodar sem bloqueios.

## 1) Pre-requisitos

- Android Studio atualizado (versao recente estavel).
- JDK 17 configurado no Android Studio.
- Android SDK com API 35 (compileSdk/targetSdk do projeto).
- Emulador Android (API 26+) ou dispositivo fisico com depuracao USB.
- Internet ativa para dependencias Gradle e consumo da PokeAPI.

## 2) Clonar e abrir o projeto

1. Clone o repositorio.
2. Abra o Android Studio.
3. Selecione Open e escolha a pasta raiz do projeto:
   - ZodiakAndroid/
4. Aguarde indexacao inicial.

## 3) Sincronizar Gradle (passo obrigatorio)

- Clique em Sync Project with Gradle Files.
- Se aparecer aviso de JDK, selecione JDK 17.
- Se pedir update de plugin/gradle, aceite apenas se compativel com o projeto.

Arquivos de referencia de versoes:
- app/build.gradle.kts
- gradle/libs.versions.toml
- gradle/wrapper/gradle-wrapper.properties

## 4) Configuracao de SDK/Emulador

1. Android Studio > Settings > Android SDK
2. Garanta instalado:
   - Android SDK Platform 35
   - Android SDK Build-Tools
   - Android Emulator
3. Crie um AVD (Pixel recomendado) com API 26+.

## 5) Rodar o app

1. Em Run/Debug configuration, selecione modulo app.
2. Selecione emulador ou dispositivo.
3. Clique Run.

## 5.1) Banco de dados (duvida comum)

- Nao e necessario criar banco manualmente para executar o projeto.
- O Save Kids usa Room local e o app cria o banco automaticamente na primeira execucao.
- O arquivo local usa o nome savekids.db (sandbox interno do app).
- Sessao/perfil usam DataStore local.
- Nao ha requisito de MySQL, PostgreSQL, SQL Server ou outro banco externo para rodar o app.

## 6) Primeiro acesso no app (Save Kids)

1. Na Home principal, abra o card Save Kids.
2. Login demo:
   - usuario: teste
   - senha: teste
3. Siga fluxo de perfil/avatar (se solicitado).

## 7) Validacao rapida (smoke test)

Depois de rodar, valide em 2-3 minutos:

1. Login funciona com teste/teste.
2. Home Save Kids abre com dashboard (saldo/XP/nivel).
3. Avatar atual aparece (com imagem quando API/rede disponivel).
4. Pelo menos 1 meta aparece na visao geral (seed inicial).
5. Navegacao por abas/telas da feature funciona sem crash.

## 8) Comandos uteis (opcionais)

Observacao importante para Windows:
- Neste repositorio existe gradlew, mas nao existe gradlew.bat.
- Para evitar bloqueio no Windows, prefira executar build/test pelo Android Studio.

Se estiver em shell compativel com script Unix (Git Bash/WSL/macOS/Linux), voce pode usar:

- ./gradlew clean
- ./gradlew :app:assembleDebug
- ./gradlew :app:test

## 9) Troubleshooting (erros comuns)

### 9.1 Sync do Gradle falha

- Verifique internet e proxy.
- Confirme JDK 17 no projeto.
- Execute File > Invalidate Caches / Restart.
- Reabra projeto e sincronize novamente.

### 9.2 Build falha por dependencias

- Rode nova sincronizacao Gradle.
- Verifique se API 35 e Build Tools estao instalados.
- Confira se nao houve alteracao manual indevida em libs.versions.toml.

### 9.3 Avatar nao mostra imagem

- Verifique internet do emulador/dispositivo.
- Teste botao Atualizar avatar na tela Save Kids.
- Em redes restritas (empresa/faculdade), teste outra rede.

### 9.4 App abre mas tela fica estranha/desatualizada

- Limpe app no dispositivo/emulador (Clear data).
- Reinstale app (Run novamente).
- Invalidate Caches / Restart no Android Studio.

### 9.5 Erro de dispositivo nao detectado

- Emulador: reinicie AVD.
- Dispositivo fisico: habilite depuracao USB e autorize chave.
- Troque cabo/porta USB se necessario.

## 10) Estrutura principal para se orientar no codigo

Feature Save Kids:
- app/src/main/kotlin/com/zodiak/android/feature/savekids/model/
- app/src/main/kotlin/com/zodiak/android/feature/savekids/view/
- app/src/main/kotlin/com/zodiak/android/feature/savekids/viewmodel/
- app/src/main/kotlin/com/zodiak/android/feature/savekids/repository/
- app/src/main/kotlin/com/zodiak/android/feature/savekids/data/
- app/src/main/kotlin/com/zodiak/android/feature/savekids/navigation/

Design System:
- design-system/src/main/kotlin/com/zodiak/android/design_system/

## 11) Dicas para quem acabou de baixar

- Comece rodando somente pelo Android Studio (mais simples e previsivel).
- Nao mude versoes de plugin/dependencia sem necessidade.
- Valide primeiro o fluxo Save Kids com teste/teste antes de mexer em codigo.
- Ao editar UI, use componentes do DS para manter consistencia.

## 12) Checklist final de onboarding

- [ ] Projeto abriu sem erros.
- [ ] Gradle sync concluido.
- [ ] Emulador/dispositivo configurado.
- [ ] App executou.
- [ ] Save Kids login funcionou.
- [ ] Home com dashboard e avatar carregou.
