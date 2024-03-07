//
//  Munchmap.swift
//  MunchMap
//
//  Created by Tarun Yada  on 2/19/24.
//

import UIKit
import Lottie
import Foundation

class Munchmap: UIViewController {
    
    
    
    @IBOutlet weak var launchLAV: LottieAnimationView!{
        didSet{
            launchLAV.animation = .named("munchmap")
            launchLAV.alpha = 1
            launchLAV.play(){ [weak self] _ in UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1, delay: 0.1, options: [.curveEaseIn]){
                self!.launchLAV.alpha = 0
            }
            }
        }
    }
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var Message: UILabel!
    
    @IBOutlet weak var firstNameRgTF: UITextField!
    
    @IBOutlet weak var lastNameRgTF: UITextField!
    
    @IBOutlet weak var gmailRgTF: UITextField!
    
    @IBOutlet weak var phoneNoRgTF: UITextField!
    
    @IBOutlet weak var passwordRgTF: UITextField!
    
    @IBOutlet weak var confrimPsdRgTF: UITextField!
    
    @IBOutlet weak var GenderpickerUISC: UIPickerView!
    
    @IBOutlet weak var AgeUISTF: UITextField!
    
    @IBOutlet weak var heightUISTF: UITextField!
    
    @IBOutlet weak var weightUISTF: UITextField!
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Set up secure text entry for the password text field
        
        passwordTF.isSecureTextEntry = true
        
        
        
        // Clear text fields
        usernameTF.text = ""
        passwordTF.text = ""
        
       
    }
    
    @IBAction func loginMpBTN(_ sender: UIButton) {
        validEmail()
    }
    
    @IBAction func forgotPsdMpBTN(_ sender: UIButton) {
    }
    
    @IBAction func signupRegMpBTN(_ sender: UIButton) {
    }
    
    @IBAction func signupRgBTN(_ sender: UIButton) {
        
    }
    
    @IBAction func submitUISBTN(_ sender: UIButton) {
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let result = email.range(of: emailRegex, options: .regularExpression)
            return result != nil
    }

    // Usage example
    
    private func validEmail(){
        let email = "example@example.com"
        if !isValidEmail(email) {
            Message.text = "Invalid email address"
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
