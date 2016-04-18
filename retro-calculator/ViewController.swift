//
//  ViewController.swift
//  retro-calculator
//
//  Created by Nikhil Pagidala on 4/6/16.
//  Copyright © 2016 Nikhil Pagidala. All rights reserved.
//

import UIKit
import AVFoundation //Audio Video Player Framework

class ViewController: UIViewController {

    enum Operation: String{
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    //Number that is printed to the screen
    var runningNumber = ""
    
    //left side of an operator
    var leftValStr = ""
    
    //right side of an operator
    var rightValStr = ""
    
    // Get Current Operation
    var currentOperation: Operation = Operation.Empty
    
    // Store intermediate results
    var result = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        do{
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError{
            print(err.debugDescription)
        }
        
    }
    
    @IBAction func numberPressed(btn: UIButton!){
        
        playSound()
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    
    }


    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
        
    }

    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
        
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }

    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
        
    }

    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    @IBAction func onClearPressed(sender: AnyObject){
        
        playSound()
        
        leftValStr = ""
        rightValStr = ""
        runningNumber = ""
        currentOperation = Operation.Empty
        result = ""
        outputLbl.text = ""
    }
    
    
    
    func processOperation(op: Operation){
        playSound()
        
        if currentOperation != Operation.Empty{
            
            // A user selectec and operator, but selected another operator without entering another operator
            if runningNumber != ""{
                
                // Run some math
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result
            
            }
            
            currentOperation = op
            
        } else
        {
            // This is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound(){
        if btnSound.playing{
            btnSound.stop()
        }
        else{
            btnSound.play()
        }
    }
    
    
    
    
    
    
}

