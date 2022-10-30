//
//  ContentView.swift
//  Calculator
//
//  Created by Ondřej Toman on 29.10.2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var calculatorModel: CalculatorModel
    
    var body: some View {
        VStack {
            
            Spacer()
            
            VStack {
                // Memory
                Text(calculatorModel.secondaryText)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                // Result
                Text(calculatorModel.primaryText)
                    .font(.system(size: 60, weight: .heavy))
                    .foregroundColor(Color.textPrimary)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.trailing, 20)
            .padding(.leading, 20)
            
            // Keyboard
            VStack(spacing: 15) {
                
                // MARK: -
                HStack(spacing: 15) {
                    Button {
                        calculatorModel.clearPrimaryText()
                    } label: {
                        Text("AC")
                    }
                    .isDefaultCalculatorButton()
                    
                    Button {
                        
                    } label: {
                        Text("+/-")
                    }
                    .isDefaultCalculatorButton()
                    
                    Button {
                        
                    } label: {
                        Text("%")
                    }
                    .isDefaultCalculatorButton()
                    
                    Button {
                        
                    } label: {
                        Text("/")
                    }
                    .isDefaultCalculatorButton()

                }
                
                // MARK: -
                HStack(spacing: 15) {
                    Button {
                        calculatorModel.addNumber(7)
                    } label: {
                        Text("7")
                    }
                    .isDefaultCalculatorButton()
                    
                    Button {
                        calculatorModel.addNumber(8)
                    } label: {
                        Text("8")
                    }
                    .isDefaultCalculatorButton()
                    
                    Button {
                        calculatorModel.addNumber(9)
                    } label: {
                        Text("9")
                    }
                    .isDefaultCalculatorButton()
                    
                    Button {
                        
                    } label: {
                        Text("×")
                    }
                    .isDefaultCalculatorButton()
                }
                
                // MARK: -
                HStack(spacing: 15) {
                    Button {
                        calculatorModel.addNumber(4)
                    } label: {
                        Text("4")
                    }
                    .isDefaultCalculatorButton()
                    
                    Button {
                        calculatorModel.addNumber(5)
                    } label: {
                        Text("5")
                    }
                    .isDefaultCalculatorButton()
                    
                    Button {
                        calculatorModel.addNumber(6)
                    } label: {
                        Text("6")
                    }
                    .isDefaultCalculatorButton()
                    
                    Button {
                        
                    } label: {
                        Text("-")
                    }
                    .isDefaultCalculatorButton()
                }
                
                // MARK: -
                HStack(spacing: 15) {
                    Button {
                        calculatorModel.addNumber(1)
                    } label: {
                        Text("1")
                    }
                    .isDefaultCalculatorButton()
                    
                    Button {
                        calculatorModel.addNumber(2)
                    } label: {
                        Text("2")
                    }
                    .isDefaultCalculatorButton()
                    
                    Button {
                        calculatorModel.addNumber(3)
                    } label: {
                        Text("3")
                    }
                    .isDefaultCalculatorButton()
                    
                    Button {
                        
                    } label: {
                        Text("×")
                    }
                    .isDefaultCalculatorButton()
                }
                
                // MARK: -
                HStack(spacing: 15) {
                    HStack(spacing: 15) {
                        Button {
                            calculatorModel.addNumber(0)
                        } label: {
                            Text("0")
                        }
                        .isDefaultCalculatorButton()
                        
                        Button {
                            
                        } label: {
                            Text(",")
                        }
                        .isDefaultCalculatorButton()
                    }
                    
                    Button {
                        
                    } label: {
                        Text("=")
                    }
                    .isPrimaryCalculatorButton()
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 40)
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .background(Color.keyboardBackground)
        }
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
