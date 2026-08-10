import Foundation

/// Serviço de validação de entrada do usuário. Funções puras e stateless.
enum ValidationService {
    /// Valida que o campo não está vazio após trimming de espaços.
    ///
    /// - Parameters:
    ///   - value: Valor digitado pelo usuário.
    ///   - fieldName: Nome do campo, usado na mensagem de erro.
    /// - Throws: `ValidationError.emptyField` quando o valor é vazio ou apenas espaços.
    static func validateNotEmpty(_ value: String, fieldName: String) throws {
        if value.trimmingCharacters(in: .whitespaces).isEmpty {
            throw ValidationError.emptyField(fieldName)
        }
    }

    /// Valida que a nota está no intervalo 0–10.
    ///
    /// - Parameter value: Nota a validar (aceita `nil`).
    /// - Returns: O valor da nota como `Double` quando válida.
    /// - Throws: `ValidationError.invalidGrade` quando `value` é `nil` ou fora de 0–10.
    static func validateGrade(_ value: Double?) throws -> Double {
        guard let grade = value else {
            throw ValidationError.invalidGrade
        }
        guard grade >= 0 && grade <= 10 else {
            throw ValidationError.outOfRange("Nota", min: 0, max: 10)
        }
        return grade
    }

    /// Valida que o valor é um número positivo (maior que zero).
    ///
    /// - Parameters:
    ///   - value: Número a validar (aceita `nil`).
    ///   - fieldName: Nome do campo, usado na mensagem de erro.
    /// - Returns: O valor como `Double` quando válido.
    /// - Throws: `ValidationError.invalidNumber` quando `value` é `nil` ou ≤ 0.
    static func validatePositiveNumber(_ value: Double?, fieldName: String) throws -> Double {
        guard let number = value else {
            throw ValidationError.invalidNumber(fieldName)
        }
        guard number > 0 else {
            throw ValidationError.invalidNumber(fieldName)
        }
        return number
    }

    /// Valida que a idade é um inteiro positivo e menor que 150.
    ///
    /// - Parameter value: Idade a validar (aceita `nil`).
    /// - Returns: A idade como `Int` quando válida.
    /// - Throws: `ValidationError.invalidAge` quando `value` é `nil`, zero, negativo ou ≥ 150.
    static func validateAge(_ value: Int?) throws -> Int {
        guard let age = value, age > 0 && age < 150 else {
            throw ValidationError.invalidAge
        }
        return age
    }

    /// Valida que o valor está dentro do intervalo `[min, max]`.
    ///
    /// - Parameters:
    ///   - value: Valor a validar (aceita `nil`).
    ///   - min: Limite inferior (inclusivo).
    ///   - max: Limite superior (inclusivo).
    ///   - fieldName: Nome do campo, usado na mensagem de erro.
    /// - Returns: O valor como `Double` quando dentro do intervalo.
    /// - Throws: `ValidationError.invalidNumber` se `nil`; `ValidationError.outOfRange` se fora do intervalo.
    static func validateInRange(_ value: Double?, min: Double, max: Double, fieldName: String) throws -> Double {
        guard let number = value else {
            throw ValidationError.invalidNumber(fieldName)
        }
        guard number >= min && number <= max else {
            throw ValidationError.outOfRange(fieldName, min: min, max: max)
        }
        return number
    }
}

/// Serviço de cálculos matemáticos e conversões. Funções puras e stateless.
enum CalculationService {
    /// Calcula a média aritmética de uma lista de notas.
    ///
    /// - Parameter grades: Lista de notas. Retorna `0` se vazia.
    /// - Returns: Média aritmética ou `0` quando `grades` está vazio.
    static func calculateAverage(_ grades: [Double]) -> Double {
        guard !grades.isEmpty else { return 0 }
        return grades.reduce(0, +) / Double(grades.count)
    }

    /// Gera a tabuada de 1 a 10 para um número inteiro.
    ///
    /// - Parameter number: Número base da tabuada.
    /// - Returns: Array de 10 tuplas `(multiplier:, result:)` com os pares da tabuada.
    static func generateMultiplicationTable(for number: Int) -> [(multiplier: Int, result: Int)] {
        (1...10).map { multiplier in
            (multiplier: multiplier, result: number * multiplier)
        }
    }

    /// Converte temperatura de Celsius para Fahrenheit.
    ///
    /// - Parameter celsius: Temperatura em graus Celsius.
    /// - Returns: Temperatura equivalente em graus Fahrenheit.
    static func celsiusToFahrenheit(_ celsius: Double) -> Double {
        (celsius * 9 / 5) + 32
    }

    /// Converte temperatura de Fahrenheit para Celsius.
    ///
    /// - Parameter fahrenheit: Temperatura em graus Fahrenheit.
    /// - Returns: Temperatura equivalente em graus Celsius.
    static func fahrenheitToCelsius(_ fahrenheit: Double) -> Double {
        (fahrenheit - 32) * 5 / 9
    }
}

/// Serviço de processamento e análise de strings. Funções puras e stateless.
enum StringProcessingService {
    /// Verifica se a string é um palíndromo ignorando acentos, maiúsculas e espaços.
    ///
    /// - Parameter text: Texto a verificar.
    /// - Returns: `true` quando o texto normalizado é igual ao seu inverso.
    static func isPalindrome(_ text: String) -> Bool {
        let cleaned = text.cleanedForPalindrome
        return cleaned == String(cleaned.reversed())
    }

    /// Remove espaços, acentos e converte para minúsculas.
    ///
    /// - Parameter text: Texto original.
    /// - Returns: Texto normalizado sem acentos e em minúsculas.
    static func normalize(_ text: String) -> String {
        text.normalized
    }
}

/// Serviço de geração de números aleatórios e dicas de proximidade. Stateless.
enum RandomService {
    /// Gera um número secreto aleatório entre 1 e 100 (inclusivo).
    ///
    /// - Returns: Número inteiro aleatório no intervalo `1...100`.
    static func generateSecret() -> Int {
        Int.random(in: 1...100)
    }

    /// Calcula uma dica de proximidade entre o palpite e o número secreto.
    ///
    /// - Parameters:
    ///   - guess: Palpite do usuário.
    ///   - secret: Número secreto a adivinhar.
    /// - Returns: Mensagem emoji descrevendo a distância (5 níveis: acertou, muito perto, perto, longe, muito longe).
    static func getProximityHint(guess: Int, secret: Int) -> String {
        let difference = abs(guess - secret)

        switch difference {
        case 0:
            return "🎉 Você acertou!"

        case 1...5:
            return "🔥 Muito perto!"

        case 6...10:
            return "😊 Perto"

        case 11...15:
            return "📍 Longe"

        default:
            return "❄️ Muito longe!"
        }
    }

    /// Verifica se o palpite é igual ao número secreto.
    ///
    /// - Parameters:
    ///   - guess: Palpite do usuário.
    ///   - secret: Número secreto a adivinhar.
    /// - Returns: `true` quando `guess == secret`.
    static func isCorrect(_ guess: Int, _ secret: Int) -> Bool {
        guess == secret
    }
}

/// Serviço de operações sobre produtos — Feature 13 (ProductManager).
enum ProductService {
    /// Agrupa produtos por marca, ordenados alfabeticamente.
    ///
    /// - Parameter products: Lista de produtos a agrupar.
    /// - Returns: Dicionário `[marca: [Product]]` com chaves ordenadas.
    static func groupByBrand(_ products: [Product]) -> [(key: String, value: [Product])] {
        let grouped = Dictionary(grouping: products, by: \.brand)
        return grouped.sorted { $0.key < $1.key }
    }

    /// Agrupa produtos por segmento, na ordem definida em `ProductSegment.allCases`.
    ///
    /// - Parameter products: Lista de produtos a agrupar.
    /// - Returns: Pares `(segmento, [Product])` na ordem canônica do enum.
    static func groupBySegment(_ products: [Product]) -> [(key: ProductSegment, value: [Product])] {
        let grouped = Dictionary(grouping: products, by: \.segment)
        return ProductSegment.allCases.compactMap { seg in
            guard let items = grouped[seg], !items.isEmpty else { return nil }
            return (key: seg, value: items)
        }
    }

    /// Calcula o preço médio de uma lista de produtos.
    ///
    /// - Parameter products: Lista de produtos.
    /// - Returns: Média dos preços ou `0` se a lista estiver vazia.
    static func averagePrice(_ products: [Product]) -> Double {
        guard !products.isEmpty else { return 0 }
        return products.map(\.price).reduce(0, +) / Double(products.count)
    }
}

// MARK: - ShopService (Feature 15 — ShopMaster)

/// Serviço stateless para operações do catálogo e carrinho da loja.
enum ShopService {
    /// Filtra produtos por categoria e texto de busca (case-insensitive).
    ///
    /// - Parameters:
    ///   - products: Catálogo completo de produtos.
    ///   - category: Categoria selecionada pelo usuário.
    ///   - query: Texto digitado na busca. Se vazio, ignora o filtro de texto.
    /// - Returns: Produtos da categoria que correspondem à busca.
    static func filter(
        _ products: [ShopProduct],
        category: ShopCategory,
        query: String
    ) -> [ShopProduct] {
        let byCategory = products.filter { $0.category == category }
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return byCategory
        }
        return byCategory.filter {
            $0.name.localizedCaseInsensitiveContains(query)
        }
    }

    /// Soma os subtotais de todos os itens do carrinho.
    ///
    /// - Parameter items: Itens presentes no carrinho.
    /// - Returns: Valor total da compra.
    static func cartTotal(_ items: [CartItem]) -> Double {
        items.reduce(0) { $0 + $1.subtotal }
    }
}

/// Serviço de quiz — banco de perguntas e lógica de jogo
enum QuizService {
    /// Retorna todas as perguntas de um tema
    static func questions(for theme: QuizTheme) -> [Question] {
        switch theme {
        case .swift:
            return swiftQuestions

        case .filmes:
            return filmesQuestions

        case .historia:
            return historiaQuestions

        case .geografia:
            return geografiaQuestions
        }
    }

    /// Seleciona N perguntas aleatórias de um array
    static func randomQuestions(from all: [Question], count: Int) -> [Question] {
        Array(all.shuffled().prefix(count))
    }

    /// Verifica se a resposta selecionada está correta
    static func isCorrect(question: Question, selectedIndex: Int) -> Bool {
        question.correctIndex == selectedIndex
    }

    // MARK: - Banco de Perguntas: Swift

    private static let swiftQuestions: [Question] = [
        Question(
            text: "Qual palavra-chave define uma constante em Swift?",
            options: ["var", "let", "const", "final"],
            correctIndex: 1
        ),
        Question(
            text: "Qual tipo representa texto em Swift?",
            options: ["Text", "Char", "String", "str"],
            correctIndex: 2
        ),
        Question(
            text: "O que é um Optional em Swift?",
            options: [
                "Um tipo que pode ser nulo",
                "Um tipo obrigatório",
                "Um tipo numérico",
                "Um tipo de coleção"
            ],
            correctIndex: 0
        ),
        Question(
            text: "Qual framework é usado para criar interfaces em SwiftUI?",
            options: ["UIKit", "AppKit", "SwiftUI", "Cocoa"],
            correctIndex: 2
        ),
        Question(
            text: "Qual operador é usado para desempacotar um Optional com segurança?",
            options: ["!", "?", "if let", "??"],
            correctIndex: 2
        ),
        Question(
            text: "Qual é o property wrapper usado para estado local em SwiftUI?",
            options: ["@Binding", "@State", "@Published", "@ObservedObject"],
            correctIndex: 1
        ),
        Question(
            text: "Qual protocolo permite iterar sobre os casos de um enum?",
            options: ["Iterable", "CaseIterable", "Enumerable", "Sequence"],
            correctIndex: 1
        ),
        Question(
            text: "Qual é a estrutura de dados ordenada mais comum em Swift?",
            options: ["Set", "Dictionary", "Array", "Tuple"],
            correctIndex: 2
        )
    ]

    // MARK: - Banco de Perguntas: Filmes

    private static let filmesQuestions: [Question] = [
        Question(
            text: "Quem dirigiu o filme 'Titanic' (1997)?",
            options: ["Steven Spielberg", "James Cameron", "Martin Scorsese", "Ridley Scott"],
            correctIndex: 1
        ),
        Question(
            text: "Qual filme ganhou o Oscar de Melhor Filme em 2020?",
            options: ["1917", "Parasita", "Coringa", "Era Uma Vez em Hollywood"],
            correctIndex: 1
        ),
        Question(
            text: "Em 'O Senhor dos Anéis', quem carrega o anel até Mordor?",
            options: ["Aragorn", "Gandalf", "Frodo", "Legolas"],
            correctIndex: 2
        ),
        Question(
            text: "Qual é o nome do personagem interpretado por Leonardo DiCaprio em 'A Origem'?",
            options: ["Arthur", "Cobb", "Fischer", "Eames"],
            correctIndex: 1
        ),
        Question(
            text: "Qual estúdio de animação criou 'Toy Story'?",
            options: ["DreamWorks", "Disney", "Pixar", "Illumination"],
            correctIndex: 2
        ),
        Question(
            text: "Em qual ano foi lançado o primeiro filme 'Star Wars'?",
            options: ["1975", "1977", "1980", "1983"],
            correctIndex: 1
        ),
        Question(
            text: "Qual ator interpretou o Coringa no filme 'O Cavaleiro das Trevas'?",
            options: ["Jack Nicholson", "Jared Leto", "Heath Ledger", "Joaquin Phoenix"],
            correctIndex: 2
        ),
        Question(
            text: "Qual filme tem a famosa frase 'Eu sou seu pai'?",
            options: [
                "Star Wars: Uma Nova Esperança",
                "Star Wars: O Império Contra-Ataca",
                "Star Wars: O Retorno de Jedi",
                "Star Wars: A Ameaça Fantasma"
            ],
            correctIndex: 1
        )
    ]

    // MARK: - Banco de Perguntas: História

    private static let historiaQuestions: [Question] = [
        Question(
            text: "Em que ano o Brasil foi proclamado República?",
            options: ["1822", "1889", "1891", "1900"],
            correctIndex: 1
        ),
        Question(
            text: "Quem foi o primeiro presidente do Brasil?",
            options: ["Getúlio Vargas", "Dom Pedro II", "Deodoro da Fonseca", "Prudente de Morais"],
            correctIndex: 2
        ),
        Question(
            text: "Qual evento marcou o início da Primeira Guerra Mundial?",
            options: [
                "Invasão da Polônia",
                "Assassinato do Arquiduque Franz Ferdinand",
                "Revolução Russa",
                "Queda do Muro de Berlim"
            ],
            correctIndex: 1
        ),
        Question(
            text: "Em que ano Cristóvão Colombo chegou às Américas?",
            options: ["1400", "1450", "1492", "1500"],
            correctIndex: 2
        ),
        Question(
            text: "Qual civilização construiu as pirâmides de Gizé?",
            options: ["Romana", "Grega", "Egípcia", "Maia"],
            correctIndex: 2
        ),
        Question(
            text: "A Revolução Francesa começou em qual ano?",
            options: ["1776", "1789", "1799", "1804"],
            correctIndex: 1
        ),
        Question(
            text: "Quem escreveu 'A Arte da Guerra'?",
            options: ["Confúcio", "Sun Tzu", "Lao Tzu", "Maquiavel"],
            correctIndex: 1
        ),
        Question(
            text: "Qual tratado encerrou a Primeira Guerra Mundial?",
            options: ["Tratado de Paris", "Tratado de Versalhes", "Tratado de Viena", "Tratado de Roma"],
            correctIndex: 1
        )
    ]

    // MARK: - Banco de Perguntas: Geografia

    private static let geografiaQuestions: [Question] = [
        Question(
            text: "Qual é o maior país do mundo em área territorial?",
            options: ["shared.country.china", "shared.country.usa", "shared.country.canada", "Rússia"],
            correctIndex: 3
        ),
        Question(
            text: "Qual é o rio mais longo do mundo?",
            options: ["Amazonas", "Nilo", "Mississipi", "Yangtzé"],
            correctIndex: 1
        ),
        Question(
            text: "Quantos continentes existem?",
            options: ["5", "6", "7", "8"],
            correctIndex: 2
        ),
        Question(
            text: "Qual é a capital da Austrália?",
            options: ["Sydney", "Melbourne", "Canberra", "Brisbane"],
            correctIndex: 2
        ),
        Question(
            text: "Qual é o menor país do mundo?",
            options: ["Mônaco", "Vaticano", "San Marino", "Liechtenstein"],
            correctIndex: 1
        ),
        Question(
            text: "Em qual continente fica o Deserto do Saara?",
            options: ["Ásia", "América do Sul", "África", "Oceania"],
            correctIndex: 2
        ),
        Question(
            text: "Qual é a montanha mais alta do mundo?",
            options: ["K2", "Kangchenjunga", "Monte Everest", "Makalu"],
            correctIndex: 2
        ),
        Question(
            text: "Qual oceano é o maior do mundo?",
            options: ["Atlântico", "Índico", "Ártico", "Pacífico"],
            correctIndex: 3
        )
    ]
}

/// Serviço de palavras para o Jogo da Forca — Feature 19 (HangmanGame).
enum HangmanService {
    static func randomWord() -> String { wordList.randomElement() ?? "SWIFT" }
    private static let wordList: [String] = [
        "SWIFT", "XCODE", "APPLE", "IPHONE", "SCREEN", "BUTTON", "NETWORK", "CAMERA", "BATTERY", "GESTURE",
        "WIDGET", "TABLET", "BROWSER", "KEYBOARD", "PORTRAIT", "PREVIEW", "RUNTIME", "TESTING", "PADDING", "ANCHOR"
    ]
}

/// Serviço de conversão de moedas — cálculo puro a partir de taxas relativas ao USD.
enum CurrencyConverterService {
    /// Converte um valor de uma moeda para outra usando taxas relativas ao USD.
    ///
    /// - Parameters:
    ///   - amount: Valor a converter.
    ///   - fromRate: Taxa da moeda de origem em relação ao USD (ex.: BRL = 5.70).
    ///   - toRate: Taxa da moeda de destino em relação ao USD (ex.: EUR = 0.92).
    /// - Returns: Valor convertido na moeda de destino.
    static func convert(amount: Double, fromRate: Double, toRate: Double) -> Double {
        (amount / fromRate) * toRate
    }
}
