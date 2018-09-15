

import UIKit

class SecondVC: UIViewController {

    var planetPicture : UIImage?
    var spaceshipPicture : UIImage?
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var goBackButton: UIButton!
    @IBOutlet var selectItemsLabels: [UILabel]!
    @IBOutlet var spaceships: [UIButton]!
    @IBOutlet var planets: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playButton.isEnabled = false
        playButton.alpha = 0.5
        
        goBackButton.layer.cornerRadius = 5
        goBackButton.layer.borderWidth = 1.4
        goBackButton.layer.borderColor = UIColor.white.cgColor
        
        // кастомизация
        for button in [spaceships,planets] {
            for item in button! {
                item.layer.cornerRadius = 10
            }
        }

        for item in selectItemsLabels {
            item.layer.borderWidth = 1.4
            item.layer.borderColor = UIColor.white.cgColor
        }
        
    } // viewDidLoad()
    
    @IBAction func spaceshipsAction(_ sender: UIButton) {
        
        sender.isSelected  = !sender.isSelected
        switch sender.isSelected {
        case true:
            for button in spaceships {
                button.layer.borderWidth = 0
            }
            sender.layer.borderWidth = 2
            sender.layer.borderColor = UIColor.yellow.cgColor
            spaceshipPicture = (sender.imageView?.image)!
            
            sender.isSelected  = !sender.isSelected
        case false:
            sender.layer.borderWidth = 0
        }
        if planetPicture != nil && spaceshipPicture != nil {
            playButton.isEnabled = true
            playButton.alpha = 1
            playButton.layer.borderWidth = 1.4
            playButton.layer.borderColor = UIColor.white.cgColor
        }
        
    } // spaceshipsAction
    
    @IBAction func planetsAction(_ sender: UIButton) {
        
        sender.isSelected  = !sender.isSelected
        switch sender.isSelected {
        case true:
            for button in planets {
                button.layer.borderWidth = 0
            }
            sender.layer.borderWidth = 2
            sender.layer.borderColor = UIColor.yellow.cgColor
            planetPicture = (sender.imageView?.image)!
            sender.isSelected  = !sender.isSelected
        case false:
            sender.layer.borderWidth = 0
        }
        if planetPicture != nil && spaceshipPicture != nil {
            playButton.isEnabled = true
            playButton.alpha = 1
            playButton.layer.borderWidth = 1.4
            playButton.layer.borderColor = UIColor.white.cgColor
            
        }
        
    } // planetsAction
    
    @IBAction func goBack(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "FirstVC")
        self.present(vc!, animated: false, completion: nil)
        
    } // goBack
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "toThirdVC" {

            let ThirdViewController = segue.destination as! ThirdVC
            ThirdViewController.planetPicture = planetPicture
            ThirdViewController.spaceshipPicture = spaceshipPicture
        }
    } // prepare
    

}
