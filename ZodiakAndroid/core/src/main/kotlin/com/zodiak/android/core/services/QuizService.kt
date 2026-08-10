package com.zodiak.android.core.services

import com.zodiak.android.core.models.Question
import com.zodiak.android.core.models.QuizTheme

/**
 * Banco de perguntas do quiz e lógica do jogo — stateless object.
 */
object QuizService {

    fun questions(theme: QuizTheme): List<Question> = when (theme) {
        QuizTheme.SWIFT     -> swiftQuestions
        QuizTheme.FILMES    -> filmesQuestions
        QuizTheme.HISTORIA  -> historiaQuestions
        QuizTheme.GEOGRAFIA -> geografiaQuestions
    }

    fun randomQuestions(from: List<Question>, count: Int): List<Question> =
        from.shuffled().take(count)

    fun isCorrect(question: Question, selectedIndex: Int): Boolean =
        question.correctIndex == selectedIndex

    // ─── Banco: Swift ──────────────────────────────────────────────────────────

    private val swiftQuestions = listOf(
        Question(
            text = "Qual palavra-chave define uma constante em Swift?",
            options = listOf("var", "let", "const", "final"),
            correctIndex = 1,
        ),
        Question(
            text = "Qual tipo representa texto em Swift?",
            options = listOf("Text", "Char", "String", "str"),
            correctIndex = 2,
        ),
        Question(
            text = "O que é um Optional em Swift?",
            options = listOf("Um tipo que pode ser nulo", "Um tipo obrigatório", "Um tipo numérico", "Um tipo de coleção"),
            correctIndex = 0,
        ),
        Question(
            text = "Qual framework é usado para criar interfaces em SwiftUI?",
            options = listOf("UIKit", "AppKit", "SwiftUI", "Cocoa"),
            correctIndex = 2,
        ),
        Question(
            text = "Qual operador desempacota um Optional com segurança?",
            options = listOf("!", "?", "if let", "??"),
            correctIndex = 2,
        ),
        Question(
            text = "Qual property wrapper é usado para estado local em SwiftUI?",
            options = listOf("@Binding", "@State", "@Published", "@ObservedObject"),
            correctIndex = 1,
        ),
        Question(
            text = "Qual protocolo permite iterar sobre os casos de um enum?",
            options = listOf("Iterable", "CaseIterable", "Enumerable", "Sequence"),
            correctIndex = 1,
        ),
        Question(
            text = "Qual é a estrutura de dados ordenada mais comum em Swift?",
            options = listOf("Set", "Dictionary", "Array", "Tuple"),
            correctIndex = 2,
        ),
    )

    // ─── Banco: Filmes ─────────────────────────────────────────────────────────

    private val filmesQuestions = listOf(
        Question(
            text = "Quem dirigiu o filme 'Titanic' (1997)?",
            options = listOf("Steven Spielberg", "James Cameron", "Martin Scorsese", "Ridley Scott"),
            correctIndex = 1,
        ),
        Question(
            text = "Qual filme ganhou o Oscar de Melhor Filme em 2020?",
            options = listOf("1917", "Parasita", "Coringa", "Era Uma Vez em Hollywood"),
            correctIndex = 1,
        ),
        Question(
            text = "Em 'O Senhor dos Anéis', quem carrega o anel até Mordor?",
            options = listOf("Aragorn", "Gandalf", "Frodo", "Legolas"),
            correctIndex = 2,
        ),
        Question(
            text = "Qual o nome do personagem de Leonardo DiCaprio em 'A Origem'?",
            options = listOf("Arthur", "Cobb", "Fischer", "Eames"),
            correctIndex = 1,
        ),
        Question(
            text = "Qual estúdio de animação criou 'Toy Story'?",
            options = listOf("DreamWorks", "Disney", "Pixar", "Illumination"),
            correctIndex = 2,
        ),
        Question(
            text = "Em qual ano foi lançado o primeiro filme 'Star Wars'?",
            options = listOf("1975", "1977", "1980", "1983"),
            correctIndex = 1,
        ),
        Question(
            text = "Qual ator interpretou o Coringa em 'O Cavaleiro das Trevas'?",
            options = listOf("Jack Nicholson", "Jared Leto", "Heath Ledger", "Joaquin Phoenix"),
            correctIndex = 2,
        ),
        Question(
            text = "Qual filme tem a frase 'Eu sou seu pai'?",
            options = listOf(
                "Star Wars: Uma Nova Esperança",
                "Star Wars: O Império Contra-Ataca",
                "Star Wars: O Retorno de Jedi",
                "Star Wars: A Ameaça Fantasma",
            ),
            correctIndex = 1,
        ),
    )

    // ─── Banco: História ───────────────────────────────────────────────────────

    private val historiaQuestions = listOf(
        Question(
            text = "Em que ano o Brasil foi proclamado República?",
            options = listOf("1822", "1889", "1891", "1900"),
            correctIndex = 1,
        ),
        Question(
            text = "Quem foi o primeiro presidente do Brasil?",
            options = listOf("Getúlio Vargas", "Dom Pedro II", "Deodoro da Fonseca", "Prudente de Morais"),
            correctIndex = 2,
        ),
        Question(
            text = "Qual evento marcou o início da Primeira Guerra Mundial?",
            options = listOf(
                "Invasão da Polônia",
                "Assassinato do Arquiduque Franz Ferdinand",
                "Revolução Russa",
                "Queda do Muro de Berlim",
            ),
            correctIndex = 1,
        ),
        Question(
            text = "Em que ano Cristóvão Colombo chegou às Américas?",
            options = listOf("1400", "1450", "1492", "1500"),
            correctIndex = 2,
        ),
        Question(
            text = "Qual civilização construiu as pirâmides de Gizé?",
            options = listOf("Romana", "Grega", "Egípcia", "Maia"),
            correctIndex = 2,
        ),
        Question(
            text = "A Revolução Francesa começou em qual ano?",
            options = listOf("1776", "1789", "1799", "1804"),
            correctIndex = 1,
        ),
        Question(
            text = "Quem escreveu 'A Arte da Guerra'?",
            options = listOf("Confúcio", "Sun Tzu", "Lao Tzu", "Maquiavel"),
            correctIndex = 1,
        ),
        Question(
            text = "Qual tratado encerrou a Primeira Guerra Mundial?",
            options = listOf("Tratado de Paris", "Tratado de Versalhes", "Tratado de Viena", "Tratado de Roma"),
            correctIndex = 1,
        ),
    )

    // ─── Banco: Geografia ──────────────────────────────────────────────────────

    private val geografiaQuestions = listOf(
        Question(
            text = "Qual é o maior país do mundo em área territorial?",
            options = listOf("China", "EUA", "Canadá", "Rússia"),
            correctIndex = 3,
        ),
        Question(
            text = "Qual é o rio mais longo do mundo?",
            options = listOf("Amazonas", "Nilo", "Mississipi", "Yangtzé"),
            correctIndex = 1,
        ),
        Question(
            text = "Quantos continentes existem?",
            options = listOf("5", "6", "7", "8"),
            correctIndex = 2,
        ),
        Question(
            text = "Qual é a capital da Austrália?",
            options = listOf("Sydney", "Melbourne", "Canberra", "Brisbane"),
            correctIndex = 2,
        ),
        Question(
            text = "Qual é o menor país do mundo?",
            options = listOf("Mônaco", "Vaticano", "San Marino", "Liechtenstein"),
            correctIndex = 1,
        ),
        Question(
            text = "Em qual continente fica o Deserto do Saara?",
            options = listOf("Ásia", "América do Sul", "África", "Oceania"),
            correctIndex = 2,
        ),
        Question(
            text = "Qual é a montanha mais alta do mundo?",
            options = listOf("K2", "Kangchenjunga", "Monte Everest", "Makalu"),
            correctIndex = 2,
        ),
        Question(
            text = "Qual oceano é o maior do mundo?",
            options = listOf("Atlântico", "Índico", "Ártico", "Pacífico"),
            correctIndex = 3,
        ),
    )
}
