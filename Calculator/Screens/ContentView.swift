//
//  ContentView.swift
//  Calculator
//
//  Created by Ondřej Toman on 29.10.2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var calculatorModel: CalculatorModel
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    @State private var displayAlert = true
    
    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: - Display numbers
            
            Spacer()
            
            VStack {
                // Secondary Row
                if calculatorModel.secondaryRow.count == 0 {
                    Text(" ")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                } else {
                    Text(calculatorModel.secondaryRow)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
                // Primary Row
                Text(calculatorModel.primaryRow)
                    .font(.system(size: 60, weight: .heavy))
                    .foregroundColor(Color.textPrimary)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding([.trailing, .leading], 20)
            .padding(.bottom, verticalSizeClass == .compact ? 0 : 20)
            
            if verticalSizeClass == .compact {
                Spacer()
            }
            
            // MARK: - 1st Row Keyboard
            VStack(spacing: verticalSizeClass == .compact ? 10 : 15) {
                
                HStack(spacing: verticalSizeClass == .compact ? 10 : 15) {
                    if calculatorModel.primaryRow == "0" || calculatorModel.primaryRow == "-0" {
                        DefaultButton(text: "AC") {
                            calculatorModel.backButtonPressed()
                        }
                    } else {
                        DefaultButton(image: "delete.backward.fill") {
                            calculatorModel.backButtonPressed()
                        }
                    }
                    
                    DefaultButton(image: "plusminus") {
                        calculatorModel.toggleNegativeNumber(true)
                    }
                    
                    DefaultButton(text: "%", image: nil) {
                        // TODO: Implement percentage behavior
                    }
                    
                    DefaultButton(text: "/", image: nil) {
                        calculatorModel.selectAction(.divide)
                    }

                }
                
                // MARK: - 2nd Row Keyboard
                HStack(spacing: verticalSizeClass == .compact ? 10 : 15) {
                    DefaultButton(text: "7", image: nil) {
                        calculatorModel.addNumberToPrimaryRow(7)
                    }
                    
                    DefaultButton(text: "8", image: nil) {
                        calculatorModel.addNumberToPrimaryRow(8)
                    }
                    
                    DefaultButton(text: "9", image: nil) {
                        calculatorModel.addNumberToPrimaryRow(9)
                    }
                    
                    DefaultButton(text: "×", image: nil) {
                        calculatorModel.selectAction(.multiply)
                    }
                }
                
                // MARK: - 3rd Row Keyboard
                HStack(spacing: verticalSizeClass == .compact ? 10 : 15) {
                    
                    DefaultButton(text: "4", image: nil) {
                        calculatorModel.addNumberToPrimaryRow(4)
                    }
                    
                    DefaultButton(text: "5", image: nil) {
                        calculatorModel.addNumberToPrimaryRow(5)
                    }
                    
                    DefaultButton(text: "6", image: nil) {
                        calculatorModel.addNumberToPrimaryRow(6)
                    }
                    
                    DefaultButton(text: "-", image: nil) {
                        calculatorModel.selectAction(.substract)
                    }
                }
                
                // MARK: - 4th Row Keyboard
                HStack(spacing: verticalSizeClass == .compact ? 10 : 15) {
                    
                    DefaultButton(text: "1", image: nil) {
                        calculatorModel.addNumberToPrimaryRow(1)
                    }
                    
                    DefaultButton(text: "2", image: nil) {
                        calculatorModel.addNumberToPrimaryRow(2)
                    }
                    
                    DefaultButton(text: "3", image: nil) {
                        calculatorModel.addNumberToPrimaryRow(3)
                    }
                    
                    DefaultButton(text: "+", image: nil) {
                        calculatorModel.selectAction(.add)
                    }
                    
                }
                
                // MARK: - 5th Row Keyboard
                HStack(spacing: verticalSizeClass == .compact ? 10 : 15) {
                    HStack(spacing: 15) {
                        
                        DefaultButton(text: "0", image: nil) {
                            calculatorModel.addNumberToPrimaryRow(0)
                        }
                        
                        DefaultButton(text: ",", image: nil) {
                            calculatorModel.toggleDecimalNumber()
                        }
                    }
                    
                    PrimaryButton(text: "=") {
                        calculatorModel.doMath()
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding([.bottom, .leading, .trailing], 20)
            .padding(.top, verticalSizeClass == .compact ? 20 : 40)
            .background(Color.keyboardBackground)
        }
        .alert("Result is too large to display properly", isPresented: $calculatorModel.tooLargeResult, actions: {
            Button(role: .cancel) {
                calculatorModel.tooLargeResult = false
            } label: {
                Text("Dismiss")
            }

        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appBackground)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CalculatorModel())
    }
}
