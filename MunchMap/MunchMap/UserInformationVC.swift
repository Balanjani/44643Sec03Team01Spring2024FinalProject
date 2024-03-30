    //
    //  UserInformationVC.swift
    //  MunchMap
    //
    //  Created by Tarun Yada  on 3/28/24.
    //

    import UIKit

    class UserInformationVC: UIViewController, UITextFieldDelegate {

        @IBOutlet weak var AgeTF: UITextField!
        @IBOutlet weak var HeightTF: UITextField!
        
        @IBOutlet weak var WeightTF: UITextField!
        
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            AgeTF.delegate = self
            HeightTF.delegate = self
            WeightTF.delegate = self
            
            AgeTF.keyboardType = .numberPad
            HeightTF.keyboardType = .numberPad
            WeightTF.keyboardType = .numberPad
            
            // Do any additional setup after loading the view.
        }
        
        
        @IBAction func submitBTN(_ sender: Any) {
            guard let text1 = AgeTF.text, !text1.isEmpty,
                  let text2 = HeightTF.text, !text2.isEmpty,
                  let text3 = WeightTF.text, !text3.isEmpty else {
                // If any of the fields are empty, display an alert or handle it accordingly
                let alertController = UIAlertController(title: "Error", message: "Please fill in all fields", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                present(alertController, animated: true, completion: nil)
                return performSegue(withIdentifier: "logintouserinfo", sender: self)
            }
        }
            
        
        
        
        
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
                // Allow only numeric characters and backspace
                let allowedCharacterSet = CharacterSet(charactersIn: "0123456789").union(.init(charactersIn: ""))
                let typedCharacterSet = CharacterSet(charactersIn: string)
                return allowedCharacterSet.isSuperset(of: typedCharacterSet)
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
