import SwiftUI
import Combine
import UIKit

struct ContentView: View {
    @State private var billAmount = ""
    @State private var tipPercent = 0.0
    @State private var finalBillAmount = ""
    @State private var splitAmount = 1.0
    @State private var userRoundedUp = false
    @State private var hideSplitSlider = true
    @State var alertShouldBeShown = !UserDefaults.standard.bool(forKey: "FirstStart")
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack {
            VStack(spacing: 50) {
                Text("TIP CALCULATOR")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                if (userRoundedUp) {
                    Text("Rounded Up Final Bill: \(roundUp(billAmount: Double(billAmount) ?? 0, tipPercent: tipPercent), specifier: "%.2f")")
                        .font(.title)
                    Text("Rounded Up Tip: \(roundUpTip(roundedUpAmount: roundUp(billAmount: Double(billAmount) ?? 0, tipPercent: tipPercent), billAmount: Double(billAmount) ?? 0), specifier: "%.2f")")
                        .font(.title2)
                } else {
                    Text("Final Bill: \(getFinalBill(billAmount: Double(billAmount) ?? 0, tipPercent: tipPercent), specifier: "%.2f")")
                        .font(.title)
                    Text("Tip: \(getTipAmount(billAmount: roundUp(billAmount: Double(billAmount) ?? 0, tipPercent: tipPercent), tipPercent: tipPercent), specifier: "%.2f")")
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
            VStack{
                Text("Tip Percent is: \(Int(tipPercent))")
                    .fontWeight(.bold)
                HStack(spacing: 25){
                    MyButton(passedStateVariable: $tipPercent, passedVariable: 15, colorScheme: _colorScheme)
                    MyButton(passedStateVariable: $tipPercent, passedVariable: 20, colorScheme: _colorScheme)
                    MyButton(passedStateVariable: $tipPercent, passedVariable: 25, colorScheme: _colorScheme)
                    MyButton(passedStateVariable: $tipPercent, passedVariable: 30, colorScheme: _colorScheme)
                    
                }
            }
            if (hideSplitSlider == false) {
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
            }
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    userRoundedUp.toggle()
                }, label: {
                    if (userRoundedUp == false) {
                        Text("Round Up")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(colorScheme == .dark ? .white : .black, lineWidth: 3)
                                    
                            )
                    } else {
                        Text("Undo Round")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(colorScheme == .dark ? .white : .black, lineWidth: 3)
                                    
                            )
                    }
                })
                Spacer()
                Button(action: {
                    hideSplitSlider.toggle()
                }, label: {
                    if (hideSplitSlider) {
                        Text("Split Bill")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(colorScheme == .dark ? .white : .black, lineWidth: 3)
                                    
                            )
                    } else {
                        Text("Hide Split")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(colorScheme == .dark ? .white : .black, lineWidth: 3)
                                    
                            )
                    }
                })
                Spacer()
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

func roundUp(billAmount: Double, tipPercent: Double) -> Double{
    let finalBill = getTipAmount(billAmount: billAmount, tipPercent: tipPercent) + (Double(billAmount))
    
    return round(finalBill)
    
}

func roundUpTip(roundedUpAmount: Double, billAmount: Double) -> Double {
    let roundedTip = roundedUpAmount - billAmount
    
    return roundedTip
    
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
