//
//  CalcBrain.swift
//  Calc
//
//  Created by Zhanna Amanbayeva on 10/8/19.
//  Copyright © 2019 Zhanna Amanbayeva. All rights reserved.
//

import Foundation



struct CalculatorBrain{
    private var accumulator: Double?
    
    private enum Operation{
        case constant(Double)
        case unaryOperation((Double)-> Double)
        case binaryOperation((Double,Double)->Double)
        case equals
    }
    
    private var operations: Dictionary<String,Operation> = [
        "p" : Operation.constant(Double.pi),
        "e" : Operation.constant(M_E),
        "sqrt": Operation.unaryOperation(sqrt),
        "x": Operation.binaryOperation({(op1, op2) in
            return op1 * op2
            }),
        "-": Operation.binaryOperation({$0 - $1}),
        "+": Operation.binaryOperation({$0 + $1}),
        "/": Operation.binaryOperation({$0 / $1}),
        "=": Operation.equals
    
    ]
    
    mutating func performOperation(_ symbol: String){
        if let operation = operations[symbol]{
             switch operation {
             case .constant(let value):
                accumulator = value
             case .unaryOperation(let function):
                if accumulator != nil{
                    accumulator = function(accumulator!)
                }
             case .binaryOperation(let function):
                if accumulator != nil{
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
                
             case .equals:
                performPBOperation()
                
            }
            
        }
    }
    private mutating func performPBOperation(){
        if pendingBinaryOperation != nil && accumulator != nil{
             accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
       
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation{
        let function: (Double,Double)-> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double)-> Double{
            return function(firstOperand, secondOperand)
        }
    }
    
    mutating func setOperand(_ operand: Double){
        accumulator = operand
    }
    var result: Double?{
        get{
            return accumulator
        }
    }
    
    
    
}
