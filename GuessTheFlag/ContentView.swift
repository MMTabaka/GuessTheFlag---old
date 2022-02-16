//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Milosz Tabaka on 15/02/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var pickedFlag = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            Color(red: 0, green: 0, blue: 0.3)
                .ignoresSafeArea()
            
            VStack{
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(Color.white)
                
                VStack(spacing: 25) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundColor(Color.white)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .foregroundColor(Color.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number].lowercased())
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                    
                    Text("Score: \(score)")
                        .foregroundColor(Color.white)
                        .font(.title2.weight(.semibold))
                }
                .padding(20)
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuastion)
        } message: {
            Text("That's the flag of \(pickedFlag)")
        }
    }
    
    func flagTapped(_ number: Int) {
        pickedFlag = countries[number]
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
            score = 0
        }
        
        showingScore = true
    }
    
    func askQuastion() {
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
