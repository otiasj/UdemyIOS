 //
 //  ViewController.swift
 //  RetroCalculator
 //
 //  Created by Julien Saito on 3/14/17.
 //  Copyright © 2017 otiasj. All rights reserved.
 //
 
 import UIKit
 import AVFoundation
 
 class ViewController: UIViewController {
    
    @IBOutlet weak var outputLabel: UILabel!
    var btnSound: AVAudioPlayer!
    var runningNumber = "0"
    var leftValue = ""
    var rightValue = ""
    var result = ""
    
    enum Operation: String {
        case Divide = "/"
        case Subtract = "-"
        case Multiply = "*"
        case Add = "+"
        case Equal = "="
        case Empty = "empty"
    }
    
    var currentOperation = Operation.Empty
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
    @IBAction func onDividePressed(_ sender: Any) {
        processOperation(operation: Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(_ sender: Any) {
        processOperation(operation: Operation.Multiply)
    }
    
    
    @IBAction func onSubstractPressed(_ sender: Any) {
        processOperation(operation: Operation.Subtract)
    }
    
    @IBAction func onEqualPressed(_ sender: Any) {
        processOperation(operation: Operation.Equal)
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        
        if (runningNumber == "0") {
            runningNumber = "\(sender.tag)"
        } else {
            runningNumber += "\(sender.tag)"
        }
        outputLabel.text = runningNumber
    }
    @IBAction func onAddPressed(_ sender: Any) {
        processOperation(operation: Operation.Add)
    }
    
    func processOperation(operation: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            
            if runningNumber != "" {
                rightValue = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValue)! * Double(rightValue)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValue)! / Double(rightValue)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValue)! - Double(rightValue)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValue)! + Double(rightValue)!)"
                }
                
                leftValue = result
                outputLabel.text = result
            } else {
                //A user selected an operator, but then selected another operator without first entering a number
            }
            
            currentOperation = operation
        } else {
            //This is the first time an operator has been pressed
            leftValue = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
    
 func playSound() {
    btnSound.play()
 }
 }
 
