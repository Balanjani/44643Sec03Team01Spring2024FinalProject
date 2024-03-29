//
//  BreakfastVC.swift
//  MunchMap
//
//  Created by Balanjani on 3/28/24.
//

import UIKit

class BreakfastVC: UIViewController {

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
           
        // Do any additional setup after loading the view.
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
           // Deselect all buttons
           BreakfastOL.isSelected = false
           LunchOL.isSelected = false
           SnacksOL.isSelected = false
           DinnerOL.isSelected = false
           
           // Highlight the tapped button
           sender.isSelected = true
           
            BreakfastOL.backgroundColor = BreakfastOL.isSelected ? UIColor.systemCyan : UIColor.clear
            LunchOL.backgroundColor = LunchOL.isSelected ? UIColor.systemCyan : UIColor.clear
            SnacksOL.backgroundColor = SnacksOL.isSelected ? UIColor.systemCyan : UIColor.clear
            DinnerOL.backgroundColor = DinnerOL.isSelected ? UIColor.systemCyan : UIColor.clear
            

           // Optionally, you can perform other actions based on the tapped button
           // For example, update UI elements based on the selected meal type
           switch sender {
           case BreakfastOL:
               // Handle breakfast selection
               break
           case LunchOL:
               // Handle lunch selection
               break
           case SnacksOL:
               // Handle snacks selection
               break
           case DinnerOL:
               // Handle dinner selection
               break
           default:
               break
           }
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
