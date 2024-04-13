//
//  BreakfastVC.swift
//  MunchMap
//
//  Created by Balanjani on 3/28/24.
//

import UIKit

class BreakfastVC: UIViewController {

    
    @IBOutlet weak var DishNameOL: UILabel!
    @IBOutlet weak var DishTFOL: UITextField!
    @IBOutlet weak var IngredientsOL: UILabel!
    @IBOutlet weak var IngredientsTFOL: UITextField!
    @IBOutlet weak var SaveOL: UIButton!
    
    @IBOutlet weak var logoBTN: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
           
        // Do any additional setup after loading the view.
    }
    
   
   
    @IBAction func logoBKBTN(_ sender: UIButton) {
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
