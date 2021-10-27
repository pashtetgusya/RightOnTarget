//
//  NumberViewController.swift
//  RightOnTarget
//
//  Created by Pavel Yarovoi on 27.10.2021.
//

import UIKit


class NumberViewController: UIViewController {
    
    // Сущность "Игра"
    var game: Game!
    
    // MARK: Элементы на сцене
    @IBOutlet var slider: UISlider!
    @IBOutlet var label: UILabel!
    
    // MARK: Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let generator = NumberGenerator(startValue: 1, endValue: 50)
        game = Game(valueGenerator: generator!, rounds: 5)
        updateLableWithSecretNumber(nexText: String(game.currentRound.currentHiddenValue))
    }

    
    // MARK: Взаимодействие View - Model
    // Проверка выбранного пользователем числа
    @IBAction func checkNumber() {
        game.currentRound.calculateScore(with: Int(slider.value))
        if game.isGameEnded {
            showAllertWith(score: game.score)
            game.restartGame()
        } else {
            game.startNewRound()
        }
        
        updateLableWithSecretNumber(nexText: String(game.currentRound.currentHiddenValue))
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
