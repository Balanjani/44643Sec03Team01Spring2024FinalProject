//
//  DBManager.swift
//  MunchMap
//
//  Created by dinesh domara on 12/04/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class DBManager {
    
    static let shared = DBManager()
    private init() {}
    
    func createUser(name: String, email: String, password: String, completion: @escaping (Error?, Bool) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password)  { authResult, error in
            
            let profile = authResult?.user.createProfileChangeRequest()
            profile?.displayName = name
            profile?.commitChanges(completion: { error in
                if error != nil {
                    
                    completion(error, false)
                }else{
                    
                    completion(nil, true)
                }
            })
        }
    }
    
    func saveUserData(gender: String, age: String, height: String, weight: String, completion: @escaping (Error?, Bool) -> ()) {
        
        let id = Auth.auth().currentUser?.uid ?? ""
        let name = Auth.auth().currentUser?.displayName ?? ""
        let email = Auth.auth().currentUser?.email ?? ""
        
        let params = ["id": id,
                      "name": name,
                      "email": email,
                      "gender": gender,
                      "age": age,
                      "height": height,
                      "weight": weight,
                      "calories": 100.0] as [String : Any]
        

        let path = String(format: "%@", "Users")
        let db = Firestore.firestore()
        
        db.collection(path).document(id).setData(params) { err in
            if let err = err {

                completion(err, false)
            } else {

                completion(nil, true)
            }
        }
    }
    
    
    func signIn(email: String, password: String, completion: @escaping (Error?, Bool) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            
            if error != nil {
                
                completion(error, false)
            }else{
                
                completion(nil, true)
            }
        }
    }
    
    func createDailyInfo(completion: @escaping (Error?, Bool) -> ()) {
        
        let id = Auth.auth().currentUser?.uid ?? ""
        let dtFormatter = DateFormatter()
        dtFormatter.dateFormat = "dd/MM/yyyy"
        let date_str = dtFormatter.string(from: Date())
        
        let params = ["user_id": id,
                      "date": date_str,
                      "calories_eaten": 0,
                      "fat": 0,
                      "carb": 0,
                      "protein": 0] as [String : Any]
        

        let path = String(format: "%@", "DailyInfo")
        let db = Firestore.firestore()
        
        db.collection(path).document().setData(params) { err in
            if let err = err {

                completion(err, false)
            } else {

                completion(nil, true)
            }
        }
    }
    
    
    func updateDailyInfo(id: String, params: [String: Any], completion: @escaping (Error?, Bool) -> ()) {

        let path = String(format: "%@", "DailyInfo")
        let db = Firestore.firestore()
        
        db.collection(path).document(id).updateData(params) { err in
            if let err = err {
                
                completion(err, false)
            } else {

                completion(nil, true)
            }
        }
    }
    
}
