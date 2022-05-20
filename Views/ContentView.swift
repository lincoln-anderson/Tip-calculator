import SwiftUI
import Combine
import UIKit

struct ContentView: View {
    @State private var billAmount = ""
    @State private var tipPercent = 0.0
    @State private var finalBillAmount = 0.0
    @State private var splitAmount = 1.0
    @State var alertShouldBeShown = !UserDefaults.standard.bool(forKey: "FirstStart")
    @State var isRoundUp = false
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack {
            VStack(spacing: 50) {
                Text("TIP CALCULATOR")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                if !isRoundUp {
                    Text("Final Bill: \(getFinalBill(billAmount: Double(billAmount) ?? 0, tipPercent: tipPercent), specifier: "%.2f")")
                        .font(.title)
                    Text("Tip: \(getTipAmount(billAmount: Double(billAmount) ?? 0, tipPercent: tipPercent), specifier: "%.2f")")
                        .font(.title2)
                } else {
                    Text("Rounded Up Final Bill: \(roundUp(passedFinalAmount: Double(billAmount) ?? 0, passedTipPercent: tipPercent), specifier: "%.2f")")
                        .font(.title)
                    Text("Rounded Up Tip: \(roundUpTip(passedBillAmount: Double(billAmount) ?? 0, passedTipPercent: tipPercent), specifier: "%.2f")")
                        .font(.title2)
                }
                
                if (splitAmount != 1.0) {
                    HStack {
                        Spacer()
                        Text("Split Amount: \(getSplitAmount(finalBill: getFinalBill(billAmount: Double(billAmount) ?? 0, tipPercent: tipPercent), splitAmount: splitAmount), specifier: "%.2f")")
                            .font(.title2)
                        Spacer()
                        Text("Split Tip: \(getSplitAmount(finalBill: getTipAmount(billAmount: Double(billAmount) ?? 0, tipPercent: tipPercent), splitAmount: splitAmount), specifier: "%.2f")")
                            .font(.title2)
                        Spacer()
                    }
                }
                Button(isRoundUp == false ? "round up" : "go back", action: {
                    isRoundUp.toggle()
                })
                    .buttonStyle(RoundUpButton())
                
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
            
            MySlider(passedStateVariable: $tipPercent, bottom: 0, top: 40, step: 1)
            Text("Tip Percent is: \(Int(tipPercent))")
                .fontWeight(.bold)
            HStack(spacing: 25){
                MyButton(passedStateVariable: $tipPercent, passedVariable: 20, colorScheme: _colorScheme)
                MyButton(passedStateVariable: $tipPercent, passedVariable: 25, colorScheme: _colorScheme)
                MyButton(passedStateVariable: $tipPercent, passedVariable: 30, colorScheme: _colorScheme)
                MyButton(passedStateVariable: $tipPercent, passedVariable: 35, colorScheme: _colorScheme)
                
            }
            
            MySlider(passedStateVariable: $splitAmount, bottom: 1, top: 12, step: 1)
            Text("Split Amount is: \(Int(splitAmount))")
                .fontWeight(.bold)
            HStack(spacing: 25){
                MyButton(passedStateVariable: $splitAmount, passedVariable: 2, colorScheme: _colorScheme)
                MyButton(passedStateVariable: $splitAmount, passedVariable: 4, colorScheme: _colorScheme)
                MyButton(passedStateVariable: $splitAmount, passedVariable: 6, colorScheme: _colorScheme)
                MyButton(passedStateVariable: $splitAmount, passedVariable: 8, colorScheme: _colorScheme)
                MyButton(passedStateVariable: $splitAmount, passedVariable: 10, colorScheme: _colorScheme)
            }
            
                .alert(isPresented: $alertShouldBeShown, content: {

                                Alert(title: Text("Hello, thank you for using my tip calculator"),
                                      message: Text("You can split a bill using the split slider which will show you the per person cost. Also, for both sliders, there are preset buttons below them to help you calculate your tip even faster!"),
                                      dismissButton: Alert.Button.default(
                                        Text("Accept"), action: {
                                            UserDefaults.standard.set(true, forKey: "FirstStart")
                                      }
                                    )
                                )
                            })
        }
        .blur(radius: alertShouldBeShown ? 30 : 0)
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

func roundUp(passedFinalAmount: Double, passedTipPercent: Double) -> Double {
    var tempValue = getFinalBill(billAmount: passedFinalAmount, tipPercent: passedTipPercent)
    tempValue = tempValue.rounded(.up)
    return tempValue
}
func roundUpTip(passedBillAmount: Double, passedTipPercent: Double) -> Double {
    var tempValue = roundUp(passedFinalAmount: passedBillAmount, passedTipPercent: passedTipPercent)
    tempValue = tempValue - passedBillAmount
    return tempValue
}


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
