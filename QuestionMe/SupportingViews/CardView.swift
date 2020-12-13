//
//  CardView.swift
//  QuestionMe
//
//  Created by Marina Romanova on 13/12/2020.
//

import SwiftUI

struct CardView: View {
	@State private var translation: CGSize = .zero
	@State private var swipeStatus: SwipeStatus = .none
	@State private var isFaceUp = true
	
	private var tresholdPercentage: CGFloat = 0.5 // user dragged the card 50% of the screen at any direction

	private var question: Question
	private var onAnswered: (_ question: Question, _ answer: Bool) -> Void

	init(question: Question, onAnswered: @escaping (Question, Bool) -> Void) {
		self.question = question
		self.onAnswered = onAnswered
	}

    var body: some View {
		GeometryReader { geometry in
			getCardView(for: geometry)

			.padding(.bottom)
			.background(Color.white)
			.cornerRadius(10)
			.shadow(radius: 3)

			//MARK: - DRAG GESTURES
			.animation(.interactiveSpring())
			.offset(x: isFaceUp ? translation.width : 0,
					y: isFaceUp ? 0 : translation.height)
			.rotationEffect(.degrees(!isFaceUp ? 0: Double(translation.width / geometry.size.width) * 25), anchor: .bottom)
			.gesture(
				DragGesture()
					.onChanged { value in
						translation = value.translation
						trackSwipe(geometry, from: value)
					}
					.onEnded { value in
						if isFaceUp {
							if abs(getGesturePercentageWidth(geometry, from: value)) > tresholdPercentage {
								withAnimation (.linear(duration: 1)) {
									isFaceUp = false
									translation = .zero
								}
							} else {
								translation = .zero
								swipeStatus = .none
							}
						} else {
							if abs(getGesturePercentageHeight(geometry, from: value)) > tresholdPercentage / 3 {
								translation = .zero
								isFaceUp = true
								onAnswered(question, swipeStatus == .positive)
								swipeStatus = .none
							} else {
								translation = .zero
							}
						}
					}
			)
		}
    }
}

// MARK: - ViewBuilders

extension CardView {

	@ViewBuilder
	private func getSwipeStatusView() -> some View {
		if swipeStatus != .none {
			Text( swipeStatus == .positive ? "YES" : "NOPE")
				.font(.headline)
				.padding()
				.cornerRadius(10)
				.foregroundColor(swipeStatus == .positive ? Color.green : Color.red)
				.overlay(
					RoundedRectangle(cornerRadius: 10)
						.stroke(swipeStatus == .positive ? Color.green : Color.red, lineWidth: 3.0)
				).padding(24)
				.rotationEffect(Angle.degrees(swipeStatus == .positive ? 45 : -45))
		}
	}

	@ViewBuilder
	private func getCardView(for geometry: GeometryProxy) -> some View {
		ZStack {
			RoundedRectangle(cornerRadius: 3).fill(Color.white)
			VStack(alignment: .center) {
				ZStack(alignment: self.swipeStatus == .positive ? .topTrailing : .topLeading) {
					Image(question.imageURL)
						.resizable()
						.scaledToFill()
						.frame(width: geometry.size.width, height:geometry.size.height * 0.75)
						.clipped()

					getSwipeStatusView()
				}

				Spacer()

				Text (question.text)
					.font(.subheadline)
					.bold()
					.padding(.horizontal)
				Spacer()
			}.opacity(isFaceUp ? 1 : 0)

			VStack {
				let correct = (swipeStatus.rawValue == 0) == question.correctAnswer
				Text(correct ? "Correct!" : "Maybe next time!")
					.font(.title)
					.bold()
					.foregroundColor(correct ? Color.green : Color.red)
					.padding()
					.rotation3DEffect(
						Angle.degrees(180),
						axis: (x: 0.0, y: 1.0, z: 0.0)
					)

				Text(correct ? question.info! : question.hint!)
					.font(.headline)
					.foregroundColor(.secondary)
					.bold()
					.padding()
					.rotation3DEffect(
						Angle.degrees(180),
						axis: (x: 0.0, y: 1.0, z: 0.0)
					)
			}
			.opacity(isFaceUp ? 0 : 1)
		}
		.rotation3DEffect(
			Angle.degrees(isFaceUp ? 0: 180),
			axis: (x: 0.0, y: 1.0, z: 0.0)
		)

	}

	private enum SwipeStatus: Int {
		case positive, negative, none
	}
}

//MARK: - Helpers

extension CardView {

	/// Helper function used to calculate percentage of width swiped off on the screen
	///
	/// - Parameter geometry : The geometry
	/// - Parameter gesture: The current gesture translation value
	///
	/// - Returns: percentage of width swiped off on the screen
	private func getGesturePercentageWidth(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
		gesture.translation.width / geometry.size.width
	}

	/// Helper function used to calculate percentage of width swiped off on the screen
	///
	/// - Parameter geometry : The geometry
	/// - Parameter gesture: The current gesture translation value
	///
	/// - Returns: percentage of width swiped off on the screen
	private func getGesturePercentageHeight(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
		gesture.translation.height / geometry.size.height
	}

	/// Helper function used to determine whether swiped to the left or rigt and display a badge
	///
	/// - Parameter geometry : The geometry
	/// - Parameter gesture: The current gesture translation value
	///
	/// - Returns: if user swiped to the left
	private func trackSwipe(_ geometry: GeometryProxy, from value: DragGesture.Value) {
		guard isFaceUp else { return }
		if (getGesturePercentageWidth(geometry, from: value)) >= tresholdPercentage /  2 {
			swipeStatus = .negative
		} else if getGesturePercentageWidth(geometry, from: value) <= -tresholdPercentage / 2 {
			self.swipeStatus = .positive
		} else {
			self.swipeStatus = .none
		}
	}
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
		CardView(question: Question.defaultQuestions[0], onAnswered: { q, answer in
			print(q, answer)
		})
			.frame(height: 600)
			.padding()
    }
}
