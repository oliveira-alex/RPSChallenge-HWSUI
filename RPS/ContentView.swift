//
//  ContentView.swift
//  RPS
//
//  Created by Alex Oliveira on 28/11/20.
//

import SwiftUI

struct ContentView: View {
	let moves = ["👊", "🖐", "✌️"]
	
	@State private var moveNumber = Int.random(in: 0 ..< 3)
	@State private var shouldWin = Bool.random()
	
	@State private var score = 0
	
	@State private var showingScoreAlert = false
	@State private var alertTitle = ""
	@State private var alertMsg = ""
	
    var body: some View {
		VStack(spacing: 30) {
			Text("")
			
			VStack(spacing: 5) {
				Text(moves[moveNumber])
				
				if shouldWin {
					Text("Win")
						.foregroundColor(.blue)
				} else {
					Text("Lose")
						.foregroundColor(.red)
				}
			}
			.font(.largeTitle)
			.frame(width: 300, height: 110)
			.background(Color.gray.opacity(0.35))
			.clipShape(RoundedRectangle(cornerRadius: 10))
			
			Spacer()
			
			VStack(spacing: 10) {
				ForEach(0 ..< 3) { number in
					Button(action: {
						self.moveTapped(number)
					}) {
						Text(moves[number])
							.font(.largeTitle)
							.frame(width: 300, height: 65)
							.background(Color.gray.opacity(0.35))
							.clipShape(RoundedRectangle(cornerRadius: 10))
					}
				}
			}

			Spacer()
			
			Text("Score: \(score)")
				.font(.title2)
		}
		.alert(isPresented: $showingScoreAlert) {
			Alert(title: Text(alertTitle), message: Text(alertMsg), dismissButton: .default(Text("Continue")) {
					let previousMoveNumber = moveNumber
					let previousShouldWin = shouldWin
					
					repeat {
						moveNumber = Int.random(in: 0 ..< 3)
						shouldWin = Bool.random()
					} while (moveNumber == previousMoveNumber && shouldWin == previousShouldWin)
			})
		}
    }
	
	func moveTapped(_ number: Int) {
		var correctAnswer = -1
		
		if shouldWin {
			if moveNumber < 2 {
				correctAnswer = moveNumber + 1
			} else if moveNumber == 2 {
				correctAnswer = 0
			}
		} else if !shouldWin {
			if moveNumber > 0 {
				correctAnswer = moveNumber - 1
			} else if moveNumber == 0 {
				correctAnswer = 2
			}
		}
		
		if number == correctAnswer {
			score += 1
			alertTitle = "Correct"
			alertMsg = "Score: \(score)"
		} else if number != correctAnswer {
			score -= 1
			alertTitle = "Wrong"
			alertMsg = "You should have chosen \(moves[correctAnswer])"
		}
		
		showingScoreAlert = true
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
