//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by Tony's Mac on 10/23/16.
//  Copyright © 2016 OceanTech. All rights reserved.
//
// Todo: 3pi, dot

import Foundation
import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var isInTheMidOfTyping: Bool = false
    
    @IBAction func appendDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        print("digit: \(digit)")
        
        if isInTheMidOfTyping {
            if digit == "." && display.text!.range(of: ".") != nil {
                
            }else{
                display.text = display.text! + digit
            }
        } else {
            display.text = digit
            isInTheMidOfTyping = true
        }
    }
    
    @IBAction func enter() {
        isInTheMidOfTyping = false;
        operandStack.append(displayValue)
        print("operandStack= \(operandStack)")

    }
    
    var operandStack = Array<Double>()
    
    var displayValue: Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text = "\(newValue)"
            isInTheMidOfTyping = false
        }
    }
    
    @IBAction func operate(_ sender: UIButton) {
        let operand = sender.currentTitle!
        if isInTheMidOfTyping {
            enter()
        }
        switch operand {
        case "×": performOperation { $0 * $1 }
        case "÷": performOperation { $1 / $0 }
        case "+": performOperation { $0 + $1 }
        case "−": performOperation { $1 - $0 }
        case "√": performOperation { sqrt($0) }
        case "sin": performOperation { sin($0) }
        case "cos": performOperation { cos($0) }
        case "tan": performOperation { tan($0) }
        case "C": clearAll()
        case "π":  displayValue = M_PI; enter()
        //case "+/-" : // negative sign

        default: break;
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
           displayValue = operation(operandStack.removeLast(), operandStack.removeLast())   // put to var displayValue and set newValue
            enter()
        }
    }
    
    private func performOperation(operation: (Double) -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())   // put to var displayValue and set newValue
            enter()
        }
    }
    
    func clearAll(){
        operandStack.removeAll()
        display.text = "0"
    }
    
    
    
    
    
    
    
    
}
