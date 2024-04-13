//
//  ForgotPasswordVC.swift
//  MunchMap
//
//  Created by Sriinivas Mane on 12/04/24.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    
    @IBOutlet weak var EmailTF: UITextField!
    
    @IBOutlet weak var ResetBTN: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        EmailTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let email = EmailTF.text, isValidEmail(email: email) {
            ResetBTN.isEnabled = true
        } else {
            ResetBTN.isEnabled = false
        }
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
        
    }
    
    @IBAction func Reset(_ sender: Any) {
        
        guard let email = EmailTF.text else {
            return
        }
        showAlert(message: "Password reset link sent to \(email)") {
            self.performSegue(withIdentifier: "ForgetpassSegue", sender: self)
        }
    }
    
    func showAlert(message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion?()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func cancleBTN(_ sender: UIButton) {
        performSegue(withIdentifier: "forgrttologin", sender: self)
        
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


