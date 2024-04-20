//
//  ForgotPasswordVC.swift
//  MunchMap
//
//  Created by Srinivas Mane on 18/04/24.
//

import UIKit
import FirebaseAuth
import AudioToolbox

class ForgotPasswordVC: UIViewController {
    
    @IBOutlet weak var MailTF: UITextField!
    @IBOutlet weak var SubmitBTN: UIButton!
    @IBOutlet weak var Cancel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func Submit(_ sender: Any) {
        AudioServicesPlaySystemSound(1306)
        guard let email = MailTF.text, !email.isEmpty else {
            openAlert(title: "Alert", message: "Please enter email!", alertStyle: .alert, actionTitles: ["okay"], actionStyles: [.default], actions: [{_ in }])
            return
        }
        Auth.auth().sendPasswordReset(withEmail: email) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                openAlert(title: "Alert", message: "Error sending reset email:", alertStyle: .alert, actionTitles: ["okay"], actionStyles: [.default], actions: [{_ in }])
            } else {
                openAlert(title: "Alert", message: "Reset email sent successfully", alertStyle: .alert, actionTitles: ["okay"], actionStyles: [.default], actions: [{_ in }])
                MailTF.text = ""
            }
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
    
    
    @IBAction func CancelBTN(_ sender: Any) {
        self.performSegue(withIdentifier: "forgottologin", sender: sender)
        AudioServicesPlaySystemSound(1306)
    }
    
    
    func showAlert(message: String, completion: @escaping () -> Void) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            
            completion()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
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


