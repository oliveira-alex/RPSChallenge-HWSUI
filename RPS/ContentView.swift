//
//  ContentView.swift
//  RPS
//
//  Created by Alex Oliveira on 28/11/20.
//

import SwiftUI

struct ContentView: View {
	let moves = ["Rock", "Paper", "Scissors"]
	
	@State private var moveNumber = Int.random(in: 0 ..< 3)
	@State private var shouldWin = Bool.random()
	
	@State private var score = 0
	
	@State private var showingScoreAlert = false
	
    var body: some View {
		VStack(spacing: 30) {
			Group {
				Text(moves[moveNumber])
				
				shouldWin ? Text("Win") : Text("Lose")
			}
			.font(.title)
			
			Spacer()
			
			ForEach(0 ..< 3) { number in
				Button(action: {
					self.moveTapped(number)
				}) {
					Text(moves[number])
						.font(.largeTitle)
				}
			}

			Spacer()
			
			Text("Score: \(score)")
		}
//		.alert(isPresented: $showingScoreAlert) {
//			Alert(title: Text("Title"), message: nil, dismissButton: .default(Text("Continue")))
//		}
    }
	
	func moveTapped(_ number: Int) {
		if shouldWin {
			if number > moveNumber || (number == 0 && moveNumber == 2){
				score += 1
			} else {
				score -= 1
			}
		} else {
			if number < moveNumber || (number == 2 && moveNumber == 0){
				score += 1
			} else {
				score -= 1
			}
		}
		
//		showingScoreAlert = true
		
		moveNumber = Int.random(in: 0 ..< 3)
		shouldWin = Bool.random()
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
