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
            VStack {
                // Memory
                Text("10 x 10")
                
                // Result
                Text("100")
            }
            
            Spacer()
            
            // Keyboard
            VStack {
                HStack {
                    Button {
                        print("AC")
                    } label: {
                        Text("AC")
                            .frame(maxWidth: .infinity, minHeight: 77)
                            .foregroundColor(Color.textPrimary)
                    }
                    .background(Color.buttonBackground)
                    

                }
                HStack {
                    Text("Row 4")
                }
                HStack {
                    Text("Row 3")
                }
                HStack {
                    Text("Row 2")
                }
                HStack {
                    Text("Row 1")
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
