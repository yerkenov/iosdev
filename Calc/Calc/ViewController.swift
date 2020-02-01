//
//  ViewController.swift
//  Calc
//
//  Created by Zhanna Amanbayeva on 10/4/19.
//  Copyright © 2019 Zhanna Amanbayeva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var Display: UILabel!
    
    var userIsTyping: Bool = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsTyping{
            let textCurrentlyInDisplay = Display.text!
            Display.text = textCurrentlyInDisplay + digit
        } else {
            Display.text = digit
            userIsTyping = true
        }
        
    }
    
    var displayValue: Double{
        get {
            return Double(Display.text!)!
        }
        set{
            Display.text = String(newValue)
        }
    }
      private var brain: CalculatorBrain = CalculatorBrain()
    
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsTyping{
            brain.setOperand(displayValue)
            userIsTyping = false
        }
        if let mathSymbol = sender.currentTitle{
            brain.performOperation(mathSymbol)
        }
        if let result = brain.result{
            displayValue = result
        }
    }
    
    
}

