package com.zodiak.android.core.services

import java.text.Normalizer

/**
 * Processamento de strings — stateless object.
 */
object StringProcessingService {

    fun isPalindrome(text: String): Boolean {
        val cleaned = normalize(text)
        return cleaned == cleaned.reversed()
    }

    fun normalize(text: String): String {
        val nfd = Normalizer.normalize(text, Normalizer.Form.NFD)
        return nfd
            .replace(Regex("\\p{InCombiningDiacriticalMarks}+"), "")
            .replace(Regex("[^a-zA-Z0-9]"), "")
            .lowercase()
    }
}
