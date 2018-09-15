

import UIKit

class FirstVC: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var rulesButton: UIButton!
    @IBOutlet weak var headLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headLabel.alpha = 0
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            if self.headLabel.alpha != 1 {
                self.headLabel.alpha += 0.005
            }
        }
        
        for button in [startButton,rulesButton] {
            button?.layer.cornerRadius = 5
            button?.layer.borderWidth = 1.4
            button?.layer.borderColor = UIColor.white.cgColor
        }
    }


}

