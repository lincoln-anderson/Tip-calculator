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
                Text("Final Bill Amount: \(getFinalBill(billAmount: Double(billAmount) ?? 0, tipPercent: tipPercent), specifier: "%.2f")")
                    .font(.title)
                Text("Tip Amount: \(getTipAmount(billAmount: Double(billAmount) ?? 0, tipPercent: tipPercent), specifier: "%.2f")")
                    .font(.title2)
                Text("")
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
            HStack{
                Text("0")
                Slider(value: $tipPercent, in: 0...40, step: 1)
                    .accentColor(colorScheme == .dark ? .white : .black)
                Text("40")
            }
            HStack{
                Spacer()
                Button {
                    tipPercent = 15
                } label: {
                    Text("15")
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .font(.title2)
                        .fontWeight(.bold)
                }
                Spacer()
                Button {
                    tipPercent = 20
                } label: {
                    Text("20")
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .font(.title2)
                        .fontWeight(.bold)
                }
                Spacer()
                Button {
                    tipPercent = 25
                } label: {
                    Text("25")
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .font(.title2)
                        .fontWeight(.bold)
                }
                Spacer()
                Button {
                    tipPercent = 30
                } label: {
                    Text("30")
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .font(.title2)
                        .fontWeight(.bold)
                }
                Spacer()
                
            }
            HStack {
                Text("1")
                Slider(value: $splitAmount, in: 1...12, step: 1)
                    .accentColor(colorScheme == .dark ? .white : .black)
                Text("12")
            }
            HStack{
                Spacer()
                Button {
                    splitAmount = 4
                } label: {
                    Text("4")
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .font(.title2)
                        .fontWeight(.bold)
                }
                Spacer()
                Button {
                    splitAmount = 6
                } label: {
                    Text("6")
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .font(.title2)
                        .fontWeight(.bold)
                }
                Spacer()
                Button {
                    splitAmount = 8
                } label: {
                    Text("8")
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .font(.title2)
                        .fontWeight(.bold)
                }
                Spacer()
                Button {
                    splitAmount = 10
                } label: {
                    Text("10")
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .font(.title2)
                        .fontWeight(.bold)
                }
                Spacer()
                Button {
                    splitAmount = 12
                } label: {
                    Text("12")
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .font(.title2)
                        .fontWeight(.bold)
                }
                Spacer()
                
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
