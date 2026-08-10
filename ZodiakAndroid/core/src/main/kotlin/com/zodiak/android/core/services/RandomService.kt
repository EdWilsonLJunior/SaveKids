package com.zodiak.android.core.services

/**
 * Geração aleatória e dicas de proximidade — stateless object.
 */
object RandomService {

    fun generateSecret(): Int = (1..100).random()

    fun getProximityHint(guess: Int, secret: Int): String {
        return when (val diff = kotlin.math.abs(guess - secret)) {
            0        -> "🎉 Você acertou!"
            in 1..5  -> "🔥 Muito perto!"
            in 6..10 -> "😊 Perto"
            in 11..15 -> "📍 Longe"
            else     -> "❄️ Muito longe!"
        }
    }

    fun isCorrect(guess: Int, secret: Int): Boolean = guess == secret
}
