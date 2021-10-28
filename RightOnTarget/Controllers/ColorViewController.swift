//
//  ColorViewController.swift
//  RightOnTarget
//
//  Created by Pavel Yarovoi on 27.10.2021.
//

import UIKit


class ColorViewController: UIViewController {
    
    // Сущность "Игра"
    var colorGame: ColorGame!
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
        
        colorGame = ColorGame(round: 5)
        updateLableWithHiddenColor(newText: colorGame.currentHiddenColor)
        
        buttonsWithColors = [buttonOne, buttonTwo, buttonThree, buttonFour]
        generateColorInButtons(hiddenColor: UIColor(hex: colorGame.currentHiddenColor)!)
        
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
        colorGame.calculateScore(with: sender.backgroundColor!)
        if colorGame.isGameEnded {
            showAllertWith(score: colorGame.score)
            colorGame.restartGame()
        } else {
            colorGame.startNewRound()
        }
        updateLableWithHiddenColor(newText: colorGame.currentHiddenColor)
        generateColorInButtons(hiddenColor: UIColor(hex: colorGame.currentHiddenColor)!)
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
                let randomColorWithOtherButton = UIColor(hex: colorGame.getRandomColor())
                button.backgroundColor = randomColorWithOtherButton
            }
        }
    }
}
