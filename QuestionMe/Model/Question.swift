//
//  Question.swift
//  QuestionMe
//
//  Created by Marina Romanova on 13/12/2020.
//

import Foundation

struct Question: Identifiable {
	var id: Int
	var imageURL: String
	var text: String
	var correctAnswer: Bool

	var info: String? = nil
	var hint: String? = nil

	#if DEBUG
	static let defaultQuestions = [
		Question(id: 0, imageURL: "pic", text: "Marina is UX Designer", correctAnswer: false, info: "Marina is a mobile developer", hint: "Marina works together with UX designers"),
		Question(id: 1, imageURL: "Sophie", text: "Sophie creates digital products", correctAnswer: true, info: "Sophie is behind User journeys", hint: "Sophie works with graphical editors"),
		Question(id: 2, imageURL: "Martin", text: "Martin loves writing CSS, he is frontend developer", correctAnswer: false, info: "Martin is a backend developer, but he does write CSS when he has to", hint: "CSS and HTML is sometimes part of Martin's job, but he deals mostly with business logic of the apps"),
		Question(id: 3, imageURL: "William", text: "William takes care of our servers, he is System Admin", correctAnswer: false, info: "William knows a big deal about servers, but he is frontend gouru", hint: "William wotks with Information systems, but his occupation has more visual nature"),

		Question(id: 4, imageURL: "pic", text: "Marina is UX Designer", correctAnswer: false, info: "Marina is a mobile developer", hint: "Marina works together with UX designers"),
		Question(id: 5,imageURL: "Sophie", text: "Sophie creates digital products", correctAnswer: true, info: "Sophie is behind User journeys", hint: "Sophie works with graphical editors"),
		Question(id: 6,imageURL: "Martin", text: "Martin loves writing CSS, he is frontend developer", correctAnswer: false, info: "Martin is a backend developer, but he does write CSS when he has to", hint: "CSS and HTML is sometimes part of Martin's job, but he deals mostly with business logic of the apps"),
		Question(id: 7,imageURL: "William", text: "William takes care of our servers, he is System Admin", correctAnswer: false, info: "William knows a big deal about servers, but he is frontend gouru", hint: "William wotks with Information systems, but his occupation has more visual nature"),

		Question(id: 8, imageURL: "pic", text: "Marina is UX Designer", correctAnswer: false, info: "Marina is a mobile developer", hint: "Marina works together with UX designers"),
		Question(id: 9,imageURL: "Sophie", text: "Sophie creates digital products", correctAnswer: true, info: "Sophie is behind User journeys", hint: "Sophie works with graphical editors"),
		Question(id: 10,imageURL: "Martin", text: "Martin loves writing CSS, he is frontend developer", correctAnswer: false, info: "Martin is a backend developer, but he does write CSS when he has to", hint: "CSS and HTML is sometimes part of Martin's job, but he deals mostly with business logic of the apps"),
		Question(id: 11,imageURL: "William", text: "William takes care of our servers, he is System Admin", correctAnswer: false, info: "William knows a big deal about servers, but he is frontend gouru", hint: "William wotks with Information systems, but his occupation has more visual nature")
	]
	#endif
}
