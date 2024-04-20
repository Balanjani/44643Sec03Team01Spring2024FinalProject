//
//  BreakfastVC.swift
//  MunchMap
//
//  Created by Balanjani on 3/28/24.
//

import UIKit
import AudioToolbox

protocol selectDishDelegate {
    func didDishSelected(dish: String) -> Void
}

class BreakfastVC: UIViewController {
    
    var delegate: selectDishDelegate?
    var selectedButton = -1
    
    @IBOutlet weak var BreakfastOL: UIButton!
    @IBOutlet weak var LunchOL: UIButton!
    @IBOutlet weak var SnacksOL: UIButton!
    @IBOutlet weak var DinnerOL: UIButton!
    @IBOutlet weak var DishNameOL: UILabel!
    @IBOutlet weak var DishTFOL: UITextField!
    @IBOutlet weak var IngredientsOL: UILabel!
    @IBOutlet weak var IngredientsTFOL: UITextField!
    @IBOutlet weak var SaveOL: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BreakfastOL.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        LunchOL.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        SnacksOL.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        DinnerOL.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        setBackground()
        
        // Do any additional setup after loading the view.
    }
    
    func setBackground() -> Void {
        
        BreakfastOL.isSelected = false
        LunchOL.isSelected = false
        SnacksOL.isSelected = false
        DinnerOL.isSelected = false
        
        if selectedButton == 1 {
            
            BreakfastOL.isSelected = true
        }else if selectedButton == 2 {
            
            LunchOL.isSelected = true
        }else if selectedButton == 3 {
            
            SnacksOL.isSelected = true
        }else if selectedButton == 4 {
            
            DinnerOL.isSelected = true
        }
        
        BreakfastOL.tintColor = BreakfastOL.isSelected ? UIColor.tintColor : UIColor.clear
        LunchOL.tintColor = LunchOL.isSelected ? UIColor.tintColor : UIColor.clear
        SnacksOL.tintColor = SnacksOL.isSelected ? UIColor.tintColor : UIColor.clear
        DinnerOL.tintColor = DinnerOL.isSelected ? UIColor.tintColor : UIColor.clear
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        
        
        
        self.selectedButton = sender.tag
        
        self.setBackground()
        
        switch sender {
        case BreakfastOL:
            break
        case LunchOL:
            
            break
        case SnacksOL:
            
            break
        case DinnerOL:
            
            break
        default:
            break
        }
        
    }
    
    
    @IBAction func Calculate(_ sender: UIButton) {
        AudioServicesPlaySystemSound(1306)
        guard let dish = DishTFOL.text, !dish.isEmpty else {
            let alertController = UIAlertController(title: "Error", message: "Please fill in all fields", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        
        
        delegate?.didDishSelected(dish: dish)
        self.dismiss(animated: true)
    }
    @IBAction func cancel(_ sender: UIButton) {
        performSegue(withIdentifier: "backtouser", sender: self)
        AudioServicesPlaySystemSound(1306)
    }
    
    @IBAction func info(_ sender: Any) {
        performSegue(withIdentifier: "Infoview", sender: self)
        AudioServicesPlaySystemSound(1306)
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
