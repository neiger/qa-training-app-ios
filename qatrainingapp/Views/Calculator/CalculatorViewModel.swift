//
//  CalculatorViewModel.swift
//  qatrainingapp
//
//  Created by Neiger Serrano on 19/5/25.
//

import Foundation

enum CalculatorAction: Character {
    case add = "+"
    case subtract = "-"
    case multiply = "*"
    case divide = "/"
    case percent = "%"
    case none = " "
}

final class CalculatorViewModel {
    @Published private(set) var input: String = ""
    @Published private(set) var output: String = ""

    private var valueOne = Double.nan
    private var valueTwo = 0.0
    private var currentAction: CalculatorAction = .none

    func handleInput(_ inputValue: String) {
        input += inputValue
        adjustFontSize()
    }

    func clear() {
        input = ""
        output = ""
        valueOne = Double.nan
        valueTwo = 0.0
        currentAction = .none
    }

    func toggleSign() {
        guard let current = Double(input) else { return }
        let toggled = -current
        input = String(toggled).trimmingCharacters(in: CharacterSet(charactersIn: ".0"))
    }

    func setOperation(_ action: CalculatorAction) {
        if !valueOne.isNaN {
            valueTwo = parseInput()
            performOperation()
        } else {
            valueOne = parseInput()
        }

        currentAction = action
        output = "\(format(valueOne)) \(action.rawValue)"
        input = ""
    }

    func calculate() {
        guard currentAction != .none else { return }

        valueTwo = parseInput()

        if currentAction == .divide, valueTwo == 0.0 {
            output = "Error: Divide by 0"
        } else {
            performOperation()
            output = format(valueOne)
            input = ""
            currentAction = .none
        }
    }

    private func parseInput() -> Double {
        Double(input) ?? 0.0
    }

    private func performOperation() {
        switch currentAction {
        case .add: valueOne += valueTwo
        case .subtract: valueOne -= valueTwo
        case .multiply: valueOne *= valueTwo
        case .divide: valueOne = valueTwo == 0 ? Double.nan : valueOne / valueTwo
        case .percent: valueOne = valueOne * valueTwo / 100
        case .none: break
        }
    }

    private func format(_ value: Double) -> String {
        if value == floor(value) {
            return String(Int(value))
        } else {
            return String(value)
        }
    }

    private func adjustFontSize() {
        // Optionally notify a delegate or use Combine/Closure to resize font in UI
    }
}
