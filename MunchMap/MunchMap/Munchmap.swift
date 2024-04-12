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
    
    
    
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var Message: UILabel!
    
    @IBOutlet weak var loginOtMpBTN: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
        guard let text1 = usernameTF.text, !text1.isEmpty,
              let text2 = passwordTF.text, !text2.isEmpty else {
            // If any of the fields are empty, display an alert or handle it accordingly
            let alertController = UIAlertController(title: "Message", message: "Please fill in all fields", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            return performSegue(withIdentifier: "logintouserinfo", sender: self)
        }
    }
    
    @IBAction func forgotPsdMpBTN(_ sender: UIButton) {
    }
    
    @IBAction func signupRegMpBTN(_ sender: UIButton) {
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
