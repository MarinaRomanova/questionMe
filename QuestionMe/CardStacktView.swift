//
//  CardStackView.swift
//  QuestionMe
//
//  Created by Marina Romanova on 13/12/2020.
//

import SwiftUI

struct CardStacktView: View {
	@EnvironmentObject var vm: GameViewModel

	// Compute what the max ID in the given questions array is.
	private var maxID: Int { self.vm.questions.map { $0.id }.max() ?? 0 }

	var body: some View {
		GeometryReader { geometry in
			VStack {
				Button("New Game") {
					withAnimation(.easeInOut) {
						vm.resetGame()
					}
				}
				ZStack(alignment: .center) {
					ForEach(vm.questions) { question in
						if (self.maxID - 3)...self.maxID ~= question.id {
							CardView(question: question) { q, answer in
								vm.updateScore(question: q, answer: answer)
							}
							.animation(.spring())
							.frame(width: getCardWidth(geometry, at: question.id),
								   height: geometry.size.height * 0.6)

							.offset(x: 0, y: getCardOffset(geometry, at: question.id))
						}
					}

				}
			}
		}.padding()
    }
}

//MARK: - Helpers

extension CardStacktView {

	/// Helper function used to calculate the width of the card depending on its position in the array
	/// 
	/// - Parameter geometry : The geometry proxy of the parent
	/// - Parameter index: The id of current question
	///
	/// - Returns: the CardView width for the given offset in the array
	private func getCardWidth(_ geometry: GeometryProxy,at index: Int) -> CGFloat {geometry.size.width - getCardOffset(geometry, at: index)
	}

	/// Helper function used to calculate frame offset for the given offset in the array
	///
	/// - Parameter geometry : The geometry proxy of the parent
	/// - Parameter index: The id of current question
	///
	/// - Returns: the CardView frame offset for the given offset in the array
	private func getCardOffset(_ geometry: GeometryProxy, at index: Int) -> CGFloat {
		CGFloat(vm.questions.count - 1 - index) * 10
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CardStacktView().environmentObject(GameViewModel())
    }
}
