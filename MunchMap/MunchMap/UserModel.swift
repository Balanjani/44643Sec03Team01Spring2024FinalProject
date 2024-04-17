//
//  UserModel.swift
//  MunchMap
//
//  Created by dinesh domara on 15/04/2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

struct UserModel: Codable {
    
    var id: String
    var name: String
    var email: String
    var gender: String
    var age: String
    var height: String
    var weight: String
    var calories: Double
}


struct DailyInfoModel: Codable {
    
    var id: String
    var user_id: String
    var calories_eaten: Double
    var fat: Double
    var carb: Double
    var protein: Double
}


struct FireStoreOperations{
    
    static var UserData: UserModel?
    static var UserDailyInfo: DailyInfoModel?
    
    
    static let db = Firestore.firestore()
    
    public static func fetchUserData(completion: @escaping (UserModel?) -> ()){
        
        
        let id = Auth.auth().currentUser?.uid ?? ""
        let docRef = db.collection("Users")
            .whereField("id", isEqualTo: id)
        
        docRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(nil)
            } else {
                
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    
                    let data = document.data()
                    let a = UserModel(id: document.documentID,
                                      name: data["name"] as? String ?? "",
                                      email: data["email"] as? String ?? "",
                                      gender: data["gender"] as? String ?? "",
                                      age: data["age"] as? String ?? "",
                                      height: data["height"] as? String ?? "",
                                      weight: data["weight"] as? String ?? "",
                                      calories: data["calories"] as? Double ?? 0.0)
                    
                    UserData = a
                    completion(a)
                }
            }
        }
    }
    
    public static func fetchUserDailyInfo(completion: @escaping (DailyInfoModel?) -> ()){
        
        let dtFormatter = DateFormatter()
        dtFormatter.dateFormat = "dd/MM/yyyy"
        let date_str = dtFormatter.string(from: Date())
        
        
        let id = Auth.auth().currentUser?.uid ?? ""
        let docRef = db.collection("DailyInfo")
            .whereField("user_id", isEqualTo: id)
            .whereField("date", isEqualTo: date_str)
        
        docRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(nil)
            } else {
                
                if querySnapshot?.documents.count == 0 {
                    
                    completion(nil)
                }
                
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    
                    let data = document.data()
                    let a = DailyInfoModel(id: document.documentID,
                                           user_id: data["user_id"] as? String ?? "",
                                           calories_eaten: data["calories_eaten"] as? Double ?? 0.0,
                                           fat: data["fat"] as? Double ?? 0.0,
                                           carb: data["carb"] as? Double ?? 0.0,
                                           protein: data["protein"] as? Double ?? 0.0
                    )
                    
                    UserDailyInfo = a
                    completion(a)
                }
            }
        }
    }
    
}
