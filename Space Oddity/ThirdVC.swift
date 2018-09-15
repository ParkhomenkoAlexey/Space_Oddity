//
//  ThirdVC.swift
//  Space Oddity
//
//  Created by Алексей Пархоменко on 13.09.2018.
//  Copyright © 2018 Алексей Пархоменко. All rights reserved.
//

import UIKit

class MyTexts {
    var text : String?
    var boolean : Bool?
    var hiddenText : String?
    
} // class

class ThirdVC: UIViewController {

    var planetPicture = UIImage(named: "")
    var spaceshipPicture = UIImage(named: "")
    
    // чтение из файла
    //var test:[Test] = (1...50).map { _ in return Test.init(str: nil) }
    var arr = (1...16).map { _ in MyTexts() }    // заполняем массив элементами класса myTexts
    var textArray = [String]()                   // массив со значениями текста
    var hiddenTextArray = [String]()             // массив с ответами true/false
    var boolean = [String]()                     // массив с объяснением ответа
    
    var matrix = [Int]()                         // массив для заполнения случайными числами для функции selectNubmer()
    var i = 0                                    // для функции burstingHearts()
    
    @IBOutlet weak var upperTextView: UITextView!
    @IBOutlet weak var goBackButton: UIButton!
    @IBOutlet weak var lowerTextView: UITextView!
    @IBOutlet var hearts: [UIImageView]!
    @IBOutlet weak var planet: UIImageView!
    @IBOutlet var redGreenButtons: [UIButton]!
    @IBOutlet weak var spaceship: UIImageView!
    
    @IBOutlet weak var endTitle: UILabel!
    @IBOutlet weak var tryAgainButton: UIButton!
    @IBOutlet weak var goToMenuButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // cкрываем view победы или проигрыша
        
        endTitle.isHidden = true
        tryAgainButton.isHidden = true
        goToMenuButton.isHidden = true
        
        for item in [tryAgainButton,goToMenuButton] {
            item?.layer.cornerRadius = 10
            item?.layer.borderWidth = 1.4
            item?.layer.borderColor = UIColor.white.cgColor
        }
        
        
        spaceship.image = spaceshipPicture
        planet.image = planetPicture
        readFromFile()
        intoMassiv()
        selectNubmer()
        upperTextView.text = arr[matrix.last!].text
        // кастоматизация textViews
        for textVie in [upperTextView,lowerTextView] {
            textVie?.isUserInteractionEnabled = false
            textVie?.textColor = .white
            textVie?.layer.cornerRadius = 10
            textVie?.layer.borderWidth = 1.4
            textVie?.layer.borderColor = UIColor.white.cgColor
        }
        lowerTextView.isUserInteractionEnabled = true
        for button in redGreenButtons {
            button.layer.cornerRadius = 10
        }
        
        MenuButton() // кнопка меню
        
    } // viewDidLoad()
    
    @IBAction func buttons(_ sender: UIButton) {
        
        Timer.scheduledTimer(withTimeInterval: 1.7, repeats: false) { _ in
            
            if self.i == self.hearts.count {            // если все сердечки лопнули, то не выводим текст
                self.upperTextView.text = nil
            } else {
                self.upperTextView.text = self.arr[self.matrix.last!].text
            }
            sender.isUserInteractionEnabled = true  // отключаем кнопки пока идет загрузка нового текста
        }
        self.lowerTextView.text = arr[self.matrix.last!].hiddenText
        
        switch sender.title(for: .normal) {
        case "True"?:
            if arr[matrix.last!].boolean == false {
                burstingHearts()
                self.lowerTextView.text = nil // если user ошибся то нужно скрывать нижний текст
            } else {
                spaceshipUp()
            }
        case "False"?:
            if arr[matrix.last!].boolean == true {
                burstingHearts()
                self.lowerTextView.text = nil
            } else {
                spaceshipUp()
            }
        default:
            break
        }
        selectNubmer()
        sender.isUserInteractionEnabled = false
        
    } // buttons
    
    func spaceshipUp() {
        

        let sverhu = planet.frame.origin.y + planet.frame.height // отступ сверху
        let snizy = 50 // отступ снизу (всегда 60, на всех моделях iphone) - 10 потому что сама картинка немножко меньше предоставленного ей окошка
        let ohh = view.frame.height - sverhu - CGFloat(snizy) // расстояние от кораблика до планеты
        print("ohh \(ohh)")
        

        // -1 это 100%, но мы можем отнимать и больше по мере того, сколько вопросов мы хотим
        let oneStep = Int(ohh)/(arr.count - 1 - 5)// один шаг "-1" т.к. учитываем шанс что user может ошибиться
        let newOriginY = self.spaceship.frame.origin.y - CGFloat(oneStep)  // новая координата корабля
        
        
        
        Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true) { _ in
            
            if self.spaceship.frame.origin.y > newOriginY {
                self.spaceship.frame.origin.y -= 0.07
            }
        }
        
        
        // planetOriginY - newOriginY < 14 && planetOriginY - newOriginY > -14
        let planetOriginY = planet.frame.origin.y + planet.frame.height  // расстояние по Y планеты
        if planetOriginY >= newOriginY  {
            Timer.scheduledTimer(withTimeInterval: 0.002, repeats: true) { _ in
                
                self.spaceship.alpha -= 0.001
            }
            Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { _ in
                self.youWin()
            }
        }
        
    } // spaceshipUp()
    
    func burstingHearts() {
        hearts[i].image = UIImage(named: "like2")
        if i == hearts.count - 1 {
            youLose()
        }
        i = i + 1
        
    } // burstingHearts()
    
    func youWin() {
        
        hideAllElements()
        
        endTitle.text = "You win!"
        endTitle.isHidden = false
        goToMenuButton.isHidden = false
    
        goToMenuButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        
    } // youWin()
    
    func youLose() {
        
        hideAllElements()
        
        endTitle.isHidden = false
        endTitle.text = "You lose!"
        tryAgainButton.isHidden = false
        goToMenuButton.isHidden = false

        tryAgainButton.addTarget(self, action: #selector(tryAgain), for: .touchUpInside)
        goToMenuButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
    } // youLose()
    
    func selectNubmer()  {
        
        let randNumber = Int(arc4random_uniform(UInt32(arr.count)))
        var r = 0
        for value in matrix {
            if value == randNumber {
                r = r + 1
            }
        }
        if r == 0 {
            matrix.append(randNumber)
        } else {
            selectNubmer()
        }
        
    } // selectNubmer()
    
    func hideAllElements() {
        upperTextView.alpha = 0.2
        lowerTextView.alpha = 0.2
        goBackButton.alpha = 0.2
        for but in redGreenButtons {
            but.alpha = 0.2
            but.isUserInteractionEnabled = false
        }
        for heart in hearts {
            heart.alpha = 0.2
        }
        //spaceship.alpha = 0.1
        
        spaceship.isHidden = true
        planet.alpha = 0.2
        view.backgroundColor = view.backgroundColor?.withAlphaComponent(0.2)
        
    } // hideAllElements()
    
    func endGoToMenuButton() {
        
        let goToMenuButton = UIButton(type: .system)
        goToMenuButton.frame = CGRect(x: 0, y: 554, width: 210, height: 50)
        goToMenuButton.setTitleColor(.white, for: .normal)
        goToMenuButton.titleLabel?.font = goToMenuButton.titleLabel?.font.withSize(25)
        goToMenuButton.center.x = view.center.x
        goToMenuButton.backgroundColor = UIColor(white: 1, alpha: 0.37)
        goToMenuButton.layer.cornerRadius = 10
        goToMenuButton.layer.borderWidth = 1.4
        goToMenuButton.layer.borderColor = UIColor.white.cgColor
        goToMenuButton.setTitle("Go to menu", for: .normal)
        goToMenuButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        view.addSubview(goToMenuButton)
        
    } // endGoToMenuButton()
    
    func readFromFile() {
        var text = ""
        if let path = Bundle.main.path(forResource: "text", ofType: "txt") {
            text = try! String(contentsOfFile: path)
            textArray = text.components(separatedBy: "\n\n")
            if textArray.last == "" {
                textArray.removeLast()
            }
        }
        
        if let path = Bundle.main.path(forResource: "hiddenText", ofType: "txt") {
            text = try! String(contentsOfFile: path)
            hiddenTextArray = text.components(separatedBy: "\n\n")
            if hiddenTextArray.last == "" {
                hiddenTextArray.removeLast()
            }
        }
        
        if let path = Bundle.main.path(forResource: "boolean", ofType: "txt") {
            text = try! String(contentsOfFile: path)
            boolean = text.components(separatedBy: "\n\n")
            if boolean.last == "" {
                boolean.removeLast()
            }
        }
        
    } // readFromFile()
    
    func intoMassiv() {
        for (index,value) in arr.enumerated() {
            if index < textArray.count {
                value.text = textArray[index]
            }
            if index < hiddenTextArray.count {
                value.hiddenText = hiddenTextArray[index]
            }
            if index < boolean.count {
                if boolean[index] == "true" {
                    value.boolean = true
                } else if boolean[index] == "false" {
                    value.boolean = false
                }
            }
        }
        
    } // intoMassiv()
    
    func MenuButton() {
        self.goBackButton.layer.cornerRadius = 5
        self.goBackButton.layer.borderWidth = 1.4
        self.goBackButton.layer.borderColor = UIColor.white.cgColor
        self.goBackButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
    } // MenuButton()
    
    @objc func tryAgain(param: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "SecondVC")
        self.present(vc!, animated: false, completion: nil)
        
    }
    
    @objc func goBack(param: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "FirstVC")
        self.present(vc!, animated: false, completion: nil)
        
    } // goBack(param: Any)
    

} // class
