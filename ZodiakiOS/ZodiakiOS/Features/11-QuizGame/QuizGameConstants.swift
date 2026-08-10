import Foundation
import SwiftUI

// MARK: - Constants
enum QuizGameConstants {
    static let questionsPerGame: Int = 5
    static let optionsPerQuestion: Int = 4
    static let activityTitle: LocalizedStringKey  = "feature.quiz_game.title"
    static let selectThemeTitle: LocalizedStringKey = "feature.quiz_game.choose_theme"
    static let confirmButton: LocalizedStringKey  = "shared.action.confirm"
    static let nextButton: LocalizedStringKey     = "shared.action.next_question"
    static let finishButton: LocalizedStringKey   = "feature.quiz_game.view_result"
    static let playAgainButton: LocalizedStringKey = "shared.action.play_again"
    static let correctFeedback: LocalizedStringKey = "feature.quiz_game.correct_feedback"
    static let incorrectFeedback: LocalizedStringKey = "feature.quiz_game.wrong_feedback"
}
