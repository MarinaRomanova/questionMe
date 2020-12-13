//
//  GameViewModel.swift
//  QuestionMe
//
//  Created by Marina Romanova on 13/12/2020.
//

import Combine
import Foundation

class GameViewModel: ObservableObject {
	private var score = 0.0
	@Published var questions: [Question]

	init() {
		questions = Question.defaultQuestions
	}

	func resetGame() {
		questions = Question.defaultQuestions
	}

	func updateScore(question: Question, answer: Bool) {
		questions.removeAll { $0.id == question.id }

		if question.correctAnswer == answer {
			score += 1
		}
		
		if questions.isEmpty {
			let readableScore = (score / Double(Question.defaultQuestions.count)).rounded() * 100
			print("You have answered correctly: \(readableScore) %")
		}
	}
}
