//
//  ContentView.swift
//  WeSplit
//
//  Created by Mian Answer on 9/12/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    private var totalAmount: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        return checkAmount + tipValue
    }
    private var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        
        return totalAmount / peopleCount
    }
    private let currencyFormat: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "USD")

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: currencyFormat)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                } header: {
                    Text("Amount")
                        .foregroundColor(.white)
                }

                Section {
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0)")
                        }
                    }
                }
                
                Section {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                } header: {
                    Text("Tip Percentage")
                        .foregroundColor(.white)
                }

                Section {
                    Text(totalAmount, format: currencyFormat)
                } header: {
                    Text("Total Amount")
                        .foregroundColor(.white)
                }
        
                Section {
                    Text(totalPerPerson, format: currencyFormat)
                } header: {
                    Text("Amount Per Person")
                        .foregroundColor(.white)
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
            .background(.green)
            .scrollContentBackground(.hidden)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
