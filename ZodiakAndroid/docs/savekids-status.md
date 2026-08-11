# Save Kids - Status de Atendimento dos Requisitos

Este documento descreve o que ja foi implementado no projeto Save Kids, onde cada ponto esta no codigo, como funciona em execucao e o que ainda falta (quando aplicavel).

## 1) Resumo executivo

- Escopo atual: MVP com 8 telas funcionais do Save Kids.
- Arquitetura: MVVM explicita com camadas de dados local e remota.
- Persistencia: Room + DataStore.
- API publica: PokeAPI para avatar/evolucao.
- Design: componentes e tokens alinhados ao DS Zodiak.

## 2) Matriz de conformidade (o que, onde e como)

### 2.1 Fluxo de acesso do app Save Kids

- Requisito: acesso unico ao Save Kids pela lista de funcionalidades.
- Status: Atendido.
- Onde:
  - app/src/main/kotlin/com/zodiak/android/navigation/HomeScreen.kt
  - app/src/main/kotlin/com/zodiak/android/feature/savekids/navigation/SaveKidsRoutes.kt
- Como:
  - A Home principal expone um unico card Save Kids que navega para SaveKidsLoginRoute.
  - O fluxo interno segue pelas rotas Save Kids.

### 2.2 Login em 2 passos (credenciais + perfil)

- Requisito: login com usuario/senha e configuracao inicial do perfil infantil.
- Status: Atendido.
- Onde:
  - app/src/main/kotlin/com/zodiak/android/feature/savekids/view/SaveKidsLoginScreen.kt
  - app/src/main/kotlin/com/zodiak/android/feature/savekids/viewmodel/SaveKidsLoginViewModel.kt
  - app/src/main/kotlin/com/zodiak/android/feature/savekids/repository/SaveKidsRepositoryImpl.kt
- Como:
  - Passo 1: autentica com credenciais demo teste/teste.
  - Passo 2: exige nome da crianca e avatar inicial.
  - Persiste sessao/perfil em DataStore e perfil em Room.

### 2.3 Navegacao entre 8 telas Save Kids

- Requisito: 8 telas principais com navegacao funcional.
- Status: Atendido.
- Onde:
  - app/src/main/kotlin/com/zodiak/android/feature/savekids/navigation/SaveKidsNavigation.kt
  - app/src/main/kotlin/com/zodiak/android/feature/savekids/view/
- Como:
  - Rotas registradas no NavGraph da feature.
  - Cada tela usa estado reativo (StateFlow) e callbacks de navegacao.
  - Botao voltar nas telas Save Kids com pop da pilha.

### 2.4 Dashboard/Home com saldo, XP, nivel e metas

- Requisito: visao geral com indicadores e foco em progresso.
- Status: Atendido.
- Onde:
  - app/src/main/kotlin/com/zodiak/android/feature/savekids/view/SaveKidsHomeScreen.kt
  - app/src/main/kotlin/com/zodiak/android/feature/savekids/viewmodel/SaveKidsHomeViewModel.kt
  - app/src/main/kotlin/com/zodiak/android/feature/savekids/repository/SaveKidsRepositoryImpl.kt
- Como:
  - Dashboard combina carteira, metas, missoes e recompensas via Flow.
  - Exibe saldo, XP, nivel, metas top e historico recente.

### 2.5 Cofrinho (deposito com validacao)

- Requisito: registrar economias com regra de valor.
- Status: Atendido.
- Onde:
  - app/src/main/kotlin/com/zodiak/android/feature/savekids/view/SaveKidsPiggyBankScreen.kt
  - app/src/main/kotlin/com/zodiak/android/feature/savekids/viewmodel/SaveKidsPiggyBankViewModel.kt
  - app/src/main/kotlin/com/zodiak/android/feature/savekids/repository/SaveKidsRepositoryImpl.kt
- Como:
  - Valida valor > 0 e <= 10.000.
  - Atualiza saldo, XP e historico.
  - Atualiza meta aberta com progresso automatico.

### 2.6 Metas

- Requisito: criar metas e acompanhar progresso.
- Status: Atendido.
- Onde:
  - app/src/main/kotlin/com/zodiak/android/feature/savekids/view/SaveKidsGoalsScreen.kt
  - app/src/main/kotlin/com/zodiak/android/feature/savekids/viewmodel/SaveKidsGoalsViewModel.kt
  - app/src/main/kotlin/com/zodiak/android/feature/savekids/repository/SaveKidsRepositoryImpl.kt
- Como:
  - Permite criar meta com nome e valor-alvo.
  - Progresso e status de conclusao aparecem na UI.
  - Bonus de XP em criacao/conclusao.

### 2.7 Missoes

- Requisito: listar e concluir missoes com recompensa.
- Status: Atendido.
- Onde:
  - app/src/main/kotlin/com/zodiak/android/feature/savekids/view/SaveKidsMissionsScreen.kt
  - app/src/main/kotlin/com/zodiak/android/feature/savekids/viewmodel/SaveKidsMissionsViewModel.kt
  - app/src/main/kotlin/com/zodiak/android/feature/savekids/model/SaveKidsModels.kt
- Como:
  - Status por enum (AVAILABLE/IN_PROGRESS/COMPLETED).
  - Ao concluir: soma XP e, se aplicavel, valor em carteira.
  - A carteira e validada antes de marcar a missao como concluida, para que a
    missao nunca seja consumida sem pagar a recompensa.
  - Observacao: IN_PROGRESS existe no enum mas nao e atribuido em nenhum fluxo atual.

### 2.8 Recompensas

- Requisito: desbloqueio por XP e sem resgate duplicado.
- Status: Atendido.
- Onde:
  - app/src/main/kotlin/com/zodiak/android/feature/savekids/view/SaveKidsRewardsScreen.kt
  - app/src/main/kotlin/com/zodiak/android/feature/savekids/viewmodel/SaveKidsRewardsViewModel.kt
  - app/src/main/kotlin/com/zodiak/android/feature/savekids/repository/SaveKidsRepositoryImpl.kt
- Como:
  - Exige XP minimo.
  - Impede resgatar item ja resgatado.
  - Debita XP no resgate.

### 2.9 Historico

- Requisito: trilha de eventos cronologica.
- Status: Atendido.
- Onde:
  - app/src/main/kotlin/com/zodiak/android/feature/savekids/view/SaveKidsHistoryScreen.kt
  - app/src/main/kotlin/com/zodiak/android/feature/savekids/data/local/room/SaveKidsDao.kt
- Como:
  - DAO ordena por createdAt DESC.
  - Eventos de login, deposito, metas, missao, recompensa e nivel.

### 2.10 Avatar e Ranking com PokeAPI

- Requisito: avatar com dados da PokeAPI e exibicao na experiencia.
- Status: Atendido (com fallback).
- Onde:
  - app/src/main/kotlin/com/zodiak/android/feature/savekids/data/remote/retrofit/PokeApiService.kt
  - app/src/main/kotlin/com/zodiak/android/feature/savekids/repository/SaveKidsRepositoryImpl.kt
  - app/src/main/kotlin/com/zodiak/android/feature/savekids/view/SaveKidsAvatarRankingScreen.kt
  - app/src/main/kotlin/com/zodiak/android/feature/savekids/view/SaveKidsHomeScreen.kt
- Como:
  - Busca pokemon base + species + cadeia de evolucao.
  - Resolve sprite com prioridade (official artwork/front_default/fallback URL).
  - Renderiza avatar na Home e na tela de Avatar/Familia.

### 2.11 Regras de gamificacao

- Requisito: XP por evento e niveis.
- Status: Atendido.
- Onde:
  - app/src/main/kotlin/com/zodiak/android/feature/savekids/utils/GamificationRules.kt
  - app/src/main/kotlin/com/zodiak/android/feature/savekids/repository/SaveKidsRepositoryImpl.kt
- Como:
  - Deposito, meta, missao, recompensa afetam XP conforme regra.
  - Nivel/titulo calculados por faixa.

### 2.12 Persistencia local (Room + DataStore)

- Requisito: dados locais persistidos.
- Status: Atendido.
- Onde:
  - app/src/main/kotlin/com/zodiak/android/feature/savekids/data/local/room/
  - app/src/main/kotlin/com/zodiak/android/feature/savekids/data/local/datastore/SaveKidsSessionDataStore.kt
  - app/src/main/kotlin/com/zodiak/android/feature/savekids/data/SaveKidsDataModule.kt
- Como:
  - Room persiste dominio (carteira, metas, missoes, recompensas, historico, familia, perfil).
  - DataStore persiste sessao e perfil de acesso.

### 2.13 Arquitetura MVVM explicita

- Requisito: separacao de camadas visivel no projeto.
- Status: Atendido.
- Onde:
  - app/src/main/kotlin/com/zodiak/android/feature/savekids/model/
  - app/src/main/kotlin/com/zodiak/android/feature/savekids/view/
  - app/src/main/kotlin/com/zodiak/android/feature/savekids/viewmodel/
  - app/src/main/kotlin/com/zodiak/android/feature/savekids/repository/
  - app/src/main/kotlin/com/zodiak/android/feature/savekids/data/
- Como:
  - View consumindo StateFlow.
  - ViewModel orquestrando casos de uso.
  - Repository mediando local/remoto.

### 2.14 Design System Zodiak

- Requisito: componentes no padrao DS.
- Status: Atendido com evolucao continua.
- Onde:
  - design-system/src/main/kotlin/com/zodiak/android/design_system/
  - app/src/main/kotlin/com/zodiak/android/feature/savekids/view/
- Como:
  - Uso de atoms/molecules/organisms e tokens de espacamento/radius/sizing.
  - Primitives de dashboard centralizadas no DS.

## 3) Testes e validacao

- Testes implementados:
  - app/src/test/kotlin/com/zodiak/android/feature/savekids/SaveKidsMvpCasesTest.kt
  - app/src/test/kotlin/com/zodiak/android/feature/savekids/SaveKidsMissionsViewModelTest.kt
  - app/src/test/kotlin/com/zodiak/android/feature/savekids/SaveKidsMissionsRepositoryTest.kt
  - app/src/test/kotlin/com/zodiak/android/feature/savekids/FakeSaveKidsRepository.kt

- Casos MVP (SaveKidsMvpCasesTest, via FakeSaveKidsRepository):
  - CT-001 login.
  - CT-002 criar meta.
  - CT-003 registrar economia.
  - CT-004 resgatar recompensa.

- Stack de missoes / camada ViewModel (SaveKidsMissionsViewModelTest):
  - CT-005 carga inicial expoe missoes e encerra loading.
  - CT-006 concluir missao marca status e emite mensagem de sucesso.
  - CT-007 concluir missao nao afeta as demais missoes.
  - CT-008 concluir missao credita XP e dinheiro na carteira.
  - CT-009 concluir missao registra evento no historico.
  - CT-010 concluir missao ja concluida retorna erro e nao credita XP novamente.
  - CT-011 concluir missao inexistente retorna erro.
  - CT-012 clearMessages limpa sucesso e erro.

- Stack de missoes / regra de negocio real (SaveKidsMissionsRepositoryTest):
  - Exercita SaveKidsRepositoryImpl.completeMission com os DAOs do Room mockados
    (mockk), ou seja, testa a logica de producao e nao o fake.
  - CT-013 concluir missao persiste status COMPLETED.
  - CT-014 concluir missao credita XP e recompensa em dinheiro na carteira.
  - CT-015 concluir missao recalcula nivel ao cruzar faixa de XP.
  - CT-016 concluir missao mantem nivel quando XP nao cruza faixa.
  - CT-017 concluir missao registra evento no historico.
  - CT-018 concluir missao inexistente falha sem tocar carteira ou historico.
  - CT-019 concluir missao ja concluida falha sem creditar recompensa novamente.
  - CT-020 carteira nao inicializada falha sem consumir a missao.

- Como executar:
  - ./gradlew :app:testDebugUnitTest --tests "com.zodiak.android.feature.savekids.*"

- Observacao de manutencao:
  - FakeSaveKidsRepository precisa implementar a interface SaveKidsRepository por
    completo. Um metodo faltando (foi o caso de clearAuthentication) quebra a
    compilacao de todo o source set de teste e derruba tambem os casos ja existentes.

- O que ainda falta (recomendado):
  - mesma cobertura de ViewModel + repositorio para a stack de recompensas;
  - testes de integracao para fluxo completo de avatar/PokeAPI;
  - testes adicionais para erros de rede e fallback de avatar;
  - cobertura estendida dos ViewModels restantes (metas, cofrinho, home, avatar).

## 4) Itens parcialmente atendidos / lacunas reais

1. Build por terminal no Windows (wrapper)
- Situacao: o repositorio possui gradlew, sem gradlew.bat.
- Impacto: no PowerShell/cmd puro o wrapper nao roda; e preciso um shell Unix
  compativel (Git Bash) ou o proprio Android Studio.
- Pre-requisito: local.properties com sdk.dir apontando para o Android SDK. O
  arquivo esta no .gitignore, entao cada integrante precisa gerar o seu (o Android
  Studio cria automaticamente ao abrir o projeto).
- Validado: ./gradlew :app:testDebugUnitTest roda pelo Git Bash com o local.properties
  configurado.
- Status: Parcial (contornavel; adicionar gradlew.bat resolveria de vez).

2. Evidencias visuais de entrega
- Situacao: README cita evidencias visuais a completar.
- Status: Pendente para entrega final (prints/gifs finais).

3. Observabilidade de rede para avatar
- Situacao: existe fallback de avatar em falha de API, mas sem telemetria dedicada.
- Status: Parcial (funcional, mas sem monitoramento extra).

## 5) Checklist final de entrega (academico)

- [x] 8 telas Save Kids implementadas.
- [x] Navegacao entre telas funcional.
- [x] Login em 2 passos com validacoes.
- [x] Persistencia Room + DataStore.
- [x] Integracao com PokeAPI para avatar/evolucao.
- [x] Regras de gamificacao implementadas.
- [x] Arquitetura MVVM explicita.
- [x] Uso do Design System Zodiak.
- [x] Testes CT-001..CT-004 (casos MVP).
- [x] Testes CT-005..CT-020 (stack de missoes: ViewModel + repositorio).
- [ ] Evidencias visuais finais (prints/gifs) para entrega.
- [ ] Cobertura adicional de testes (recomendado, nao bloqueante no MVP).

## 6) Conclusao

O app Save Kids atende os principais requisitos funcionais e tecnicos do projeto no escopo MVP. As pendencias atuais sao majoritariamente de acabamento de entrega (evidencias visuais) e incremento de qualidade (cobertura extra de testes), sem bloquear funcionamento do produto em Android Studio.
