//
//  calorieProgressVC.swift
//  MunchMap
//
//  Created by Srinivas Mane on 27/03/24.
//

import UIKit

class calorieProgressVC: UIViewController {

    @IBOutlet weak var EatenPV: UIProgressView!
    
    @IBOutlet weak var RemainingPV: UIProgressView!
    
    @IBOutlet weak var FatPV: UIProgressView!
    
    @IBOutlet weak var CarbsPV: UIProgressView!
    
    @IBOutlet weak var ProtienPV: UIProgressView!
    
    @IBOutlet weak var logoBTN: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EatenPV.progress = 0.0
        RemainingPV.progress = 0.0
        FatPV.progress = 0.0
        CarbsPV.progress = 0.0
        ProtienPV.progress = 0.0
        
        

        // Do any additional setup after loading the view.
    }
    func updateProgress(value: Float) {
        EatenPV.progress = value
        RemainingPV.progress = value
        FatPV.progress = value
        CarbsPV.progress = value
        ProtienPV.progress = value
        
        }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func logoBKBTN(_ sender: UIButton) {
    }
}
