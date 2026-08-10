// swiftlint:disable file_length
// Reason: Comprehensive test suite — splitting across files would reduce readability.
//
//  ZodiakiOSTests.swift
//  ZodiakiOSTests
//
//  Created by MARCOS FELIPE SOARES ROCHA on 16/04/26.
//

import Testing
@testable import ZodiakiOS

// MARK: - PersonManagerViewModel Tests

@Suite("PersonManagerViewModel")
struct PersonManagerViewModelTests {
    @Test("Adicionar pessoa válida incrementa a lista")
    func addValidPerson() {
        let vm = PersonManagerViewModel()
        vm.nameInput = "Maria Silva"
        vm.ageInput = "30"
        vm.addPerson()
        #expect(vm.persons.count == 1)
        #expect(vm.persons.first?.name == "Maria Silva")
        #expect(vm.persons.first?.age == 30)
        #expect(vm.errorMessage == nil)
    }

    @Test("Nome vazio gera erro e não adiciona pessoa")
    func addPersonWithEmptyName() {
        let vm = PersonManagerViewModel()
        vm.nameInput = ""
        vm.ageInput = "25"
        vm.addPerson()
        #expect(vm.persons.isEmpty)
        #expect(vm.errorMessage != nil)
    }

    @Test("Idade inválida (texto) gera erro")
    func addPersonWithNonNumericAge() {
        let vm = PersonManagerViewModel()
        vm.nameInput = "João"
        vm.ageInput = "abc"
        vm.addPerson()
        #expect(vm.persons.isEmpty)
        #expect(vm.errorMessage != nil)
    }

    @Test("Remover pessoa remove da lista corretamente")
    func removePerson() throws {
        let vm = PersonManagerViewModel()
        vm.nameInput = "Ana"
        vm.ageInput = "20"
        vm.addPerson()
        let person = try #require(vm.persons.first)
        vm.removePerson(person)
        #expect(vm.persons.isEmpty)
    }

    @Test("Inputs são limpos após adição bem-sucedida")
    func inputsClearedAfterAdd() {
        let vm = PersonManagerViewModel()
        vm.nameInput = "Carlos"
        vm.ageInput = "40"
        vm.addPerson()
        #expect(vm.nameInput.isEmpty)
        #expect(vm.ageInput.isEmpty)
    }
}

// MARK: - QuizGameViewModel Tests

@Suite("QuizGameViewModel")
@MainActor
struct QuizGameViewModelTests {
    @Test("Estado inicial é selectingTheme")
    func initialPhase() {
        let vm = QuizGameViewModel()
        #expect(vm.phase == .selectingTheme)
    }

    @Test("selectTheme muda fase para answering")
    func selectThemeSetsAnsweringPhase() {
        let vm = QuizGameViewModel()
        vm.selectTheme(.historia)
        #expect(vm.phase == .answering)
        #expect(vm.questions.count == QuizGameConstants.questionsPerGame)
    }

    @Test("selectOption define selectedOptionIndex")
    func selectOption() {
        let vm = QuizGameViewModel()
        vm.selectTheme(.historia)
        vm.selectOption(2)
        #expect(vm.selectedOptionIndex == 2)
    }

    @Test("restart restaura para selectingTheme")
    func restart() {
        let vm = QuizGameViewModel()
        vm.selectTheme(.historia)
        vm.restart()
        #expect(vm.phase == .selectingTheme)
        #expect(vm.questions.isEmpty)
        #expect(vm.answers.isEmpty)
        #expect(vm.currentIndex == 0)
    }

    @Test("correctCount e incorrectCount somam respostas corretamente")
    func answerCounting() {
        let vm = QuizGameViewModel()
        vm.selectTheme(.historia)
        // Força uma resposta correta
        if let q = vm.currentQuestion {
            let answer = QuizAnswer(question: q, selectedIndex: q.correctIndex, isCorrect: true)
            vm.answers.append(answer)
        }
        #expect(vm.correctCount == 1)
        #expect(vm.incorrectCount == 0)
    }
}

// MARK: - PixDiscountViewModel Tests

@Suite("PixDiscountViewModel")
struct PixDiscountViewModelTests {
    @Test("Pix elegível (valor >= 1000 e pix ativo) aplica desconto de 5%")
    func pixDiscountApplied() {
        let vm = PixDiscountViewModel()
        vm.productName = "Notebook"
        vm.productValue = 2000.0
        vm.isPixSelected = true
        vm.submit()
        #expect(vm.result != nil)
        #expect(vm.result?.discount == 100.0)
        #expect(vm.result?.finalValue == 1900.0)
        #expect(vm.errorMessage == nil)
    }

    @Test("Pix não elegível (valor < 1000) não aplica desconto")
    func pixDiscountNotAppliedBelowMinimum() {
        let vm = PixDiscountViewModel()
        vm.productName = "Fone"
        vm.productValue = 500.0
        vm.isPixSelected = true
        vm.submit()
        #expect(vm.result?.discount == 0.0)
        #expect(vm.result?.finalValue == 500.0)
    }

    @Test("Pix desativado não aplica desconto mesmo com valor elegível")
    func pixDiscountNotAppliedWhenDeselected() {
        let vm = PixDiscountViewModel()
        vm.productName = "TV"
        vm.productValue = 3000.0
        vm.isPixSelected = false
        vm.submit()
        #expect(vm.result?.discount == 0.0)
        #expect(vm.result?.finalValue == 3000.0)
    }

    @Test("Nome de produto vazio gera errorMessage")
    func emptyProductNameGeneratesError() {
        let vm = PixDiscountViewModel()
        vm.productName = ""
        vm.productValue = 500.0
        vm.submit()
        #expect(vm.result == nil)
        #expect(vm.errorMessage != nil)
    }

    @Test("Valor nil gera errorMessage")
    func nilValueGeneratesError() {
        let vm = PixDiscountViewModel()
        vm.productName = "Produto"
        vm.productValue = nil
        vm.submit()
        #expect(vm.result == nil)
        #expect(vm.errorMessage != nil)
    }

    @Test("reset limpa todos os campos")
    func resetClearsState() {
        let vm = PixDiscountViewModel()
        vm.productName = "TV"
        vm.productValue = 2000.0
        vm.isPixSelected = true
        vm.submit()
        vm.reset()
        #expect(vm.productName.isEmpty)
        #expect(vm.productValue == nil)
        #expect(vm.isPixSelected == false)
        #expect(vm.result == nil)
        #expect(vm.errorMessage == nil)
    }
}

// MARK: - VotingViewModel Tests

@Suite("VotingViewModel")
struct VotingViewModelTests {
    @Test("vote incrementa votos do candidato correto")
    func voteIncrementsCandidate() {
        let vm = VotingViewModel()
        let candidateId = vm.candidates[0].id
        vm.vote(for: candidateId)
        vm.vote(for: candidateId)
        #expect(vm.candidates[0].votes == 2)
        #expect(vm.candidates[1].votes == 0)
    }

    @Test("finishVoting define votingFinished como true")
    func finishVotingSetsFlag() {
        let vm = VotingViewModel()
        vm.finishVoting()
        #expect(vm.votingFinished == true)
    }

    @Test("candidato com mais votos é declarado vencedor")
    func singleWinnerDetermined() {
        let vm = VotingViewModel()
        vm.vote(for: vm.candidates[1].id)
        vm.vote(for: vm.candidates[1].id)
        vm.vote(for: vm.candidates[2].id)
        vm.finishVoting()
        #expect(vm.runoffCandidates == nil)
        #expect(vm.leadingCandidate != nil)
        #expect(vm.leadingCandidate?.name == vm.candidates[1].name)
    }

    @Test("empate gera segundo turno")
    func tieGeneratesRunoff() {
        let vm = VotingViewModel()
        vm.vote(for: vm.candidates[0].id)
        vm.vote(for: vm.candidates[1].id)
        vm.finishVoting()
        #expect(vm.runoffCandidates != nil)
    }

    @Test("reset restaura estado inicial")
    func resetRestoresInitialState() {
        let vm = VotingViewModel()
        vm.vote(for: vm.candidates[0].id)
        vm.finishVoting()
        vm.reset()
        #expect(vm.votingFinished == false)
        #expect(vm.leadingCandidate == nil)
        #expect(vm.runoffCandidates == nil)
        #expect(vm.candidates.allSatisfy { $0.votes == 0 })
    }
}

// MARK: - PalindromeViewModel Tests

@Suite("PalindromeViewModel")
struct PalindromeViewModelTests {
    @Test("palavra palindrômica é detectada")
    func palindromeDetected() {
        let vm = PalindromeViewModel()
        vm.input = "arara"
        vm.check()
        #expect(vm.result?.isPalindrome == true)
    }

    @Test("palavra não palindrômica retorna false")
    func nonPalindromeDetected() {
        let vm = PalindromeViewModel()
        vm.input = "hello"
        vm.check()
        #expect(vm.result?.isPalindrome == false)
    }

    @Test("input vazio não define resultado")
    func emptyInputDoesNotSetResult() {
        let vm = PalindromeViewModel()
        vm.input = ""
        vm.check()
        #expect(vm.result == nil)
    }

    @Test("reset limpa input e resultado")
    func resetClearsState() {
        let vm = PalindromeViewModel()
        vm.input = "level"
        vm.check()
        vm.reset()
        #expect(vm.input.isEmpty)
        #expect(vm.result == nil)
    }
}

// MARK: - GradeViewModel Tests

@Suite("GradeViewModel")
struct GradeViewModelTests {
    @Test("estado inicial tem todos os campos vazios")
    func initialState() {
        let vm = GradeViewModel()
        #expect(vm.name.isEmpty)
        #expect(vm.grades.allSatisfy { $0 == nil })
        #expect(vm.result == nil)
        #expect(vm.errorMessage == nil)
        #expect(vm.gradeErrors.allSatisfy { $0 == nil })
    }

    @Test("submit com nome vazio gera errorMessage")
    func submitEmptyNameGeneratesError() {
        let vm = GradeViewModel()
        vm.grades = [7.0, 8.0, 9.0]
        vm.submit()
        #expect(vm.result == nil)
        #expect(vm.errorMessage != nil)
    }

    @Test("submit com nome apenas espaços gera errorMessage")
    func submitWhitespaceNameGeneratesError() {
        let vm = GradeViewModel()
        vm.name = "   "
        vm.grades = [7.0, 8.0, 9.0]
        vm.submit()
        #expect(vm.result == nil)
        #expect(vm.errorMessage != nil)
    }

    @Test("submit com nota nil gera gradeErrors na posição correta")
    func submitNilGradeGeneratesGradeError() {
        let vm = GradeViewModel()
        vm.name = "Ana"
        vm.grades = [nil, 8.0, 9.0]
        vm.submit()
        #expect(vm.result == nil)
        #expect(vm.gradeErrors[0] != nil)
    }

    @Test("submit com nota fora do intervalo gera gradeErrors")
    func submitGradeOutOfRangeGeneratesError() {
        let vm = GradeViewModel()
        vm.name = "Lucas"
        vm.grades = [11.0, 8.0, 9.0]
        vm.submit()
        #expect(vm.result == nil)
        #expect(vm.gradeErrors[0] != nil)
    }

    @Test("erro em uma nota não contamina as demais posições")
    func singleGradeErrorDoesNotAffectOtherPositions() {
        let vm = GradeViewModel()
        vm.name = "Pedro"
        vm.grades = [nil, 8.0, 9.0]
        vm.submit()
        #expect(vm.gradeErrors[0] != nil)
        #expect(vm.gradeErrors[1] == nil)
        #expect(vm.gradeErrors[2] == nil)
    }

    @Test("submit válido gera resultado com média correta")
    func submitValidCalculatesCorrectAverage() {
        let vm = GradeViewModel()
        vm.name = "João"
        vm.grades = [7.0, 8.0, 9.0]
        vm.submit()
        #expect(vm.result != nil)
        #expect(vm.result?.average == 8.0)
        #expect(vm.result?.name == "João")
        #expect(vm.errorMessage == nil)
        #expect(vm.gradeErrors.allSatisfy { $0 == nil })
    }

    @Test("média exatamente 7.0 é aprovado")
    func averageExactly7IsApproved() {
        let vm = GradeViewModel()
        vm.name = "Maria"
        vm.grades = [7.0, 7.0, 7.0]
        vm.submit()
        #expect(vm.result?.average == 7.0)
    }

    @Test("média abaixo de 7.0 é reprovado")
    func averageBelow7IsReprovado() {
        let vm = GradeViewModel()
        vm.name = "Carlos"
        vm.grades = [5.0, 6.0, 6.0]
        vm.submit()
        #expect(vm.result != nil)
        #expect((vm.result?.average ?? 0) < 7.0)
    }

    @Test("reset limpa todos os campos e erros")
    func resetClearsAllFields() {
        let vm = GradeViewModel()
        vm.name = "Maria"
        vm.grades = [8.0, 9.0, 10.0]
        vm.submit()
        vm.reset()
        #expect(vm.name.isEmpty)
        #expect(vm.grades.allSatisfy { $0 == nil })
        #expect(vm.result == nil)
        #expect(vm.errorMessage == nil)
        #expect(vm.gradeErrors.allSatisfy { $0 == nil })
    }
}

// MARK: - ValidationService Tests

@Suite("ValidationService")
struct ValidationServiceTests {
    @Test("campo vazio lança emptyField")
    func emptyStringThrows() {
        #expect(throws: (any Error).self) {
            try ValidationService.validateNotEmpty("", fieldName: "Teste")
        }
    }

    @Test("campo com apenas espaços lança emptyField")
    func whitespaceStringThrows() {
        #expect(throws: (any Error).self) {
            try ValidationService.validateNotEmpty("   ", fieldName: "Teste")
        }
    }

    @Test("campo preenchido não lança")
    func validStringDoesNotThrow() throws {
        try ValidationService.validateNotEmpty("ABC", fieldName: "Teste")
    }

    @Test("nil lança invalidGrade")
    func nilGradeThrows() {
        #expect(throws: (any Error).self) {
            try ValidationService.validateGrade(nil)
        }
    }

    @Test("nota -0.1 lança outOfRange")
    func gradeBelowZeroThrows() {
        #expect(throws: (any Error).self) {
            try ValidationService.validateGrade(-0.1)
        }
    }

    @Test("nota 10.1 lança outOfRange")
    func gradeAbove10Throws() {
        #expect(throws: (any Error).self) {
            try ValidationService.validateGrade(10.1)
        }
    }

    @Test("nota 0.0 é válida")
    func gradeZeroIsValid() throws {
        let result = try ValidationService.validateGrade(0.0)
        #expect(result == 0.0)
    }

    @Test("nota 10.0 é válida")
    func grade10IsValid() throws {
        let result = try ValidationService.validateGrade(10.0)
        #expect(result == 10.0)
    }

    @Test("nil lança invalidAge")
    func nilAgeThrows() {
        #expect(throws: (any Error).self) {
            try ValidationService.validateAge(nil)
        }
    }

    @Test("idade 0 lança invalidAge")
    func zeroAgeThrows() {
        #expect(throws: (any Error).self) {
            try ValidationService.validateAge(0)
        }
    }

    @Test("idade 150 lança invalidAge")
    func age150Throws() {
        #expect(throws: (any Error).self) {
            try ValidationService.validateAge(150)
        }
    }

    @Test("idade 1 é válida")
    func age1IsValid() throws {
        let result = try ValidationService.validateAge(1)
        #expect(result == 1)
    }

    @Test("idade 149 é válida")
    func age149IsValid() throws {
        let result = try ValidationService.validateAge(149)
        #expect(result == 149)
    }

    @Test("nil em validatePositiveNumber lança")
    func nilPositiveNumberThrows() {
        #expect(throws: (any Error).self) {
            try ValidationService.validatePositiveNumber(nil, fieldName: "X")
        }
    }

    @Test("zero em validatePositiveNumber lança")
    func zeroPositiveNumberThrows() {
        #expect(throws: (any Error).self) {
            try ValidationService.validatePositiveNumber(0.0, fieldName: "X")
        }
    }

    @Test("valor positivo retorna o próprio valor")
    func positiveNumberReturnsValue() throws {
        let result = try ValidationService.validatePositiveNumber(42.5, fieldName: "X")
        #expect(result == 42.5)
    }
}

// MARK: - CalculationService Tests

@Suite("CalculationService")
struct CalculationServiceTests {
    @Test("média de [7, 8, 9] é 8.0")
    func averageOfThreeGrades() {
        #expect(CalculationService.calculateAverage([7.0, 8.0, 9.0]) == 8.0)
    }

    @Test("média de array vazio é 0.0")
    func averageOfEmptyArray() {
        #expect(CalculationService.calculateAverage([]) == 0.0)
    }

    @Test("média de valor único retorna o próprio valor")
    func averageOfSingleValue() {
        #expect(CalculationService.calculateAverage([5.5]) == 5.5)
    }

    @Test("tabuada de 5 tem exatamente 10 entradas")
    func multiplicationTableHas10Entries() {
        let table = CalculationService.generateMultiplicationTable(for: 5)
        #expect(table.count == 10)
    }

    @Test("primeira entrada da tabuada de 5 é 5")
    func multiplicationTableFirstEntry() {
        let table = CalculationService.generateMultiplicationTable(for: 5)
        #expect(table.first?.result == 5)
    }

    @Test("última entrada da tabuada de 5 é 50")
    func multiplicationTableLastEntry() {
        let table = CalculationService.generateMultiplicationTable(for: 5)
        #expect(table.last?.result == 50)
    }

    @Test("0°C converte para 32°F")
    func zeroCelsiusToFahrenheit() {
        #expect(CalculationService.celsiusToFahrenheit(0) == 32.0)
    }

    @Test("100°C converte para 212°F")
    func boilingCelsiusToFahrenheit() {
        #expect(CalculationService.celsiusToFahrenheit(100) == 212.0)
    }

    @Test("32°F converte para 0°C")
    func freezingFahrenheitToCelsius() {
        #expect(CalculationService.fahrenheitToCelsius(32) == 0.0)
    }

    @Test("212°F converte para 100°C")
    func boilingFahrenheitToCelsius() {
        #expect(CalculationService.fahrenheitToCelsius(212) == 100.0)
    }
}

// MARK: - StringProcessingService Tests

@Suite("StringProcessingService")
struct StringProcessingServiceTests {
    @Test("'arara' é palíndromo")
    func simpleWordIsPalindrome() {
        #expect(StringProcessingService.isPalindrome("arara") == true)
    }

    @Test("'hello' não é palíndromo")
    func nonPalindromeWord() {
        #expect(StringProcessingService.isPalindrome("hello") == false)
    }

    @Test("palíndromo com maiúsculas")
    func uppercasePalindrome() {
        #expect(StringProcessingService.isPalindrome("ARARA") == true)
    }

    @Test("palíndromo com espaços internos")
    func palindromeWithSpaces() {
        #expect(StringProcessingService.isPalindrome("A rara") == true)
    }

    @Test("palíndromo com acento (Ana)")
    func palindromeWithAccent() {
        #expect(StringProcessingService.isPalindrome("Ana") == true)
    }

    @Test("string vazia é palíndromo")
    func emptyStringIsPalindrome() {
        #expect(StringProcessingService.isPalindrome("") == true)
    }

    @Test("normalize converte para minúsculas e remove acentos e espaços")
    func normalizeRemovesAccentsAndSpaces() {
        let result = StringProcessingService.normalize("Ação Voa")
        #expect(result == "acaovoa")
    }
}

// MARK: - RandomService Tests

@Suite("RandomService")
struct RandomServiceTests {
    @Test("generateSecret retorna valor no intervalo [1, 100]")
    func secretInRange() {
        for _ in 0..<20 {
            let secret = RandomService.generateSecret()
            #expect(secret >= 1 && secret <= 100)
        }
    }

    @Test("isCorrect retorna true para valores iguais")
    func isCorrectWhenEqual() {
        #expect(RandomService.isCorrect(42, 42) == true)
    }

    @Test("isCorrect retorna false para valores diferentes")
    func isCorrectWhenDifferent() {
        #expect(RandomService.isCorrect(1, 2) == false)
    }

    @Test("getProximityHint com diferença 0 indica acerto")
    func hintDifference0ShowsCelebration() {
        let hint = RandomService.getProximityHint(guess: 50, secret: 50)
        #expect(hint.contains("🎉"))
    }

    @Test("getProximityHint com diferença 3 indica muito perto")
    func hintDifference3ShowsVeryClose() {
        let hint = RandomService.getProximityHint(guess: 50, secret: 53)
        #expect(hint.contains("🔥"))
    }

    @Test("getProximityHint com diferença 8 indica perto")
    func hintDifference8ShowsClose() {
        let hint = RandomService.getProximityHint(guess: 50, secret: 58)
        #expect(hint.contains("😊"))
    }

    @Test("getProximityHint com diferença 13 indica longe")
    func hintDifference13ShowsFar() {
        let hint = RandomService.getProximityHint(guess: 50, secret: 63)
        #expect(hint.contains("📍"))
    }

    @Test("getProximityHint com diferença 20 indica muito longe")
    func hintDifference20ShowsVeryFar() {
        let hint = RandomService.getProximityHint(guess: 50, secret: 80)
        #expect(hint.contains("❄️"))
    }
}

// MARK: - QuizService Tests

@Suite("QuizService")
struct QuizServiceTests {
    @Test("questions(for:) retorna array não vazio para todos os temas")
    func questionsNotEmptyForAllThemes() {
        for theme in QuizTheme.allCases {
            let questions = QuizService.questions(for: theme)
            #expect(!questions.isEmpty)
        }
    }

    @Test("randomQuestions retorna a quantidade solicitada quando disponível")
    func randomQuestionsReturnsRequestedCount() {
        let all = QuizService.questions(for: .swift)
        let sample = QuizService.randomQuestions(from: all, count: 5)
        #expect(sample.count == 5)
    }

    @Test("randomQuestions com count maior que total retorna todos os itens")
    func randomQuestionsWithExcessCountReturnsAll() {
        let all = QuizService.questions(for: .swift)
        let sample = QuizService.randomQuestions(from: all, count: all.count + 100)
        #expect(sample.count == all.count)
    }

    @Test("isCorrect retorna true para índice correto")
    func isCorrectForCorrectIndex() {
        let question = QuizService.questions(for: .swift)[0]
        #expect(QuizService.isCorrect(question: question, selectedIndex: question.correctIndex) == true)
    }

    @Test("isCorrect retorna false para índice errado")
    func isCorrectForWrongIndex() {
        let question = QuizService.questions(for: .swift)[0]
        let wrongIndex = question.correctIndex == 0 ? 1 : 0
        #expect(QuizService.isCorrect(question: question, selectedIndex: wrongIndex) == false)
    }
}
