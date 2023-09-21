//
//  ContentView.swift
//  LengthConverter
//
//  Created by Mian Answer on 9/20/23.
//

import SwiftUI

struct ContentView: View {
    let lengthConversions = ["m", "km", "ft", "yd", "mi"]
    @State private var fromConversion = 0
    @State private var toConversion = 0
    @State private var input = 0.0
    private var result: Double {
        let from = lengthConversions[fromConversion]
        let to = lengthConversions[toConversion]
        var convertedAmount = convertToMeters(from: from, value: input)
        convertedAmount = convertFromMeters(to: to, value: convertedAmount)

        return convertedAmount
    }
    private func convertToMeters(from: String, value: Double) -> Double {
        var convertedAmount = value
        switch(from) {
        case "km":
            convertedAmount *= 1000
        case "ft":
            convertedAmount *= 0.3048
        case "yd":
            convertedAmount *= 0.9144
        case "mi":
            convertedAmount *= 1609.34
        default:
            convertedAmount = value
        }
        
        return convertedAmount
    }
    private func convertFromMeters(to: String, value: Double) -> Double {
        var convertedAmount = value
        switch(to) {
        case "km":
            convertedAmount /= 1000
        case "ft":
            convertedAmount /= 0.3048
        case "yd":
            convertedAmount /= 0.9144
        case "mi":
            convertedAmount /= 1609.34
        default:
            convertedAmount = value
        }
        
        return convertedAmount
    }
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Text", value: $input, format: .number)
                        .keyboardType(.decimalPad)
                } header: {
                    Text("Length To Convert")
                }

                Section {
                    Picker("From", selection: $fromConversion) {
                        ForEach(0..<lengthConversions.count, id: \.self) {
                            Text("\(lengthConversions[$0])")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Conversion From")
                }
                
                Section {
                    Picker("From", selection: $toConversion) {
                        ForEach(0..<lengthConversions.count, id: \.self) {
                            Text("\(lengthConversions[$0])")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Conversion To")
                }
                
                Section {
                    HStack {
                        Text(result, format: .number)
                        Text(lengthConversions[toConversion])
                    }
                } header: {
                    Text("Result")
                }
            }
            .navigationTitle("Length Converter")
        }
    }
}

#Preview {
    ContentView()
}
