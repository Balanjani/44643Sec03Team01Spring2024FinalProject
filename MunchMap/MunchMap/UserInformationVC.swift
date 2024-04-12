    //
    //  UserInformationVC.swift
    //  MunchMap
    //
    //  Created by Tarun Yada  on 3/28/24.
    //

    import UIKit

class UserInformationVC: UIViewController, UITextFieldDelegate,UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var AgeTF: UITextField!
    @IBOutlet weak var HeightTF: UITextField!
    
    @IBOutlet weak var WeightTF: UITextField!
    
    @IBOutlet weak var genderPCK: UIPickerView!
    
    @IBOutlet weak var logoBTN: UIButton!
    
    let genders = ["","Male", "Female", "Other"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AgeTF.delegate = self
        HeightTF.delegate = self
        WeightTF.delegate = self
        
        
        AgeTF.keyboardType = .numberPad
        HeightTF.keyboardType = .numberPad
        WeightTF.keyboardType = .numberPad
        genderPCK.delegate = self
        genderPCK.dataSource = self
        genderPCK.selectRow(0, inComponent: 0, animated: false)
        
        // Do any additional setup after loading the view.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genders.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
            let title = genders[row]
            let attributedString = NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            return attributedString
        }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedGender = genders[row]
        print("Selected gender: \(selectedGender)")
    }
    
    
    @IBAction func submitBTN(_ sender: UIButton) {
        
        checkFieldsAndSegue()
    }
    
    func checkFieldsAndSegue() {
            if let ageText = AgeTF.text, let heightText = HeightTF.text,
               let weightText = WeightTF.text{
                if ageText == ""{
                    openAlert(title: "Alert", message: "Please enter Age", alertStyle: .alert, actionTitles: ["okay"], actionStyles: [.default], actions: [{_ in}])
                }else{
                    if heightText == ""{
                        openAlert(title: "Alert", message: "Please enter Height", alertStyle: .alert, actionTitles: ["okay"], actionStyles: [.default], actions: [{_ in}])
                    } else {
                        if weightText == ""{
                            openAlert(title: "Alert", message: "Please enter weight", alertStyle: .alert, actionTitles: ["okay"], actionStyles: [.default], actions: [{_ in}])
                        }
                    }
                }
            performSegue(withIdentifier: "userdatatocalorie", sender: self)
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
    
    

