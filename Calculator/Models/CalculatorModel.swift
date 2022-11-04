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
    
    // MARK: - Published values
    
    /// Primary Row is the big text and main line above the keyboard
    @Published var primaryRow = "0"
    
    /// Secondary Row is the smaller, gray line above the keyboard
    @Published var secondaryRow = ""
    
    /// Indicates if the number for Primary Row is too large to render (more than 9 digits)
    @Published var tooLargeResult = false
    
    
    // MARK: - Primary Row states
    
    /// Is current Primary number negative?
    private var isNumberNegative = false
    
    /// Does current primary number has decimal part?
    private var isNumberDecimal = false
    
    /// Whole part of Primary number
    private var wholeNumber = "0"
    
    /// Decimal part of Primary number
    private var decimalNumber = ""
    
    
    // MARK: - Secondary Row states
    
    /// Indicates which action is currently selected on Calculator
    private var selectedAction: CalculatorAction = .none
    
    /// All numbers and symbols that connect together the current equation
    private var currentEquation: [String] = []
    
    
    // MARK: - Helper states
    
    /// Temporary number is storage for value of Primary Row, after user clicks on button which selects action
    private var temporaryNumber = ""
    
    /// How many characters can we fit into Primary Row
    private var maximumPrimaryRowCharacters = 9
    
    
    // MARK: - Rendering methods
    
    /// Renders the current number from Calculators internal state to Primary Row
    /// This function connects the whole and decimal part of the number, automatically adds "-" if primary number is negative
    private func renderPrimaryRow() {
        let prepend = isNumberNegative ? "-" : ""
        let dot = isNumberDecimal ? "," : ""
        primaryRow = "\(prepend)\(wholeNumber)\(dot)\(decimalNumber)"
    }
    
    /// Renders the current equation to Secondary Row
    private func renderSecondaryRow() {
        var tempText = ""
        
        for text in currentEquation {
            tempText.append(text)
        }
        
        secondaryRow = tempText
    }
    
    
    // MARK: - Clearing methods
    
    /// Clears the last digit from Primary Row. When there is no more decimal digits left, this function will switch the decimal mode off.
    /// - Parameter reRender: Determines if the method will re-render the Primary Row.
    func clearLastDigit(_ reRender: Bool = false) {
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
        
        if reRender {
            renderPrimaryRow()
        }
    }
    
    /// Resets the Calculator to its initial state.
    /// - Parameter reRender: Determines if the method will re-render Primary and Secondary rows.
    private func resetCalculator(_ reRender: Bool = false) {
        wholeNumber = "0"
        decimalNumber = ""
        isNumberNegative = false
        isNumberDecimal = false
        selectedAction = .none
        temporaryNumber = ""
        currentEquation = []
        
        if reRender {
            renderPrimaryRow()
            renderSecondaryRow()
        }
    }
    
    
    /// Resets properties related to Calculator Primary Text field
    /// - Parameter reRender: Determines if this function will re-render the primary text right away
    private func clearPrimaryText(_ reRender: Bool = false) {
        wholeNumber = "0"
        decimalNumber = ""
        isNumberNegative = false
        isNumberDecimal = false
        
        if reRender {
            renderPrimaryRow()
        }
    }
    
    
    // MARK: - Button action methods
    
    /// This function either removes the last digit from Primary Number or resets the whole calculator.
    ///
    /// This depends on the value of the Primary Row. If the Primary row has value other than "0",
    func backButtonPressed() {
        // Reset everything if Primary Row is equal to "0", otherwise clear the last digit of Primary Row
        if wholeNumber == "0" && decimalNumber == "" {
            resetCalculator(true)
        } else {
            clearLastDigit(true)
        }
    }
    
    /// Adds one digit to Primary Row.
    /// If the current Primary Row value is "0", then the "0" is replaced by the new number.
    /// - Parameter number: Number to be added
    func addNumberToPrimaryRow(_ number: Int) {
        
        // When Primary row contains only "0" and nothing else, replace "0" with the new number and return early
        if wholeNumber == "0" && !isNumberDecimal {
            wholeNumber = "\(number)"
            renderPrimaryRow()
            return
        }
        
        // We will check if the number (with "-" and "," symbols) don't have more than 9 characters
        if wholeNumber.count + decimalNumber.count + (isNumberDecimal ? 1 : 0) + (isNumberNegative ? 1 : 0) < maximumPrimaryRowCharacters {
            // Decide if we want the new number to be appended to whole or decimal part of the number
            if !isNumberDecimal {
                wholeNumber.append("\(number)")
            } else {
                decimalNumber.append("\(number)")
            }
            
            // Re-render the Primary Row
            renderPrimaryRow()
        }
    }
    
    /// Select action from predefined actions.
    ///
    /// This action will be executed when "=" button is pressed. If another action is already selected, then the previous action will be swapped for the new one, without removing the current value of the Primary Row
    /// - Parameter action: Select CalculatorAction
    func selectAction(_ action: CalculatorAction) {
        // Determines if there is already action selected
        if selectedAction == .none {
            // Append current Primary Row's value to Secondary Row
            currentEquation.append(primaryRow)
            // Save current value in temporary number. This will be used to make the calculation.
            temporaryNumber = primaryRow
            // Clear Primary Row, to get rid of the first number
            clearPrimaryText(true)
        } else {
            // Remove last action from the list
            currentEquation.removeLast()
        }
        
        // Append right symbol to current equation for selected action
        currentEquation.append(" \(action.rawValue) ")
        
        // Save selected action to internal state
        selectedAction = action
        
        // Render Secondary Row
        renderSecondaryRow()
    }
    
    /// Primary number can be negative or positive. This function toggles the internal setting determining that.
    ///
    /// This function can be executed only if the current Primary Row has 8 or less characters, so we can fit the "-" symbol in.
    /// - Parameter reRender: Determines if this function will re-render the Primary Row
    func toggleNegativeNumber(_ reRender: Bool = false) {
        // Check for the length of the Primary Row
        if wholeNumber.count + decimalNumber.count + (isNumberDecimal ? 1 : 0) < maximumPrimaryRowCharacters {
            isNumberNegative.toggle()
            
            if reRender {
                renderPrimaryRow()
            }
        }
    }
    
    /// Primary number can be decimal or whole. This function toggles the internal setting.
    ///
    /// This function can be executed only if the current Primary Row has 7 or less characters. Tha is because we can't add 10th character, if 9th character would be ",". So this rule ensures that at least one character will be decimal.
    /// - Parameter reRender: Determines if this function will re-render the primary text right away
    func toggleDecimalNumber(_ reRender: Bool = true) {
        // This function can be executed only if we have less than 8 characters currently in display
        //
        if wholeNumber.count + decimalNumber.count + (isNumberNegative ? 1 : 0) < (maximumPrimaryRowCharacters - 1) {
            if isNumberDecimal {
                wholeNumber.append(decimalNumber)
                decimalNumber = ""
                isNumberDecimal = false
            } else {
                isNumberDecimal = true
            }
            
            if reRender {
                renderPrimaryRow()
            }
        }
    }
    
    /// Executes currently selected action on two numbers: Previousl number and current number from the Primary Row.
    func doMath() {
        // Both numbers are valid, otherwise return early
        guard let num1 = getRealNumber(from: temporaryNumber), let num2 = getRealNumber(from: primaryRow) else {
            return
        }
        
        switch selectedAction {
        case .none:
            return
            
        case .add:
            // Push number 2 to Secondary text
            currentEquation.append(primaryRow)
            renderSecondaryRow()
            changePrimaryText(to: num1 + num2)
            
        case .substract:
            // Push number 2 to Secondary text
            currentEquation.append(primaryRow)
            renderSecondaryRow()
            changePrimaryText(to: num1 - num2)
            
        case .multiply:
            // Push number 2 to Secondary text
            currentEquation.append(primaryRow)
            renderSecondaryRow()
            changePrimaryText(to: num1 * num2)
            
        case .divide:
            // Push number 2 to Secondary text
            currentEquation.append(primaryRow)
            renderSecondaryRow()
            changePrimaryText(to: num1 / num2)
        }
        
        selectedAction = .none
    }
    
    
    // MARK: - Math methods
    
    /// Returns number in Double format from String
    /// - Parameter from: Number string which will be deconstructed to the number
    /// - Returns: Double number returned from the String provided
    private func getRealNumber(from: String) -> Double? {
        return Double(from.replacingOccurrences(of: ",", with: "."))
    }
    
    /// Changes primary text to certail value, based on number input
    /// - Parameter number: Value to be displayed in Primary Text
    private func changePrimaryText(to number: Double) {
        let tempNumberString = String(number)
        
        // Quick hack to solve too big numbers
        // Has some problems, like 0.1 + 0.3, but works for really simple math
        // TODO: Fix this in the future.
        if tempNumberString.count > (maximumPrimaryRowCharacters - 1) {
            // Set that result is too large to display
            tooLargeResult = true
            // Reset calculator
            resetCalculator()
        } else {
            let wholePart = String(tempNumberString.replacingOccurrences(of: "-", with: "").split(separator: ".")[0])
            
            // Set the internal state of positive / negative number
            isNumberNegative = number < 0
            
            // Reset the current equation
            currentEquation = []
            
            // Set the whole number part
            wholeNumber = wholePart
            
            // We will find out if the number is decimal. If so, add the decimal part.
            if Double(tempNumberString.split(separator: ".")[1])! > 0 {
                isNumberDecimal = true
                decimalNumber = String(tempNumberString.split(separator: ".")[1])
            }
        }
        
        renderPrimaryRow()
        renderSecondaryRow()
    }
}
