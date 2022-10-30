//
//  ContentView.swift
//  Calculator
//
//  Created by Ondřej Toman on 29.10.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            
            Spacer()
            
            VStack {
                // Memory
                Text("10 x 10")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                // Result
                Text("100")
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.trailing, 20)
            .padding(.leading, 20)
            
            // Keyboard
            VStack(spacing: 15) {
                
                // MARK: -
                HStack(spacing: 15) {
                    Button {
                        print("AC")
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
                        
                    } label: {
                        Text("7")
                    }
                    .isDefaultCalculatorButton()
                    
                    Button {
                        
                    } label: {
                        Text("8")
                    }
                    .isDefaultCalculatorButton()
                    
                    Button {
                        
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
                        
                    } label: {
                        Text("4")
                    }
                    .isDefaultCalculatorButton()
                    
                    Button {
                        
                    } label: {
                        Text("5")
                    }
                    .isDefaultCalculatorButton()
                    
                    Button {
                        
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
                        
                    } label: {
                        Text("1")
                    }
                    .isDefaultCalculatorButton()
                    
                    Button {
                        
                    } label: {
                        Text("2")
                    }
                    .isDefaultCalculatorButton()
                    
                    Button {
                        
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
    }
}
