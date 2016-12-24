//
//  Exercise3ViewController.swift
//  Day01
//
//  Created by Developer on 12/23/16.
//  Copyright © 2016 Developer. All rights reserved.
//

import UIKit

class Exercise3ViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var expressionLabel: UILabel!
    @IBOutlet weak var outputLabel: UILabel!
    var outputValue: Double = 0 { didSet { updateOutput() }}
    @IBOutlet var calculatorButtons: [UIButton]!
    
    @IBOutlet weak var mrButton: UIButton!
    @IBOutlet weak var mcButton: UIButton!
    
    // Types
    enum CharacterType {
        case numbers, operators, equal, decimal
    }
    
    // Variables
    var currentType: CharacterType = .numbers
    var characters = ["0"]
    var usedAC = false
    var usedEqual = false
    var memory: Double? = nil
    
    // Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for button in calculatorButtons {
            button.addTarget(self, action: #selector(touchedButton), for: .touchUpInside)
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func touchedButton(_ sender: AnyObject) {
        guard let button = sender as? UIButton else { return }
        let text = button.title(for: .normal)!
        
        if text == "=" { tappedEqual() } else { usedEqual = false }
        if text == "AC" { tappedAC() } else { usedAC = false }
        if text == "+/-" { tappedPositiveNegative() }
        if text == "." { tappedDecimal() }
        
        if isNumber(text) { tappedNumber(text) }
        if isOperator(text) { tappedOperator(text) }
        
        if text == "mc" { tappedMC() }
        if text == "mr" { tappedMR() }
        if text == "m-" { tappedMSubtract() }
        if text == "m+" { tappedMAdd() }
    
        updateExpression()
    }
    
    func tappedMSubtract() {
        if memory == nil {
            mrButton.backgroundColor = .white
            mrButton.setTitleColor(.black, for: .normal)
        }
        
        memory = (memory == nil) ? -outputValue : memory! - outputValue
    }
    
    func tappedMAdd() {
        if memory == nil {
            mrButton.backgroundColor = .white
            mrButton.setTitleColor(.black, for: .normal)
        }
        
        memory = (memory == nil) ? outputValue : memory! + outputValue
    }
    
    func tappedMR() {
        guard memory != nil else { return }
        outputValue = memory!
        
        if currentType == .operators {
            characters.append(outputToString())
        } else if currentType == .equal {
            characters.removeAll()
            characters.append(outputToString())
        } else {
            characters[characters.count - 1] = outputToString()
        }
        currentType = .numbers
    }
    
    func tappedMC() {
        memory = nil
        mrButton.backgroundColor = mcButton.backgroundColor
        mrButton.setTitleColor(mcButton.titleColor(for: .normal), for: .normal)
    }
    
    func tappedDecimal() {
        guard currentType != .decimal else { return }
        
        if currentType == .numbers {
            guard !characters.last!.contains(".") else { return }
            
            outputLabel.text = characters.last! + "."
            characters[characters.count - 1] += "."
        }
        if currentType == .operators  {
            characters.append("0.")
            outputLabel.text = "0."
        }
        if currentType == .equal {
            characters.removeAll()
            characters.append("0.")
            outputLabel.text = "0."
        }
        
        currentType = .decimal
    }
    
    func tappedPositiveNegative() {
        if currentType == .equal {
            outputValue *= -1
            characters.removeAll()
            characters.append(outputToString())
            return
        }
        if currentType == .decimal {
            let text = characters.last!
            
            if !text.hasPrefix("-") {
                characters[characters.count - 1] = "-" + characters[characters.count - 1]
                outputLabel.text = "-" + outputLabel.text!
            } else {
                characters[characters.count - 1].remove(at: text.startIndex)
                outputLabel.text?.remove(at: text.startIndex)
            }
            return
        }
        
        if currentType == .numbers {
            let number = -Double(characters.last!)!
            outputValue = number
            characters[characters.count - 1] = outputToString()
        }
        if currentType == .operators {
            let number = -Double(characters[characters.count - 2])!
            outputValue = number
            currentType = .numbers
            characters.append(outputToString())
        }
    }
    
    func tappedAC() {
        if usedAC == true {
            characters.removeAll()
            characters.append("0")
            usedAC = false
            currentType = .numbers
        }
        
        outputValue = 0
        usedAC = true
        
        if currentType == .numbers {
            if characters.count > 1 {
                characters.removeLast()
                currentType = .operators
            }
        }
        
    }
    
    func tappedEqual() {
        guard !characters.isEmpty else { return }
        guard characters.count > 1 else { return }
        
        if usedEqual {
            var array: [String] = [outputToString()]
            array.append(characters[characters.count - 2])
            array.append(characters[characters.count - 1])
            characters = array
        }
        
        if currentType == .operators {
            characters.removeLast()
        }
        if currentType == .decimal {
            if (characters.last?.hasSuffix("."))! {
                let text = characters.last!
                characters[characters.count - 1].remove(at: text.index(before: text.endIndex))
            }
        }
        
        var array = characters
        for i in 0...(array.count - 1) {
            if array[i] == " x " {
                array[i] = " * "
                continue
            }
            if array[i] == " ÷ " {
                array[i] = " / "
                array[i+1] = String(describing: Double(array[i+1])!)
                continue
            }
        }
        
        let expression = array.joined()
        let nse = NSExpression(format: expression)
        outputValue = nse.expressionValue(with: nil, context: nil) as! Double
        
        self.currentType = .equal
        self.usedEqual = true
    }
    
    func tappedOperator(_ text: String) {
        if currentType == .numbers {
            characters.append(" \(text) ")
        }
        if currentType == .operators {
            characters[characters.count - 1] = " \(text) "
        }
        if currentType == .equal {
            characters.removeAll()
            characters.append(outputToString())
            characters.append(" \(text) ")
        }
        if currentType == .decimal {
            if (characters.last?.hasSuffix("."))! {
                let text = characters.last!
                characters[characters.count - 1].remove(at: text.index(before: text.endIndex))
            }
            characters.append(" \(text) ")
        }
        
        currentType = .operators
        outputValue = Double(characters[characters.count - 2])!
    }
    
    func tappedNumber(_ text: String) {
        if currentType == .numbers {
            if characters.last! == "0" {
                characters[characters.count - 1] = text
            } else {
                characters[characters.count - 1] += text
            }
        }
        
        if currentType == .operators {
            characters.append(text)
        }
        
        if currentType == .equal {
            characters.removeAll()
            characters.append(text)
        }
        
        if currentType == .decimal {
            characters[characters.count - 1] += text
        } else {
            currentType = .numbers
        }
        outputValue = Double(characters[characters.count - 1])!
        
    }
    
    func outputToString() -> String {
        if outputValue == outputValue.rounded() {
            return String.init(format: "%.f", outputValue)
        } else {
            return String(describing: outputValue)
        }
    }
    
    func updateOutput() {
        outputLabel.text = outputToString()
    }
    
    func updateExpression() {
        let text = characters.joined()
        self.expressionLabel.text = text
    }
    
    func isNumber(_ input: String) -> Bool {
        return Int(input) != nil
    }
    
    func isOperator(_ input: String) -> Bool {
        let operators = ["+", "-", "x", "÷"]
        for sign in operators {
            if sign == input { return true }
        }
        return false
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
