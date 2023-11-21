//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by iVan on 9/19/23.
//

import SwiftUI

struct ContentView: View {
     // State properties to store the alert title, the state ofhte score viewer and the player's score.
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var showingScore = false
    @State private var score = 0
    @State private var done =  false
    @State private var count =  0
    @State private var animationAmount = 0.0
    @State private var tappedIndex: Int?//
    
    // Custon View that renders one flag image using the specified country name and modifiers.
    struct FlagImage: View {
        let country: String
        var body: some View {
            Image(country)
                .renderingMode(.original)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(radius: 10)
        }
    }
    
    // List of countries and a random assignment for the right answer among the displayed flags.
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAns = Int.random(in: 0...2)
    
    var body: some View {
        
        // Colorful background.
        ZStack {
            AngularGradient(colors: [.red, .orange, .yellow, .teal, .blue, .white, .red], center: .top)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the flag").font(.largeTitle).bold().foregroundColor(.white)
                
                // Flag options.
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
                            FlagImage(country: countries[number])
                        }
//                        .blur(radius: tappedIndex != number ? 0 : 6.0)
                        .rotation3DEffect(
                            .degrees(tappedIndex == number ? animationAmount : 0.0), axis: (x: 0.0, y: 1.0, z: 0.0)
                        )
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 25)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                
                Spacer()
                Spacer()
                
                // Score display at the bottom of the screen.
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title2.bold())
                Spacer()
            }
            .padding(.horizontal)
                
        }
        // Dialog box to present score.
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(scoreMessage)
        }
        // Dialog box to present final score and restart button.
        .alert("Done", isPresented: $done) {
            Button("Restart", action: restart)
        } message: {
            Text("Your final score is \(score)")
        }
    }
    
    // Action executed for every flag tap.
    func flagTapped(_ number: Int){
        count += 1
        // Update the selected flag with the desired animation.
        withAnimation {
            tappedIndex = number
            animationAmount = 360
        }
        if count >= 8 {
            showingScore = true
            done = true
        } else if number == correctAns {
            scoreTitle = "🥳Correct"
            scoreMessage = "You guessed the right flag!"
            score += 1
            showingScore = true
        } else {
            scoreTitle = "😅Wrong"
            scoreMessage = "You tapped the flag of \(countries[number])!"
            showingScore = true
        }
        tappedIndex = 99
    }
    
    // Reshuffles the flag options displayed and randomizes the correct answer.
    func askQuestion() {
        countries.shuffle()
        correctAns = Int.random(in: 0...2)
    }
    
    // Resets the score, answer count and calls the askQuestion() function to reshuffle the flag options displayed and randomize the correct answer.
    func restart() {
        askQuestion()
        done = true
        score = 0
        count = 0
    }
}

#Preview {
    ContentView()
}
