import Testing
@testable import ZodiakiOS

// MARK: - HangmanGameViewModel Tests

@Suite("HangmanGameViewModel Tests")
@MainActor
struct HangmanGameViewModelTests {
    @Test("initial state is playing with empty guessed letters")
    func initialStateIsPlaying() {
        let vm = HangmanGameViewModel()
        #expect(vm.phase == .playing)
        #expect(vm.guessedLetters.isEmpty)
        #expect(vm.wrongAttempts == 0)
        #expect(!vm.currentWord.isEmpty)
    }

    @Test("guessing a correct letter reveals it and stays playing")
    func correctLetterIsRevealed() {
        let vm = HangmanGameViewModel()
        guard let firstLetter = vm.currentWord.first else {
            Issue.record("currentWord is empty")
            return
        }
        vm.guessLetter(firstLetter)
        #expect(vm.guessedLetters.contains(firstLetter))
        #expect(vm.wrongAttempts == 0)
        #expect(vm.phase == .playing || vm.phase == .won)
    }

    @Test("guessing a wrong letter increments wrong attempts")
    func wrongLetterIncrementsAttempts() {
        let vm = HangmanGameViewModel()
        let wrongLetter = wrongLetterNotInWord(vm.currentWord)
        vm.guessLetter(wrongLetter)
        #expect(vm.wrongAttempts == 1)
        #expect(vm.phase == .playing)
    }

    @Test("same letter cannot be guessed twice")
    func duplicateLetterIgnored() {
        let vm = HangmanGameViewModel()
        guard let letter = vm.currentWord.first else {
            Issue.record("currentWord is empty")
            return
        }
        vm.guessLetter(letter)
        vm.guessLetter(letter)
        #expect(vm.guessedLetters.count == 1)
    }

    @Test("reaching max errors transitions to lost")
    func maxErrorsLosesGame() {
        let vm = HangmanGameViewModel()
        var errorsGiven = 0
        for letter in HangmanGameConstants.alphabet {
            guard errorsGiven < HangmanGameConstants.maxAttempts else { break }
            if !vm.currentWord.contains(letter) {
                vm.guessLetter(letter)
                errorsGiven += 1
            }
        }
        if errorsGiven == HangmanGameConstants.maxAttempts {
            #expect(vm.phase == .lost)
        }
    }

    @Test("guessing all letters transitions to won")
    func allLettersWinsGame() {
        let vm = HangmanGameViewModel()
        for letter in vm.currentWord {
            vm.guessLetter(letter)
        }
        #expect(vm.phase == .won)
    }

    @Test("displayWord shows underscores for hidden letters")
    func displayWordShowsUnderscores() {
        let vm = HangmanGameViewModel()
        #expect(vm.displayWord.contains("_"))
    }

    @Test("displayWord reveals only guessed letters")
    func displayWordRevealsGuessedLetters() {
        let vm = HangmanGameViewModel()
        guard let letter = vm.currentWord.first else {
            Issue.record("currentWord is empty")
            return
        }
        vm.guessLetter(letter)
        #expect(vm.displayWord.contains(String(letter)))
    }

    @Test("restart resets all state")
    func restartResetsState() {
        let vm = HangmanGameViewModel()
        let wrongLetter = wrongLetterNotInWord(vm.currentWord)
        vm.guessLetter(wrongLetter)
        vm.restart()
        #expect(vm.phase == .playing)
        #expect(vm.guessedLetters.isEmpty)
        #expect(vm.wrongAttempts == 0)
    }

    @Test("remainingAttempts decrements with each wrong guess")
    func remainingAttemptsDecrement() {
        let vm = HangmanGameViewModel()
        let initial = vm.remainingAttempts
        let wrongLetter = wrongLetterNotInWord(vm.currentWord)
        vm.guessLetter(wrongLetter)
        #expect(vm.remainingAttempts == initial - 1)
    }

    @Test("guessing is ignored when game is won")
    func guessIgnoredAfterWon() {
        let vm = HangmanGameViewModel()
        for letter in vm.currentWord { vm.guessLetter(letter) }
        #expect(vm.phase == .won)
        let countBefore = vm.guessedLetters.count
        let unused = HangmanGameConstants.alphabet.first { !vm.guessedLetters.contains($0) }
        if let letter = unused {
            vm.guessLetter(letter)
            #expect(vm.guessedLetters.count == countBefore)
        }
    }

    // MARK: - Helpers

    private func wrongLetterNotInWord(_ word: String) -> Character {
        HangmanGameConstants.alphabet.first { !word.contains($0) } ?? "Z"
    }
}
