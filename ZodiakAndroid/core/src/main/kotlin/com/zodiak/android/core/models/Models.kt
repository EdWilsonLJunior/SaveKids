package com.zodiak.android.core.models

import java.util.Date
import java.util.UUID

// ─────────────────────────────────────────────────────────────────────────────
// Grade
// ─────────────────────────────────────────────────────────────────────────────

data class Grade(
    val name: String,
    val grade1: Double,
    val grade2: Double,
    val grade3: Double,
) {
    val average: Double get() = (grade1 + grade2 + grade3) / 3.0
    val isPassing: Boolean get() = average >= 7.0
}

// ─────────────────────────────────────────────────────────────────────────────
// Person
// ─────────────────────────────────────────────────────────────────────────────

data class Person(
    val id: UUID = UUID.randomUUID(),
    val name: String,
    val age: Int,
)

// ─────────────────────────────────────────────────────────────────────────────
// Task
// ─────────────────────────────────────────────────────────────────────────────

data class Task(
    val id: UUID = UUID.randomUUID(),
    val title: String,
    val isCompleted: Boolean = false,
)

// ─────────────────────────────────────────────────────────────────────────────
// Candidate
// ─────────────────────────────────────────────────────────────────────────────

data class Candidate(
    val id: UUID = UUID.randomUUID(),
    val name: String,
    val votes: Int = 0,
)

// ─────────────────────────────────────────────────────────────────────────────
// Quiz
// ─────────────────────────────────────────────────────────────────────────────

enum class QuizTheme {
    SWIFT, FILMES, HISTORIA, GEOGRAFIA
}

data class Question(
    val id: UUID = UUID.randomUUID(),
    val text: String,
    val options: List<String>,
    val correctIndex: Int,
)

data class QuizAnswer(
    val id: UUID = UUID.randomUUID(),
    val question: Question,
    val selectedIndex: Int,
    val isCorrect: Boolean,
)

// ─────────────────────────────────────────────────────────────────────────────
// Validation Errors
// ─────────────────────────────────────────────────────────────────────────────

sealed class ValidationError : Exception() {
    data class EmptyField(val fieldName: String) : ValidationError()
    data class InvalidNumber(val fieldName: String) : ValidationError()
    data class OutOfRange(val fieldName: String, val min: Double, val max: Double) : ValidationError()
    object InvalidAge : ValidationError()
    object InvalidGrade : ValidationError()
}

// ─────────────────────────────────────────────────────────────────────────────
// Subject + Student  (Feature 12 — StudentGrades)
// ─────────────────────────────────────────────────────────────────────────────

data class Subject(
    val id: UUID = UUID.randomUUID(),
    val name: String,
    val grade: Double,
)

data class Student(
    val id: UUID = UUID.randomUUID(),
    val name: String,
    val absences: Int,
    val address: String,
    val phone: String,
    val subjects: List<Subject>,
) {
    val average: Double get() =
        if (subjects.isEmpty()) 0.0 else subjects.sumOf { it.grade } / subjects.size
    val isPassing: Boolean get() = average >= 7.0
    val hasCriticalAbsences: Boolean get() = absences >= 15
}

// ─────────────────────────────────────────────────────────────────────────────
// ProductSegment + Product  (Feature 13 — ProductManager)
// ─────────────────────────────────────────────────────────────────────────────

enum class ProductSegment {
    FOOD, ELECTRONICS, HOME
}

data class Product(
    val id: UUID = UUID.randomUUID(),
    val name: String,
    val brand: String,
    val segment: ProductSegment,
    val price: Double,
)

// ─────────────────────────────────────────────────────────────────────────────
// CardTheme + CreditCard  (Feature 14 — CardManager)
// ─────────────────────────────────────────────────────────────────────────────

enum class CardTheme(
    val r: Float,
    val g: Float,
    val b: Float,
) {
    OCEAN   (0.11f, 0.44f, 0.73f),
    MIDNIGHT(0.08f, 0.08f, 0.20f),
    SLATE   (0.25f, 0.32f, 0.40f),
    AMBER   (0.58f, 0.33f, 0.05f),
    FOREST  (0.10f, 0.35f, 0.20f),
    CRIMSON (0.55f, 0.09f, 0.12f),
}

data class CreditCard(
    val id: UUID = UUID.randomUUID(),
    val bankName: String,
    val brand: String,
    val lastDigits: String,
    val theme: CardTheme,
    val limit: Double,
    val dueDate: Date,
)

// ─────────────────────────────────────────────────────────────────────────────
// ShopCategory + ShopProduct + CartItem  (Feature 15 — ShopMaster)
// ─────────────────────────────────────────────────────────────────────────────

enum class ShopCategory {
    ELECTRONICS, FOOD, HOME
}

data class ShopProduct(
    val id: UUID = UUID.randomUUID(),
    val name: String,
    val category: ShopCategory,
    val price: Double,
    val icon: String,
)

data class CartItem(
    val id: UUID,
    val product: ShopProduct,
    val quantity: Int,
) {
    val subtotal: Double get() = product.price * quantity

    constructor(product: ShopProduct, quantity: Int = 1) : this(
        id = product.id,
        product = product,
        quantity = quantity,
    )
}

// ─────────────────────────────────────────────────────────────────────────────
// Currency  (Feature 26 — CurrencyConverter)
// ─────────────────────────────────────────────────────────────────────────────

data class Currency(
    val code: String,
    val name: String,
    val symbol: String,
    val flag: String,
    /** Taxa em relação ao USD (ex: BRL = 5.70, EUR = 0.92) */
    val usdRate: Double,
)

// ─────────────────────────────────────────────────────────────────────────────
// BookPage  (Feature 17 — BookReader)
// ─────────────────────────────────────────────────────────────────────────────

data class BookPage(
    val index: Int,
    val title: String,
    val content: String,
)
