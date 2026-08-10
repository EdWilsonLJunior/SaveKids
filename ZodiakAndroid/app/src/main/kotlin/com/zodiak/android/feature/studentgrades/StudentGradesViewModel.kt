package com.zodiak.android.feature.studentgrades

import androidx.lifecycle.ViewModel
import com.zodiak.android.core.models.Student
import com.zodiak.android.core.models.Subject
import com.zodiak.android.core.models.ValidationError
import com.zodiak.android.core.services.ValidationService
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import java.util.UUID
import javax.inject.Inject

data class StudentGradesUiState(
    val name: String = "",
    val absences: String = "",
    val address: String = "",
    val phone: String = "",
    val subjectName: String = "",
    val subjectGrade: String = "",
    val subjects: List<Subject> = emptyList(),
    val students: List<Student> = emptyList(),
    val selectedStudent: Student? = null,
    val error: ValidationError? = null,
    val noSubjectsError: Boolean = false,
)

@HiltViewModel
class StudentGradesViewModel @Inject constructor() : ViewModel() {

    private val _uiState = MutableStateFlow(StudentGradesUiState())
    val uiState: StateFlow<StudentGradesUiState> = _uiState.asStateFlow()

    fun onNameChange(v: String)        = _uiState.update { it.copy(name = v) }
    fun onAbsencesChange(v: String)    = _uiState.update { it.copy(absences = v) }
    fun onAddressChange(v: String)     = _uiState.update { it.copy(address = v) }
    fun onPhoneChange(v: String)       = _uiState.update { it.copy(phone = v) }
    fun onSubjectNameChange(v: String) = _uiState.update { it.copy(subjectName = v) }
    fun onSubjectGradeChange(v: String)= _uiState.update { it.copy(subjectGrade = v) }

    fun addSubject() {
        try {
            ValidationService.validateNotEmpty(_uiState.value.subjectName, "Matéria")
            val grade = ValidationService.validateGrade(_uiState.value.subjectGrade.toDoubleOrNull())
            val subject = Subject(name = _uiState.value.subjectName.trim(), grade = grade)
            _uiState.update { it.copy(subjects = it.subjects + subject, subjectName = "", subjectGrade = "") }
        } catch (e: ValidationError) {
            _uiState.update { it.copy(error = e, noSubjectsError = false) }
        }
    }

    fun addStudent() {
        try {
            ValidationService.validateNotEmpty(_uiState.value.name, "Nome")
            if (_uiState.value.subjects.isEmpty()) {
                _uiState.update { it.copy(noSubjectsError = true, error = null) }
                return
            }
            val student = Student(
                name     = _uiState.value.name.trim(),
                absences = _uiState.value.absences.toIntOrNull() ?: 0,
                address  = _uiState.value.address.trim(),
                phone    = _uiState.value.phone.trim(),
                subjects = _uiState.value.subjects,
            )
            _uiState.update {
                it.copy(students = it.students + student, name = "", absences = "", address = "", phone = "", subjects = emptyList(), error = null, noSubjectsError = false)
            }
        } catch (e: ValidationError) {
            _uiState.update { it.copy(error = e, noSubjectsError = false) }
        }
    }

    fun selectStudent(student: Student?) = _uiState.update { it.copy(selectedStudent = student) }
    fun removeStudent(id: UUID) = _uiState.update { it.copy(students = it.students.filter { s -> s.id != id }) }
}
