//
//  BoardGameController.swift
//  Cards
//
//  Created by IosDeveloper on 06.01.2022.
//

import UIKit

class BoardGameController: UIViewController {
    //количество пар уникальных  карточек
    var cardPairsCount =  8
    
    lazy var game:Game = getNewGame()
    func getNewGame() ->Game{
        let game = Game()
        game.cardsCount = self.cardPairsCount
        game.generateCards()
        return game
    }
    
    //кнопка для запускака/перезапуска игры
    lazy var startButtonView = getStartButtonView()
    func getStartButtonView() -> UIButton {
        //1. create button
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        //2. Изменяем положение кнопки
        button.center.x = view.center.x
        
        //3. настраиваем внешний вид кнопки
        button.setTitle("Start game", for:.normal)
        //color text (для не нажатого)
        button.setTitleColor(.black, for: .normal)
        //color text (для нажатого)
        button.setTitleColor(.gray, for: .highlighted)
        //фоновый цвет
        button.backgroundColor = .systemGray4
        //скругляем углы
        button.layer.cornerRadius = 10
        
        return button
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
