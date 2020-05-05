//
//  FirebaseCollection.swift
//  Line Up
//
//  Created by Sreenikhil Kollu on 4/10/20.
//  Copyright © 2020 Sreenikhil Kollu. All rights reserved.
//


import FirebaseFirestore

protocol FirebaseCodable: Identifiable, ObservableObject {
    init?(id: String, data: [String: Any])
    
}

class FirebaseCollection<T: FirebaseCodable>: ObservableObject{
    @Published private(set) var items: [T]
    
    init(collectionRef: CollectionReference){
        self.items = []
        listenForChanges(collectionRef: collectionRef)
    }
    
    func listenForChanges(collectionRef: CollectionReference){
        collectionRef.addSnapshotListener{snapshot, error in
            guard let snapshot = snapshot else{
            print("Error fetching snapshot: \(error!)")
            return
        }
            let models = snapshot.documents.map{(document) -> T in
                if let model = T(id: document.documentID, data: document.data()){
                    return model
                }
                else{
                    fatalError("I am facing lot of problems"+"unable to initialize type \(T.self) with dictionary \(document.data())")
                }
                }
            self.items = models
    }
}
}
