//
//  ContentView.swift
//  WeSplit
//
//  Created by iVan on 9/15/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var amount = 0.0
    @State private var numPeople = 0
    @State private var tipPct = 0
    @FocusState private var amtIsFocused: Bool
    @FocusState private var numPeopleIsFocused: Bool
    private let currencyFormat = FloatingPointFormatStyle<Double>.Currency(code: Locale.current.currency?.identifier ?? "USD")
    let tipPcts = [0, 10, 15, 20, 25]

    var total: Double {
        // Grand total
        let tipSelection = Double(tipPct)
        
        let tipValue = amount / 100 * tipSelection
        let total = amount + tipValue
        return total
    }
    
    var totalSplit: Double {
        // Total per person
        let peopleCount = Double(numPeople + 2)
        let splitAmt = total / peopleCount
        return splitAmt
    }
    

    
    var body: some View {
            
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $amount, format: currencyFormat)
                        .keyboardType(.decimalPad)
                        .focused($amtIsFocused)
                    
                    Picker("Number of Splitter", selection: $numPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.menu)
                    
                }
                
                Section {
                    Picker("Tip Percentage", selection: $tipPct) {
                        ForEach(0...100, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.wheel)
                    
                } header: {
                    Text("Tip")
                }
                
                Section {
                    // Display the total in black if the tip is > 0% or in red if no tip is added.
                    Text(total, format: currencyFormat)
                        .foregroundStyle(tipPct == 0 ? .red : .primary)
                } header: {
                    Text("total cost")
                }
                
                Section {
                    Text(totalSplit, format: currencyFormat)
                } header: {
                    Text("Amount per customer")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amtIsFocused = false
                    }
                }
            }
        }
                
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


