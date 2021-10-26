//
//  ViewController.swift
//  RightOnTarget
//
//  Created by Pavel Yarovoi on 24.10.2021.
//

import UIKit

class ViewController: UIViewController {
    var hiddenNumber: Int = 0
    var roundNumber: Int = 0
    var score: Int = 0
    
    @IBOutlet var slider: UISlider!
    @IBOutlet var label: UILabel!
    
    @IBAction func checkNumber() {
        let numberOnSlider = Int(self.slider.value.rounded())
        
        if numberOnSlider > self.hiddenNumber {
            self.score += 50 - self.hiddenNumber + numberOnSlider
        } else if numberOnSlider < self.hiddenNumber {
            self.score += 50 - numberOnSlider + self.hiddenNumber
        } else {
            self.score += 50
        }
        if self.roundNumber != 5 {
            self.roundNumber += 1
        } else {
            let alert = UIAlertController(
                title: "Игра окончена.",
                message: "Вы заработали \(self.score) очков.",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(
                title: "Начать заново.",
                style: .default,
                handler: nil))
            self.present(alert, animated: true, completion: nil)
            self.roundNumber = 1
            self.score = 0
        }
        
        self.hiddenNumber = Int.random(in: 1...50)
        self.label.text = String(self.hiddenNumber)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hiddenNumber = Int.random(in: 0...50)
        self.label.text = String(self.hiddenNumber)
    }
}
