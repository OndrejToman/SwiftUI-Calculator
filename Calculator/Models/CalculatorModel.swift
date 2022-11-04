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
    
    /// Primary Text is the big text and main line above the keyboard
    @Published var primaryText = "0"
    
    /// Secondary Text is the smaller, gray line above the keyboard
    @Published var secondaryText = ""
    
    /// Indicates if the number is too large to render
    @Published var tooLargeResult = false
    
    /// Which action us currently selected on Calculator
    private var selectedAction: CalculatorAction = .none
    
    /// Is current Primary number negative?
    private var isNumberNegative = false
    
    /// Does current primary number has decimal part?
    private var isNumberDecimal = false
    
    /// All numbers and symbols that connect together the current equation
    private var currentEquation: [String] = []
    
    /// Temporary number is stored after a user selects action.
    private var temporaryNumber = ""
    
    /// Whole part of Primary number
    private var wholeNumber = "0"
    
    /// Decimal part of Primary number
    private var decimalNumber = ""
    
    /// Adds number to Primary Text
    /// - Parameter number: Number to be added to Primary Text
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
    
    /// Renders the Primary Text.
    /// This function connects the whole and decimal part of the number, automatically adds "-" if primary number is negative
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
    
    /// Clears the last digit from Primary Text
    /// When there is no more decimal digits left, this function will switch the decimal mode off
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
    
    /// This function either removes the last digit from Primary Number or resets the whole calculator.
    /// The Calculator is resetted only if there are no numbers (other than 0) left in the Primary Number.
    func backButtonPressed() {
        // Reset everything if wholeNumber is "0" and decimalNumber is empty
        // This means we have cleared tho whole Primary Text and expected behavior is now to reset the whole app
        if wholeNumber == "0" && decimalNumber == "" {
            resetCalculator()
            
            renderSecondaryText()
        } else {
            clearLastDigit()
        }
        
        renderPrimaryText()
        
    }
    
    /// Resets the Calculator to its initial state
    private func resetCalculator() {
        wholeNumber = "0"
        decimalNumber = ""
        isNumberNegative = false
        isNumberDecimal = false
        selectedAction = .none
        temporaryNumber = ""
        currentEquation = []
    }
    
    
    /// Resets properties related to Calculator Primary Text field
    /// - Parameter reRender: Determines if this function will re-render the primary text right away
    private func clearPrimaryText(_ reRender: Bool = true) {
        wholeNumber = "0"
        decimalNumber = ""
        isNumberNegative = false
        isNumberDecimal = false
        
        if reRender {
            renderPrimaryText()
        }
    }
    
    /// Select action which will be executed in Calculator
    /// - Parameter action: Select CalculatorAction
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
    
    /// Primary number can be negative or positive.
    /// This function toggles the internal setting
    /// - Parameter reRender: Determines if this function will re-render the primary text right away
    func toggleNegativeNumber(_ reRender: Bool = true) {
        // This function can be executed only if we have less than 9 characters currently in display
        if wholeNumber.count + decimalNumber.count + (isNumberDecimal ? 1 : 0) < 9 {
            isNumberNegative.toggle()
            
            if reRender {
                renderPrimaryText()
            }
        }
    }
    
    /// Primary number can be decimal or whole.
    /// This function toggles the internal setting
    /// - Parameter reRender: Determines if this function will re-render the primary text right away
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
    
    /// Executes currently selected operation on two numbers
    func doMath() {
        // Both numbers are valid, otherwise return early
        guard let num1 = getRealNumber(from: temporaryNumber), let num2 = getRealNumber(from: primaryText) else {
            return
        }
        
        switch selectedAction {
        case .none:
            return
            
        case .add:
            // Push number 2 to Secondary text
            currentEquation.append(primaryText)
            renderSecondaryText()
            changePrimaryText(to: num1 + num2)
            
        case .substract:
            // Push number 2 to Secondary text
            currentEquation.append(primaryText)
            renderSecondaryText()
            changePrimaryText(to: num1 - num2)
            
        case .multiply:
            // Push number 2 to Secondary text
            currentEquation.append(primaryText)
            renderSecondaryText()
            changePrimaryText(to: num1 * num2)
            
        case .divide:
            // Push number 2 to Secondary text
            currentEquation.append(primaryText)
            renderSecondaryText()
            changePrimaryText(to: num1 / num2)
        }
        
        selectedAction = .none
    }
    
    /// Changes primary text to certail value, based on number input
    /// - Parameter number: Value to be displayed in Primary Text
    private func changePrimaryText(to number: Double) {
        let tempNumberString = String(number)
        
        // Quick hack to solve too big numbers
        // Has some problems, like 0.1 + 0.3, but works for most cases
        // TODO: Fix this in the future.
        if tempNumberString.count > 9 {
            // Set that result is too large to display
            tooLargeResult = true
            // Reset calculator
            resetCalculator()
        } else {
            let wholePart = String(tempNumberString.replacingOccurrences(of: "-", with: "").split(separator: ".")[0])
            
            // We will find out if the number is negative or positive
            isNumberNegative = number < 0
            
            currentEquation = []
            
            wholeNumber = wholePart
            
            // We will find out if the number is decimal
            if Double(tempNumberString.split(separator: ".")[1])! > 0 {
                isNumberDecimal = true
                decimalNumber = String(tempNumberString.split(separator: ".")[1])
            }
        }
        
        renderPrimaryText()
        renderSecondaryText()
    }
}
