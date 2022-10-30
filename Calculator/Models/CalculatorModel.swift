//
//  CalculatorModel.swift
//  Calculator
//
//  Created by Ondřej Toman on 30.10.2022.
//

import Foundation
import SwiftUI

class CalculatorModel: ObservableObject {
    
    @Published var primaryText = "0"
    @Published var secondaryText = "10 x 10"
    
    private var internalPrimaryValue: Double = 0
    
    func addNumber(_ number: Int) {
        if primaryText == "0" {
            primaryText = ""
        }
        primaryText.append(String(number))
    }
    
    func clearPrimaryText() {
        primaryText = "0"
    }
    
    func clearEverything() {
        primaryText = "0"
        secondaryText = ""
    }
}
