package com.zodiak.android.core.services

import com.zodiak.android.core.models.ValidationError

/**
 * Validações puras de entrada do usuário — stateless object, sem dependências Android.
 */
object ValidationService {

    @Throws(ValidationError.EmptyField::class)
    fun validateNotEmpty(value: String, fieldName: String) {
        if (value.trim().isEmpty()) throw ValidationError.EmptyField(fieldName)
    }

    @Throws(ValidationError::class)
    fun validateGrade(value: Double?): Double {
        val grade = value ?: throw ValidationError.InvalidGrade
        if (grade < 0.0 || grade > 10.0) throw ValidationError.OutOfRange("Nota", 0.0, 10.0)
        return grade
    }

    @Throws(ValidationError::class)
    fun validatePositiveNumber(value: Double?, fieldName: String): Double {
        val number = value ?: throw ValidationError.InvalidNumber(fieldName)
        if (number <= 0) throw ValidationError.InvalidNumber(fieldName)
        return number
    }

    @Throws(ValidationError::class)
    fun validateAge(value: Int?): Int {
        val age = value ?: throw ValidationError.InvalidAge
        if (age <= 0 || age >= 150) throw ValidationError.InvalidAge
        return age
    }

    @Throws(ValidationError::class)
    fun validateInRange(value: Double?, min: Double, max: Double, fieldName: String): Double {
        val number = value ?: throw ValidationError.InvalidNumber(fieldName)
        if (number < min || number > max) throw ValidationError.OutOfRange(fieldName, min, max)
        return number
    }
}
