//
//  NumericField.swift
//  SwiftGymTracker
//
//  Created by D F on 10/17/25.
//

import SwiftUI

struct NumericFieldView: View {
    @Binding var value: String
    let label: String
    let maxDigits: Int
    let isDecimal: Bool
    let onValueChange: (Double) -> Void
    
    var body: some View {
        HStack(alignment:.center, spacing: 15){
            Text(label)
                .font(.title3)
            TextField(isDecimal ? "0.0" : "0", text: $value)
                .keyboardType(isDecimal ? .decimalPad : .numberPad)
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .fixedSize()
                .onChange(of: value) {_, newValue in
                    var filtered = newValue
                    
                    if isDecimal {
                        filtered = filtered.filter { "0123456789.".contains($0) }
                        let parts = filtered.split(separator: ".")
                        var result = ""
                        if let inParts = parts.first {
                            result += String(inParts.prefix(maxDigits))
                        }
                        
                        if parts.count > 1 {
                            result += "." + parts[1].prefix(1)
                        }
                        filtered = result
                    }else {
                        // Integer only
                        filtered = String(filtered.filter { $0.isNumber }.prefix(maxDigits))
                    }
                    
                    value = filtered
                    
                    onValueChange(Double(filtered) ?? 0)
                    
                }
        }
        .padding(.top, 10)
    }
}

#Preview {
    @Previewable @State var value: String = ""
    
    NumericFieldView(
        value: $value,
        label: "Repetitions",
        maxDigits: 3,
        isDecimal: false
    ) { newValue in
        print("Value changed: \(newValue)")
    }
}
