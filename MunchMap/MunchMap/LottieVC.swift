//
//  LottieVC.swift
//  MunchMap
//
//  Created by Srinivas Mane on 19/04/24.
//

import UIKit
import Lottie
import FirebaseAuth
import AudioToolbox

class LottieVC: UIViewController {
    
    @IBOutlet weak var launchLAV: LottieAnimationView!{
        didSet{
            FireStoreOperations.fetchUserData{_ in
            }
            
            launchLAV.animation = .named("munchmap")
            launchLAV.alpha = 1
            launchLAV.play(){ [weak self] _ in UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1, delay: 0.1, options: [.curveEaseIn]){
                self?.performSegue(withIdentifier: "lottietologin", sender: self)
                AudioServicesPlaySystemSound(1302)
            }
            }
        }
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
