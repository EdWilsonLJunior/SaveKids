# Save Kids - PocketBank Kids

Save Kids e um aplicativo Android de educacao financeira gamificada para criancas de 6 a 14 anos, com foco em criar habitos financeiros saudaveis por meio de cofrinho, metas, missoes, recompensas e evolucao progressiva de avatar com Pokemon.

## Proposta

- Tema: Educacao financeira gamificada infantil.
- Diferencial: evolucao estilo jogo conforme a crianca economiza.
- API publica: PokeAPI (https://pokeapi.co/) para avatar e evolucao Pokemon.
- Persistencia local: Room + DataStore.

## Publico alvo

- Criancas entre 6 e 14 anos.
- Pais e responsaveis que acompanham a jornada.
- Familias que incentivam metas e rotina de poupanca.

## MVP implementado

1. Save Kids Login
- Login em 2 passos.
- Passo 1: autenticacao mockada com usuario e senha teste/teste.
- Passo 2: nome da crianca (3 a 30 caracteres) e avatar inicial obrigatorios.

2. Save Kids Home
- Dashboard com saldo, XP, nivel e resumo de metas/missoes/recompensas.

3. Save Kids Cofrinho
- Registro de economia com validacao (valor > 0 e <= 10.000).
- Atualiza saldo e XP.
- Registra evento no historico.

4. Save Kids Metas
- Criacao de metas financeiras.
- Acompanhamento de progresso.
- Bonus de XP para meta criada e meta concluida.

5. Save Kids Missoes
- Lista de missoes com status.
- Conclusao de missao gera XP e pode gerar valor no cofrinho.

6. Save Kids Recompensas
- Resgate condicionado por XP minimo.
- Bloqueio de resgate duplicado.

7. Save Kids Historico
- Eventos ordenados do mais recente para o mais antigo.
- Registro de login, metas, depositos, missoes, recompensas e evolucao.

8. Save Kids Avatar/Familia
- Consumo da PokeAPI para exibir avatar e cadeia de evolucao.
- Ranking familiar mockado e persistido localmente.

## Regras de gamificacao implementadas

- Adicionar R$ 1,00: +1 XP.
- Criar meta: +20 XP.
- Completar missao: XP da missao.
- Concluir meta: +100 XP.
- Resgatar recompensa: -10 XP por resgate (com XP minimo exigido para desbloqueio).

## Niveis

- Nivel 1: 0 XP - Iniciante.
- Nivel 2: 100 XP - Aprendiz Economico.
- Nivel 3: 250 XP - Guardiao do Cofrinho.
- Nivel 4: 500 XP - Mestre das Economias.
- Nivel 5: 1000 XP - Rei da Poupanca.

## Arquitetura MVVM explicita

Estrutura criada para deixar MVVM e camadas de dados explicitas:

app/src/main/kotlin/com/zodiak/android/feature/savekids/
- model/
- view/
- viewmodel/
- repository/
- data/
  - local/
    - room/
    - datastore/
  - remote/
    - retrofit/
- navigation/
- utils/

## Tecnologias

- Kotlin
- Jetpack Compose
- Navigation Compose (type-safe routes)
- Hilt
- Room
- DataStore
- Retrofit + OkHttp
- Coil (carregamento de imagem de avatar)
- PokeAPI
- Design System Zodiak

## Como executar

1. Abra o projeto no Android Studio.
2. Sincronize o Gradle.
3. Execute o modulo app em emulador ou dispositivo Android (API 26+).
4. Na Home principal do Zodiak, procure as entradas Save Kids.
5. Para login de demonstracao use:
- usuario: teste
- senha: teste

## Documentacao complementar

- Status de atendimento dos requisitos (o que, onde, como e lacunas):
  - docs/savekids-status.md
- Guia de setup e execucao para quem acabou de baixar:
  - docs/setup-android-studio.md

## Checklist de requisitos

- App com 8 telas do Save Kids: ok.
- Jetpack Compose + navegacao: ok.
- Consumo de API (PokeAPI): ok.
- Persistencia local (Room + DataStore): ok.
- Arquitetura MVVM explicita por pastas: ok.
- README com proposta, funcionalidades, arquitetura e execucao: ok.

## Integrantes

- Preencher com os nomes da equipe.

## Evidencias visuais

- Adicionar prints ou GIFs das telas para entrega final.

## Integrantes

- Cicero Diogo Lemos da Silva
- Ed Wilson Luciano Junior
- Deyvid Santos da Silva
- Glauciany Brandao dos Santos
- Rodrigo Eleuterio da Silva Santos
- Jorge de Lima Rocha
