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
    
    private let portraitButtonHeight: CGFloat = 77
    private let landscapeButtonHeight: CGFloat = 32
    
    var body: some View {
        VStack(spacing: 0) {
            
            Spacer()
            
            VStack {
                // Memory
                if calculatorModel.secondaryRow.count == 0 {
                    Text(" ")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                } else {
                    Text(calculatorModel.secondaryRow)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
                // Result
                Text(calculatorModel.primaryRow)
                    .font(.system(size: 60, weight: .heavy))
                    .foregroundColor(Color.textPrimary)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.trailing, 20)
            .padding(.leading, 20)
            .padding(.bottom, verticalSizeClass == .compact ? 0 : 20)
            
            if verticalSizeClass == .compact {
                Spacer()
            }
            
            // Keyboard
            VStack(spacing: verticalSizeClass == .compact ? 10 : 15) {
                
                // MARK: -
                HStack(spacing: verticalSizeClass == .compact ? 10 : 15) {
                    Button {
                        calculatorModel.backButtonPressed()
                    } label: {
                        //Text("AC")
                        if calculatorModel.primaryRow == "0" || calculatorModel.primaryRow == "-0" {
                            Text("AC")
                        } else {
                            Image(systemName: "delete.backward.fill")
                        }
                    }
                    .isDefaultCalculatorButton(btnHeight: verticalSizeClass == .compact ? landscapeButtonHeight : portraitButtonHeight)
                    
                    Button {
                        calculatorModel.toggleNegativeNumber(true)
                    } label: {
                        Image(systemName: "plusminus")
                    }
                    .isDefaultCalculatorButton(btnHeight: verticalSizeClass == .compact ? landscapeButtonHeight : portraitButtonHeight)
                    
                    Button {
                        
                    } label: {
                        Text("%")
                    }
                    .isDefaultCalculatorButton(btnHeight: verticalSizeClass == .compact ? landscapeButtonHeight : portraitButtonHeight)
                    
                    Button {
                        calculatorModel.selectAction(.divide)
                    } label: {
                        Text("/")
                    }
                    .isDefaultCalculatorButton(btnHeight: verticalSizeClass == .compact ? landscapeButtonHeight : portraitButtonHeight)

                }
                
                // MARK: -
                HStack(spacing: verticalSizeClass == .compact ? 10 : 15) {
                    Button {
                        calculatorModel.addNumberToPrimaryRow(7)
                    } label: {
                        Text("7")
                    }
                    .isDefaultCalculatorButton(btnHeight: verticalSizeClass == .compact ? landscapeButtonHeight : portraitButtonHeight)
                    
                    Button {
                        calculatorModel.addNumberToPrimaryRow(8)
                    } label: {
                        Text("8")
                    }
                    .isDefaultCalculatorButton(btnHeight: verticalSizeClass == .compact ? landscapeButtonHeight : portraitButtonHeight)
                    
                    Button {
                        calculatorModel.addNumberToPrimaryRow(9)
                    } label: {
                        Text("9")
                    }
                    .isDefaultCalculatorButton(btnHeight: verticalSizeClass == .compact ? landscapeButtonHeight : portraitButtonHeight)
                    
                    Button {
                        calculatorModel.selectAction(.multiply)
                    } label: {
                        Text("×")
                    }
                    .isDefaultCalculatorButton(btnHeight: verticalSizeClass == .compact ? landscapeButtonHeight : portraitButtonHeight)
                }
                
                // MARK: -
                HStack(spacing: verticalSizeClass == .compact ? 10 : 15) {
                    Button {
                        calculatorModel.addNumberToPrimaryRow(4)
                    } label: {
                        Text("4")
                    }
                    .isDefaultCalculatorButton(btnHeight: verticalSizeClass == .compact ? landscapeButtonHeight : portraitButtonHeight)
                    
                    Button {
                        calculatorModel.addNumberToPrimaryRow(5)
                    } label: {
                        Text("5")
                    }
                    .isDefaultCalculatorButton(btnHeight: verticalSizeClass == .compact ? landscapeButtonHeight : portraitButtonHeight)
                    
                    Button {
                        calculatorModel.addNumberToPrimaryRow(6)
                    } label: {
                        Text("6")
                    }
                    .isDefaultCalculatorButton(btnHeight: verticalSizeClass == .compact ? landscapeButtonHeight : portraitButtonHeight)
                    
                    Button {
                        calculatorModel.selectAction(.substract)
                    } label: {
                        Text("-")
                    }
                    .isDefaultCalculatorButton(btnHeight: verticalSizeClass == .compact ? landscapeButtonHeight : portraitButtonHeight)
                }
                
                // MARK: -
                HStack(spacing: verticalSizeClass == .compact ? 10 : 15) {
                    Button {
                        calculatorModel.addNumberToPrimaryRow(1)
                    } label: {
                        Text("1")
                    }
                    .isDefaultCalculatorButton(btnHeight: verticalSizeClass == .compact ? landscapeButtonHeight : portraitButtonHeight)
                    
                    Button {
                        calculatorModel.addNumberToPrimaryRow(2)
                    } label: {
                        Text("2")
                    }
                    .isDefaultCalculatorButton(btnHeight: verticalSizeClass == .compact ? landscapeButtonHeight : portraitButtonHeight)
                    
                    Button {
                        calculatorModel.addNumberToPrimaryRow(3)
                    } label: {
                        Text("3")
                    }
                    .isDefaultCalculatorButton(btnHeight: verticalSizeClass == .compact ? landscapeButtonHeight : portraitButtonHeight)
                    
                    Button {
                        calculatorModel.selectAction(.add)
                    } label: {
                        Text("+")
                    }
                    .isDefaultCalculatorButton(btnHeight: verticalSizeClass == .compact ? landscapeButtonHeight : portraitButtonHeight)
                }
                
                // MARK: -
                HStack(spacing: verticalSizeClass == .compact ? 10 : 15) {
                    HStack(spacing: 15) {
                        Button {
                            calculatorModel.addNumberToPrimaryRow(0)
                        } label: {
                            Text("0")
                        }
                        .isDefaultCalculatorButton(btnHeight: verticalSizeClass == .compact ? landscapeButtonHeight : portraitButtonHeight)
                        
                        Button {
                            calculatorModel.toggleDecimalNumber()
                        } label: {
                            Text(",")
                        }
                        .isDefaultCalculatorButton(btnHeight: verticalSizeClass == .compact ? landscapeButtonHeight : portraitButtonHeight)
                    }
                    
                    Button {
                        calculatorModel.doMath()
                    } label: {
                        Text("=")
                    }
                    .isPrimaryCalculatorButton(btnHeight: verticalSizeClass == .compact ? landscapeButtonHeight : portraitButtonHeight)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.top, verticalSizeClass == .compact ? 20 : 40)
            .padding(.bottom, 20)
            .padding(.leading, 20)
            .padding(.trailing, 20)
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
        .background(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CalculatorModel())
    }
}
