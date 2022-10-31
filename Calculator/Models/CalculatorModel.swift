//
//  CalculatorModel.swift
//  Calculator
//
//  Created by Ondřej Toman on 30.10.2022.
//

import Foundation
import SwiftUI

enum CalculatorAction: String {
    case none = ""
    case add = "+"
    case substract = "-"
    case multiply = "×"
    case divide = "÷"
}

class CalculatorModel: ObservableObject {
    
    @Published var primaryText = "0"
    @Published var secondaryText = ""
    
    private var selectedAction: CalculatorAction = .none
    
    private var isNumberNegative = false
    private var isNumberDecimal = false
    
    private var currentEquation: [String] = []
    private var temporaryNumber = ""
    
    private var wholeNumber = "0"
    private var decimalNumber = ""
    
    // Adds number to primaryText
    func addNumber(_ number: Int) {
        // Start of the app or after reset, number is "0"
        if wholeNumber == "0" && !isNumberDecimal {
            wholeNumber = "\(number)"
            renderPrimaryText()
            return
        }
        
        // We will check if the number (with "-" and "," symbols) don't have more than 9 characters
        if wholeNumber.count + decimalNumber.count + (isNumberDecimal ? 1 : 0) + (isNumberNegative ? 1 : 0) < 9 {
            // If number IS NOT decimal, we will append to the whole part
            // If number IS decimal, we will append to the decimal part
            if !isNumberDecimal {
                wholeNumber.append("\(number)")
            } else {
                decimalNumber.append("\(number)")
            }
            
            renderPrimaryText()
        }
    }
    
    // Change primaryText property, so it can re-render the UI
    private func renderPrimaryText() {
        let prepend = isNumberNegative ? "-" : ""
        let dot = isNumberDecimal ? "," : ""
        primaryText = "\(prepend)\(wholeNumber)\(dot)\(decimalNumber)"
    }
    
    private func renderSecondaryText() {
        var tempText = ""
        
        for text in currentEquation {
            tempText.append(text)
        }
        
        secondaryText = tempText
    }
    
    // Clears the last digit from Primary Text
    // When there is no more decimal digits left, this function will switch decimal mode off
    func clearLastDigit() {
        // If number is not decimal
        if !isNumberDecimal {
            // Remove last number if whole number isn't already "0"
            if wholeNumber != "0" {
                wholeNumber.removeLast()
            }
            
            // If all numbers were removed, we simply assign "0" as our whole number
            if wholeNumber.count == 0 {
                wholeNumber = "0"
            }
        } else {
            // Remove last position from decimalNumber. We can do this even on empty string.
            decimalNumber.removeLast()
            
            // If we removed last position from decimalNumber, we will set calculator decimal number state to false
            if decimalNumber.count == 0 {
                isNumberDecimal = false
            }
        }
        
        renderPrimaryText()
    }
    
    // Resets Calculator to its initial state or clears the last digit
    func clearEverything() {
        
        // Reset everything if wholeNumber is "0" and decimalNumber is empty
        // This means we have cleared tho whole Primary Text and expected behavior is now to reset the whole app
        if wholeNumber == "0" && decimalNumber == "" {
            wholeNumber = "0"
            decimalNumber = ""
            isNumberNegative = false
            isNumberDecimal = false
            selectedAction = .none
            temporaryNumber = ""
            currentEquation = []
            
            renderSecondaryText()
        } else {
            clearLastDigit()
        }
        
        renderPrimaryText()
        
    }
    
    // Resets properties related to Calculator Primary Text field
    private func clearPrimaryText(_ reRender: Bool = true) {
        wholeNumber = "0"
        decimalNumber = ""
        isNumberNegative = false
        isNumberDecimal = false
        
        if reRender {
            renderPrimaryText()
        }
    }
    
    // Select action which is about to be made in our calculator
    func selectAction(_ action: CalculatorAction) {
        // If there is no previously selected action
        if selectedAction == .none {
            // Append current Primary value to Secondary text
            currentEquation.append(primaryText)
            // Save current value in temporary number (will be handy later)
            temporaryNumber = primaryText
        } else {
            // Remove last action from the list
            currentEquation.removeLast()
        }
        
        // Append right symbol for selected action
        currentEquation.append(" \(action.rawValue) ")
        
        // Save selected action
        selectedAction = action
        
        // Clear Primary Text field
        clearPrimaryText()
        
        // Render Secondary Text field
        renderSecondaryText()
    }
    
    // Toggles between positive and negative primaryText
    func toggleNegativeNumber(_ reRender: Bool = true) {
        // This function can be executed only if we have less than 9 characters currently in display
        if wholeNumber.count + decimalNumber.count + (isNumberDecimal ? 1 : 0) < 9 {
            isNumberNegative.toggle()
            
            if reRender {
                renderPrimaryText()
            }
        }
    }
    
    // Toggles between decimal and non decimal number
    func toggleDecimalNumber(_ reRender: Bool = true) {
        // This function can be executed only if we have less than 8 characters currently in display
        // 8 characters because we can't add 10th character, if 9th character would be ","
        if wholeNumber.count + decimalNumber.count + (isNumberNegative ? 1 : 0) < 8 {
            if isNumberDecimal {
                wholeNumber.append(decimalNumber)
                decimalNumber = ""
                isNumberDecimal = false
            } else {
                isNumberDecimal = true
            }
            
            if reRender {
                renderPrimaryText()
            }
        }
    }
    
    func getRealNumber(from: String) -> Double? {
        return Double(from.replacingOccurrences(of: ",", with: "."))
    }
    
    func doMath() {
        guard let number1 = getRealNumber(from: temporaryNumber) else {
            return
        }
        
        guard let number2 = getRealNumber(from: primaryText) else {
            return
        }
        
        switch selectedAction {
        case .none:
            print("Nothing selected")
            
        case .add:
            print(number1 + number2)
            
        case .substract:
            print(number1 - number2)
            
        case .multiply:
            print(number1 * number2)
            
        case .divide:
            print(number1 / number2)
        }
    }
    
    // This function will take result of equation and paste it properly to the Primary Text
    // While paste means setup inner state of calculator and display that
    #warning("Complete this function")
    private func changePrimaryText() {
        
    }
}
