//
//  calorieProgressVC.swift
//  MunchMap
//
//  Created by Srinivas Mane on 27/03/24.
//

import UIKit
import FirebaseAuth
import SVProgressHUD

class calorieProgressVC: UIViewController, selectDishDelegate, caloriesDelegate{
    func didUpdated() {
        FireStoreOperations.fetchUserData { _ in
            self.setData()
        }
    }
    func didDishSelected(dish: String) {
        
        self.fetchData(foodName: dish)
    }
    @IBOutlet weak var nameLBL: UILabel!
    @IBOutlet weak var EatenPV: UIProgressView!
    @IBOutlet weak var eatenLBL: UILabel!
    @IBOutlet weak var RemainingPV: UIProgressView!
    @IBOutlet weak var remainingLBL: UILabel!
    @IBOutlet weak var FatPV: UIProgressView!
    @IBOutlet weak var fatLBL: UILabel!
    @IBOutlet weak var CarbsPV: UIProgressView!
    @IBOutlet weak var carbsLBL: UILabel!
    @IBOutlet weak var ProtienPV: UIProgressView!
    @IBOutlet weak var proteinLBL: UILabel!
    
    var buttonTag = -1
    
    var apikey = "Kk6twQpaFLmSNaRYvtsJPkE3NtNz3lYap4AEnSrA"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLBL.text = "Hi, \(Auth.auth().currentUser?.displayName ?? "")"
        // Do any additional setup after loading the view.
        
        if FireStoreOperations.UserData == nil {
            
            FireStoreOperations.fetchUserData { _ in
                
                
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getDailyData()
    }
    
    @IBAction func profile(_ sender: UIButton) {
        self.performSegue(withIdentifier: "profile", sender: self)
    }
    
    func getDailyData() -> Void {
        
        SVProgressHUD.show()
        FireStoreOperations.fetchUserDailyInfo { resp in
            
            if resp == nil {
                
                DBManager.shared.createDailyInfo { _, success in
                    
                    SVProgressHUD.dismiss()
                    if success {
                        
                        FireStoreOperations.fetchUserDailyInfo { resp in
                            
                            self.setData()
                        }
                    }
                }
            }else {
                
                SVProgressHUD.dismiss()
                self.setData()
            }
        }
    }
    
    
    func setData() -> Void {
        
        let userData = FireStoreOperations.UserData
        let total = userData?.calories as? Double ?? 0
        
        let dailyInfo = FireStoreOperations.UserDailyInfo
        let eaten = dailyInfo?.calories_eaten as? Double ?? 0
        eatenLBL.text = String(format: "%0.0f / %0.0f", eaten, total)
        let remaning = total - eaten
        remainingLBL.text = String(format: "%0.0f / %0.0f", remaning, total)
        
        EatenPV.progress = Float(eaten / total)
        RemainingPV.progress = Float(remaning / total)
        
        FatPV.progress = Float(dailyInfo?.fat as? Double ?? 0) / 100
        fatLBL.text = String(format: "%0.0f / 100", Float(dailyInfo?.fat as? Double ?? 0))
        
        
        ProtienPV.progress = Float(dailyInfo?.protein as? Double ?? 0) / 100
        proteinLBL.text = String(format: "%0.0f / 100", Float(dailyInfo?.protein as? Double ?? 0))
        
        
        CarbsPV.progress = Float(dailyInfo?.carb as? Double ?? 0) / 100
        carbsLBL.text = String(format: "%0.0f / 100", Float(dailyInfo?.carb as? Double ?? 0))
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "homeToDish" {
            
            let navVC = segue.destination as! UINavigationController
            let vc = navVC.topViewController as! BreakfastVC
                vc.delegate = self
            vc.selectedButton = buttonTag
        }else if segue.identifier == "profile" {
            
            let vc = segue.destination as! ProfileVC
            vc.delegate = self
        }
    }
    
    @IBAction func add(_ sender: UIButton) {
        buttonTag = sender.tag
        self.performSegue(withIdentifier: "homeToDish", sender: self)
    }
    
    func fetchData(foodName: String) {
        // Construct the URL for the API request
        let baseURL = "https://api.nal.usda.gov/fdc/v1/foods/search"
        let query = foodName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let urlString = "\(baseURL)?query=\(query)&api_key=\(apikey)"
        
        SVProgressHUD.show()
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            
            SVProgressHUD.dismiss()
            return
        }
        
        // Create a URLSession data task to fetch the data
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                
                SVProgressHUD.dismiss()
                return
            }
            
            do {
                // Parse the JSON response
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let foods = json?["foods"] as? [[String: Any]], let firstFood = foods.first {
                    let foodDescription = firstFood["description"] as? String ?? "Unknown"
                    let nutrients = firstFood["foodNutrients"] as? [[String: Any]] ?? []
                    var calories: Double = 0
                    var fat: Double = 0
                    var protein: Double = 0
                    var carbs: Double = 0
                    for nutrient in nutrients {
                        if let nutrientName = nutrient["nutrientName"] as? String {
                            switch nutrientName {
                            case "Energy":
                                calories = nutrient["value"] as? Double ?? 0
                            case "Total lipid (fat)":
                                fat = nutrient["value"] as? Double ?? 0
                            case "Protein":
                                protein = nutrient["value"] as? Double ?? 0
                            case "Carbohydrate, by difference":
                                carbs = nutrient["value"] as? Double ?? 0
                            default:
                                break
                            }
                        }
                    }
                    print("Food: \(foodDescription)")
                    print("Calories: \(calories)")
                    print("Fat: \(fat)")
                    print("Protein: \(protein)")
                    print("Carbs: \(carbs)")
                    
                    self.updateDailyData(cal: calories, fat: fat, carb: carbs, protein: protein)
                    
                } else {
                    
                    SVProgressHUD.dismiss()
                    print("No food data found")
                }
            } catch {
                
                SVProgressHUD.dismiss()
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        }
        
        // Start the data task
        task.resume()
    }
    
    
    func updateDailyData(cal: Double, fat: Double, carb: Double, protein: Double) -> Void {
        
        let daily = FireStoreOperations.UserDailyInfo
        
        let a = Double(daily?.calories_eaten ?? 0) + cal
        let b = Double(daily?.fat ?? 0) + fat
        let c = Double(daily?.carb ?? 0) + carb
        let d = Double(daily?.protein ?? 0) + protein
        
        let params = ["calories_eaten": a,
                      "fat": b,
                      "carb": c,
                      "protein": d]
        
        let id = FireStoreOperations.UserDailyInfo?.id ?? ""
        DBManager.shared.updateDailyInfo(id: id, params: params) { _, success in
            
            SVProgressHUD.dismiss()
            if success {
                
                self.showAlert(str: "daily info updated")
                self.getDailyData()
            }
        }
    }
    
    
    func showAlert(str: String) -> Void {
        
        let alert = UIAlertController(title: "Added Successfully", message: str, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func ResetBTN(_ sender: UIButton) {
        let params = ["calories_eaten": 0,
                      "fat": 0,
                      "carb": 0,
                      "protein": 0]
        
        let id = FireStoreOperations.UserDailyInfo?.id ?? ""
        DBManager.shared.updateDailyInfo(id: id, params: params) { _, success in
            SVProgressHUD.dismiss()
            if success {
                // Removed showAlert method call
                self.getDailyData() // Refresh data after reset
            }
        }
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
