import SwiftUI
import Combine
import UIKit

struct ContentView: View {
    @State private var billAmount = ""
    @State private var tipPercent = 0.0
    @State private var finalBillAmount = ""
    @State private var splitAmount = 1.0
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack {
            VStack(spacing: 50) {
                Text("TIP CALCULATOR")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                Text("Final Bill: \(getFinalBill(billAmount: Double(billAmount) ?? 0, tipPercent: tipPercent), specifier: "%.2f")")
                    .font(.title)
                Text("Tip: \(getTipAmount(billAmount: Double(billAmount) ?? 0, tipPercent: tipPercent), specifier: "%.2f")")
                    .font(.title2)
                HStack {
                    Text("Split Amount: \(getSplitAmount(finalBill: getFinalBill(billAmount: Double(billAmount) ?? 0, tipPercent: tipPercent), splitAmount: splitAmount), specifier: "%.2f")")
                        .font(.title2)
                    Spacer()
                    Text("Split Tip: \(getSplitAmount(finalBill: getTipAmount(billAmount: Double(billAmount) ?? 0, tipPercent: tipPercent), splitAmount: splitAmount), specifier: "%.2f")")
                        .font(.title2)
                }
                
            }
            Spacer()
                TextField("Enter Bill Amount", text: $billAmount)
                    .keyboardType(.decimalPad)
                    .onReceive(Just(billAmount)) { newValue in
                        let filtered = newValue.filter { "0123456789.".contains($0) }
                        if filtered != newValue {
                            self.billAmount = filtered
                        }
                    }
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding()
            Text("Tip Percent is: \(Int(tipPercent))")
            MySlider(passedStateVariable: $tipPercent, bottom: 0, top: 40, step: 1)
            HStack{
                MyButton(passedStateVariable: $tipPercent, passedVariable: 15, colorScheme: _colorScheme)
                MyButton(passedStateVariable: $tipPercent, passedVariable: 20, colorScheme: _colorScheme)
                MyButton(passedStateVariable: $tipPercent, passedVariable: 25, colorScheme: _colorScheme)
                MyButton(passedStateVariable: $tipPercent, passedVariable: 30, colorScheme: _colorScheme)
                
            }
            Text("Split Amount is: \(Int(splitAmount))")
            MySlider(passedStateVariable: $splitAmount, bottom: 1, top: 12, step: 1)
            HStack{
                MyButton(passedStateVariable: $splitAmount, passedVariable: 4, colorScheme: _colorScheme)
                MyButton(passedStateVariable: $splitAmount, passedVariable: 6, colorScheme: _colorScheme)
                MyButton(passedStateVariable: $splitAmount, passedVariable: 8, colorScheme: _colorScheme)
                MyButton(passedStateVariable: $splitAmount, passedVariable: 10, colorScheme: _colorScheme)
                MyButton(passedStateVariable: $splitAmount, passedVariable: 12, colorScheme: _colorScheme)
            }
            
            Spacer()
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif



func getFinalBill(billAmount: Double, tipPercent: Double) -> Double {
    let finalBill = getTipAmount(billAmount: billAmount, tipPercent: tipPercent) + (Double(billAmount))
    
    return finalBill
}

func getTipAmount(billAmount:Double, tipPercent: Double) -> Double {
    let finalBill = Double(billAmount) * (tipPercent / 100)
    
    return finalBill
}

func getSplitAmount(finalBill: Double, splitAmount: Double) -> Double {
    let finalSplitAmount = finalBill / splitAmount
    
    return finalSplitAmount
}
