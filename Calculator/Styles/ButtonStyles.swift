//
//  ButtonStyles.swift
//  Calculator
//
//  Created by Ondřej Toman on 29.10.2022.
//

import SwiftUI

struct DefaultCalculatorButton: ButtonStyle {
    var buttonHeight: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .bold()
            .frame(maxWidth: .infinity, minHeight: buttonHeight)
            .background(configuration.isPressed ? Color.buttonBackgroundPressed : Color.buttonBackground)
            .foregroundColor(Color.textPrimary)
            .cornerRadius(24)
    }
}

struct PrimaryCalculatorButton: ButtonStyle {
    var buttonHeight: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .bold()
            .frame(maxWidth: .infinity, minHeight: buttonHeight)
            .background(Color.cPrimary)
            .foregroundColor(Color.white)
            .cornerRadius(24)
            .shadow(color: (configuration.isPressed ? Color.primaryButtoShadow.opacity(0) : Color.primaryButtoShadow.opacity(0.25)), radius: 12, x: 0, y: 10)
    }
}

extension View {
    func isDefaultCalculatorButton(btnHeight: CGFloat) -> some View {
        buttonStyle(DefaultCalculatorButton(buttonHeight: btnHeight))
    }
    
    func isPrimaryCalculatorButton(btnHeight: CGFloat) -> some View {
        buttonStyle(PrimaryCalculatorButton(buttonHeight: btnHeight))
    }
}
