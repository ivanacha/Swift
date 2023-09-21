//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by iVan on 9/19/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var scoreTitle = ""
    @State private var showingScore = false
    @State private var score = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAns = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            AngularGradient(colors: [.red, .orange, .yellow, .teal, .blue, .indigo, .purple], center: .center)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                VStack {
                    Text("What is the Flag of")
                        .bold()
                        .font(.title)
                    Text(countries[correctAns])
                        .bold()
                        .font(.title2)
                }
                
                ForEach(0..<3) { number in
                    Button {
                        //Tapped
                        flagTapped(number)
                        
                    } label: {
                        Image(countries[number])
                            .renderingMode(.original)
                    }
                }
            }
        }
        alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        
    }
    
    func flagTapped(_ number: Int){
        if number == correctAns {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
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
