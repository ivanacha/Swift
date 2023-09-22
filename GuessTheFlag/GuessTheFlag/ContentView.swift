//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by iVan on 9/19/23.
//

import SwiftUI

struct ContentView: View {
     // State properties to store the alert title, the state ofhte score viewer and the player's score
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var showingScore = false
    @State private var score = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAns = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            AngularGradient(colors: [.red, .orange, .yellow, .teal, .blue, .white, .red], center: .top)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the flag").font(.largeTitle).bold().foregroundColor(.white)
                VStack(spacing: 30) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .bold()
                        
                        Text(countries[correctAns])
                            .font(.largeTitle.bold())
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            //Tapped
                            flagTapped(number)
                            
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .shadow(radius: 10)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 25)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title2.bold())
                Spacer()
            }
            .padding(.horizontal)
                
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(scoreMessage)
        }
        
    }
    
    func flagTapped(_ number: Int){
        if number == correctAns {
            scoreTitle = "🥳Correct"
            scoreMessage = "You guessed the right flag!"
            score += 1
        } else {
            scoreTitle = "😅Wrong"
            scoreMessage = "You tapped the flag of \(countries[number])!"
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAns = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
