//
//  main.swift
//  gagan_Citizenship
//
//  Created by Gagandeep Kaur on 2025-01-21.
//

import Foundation

print("Hello, World!")

protocol Evaluatable {
    func evaluate(score: Int) -> Bool
}
class Question {
    let category: String
    let questionText: String
    let options: [String]
    let correctAnswer: Int // Index of the correct option
    
    init(category: String, questionText: String, options: [String], correctAnswer: Int) {
        self.category = category
        self.questionText = questionText
        self.options = options
        self.correctAnswer = correctAnswer
    }
}
class QuizCategory: Evaluatable {
    let name: String
    let questions: [Question]
    let passingScore: Int
    
    init(name: String, questions: [Question], passingScore: Int) {
        self.name = name
        self.questions = questions
        self.passingScore = passingScore
    }
    
    func evaluate(score: Int) -> Bool {
        return score >= passingScore
    }
}
class Quiz {
    private var categories: [QuizCategory]
    private var userScores: [String: Int] = [:]
    
    init(categories: [QuizCategory]) {
        self.categories = categories
    }
    func startQuiz() {
        print("Welcome to the Citizenship Quiz!")
        for category in quiz.categories {
            print("Category: \(category.name)")
            var score = 0
            for question in category.questions {
                print(question.questionText)
                for option in question.options {
                    print("  \(option)")
                }
                print("Your answer (a or b): ", terminator: "")
                if let input = readLine(), let answerIndex = ["a": 0, "b": 1][input.lowercased()], answerIndex == question.correctAnswer {
                        print("Correct!")
                        score += 1
                    } else {
                        print("Wrong answer.")
                    }
            }
            userScores[category.name] = score
           print("\nCategory \(category.name) Results: \(score) out of \(category.questions.count)")
           
           if !category.evaluate(score: score) {
               print("You did not meet the passing criteria for \(category.name). Test terminated.")
               return
           }
        }
    }
    private func result(){
        for (category, score) in userScores {
            print("\(category): \(score) out of \(category.questions.count)")
        }
    }
}

let historyQuestions = [
    Question(category: "History", questionText: "When did Canada become a country?", options: ["1867", "1905"], correctAnswer: 0),
    Question(category: "History", questionText: "Who was the first Prime Minister of Canada?", options: ["John A. Macdonald", "Wilfrid Laurier"], correctAnswer: 0),
    Question(category: "History", questionText: "Which war defined Canada as a nation?", options: ["World War I", "The War of 1812"], correctAnswer: 1)
]
let politicsQuestions = [
    Question(category: "Politics", questionText: "How many provinces does Canada have?", options: ["10", "13"], correctAnswer: 0),
    Question(category: "Politics", questionText: "What does the Canadian Parliament consist of?", options: ["The House of Commons and the Senate", "The Prime Minister and the Cabinet"], correctAnswer: 0),
    Question(category: "Politics", questionText: "Who is the head of state in Canada?", options: ["The King", "The Prime Minister"], correctAnswer: 0)
]

let cultureQuestions = [
    Question(category: "Culture", questionText: "What is Canada's national sport?", options: ["Hockey and Lacrosse", "Baseball"], correctAnswer: 0),
    Question(category: "Culture", questionText: "What is a popular Canadian dish?", options: ["Poutine", "Tacos"], correctAnswer: 0),
    Question(category: "Culture", questionText: "Which city is known for its French culture?", options: ["Montreal", "Vancouver"], correctAnswer: 0)
]

let historyCategory = QuizCategory(name: "History", questions: historyQuestions, passingScore: 1)
let politicsCategory = QuizCategory(name: "Politics", questions: politicsQuestions, passingScore: 2)
let cultureCategory = QuizCategory(name: "Culture", questions: cultureQuestions, passingScore: 3)

let quiz = Quiz(categories: [historyCategory,politicsCategory, cultureCategory])
quiz.startQuiz()
