//
//  ProfileVC.swift
//  MunchMap
//
//  Created by Balanjani on 3/28/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

protocol caloriesDelegate {
    
    func didUpdated() -> Void
}


class ProfileVC: UIViewController {
    
    var delegate: caloriesDelegate?
    
    @IBOutlet weak var nameLBL: UILabel!
    
    @IBOutlet weak var emailLBL: UILabel!
    
    @IBOutlet weak var caloriesTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        nameLBL.text = Auth.auth().currentUser?.displayName ?? ""
        emailLBL.text = Auth.auth().currentUser?.email ?? ""
        // Do any additional setup after loading the view.
        
        let str = String(format: "%0.0f", FireStoreOperations.UserData?.calories ?? 0)
        caloriesTF.text = str
        
    }
    
    
    @IBAction func back(_ sender: Any) {
        
        
        self.dismiss(animated: true)
    }
    
    @IBAction func save(_ sender: Any) {
        
        guard let calories = caloriesTF.text, !calories.isEmpty else {
            // If any of the fields are empty, display an alert or handle it accordingly
            let alertController = UIAlertController(title: "Error", message: "Please fill in all fields", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        
        let id = Auth.auth().currentUser?.uid ?? ""
        let db = Firestore.firestore()
        
        let cal = Double(caloriesTF.text ?? "0.0") ?? 0
        let params = ["calories": cal]
        
        db.collection("Users").document(id).updateData(params) { err in
            if let _ = err {
                
                
                
                self.showMsg(msg: "Failed to update Calories")
            } else {
                
                self.delegate?.didUpdated()
                self.showMsg(msg: "Calories updated")
            }
        }
    }
    
    func showMsg(msg: String) -> Void {
        
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func logout(_ sender: Any) {
        
        do {
            
            try Auth.auth().signOut()
        } catch {}
        
        
        self.performSegue(withIdentifier: "profileToLogin", sender: self)
    }
    
    @IBAction func Delete(_ sender: UIButton) {
            let user = Auth.auth().currentUser
            
            user?.delete { error in
                if let error = error {
                    self.showMsg(msg: "Error deleting user: \(error.localizedDescription)")
                } else {
                    self.showMsg(msg: "User deleted successfully")
                }
            }
            self.performSegue(withIdentifier: "profileToLogin", sender: self)
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
