//
//  ViewController.swift
//  iPhoneCalculator
//
//  Created by Brian Ho on 06/02/2017.
//  Copyright © 2017 Brian Ho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var currentNumber = ""
    var LHSvalue = ""
    var RHSvalue = ""
    var outcome = ""
    // needs to be defined as empty
    var currentOperation = Operation.Empty
    
    
    // give an enum, name and type
    enum Operation: String {
        case Add = "+"
        case Minus = "-"
        case Multiply = "*"
        case Divide = "/"
        case Percent = "%"
        case Decimal = "."
        case Empty = "Empty"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // default label should always be 0
        outputLbl.text = "0"
    }
    
    // need an IBAction to clear the number.
    // do i want to clear the whole calculation or just that part?
    @IBAction func clearNumber(_ sender: Any) {
        currentNumber = ""
        LHSvalue = ""
        RHSvalue = ""
        outputLbl.text = "0"
        currentOperation = Operation.Empty
    }
    
    
    // need a universal method for each button pressed
    @IBAction func numberPressed(button: UIButton){
        currentNumber += "\(button.tag)"
        outputLbl.text = currentNumber
    }
    
    @IBAction func divide(_ sender: Any) {
        processOperation(operation: .Divide)
    }
    @IBAction func times(_ sender: Any) {
        processOperation(operation: .Multiply)
    }
    @IBAction func minus(_ sender: Any) {
        processOperation(operation: .Minus)
    }
    @IBAction func adds(_ sender: Any) {
        processOperation(operation: .Add)
    }
    @IBAction func percent(_ sender: Any) {
        
        var percentage = ""
        if currentOperation == .Empty {
            
            if currentNumber != "" {
            percentage = "\(Double(currentNumber)!/100)"
            LHSvalue = percentage
            currentNumber = ""
            }
            
        } else {
            
            percentage = "\(Double(LHSvalue)!/100)"
            LHSvalue = percentage
            
        }
        outputLbl.text = percentage
    }
    @IBAction func equals(_ sender: Any) {
        processOperation(operation: currentOperation)
    }
    
    func processOperation(operation:Operation){
        
        if currentOperation != Operation.Empty {
            // if midway through an expression
            if currentNumber != "" {
                
                RHSvalue = currentNumber
                currentNumber = ""
                
                if currentOperation == Operation.Add {
                    outcome = "\(Double(LHSvalue)! + Double(RHSvalue)!)"
                } else if currentOperation == Operation.Minus {
                    outcome = "\(Double(LHSvalue)! - Double(RHSvalue)!)"
                } else if currentOperation == Operation.Multiply {
                    outcome = "\(Double(LHSvalue)! * Double(RHSvalue)!)"
                } else if currentOperation == Operation.Divide {
                    outcome = "\(Double(LHSvalue)! / Double(RHSvalue)!)"
                }
                
                // for further expressions
                LHSvalue = outcome
                outputLbl.text = outcome
            }
            
            currentOperation = operation
            
        } else {
            
            LHSvalue = currentNumber
            currentNumber = ""
            currentOperation = operation
            
        }
        
    }

}

