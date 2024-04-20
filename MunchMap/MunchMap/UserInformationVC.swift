//
//  UserInformationVC.swift
//  MunchMap
//
//  Created by Tarun Yada  on 3/28/24.
//

import UIKit
import SVProgressHUD
import AudioToolbox

class UserInformationVC: UIViewController, UITextFieldDelegate,UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var AgeTF: UITextField!
    @IBOutlet weak var HeightTF: UITextField!
    
    @IBOutlet weak var WeightTF: UITextField!
    
    @IBOutlet weak var genderPV: UIPickerView!
    
    
    let genderArray = ["","Male", "Female", "Other"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AgeTF.delegate = self
        HeightTF.delegate = self
        WeightTF.delegate = self
        
        
        AgeTF.keyboardType = .numberPad
        HeightTF.keyboardType = .numberPad
        WeightTF.keyboardType = .numberPad
        genderPV.delegate = self
        genderPV.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderArray[row]
    }
    
    
    @IBAction func submitBTN(_ sender: UIButton) {
        AudioServicesPlaySystemSound(1306)
        guard let age = AgeTF.text, !age.isEmpty,
              let height = HeightTF.text, !height.isEmpty,
              let weight = WeightTF.text, !weight.isEmpty else {
            // If any of the fields are empty, display an alert or handle it accordingly
            let alertController = UIAlertController(title: "Error", message: "Please fill in all fields", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            //return performSegue(withIdentifier: "logintouserinfo", sender: self)
            return
        }
        
        let index = genderPV.selectedRow(inComponent: 0)
        let gender = genderArray[index]
        
        SVProgressHUD.show()
        DBManager.shared.saveUserData(gender: gender, age: age, height: height, weight: weight) { error, success in
            
            SVProgressHUD.dismiss()
            if success {
                
                let alertController = UIAlertController(title: "Alert", message: "Data saved successfully", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                    
                    self.performSegue(withIdentifier: "infoToHome", sender: self)
                })
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
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
