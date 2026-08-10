# SwiftUI App - 10 Atividades Consolidadas

Um app SwiftUI completo com 10 atividades práticas, construído com Atomic Design, Design System centralizado e separação clara entre lógica de negócio, apresentação e UI.

## 📱 Atividades Implementadas

1. **Grades** - Calcular média de 3 notas e verificar aprovação
2. **Pix Discount** - Desconto automático de 5% em compras Pix ≥ R$ 1.000
3. **Votação** - Sistema de votação com detecção de empate (segundo turno)
4. **Palíndromo** - Verificador de palavras/frases palíndromas
5. **Adivinhe o Número** - Jogo com dicas de proximidade (1-100)
6. **Tabuada** - Gerador de tabuada de qualquer número
7. **Gerenciador de Pessoas** - CRUD de pessoas (nome + idade)
8. **Alternador de Tema** - Toggle light/dark com preview de cores
9. **Conversor de Temperatura** - Bidireccional Celsius ↔ Fahrenheit
10. **Gerenciador de Tarefas** - To-Do com checkbox e delete

## 🏗️ Arquitetura

### Atomic Design (Strict)
```
Design System/
├── Atoms:        Componentes mínimos reutilizáveis (Button, TextField, Text, Badge)
├── Molecules:    Átomos combinados (LabelledInput, ResultCard, CounterControl)
├── Organisms:    Moléculas + lógica de layout (VoteCard, TaskListItem)
└── Templates:    Layouts reutilizáveis (ActivityTemplate, ListTemplate)
```

### Separação de Responsabilidades
- **Design System**: Tokens (cores, spacing, tipografia) + componentes estilizados
- **Services**: Lógica pura (ValidationService, CalculationService, StringProcessingService)
- **ViewModels**: State management (@Published) + orquestração
- **Screens**: UI composition (zero lógica de negócio)

## 📁 Estrutura de Pastas

```
SwiftUIApp/
├── App/
│   ├── SwiftUIApp.swift          # @main entry point
│   └── MainTabView.swift         # Navegação (10 abas)
├── Shared/
│   └── DesignSystem/
│       ├── Theme/               # Tokens (AppTheme, AppColors, AppTypography)
│       ├── Atoms/              # Botões, TextFields, Textos, Badges
│       ├── Molecules/          # InputFields, ResultCard, CounterControl, Toggle
│       ├── Organisms/          # InfoRow, FormContainer
│       ├── Templates/          # ActivityTemplate, ListTemplate
│       └── Utils/              # ViewModifiers, Extensions
├── Services/                    # Lógica de negócio (puro, sem UI)
├── Models/                      # Structs de dados
└── Features/                    # 10 Atividades
    ├── 01-Grades/
    ├── 02-PixDiscount/
    ├── ... (03-10)
    └── 10-TaskManager/
```

## 🚀 Instruções de Uso

## 📚 Documentação

- Índice central de documentação: [docs/README.md](docs/README.md)
- Documentação do fix de teclado: [docs/keyboard/index.md](docs/keyboard/index.md)
- Auditoria de dark mode: [docs/dark-mode-audit.md](docs/dark-mode-audit.md)

### Opção 1: Abrir no Xcode (Recomendado)
```bash
cd Exericicios/SwiftUIApp/
open SwiftUIApp.xcodeproj
```

Depois, no Xcode:
1. Selecione um simulador iOS (iPhone 15+, recomendado iOS 16+)
2. Pressione `Cmd+R` para compilar e rodar
3. Navegue entre as 10 abas na parte inferior

### Opção 2: Swift Package Manager (Alternativa)
Se o projeto.xcodeproj não abrir, você pode usar:
```bash
swift build
```

## 🎨 Design System

### Cores
- **Primary**: Azul (#3366FF)
- **Success**: Verde (#33CC33)
- **Error**: Vermelho (#E63946)
- **Warning**: Amarelo (#FFD60A)

### Spacing (Tokens)
- spacing2, spacing4, spacing6, spacing8, spacing10, spacing12, spacing16

### Typography
- headline, title1, title2, body, caption, label, button

### Componentes Reutilizáveis
| Componente | Usado em Atividades |
|-----------|-------------------|
| LabelledInputField | 1, 2, 4, 5, 6, 7, 9 |
| ResultCard | 1, 2, 4, 5, 6, 9 |
| PrimaryButton | Todas (10) |
| AppToggleSwitch | 2, 8 |
| CounterControl | 5 |
| TaskListItem | 10 |
| PersonListItem | 7 |
| VoteCard | 3 |

## ✅ Verificação de Compilação

Ao abrir no Xcode, você deve ver:
- ✅ **0 Errors** - Nenhum erro de compilação
- ✅ **0 Warnings** - Nenhum aviso
- ✅ **Menu Principal com 10 abas** - Navegação funcional
- ✅ **Cada atividade funcional** - Inputs, validações, outputs

## 📘 Padrões Utilizados

### Padrão MVVM
```swift
class GradeViewModel: ObservableObject {
    @Published var name: String = ""
    // State management
}

struct GradeScreen: View {
    @StateObject private var viewModel = GradeViewModel()
    // UI apenas
}
```

### Services Stateless (Funções Puras)
```swift
class ValidationService {
    static func validateGrade(_ value: Double?) throws -> Double { ... }
}

class CalculationService {
    static func calculateAverage(_ grades: [Double]) -> Double { ... }
}
```

### Design System Centralizado
```swift
struct AppTheme {
    static let spacing8: CGFloat = 16
    static let cornerRadiusMedium: CGFloat = 8
}

struct AppColors {
    static let primary = Color(red: 0.2, green: 0.5, blue: 0.9)
}
```

## 🔧 Tecnologias

- **iOS**: 16.0+
- **Swift**: 5.9+
- **Framework**: SwiftUI
- **Arquitetura**: Atomic Design + Clean Code
- **Padrão**: MVVM

## 📝 Checklist de Funcionalidades

### Atividade 1: Grades ✅
- [x] Input: nome + 3 notas
- [x] Validação: notas 0-10
- [x] Output: média + status (Aprovado/Reprovado)
- [x] Críterio: ≥7 = Aprovado

### Atividade 2: Pix Discount ✅
- [x] Input: produto + valor + checkbox Pix
- [x] Desconto: 5% se valor ≥ R$1.000 e Pix selecionado
- [x] Output: valor final + desconto aplicado

### Atividade 3: Votação ✅
- [x] 3 botões candidatos com contadores
- [x] Botão finalizar votação
- [x] Detecção de empate com segundo turno
- [x] Exibição do vencedor

### Atividade 4: Palíndromo ✅
- [x] Input: texto
- [x] Normalização: remover espaços, acentos, pontuação
- [x] Output: é/não é palíndromo

### Atividade 5: Adivinhe Número ✅
- [x] Random 1-100
- [x] Input: palpite
- [x] Dicas: Muito perto, Perto, Longe, Muito longe
- [x] Contador de tentativas
- [x] Fim do jogo ao acertar

### Atividade 6: Tabuada ✅
- [x] Input: número
- [x] Output: tabuada 1-10

### Atividade 7: Modo Pessoas ✅
- [x] Form: nome + idade
- [x] CRUD: add + remove
- [x] List com pessoas cadastradas

### Atividade 8: Tema Toggle ✅
- [x] Toggle light/dark
- [x] Colors dinâmicas
- [x] Preview de cores
- [x] Botões mudam com tema

### Atividade 9: Conversor Temperatura ✅
- [x] Input: Celsius
- [x] Output: Fahrenheit
- [x] Bidirecional (Fahrenheit → Celsius)
- [x] Conversão em tempo real

### Atividade 10: Tarefas (To-Do) ✅
- [x] Form: nova tarefa
- [x] List: tarefas com checkbox
- [x] Toggle: marcar concluída
- [x] Delete: remover tarefa
- [x] Aparência muda ao concluir

## 🐛 Troubleshooting

### Problema: Projeto não abre no Xcode
**Solução**: O arquivo `SwiftUIApp.xcodeproj/project.pbxproj` pode precisar ser recriado. Você pode:
1. Deletar a pasta `SwiftUIApp.xcodeproj/`
2. Abrir Xcode → File → New → Project
3. Escolher "App" template
4. Copiar os arquivos Swift para o novo projeto

### Problema: Erros de compilação
**Solução**: Certifique-se que:
- iOS deployment target é ≥ 16.0
- Swift version é 5.9+
- Todos os arquivos estão no target correto

## 👨‍💻 Próximas Melhorias (Opcionais)

- [ ] Persistência com UserDefaults (Pessoas, Tarefas)
- [ ] Dark mode automático baseado em sistema
- [ ] Animations e transições suaves
- [ ] Testes unitários (Services)
- [ ] SwiftUI previews para todos os componentes
- [ ] Acessibilidade (VoiceOver)
- [ ] Suporte a iPad (landscape)

## 📞 Contato

Projeto criado como parte do treinamento **Re-Skilling Mobile iOS** (Capgemini/ProWay).
