//
//  RulesVC.swift
//  Space Oddity
//
//  Created by Алексей Пархоменко on 13.09.2018.
//  Copyright © 2018 Алексей Пархоменко. All rights reserved.
//

import UIKit

class RulesVC: UIViewController {

    @IBOutlet weak var goBackButton: UIButton!
    @IBOutlet weak var rulesTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        goBackButton.layer.cornerRadius = 5
        goBackButton.layer.borderWidth = 1.4
        goBackButton.layer.borderColor = UIColor.white.cgColor
        
        //rulesTextView.isUserInteractionEnabled = false
        rulesTextView.layer.cornerRadius = 10
        rulesTextView.layer.borderWidth = 1.4
        rulesTextView.layer.borderColor = UIColor.white.cgColor
        
        rulesTextView.text = "Привет! Ты пилот звездолета ТЕ-284. Огромная удача - древние реликвии планеты Sattul оказались в твоих руках. Необходимо доставить ценный груз на родную планету в полной сохранности. Путь непростой, но очень познавательный. Покажи все свои знания о Космосе, ответь на вопросы и вернись домой!\n\nТолько два ответа на вопрос: правда или ложь. Правильный ответ приблизит тебя к цели, неправильный оставит на месте, но помни, у тебя есть только два права на ошибку.Удачи! Твоя планета верит в тебя."
    }
    
    @IBAction func goBackButton(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "FirstVC")
        self.present(vc!, animated: false, completion: nil)
        
    } // goBack
    
    

    

}
