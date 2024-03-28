//
//  Munchmap.swift
//  MunchMap
//
//  Created by Tarun Yada  on 2/19/24.
//

import UIKit
import Lottie
import Foundation
import SwiftUI

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
    
    @IBOutlet weak var loginOtMpBTN: UIButton!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up secure text entry for the password text field
        
        //passwordTF.isSecureTextEntry = true
        
        // Clear text fields
        //usernameTF.text = ""
        //passwordTF.text = ""
        //AgeUISTF.text = ""
        //heightUISTF.text = ""
        //weightUISTF.text = ""
        
    }
    
    @IBAction func UserNameValue(_ sender: Any) {
        if let Username = usernameTF.text{
            if let message = inValidEmail(Username){
                Message.text = message
                Message.isHidden = false
            }
            else
            
            {
                Message.isHidden = true
            }
        }
        checkvalid()
    }
    
    @IBAction func PasswordValue(_ sender: Any) {
        if let password = passwordTF.text{
            if let message = inValidPassword(password){
                Message.text = message
                Message.isHidden = false
            }
            else
            
            {
                Message.isHidden = true
            }
        }
        checkvalid()
        
    }
    @IBAction func loginMpBTN(_ sender: UIButton) {
        //if let email = usernameTF.text
        //validCode()
        resetForm()
    }
    
    @IBAction func forgotPsdMpBTN(_ sender: UIButton) {
    }
    
    @IBAction func signupRegMpBTN(_ sender: UIButton) {
    }
    
    @IBAction func signupRgBTN(_ sender: UIButton) {
        
    }
    
    @IBAction func submitUISBTN(_ sender: UIButton) {
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func resetForm()
    {
        loginOtMpBTN.isEnabled = false
        Message.isHidden = false
        Message.text = "Required to fill the fields"
        
        usernameTF.text = ""
        passwordTF.text = ""
        
        
    }
    func checkvalid()
    {
        if Message.isHidden == true
        {
            loginOtMpBTN.isEnabled = true
        }else{
            loginOtMpBTN.isEnabled = false
        }
    }
    
    // Usage example
    func inValidEmail(_ value: String) -> String?
    {
        let emailRegularExp =  "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegularExp)
        if !predicate.evaluate(with: value )
        {
            return "Invalid Email Address "
        }
        return nil
    }
    func inValidPassword(_ value: String) -> String?
    {
        if value.count < 8
        {
            return "Password Must contain at least 8 characters"
        }
        if containsDigit(value)
        {
            return "Password Must contain at least 1 digit"
        }
        if containsLowerCase(value)
        {
            return "Password Must contain at least 1 lowercase character"
        }
        if containsUpperCase(value)
        {
            return "Password Must contain at least 1 uppercase character"
        }
        return nil
        
        func containsDigit(_ value: String) -> Bool
        {
            let psdExpression = ".*[1-9]+.*"
            let psdpredicate = NSPredicate(format: "SELF MATCHES %@", psdExpression)
            return !psdpredicate.evaluate(with: value)
        }
        func containsLowerCase(_ value: String) -> Bool
        {
            let psdExpression = ".*[a-z]+.*"
            let psdpredicate = NSPredicate(format: "SELF MATCHES %@", psdExpression)
            return !psdpredicate.evaluate(with: value)
        }
        func containsUpperCase(_ value: String) -> Bool
        {
            let psdExpression = ".*[A-Z]+.*"
            let psdpredicate = NSPredicate(format: "SELF MATCHES %@", psdExpression)
            return !psdpredicate.evaluate(with: value)
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
}
