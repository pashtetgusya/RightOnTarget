//
//  NumberViewController.swift
//  RightOnTarget
//
//  Created by Pavel Yarovoi on 27.10.2021.
//

import UIKit


class NumberViewController: UIViewController {
    
    // Сущность "Игра"
    var numberGame: Game<Int>!
    var numberGameRound: GameRound<Int>!
    var numberGenerator: ValueGenerator<Int>!
    
    // MARK: Элементы на сцене
    @IBOutlet var slider: UISlider!
    @IBOutlet var label: UILabel!
    
    // MARK: Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        numberGenerator = ValueGenerator.init(startValue: 1, endValue: 50)
        numberGameRound = GameRound.init(hiddenValue: numberGenerator)
        numberGame = Game.init(valueGenerator: numberGenerator, gameRound: numberGameRound, rounds: 5)
        updateLableWithSecretNumber(nexText: String(numberGame.currentRound.currentHiddenValue))
    }
    
    
    // MARK: Взаимодействие View - Model
    // Проверка выбранного пользователем числа
    @IBAction func checkNumber() {
        numberGame.currentRound.calculateScore(with: Int(slider.value))
        if numberGame.isGameEnded {
            showAllertWith(score: numberGame.score)
            numberGame.restartGame()
        } else {
            numberGame.startNewRound()
        }
        
        updateLableWithSecretNumber(nexText: String(numberGame.currentRound.currentHiddenValue))
    }
    
    // MARK: Обновление View
    // Обновление текста о текущем загаданном числе
    private func updateLableWithSecretNumber(nexText: String) {
        label.text = nexText
    }
    // Отображение она со счетом
    private func showAllertWith(score: Int) {
        let alert = UIAlertController(
            title: "Игра окончена.",
            message: "Вы заработали \(score) очков.",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(
            title: "Начать заново.",
            style: .default,
            handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
