//
//  registerSV.swift
//  MunchMap
//
//  Created by Tarun Yada  on 3/28/24.
//

import UIKit

class registerSV: UIViewController {

    @IBOutlet weak var firstNameTF: UITextField!
    
    @IBOutlet weak var lastNameTF: UITextField!
    
    @IBOutlet weak var gmailTF: UITextField!
    
    @IBOutlet weak var phoneNumberTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var confrimPasswordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func inValidEmail(_ value: String) -> String?
        {
            let emailRegularExp =  "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegularExp)
            if !predicate.evaluate(with: value )
            {
                return "Please enter valid email address"
            }
            return nil
        }
        func inValidPassword(_ value: String) -> String?
        {
            if value.count < 8
            {
                return "Please enter password"
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
        }
        func isValidPhoneNumber(_ value: String) -> String? {
            let phoneRegex = #"^\d{10}$"#
            let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            if !predicate.evaluate(with: value) {
                return "Please enter valid 10 digits phone number"
            }
            return nil
        }
    
    @IBAction func SignupBTN(_ sender: UIButton) {
        if let email = gmailTF.text, let phonenumber = phoneNumberTF.text, let password = passwordTF.text, let firstname = firstNameTF.text, let lastname = lastNameTF.text, let confirmPassword = confrimPasswordTF.text{
                    if firstname == ""{
                        openAlert(title: "Alert", message: "Please enter firstname", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                    }else if lastname == ""{
                        openAlert(title: "Alert", message: "Please enter lastname", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                    } else if let emailError = inValidEmail(email) {
                        openAlert(title: "Alert", message: emailError, alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                    } else if let phoneError = isValidPhoneNumber(phonenumber) {
                        openAlert(title: "Alert", message: phoneError, alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                    }else if let passwordError = inValidPassword(password) {
                        openAlert(title: "Alert", message: passwordError, alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                        print("Password is not valid")
                    } else {
                        if confirmPassword == "" {
                            openAlert(title: "Alert", message: "Please confirm password", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                            print("Please confirm password")
                        }else{
                            if password == confirmPassword{
                                openAlert(title: "Alert", message: "Account created", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                                firstNameTF.text = ""
                                lastNameTF.text = ""
                                gmailTF.text = ""
                                phoneNumberTF.text = ""
                                passwordTF.text = ""
                                confrimPasswordTF.text = ""
                            }else{
                                openAlert(title: "Alert", message: "password doesn't match", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                                print("password does not match")
                            }
                        }
                    }
                }else{
                    openAlert(title: "Alert", message: "please validate your details", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                    print("Please check your details")
                }
            }
            
            public func openAlert(title: String,
                                  message: String,
                                  alertStyle:UIAlertController.Style,
                                  actionTitles:[String],
                                  actionStyles:[UIAlertAction.Style],
                                  actions: [((UIAlertAction) -> Void)]){
                
                let alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
                for(index, indexTitle) in actionTitles.enumerated(){
                    let action = UIAlertAction(title: indexTitle, style: actionStyles[index], handler: actions[index])
                    alertController.addAction(action)
                }
                self.present(alertController, animated: true)
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
