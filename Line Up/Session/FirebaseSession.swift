//
//  FirebaseSession.swift
//  Line Up
//
//  Created by Sreenikhil Kollu on 4/5/20.
//  Copyright © 2020 Sreenikhil Kollu. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

let firebaseSession = FirebaseSession() // Singleton

class FirebaseSession: ObservableObject{
    @Published var completeusers = [User]()
    
    let db = Firestore.firestore()
    init(){
        performLogin()
    }
    func performLogin(){
        db.collection("User").addSnapshotListener{ QuerySnapshot, error in
            guard let snapshot  = QuerySnapshot else{
               print("Error in fetching snapshot \(error!)")
                return
            }
            snapshot.documentChanges.forEach{ diff in
                if(diff.type == .added){
                    print("New User added: \(diff.document.data())")
                    let k = User( firstname: diff.document.get("firstname") as! String,
                                  lastname: diff.document.get("lastname") as! String,
                                  email: diff.document.get("email") as! String,
                                  password: diff.document.get("password") as! String)
                    self.completeusers.append(k!)
                }
                
            }
        }
         }
    
}
