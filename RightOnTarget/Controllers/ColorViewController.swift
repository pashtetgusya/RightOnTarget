//
//  ColorViewController.swift
//  RightOnTarget
//
//  Created by Pavel Yarovoi on 27.10.2021.
//

import UIKit


class ColorViewController: UIViewController {
    
    // Сущность "Игра"
    var colorGame: Game<String>!
    var colorGameRound: GameRound<String>!
    var colorGenerator: ValueGenerator<String>!
    var buttonsWithColors: [UIButton]!
    var correctButton: UIButton!
    
    // MARK: Элементы на сцене
    @IBOutlet var hexColorLable: UILabel!
    @IBOutlet var buttonOne: UIButton!
    @IBOutlet var buttonTwo: UIButton!
    @IBOutlet var buttonThree: UIButton!
    @IBOutlet var buttonFour: UIButton!
    
    // MARK: Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        colorGenerator = ValueGenerator.init()
        colorGameRound = GameRound.init(hiddenValue: colorGenerator)
        colorGame = Game.init(valueGenerator: colorGenerator, gameRound: colorGameRound, rounds: 5)
        updateLableWithHiddenColor(newText: String(colorGame.currentRound.currentHiddenValue))
        
        buttonsWithColors = [buttonOne, buttonTwo, buttonThree, buttonFour]
        generateColorInButtons(hiddenColor: UIColor(hex: colorGame.currentRound.currentHiddenValue)!)
        
        for button in buttonsWithColors {
            changeButton(button: button)
        }
    }
    
    // Функция для изменения стиля кнопок (чтобы не было копипаста кода для каждой кнопки)
    private func changeButton(button: UIButton) {
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 10
    }
    
    // MARK: Взаимодействие View - Model
    // Проверка выбранного пользователем числа
    @IBAction func checkColor(sender: UIButton) {
        colorGame.currentRound.calculateScore(with: sender.backgroundColor!.asHexColorCode())
        if colorGame.isGameEnded {
            showAllertWith(score: colorGame.score)
            colorGame.restartGame()
        } else {
            colorGame.startNewRound()
        }
        updateLableWithHiddenColor(newText: colorGame.currentRound.currentHiddenValue)
        generateColorInButtons(hiddenColor: UIColor(hex: colorGame.currentRound.currentHiddenValue)!)
    }
    
    // MARK: Обновление View
    // Обновление текста о текущем загаданном числе
    private func updateLableWithHiddenColor(newText: String) {
        hexColorLable.text = newText
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
    
    // Фкнция для заполнения кнопок новыми цветами
    private func generateColorInButtons(hiddenColor: UIColor) {
        correctButton = buttonsWithColors.randomElement()!
        buttonsWithColors.forEach { button in
            if button == correctButton {
                button.backgroundColor = hiddenColor
            } else {
                let randomColorWithOtherButton = UIColor(hex: colorGenerator.getRandomValue())
                button.backgroundColor = randomColorWithOtherButton
            }
        }
    }
}
