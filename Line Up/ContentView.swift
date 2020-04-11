//
//  ContentView.swift
//  Line Up
//
//  Created by Sreenikhil Kollu on 2/18/20.
//  Copyright © 2020 Sreenikhil Kollu. All rights reserved.
//  Properly able to speak to firebase by March 1st 12:18 PM
//  Softcoding is our next target

//
import SwiftUI
import FirebaseFirestore
let db = Firestore.firestore()
struct ContentView: View {
    var body: some View {
             VStack {
                        Button(action: {
                                getAllDocuments(collection: "List")
                            }){
                                Text("Get all Lists")
                        }.font(.largeTitle)
                            .padding(10.0)
                        
                        Button(action: {
                                createDocument()
                                }){
                                Text("Create Documents")
                                }.font(.largeTitle)
                    
                          .padding(10.0)
                        
                        Button(action: {
                            deletingDocument(collection: "List")
                                    }){
                       Text("Deleting Documents")
                        }.font(.largeTitle)
                        
                          .padding(10.0)
                        
                        Button(action:{
                            updateDocument(collection: "List", listname: "MyList 1", taskname: "Go to movie")
                        }){
                            Text("Updating documents")
                        }.font(.largeTitle)
                        
                        .padding(10.0)
                        
                    }
                        }
                    }

            // Function to print all documents to the console.
                    private func getAllDocuments(collection: String){
                        print("I am in get all documents list")
                      db.collection(collection).getDocuments(){
                          (QuerySnapshot, err) in
                          if let err = err{
                              print("Error getting in documents: \(err)")
                          }else{
                              for document in QuerySnapshot!.documents{
                                  print("\(document.documentID) => \(document.data())")
                              }
                          }
                          
                      }
                  }

            // Function to add a document to the collection

            private func createDocument(){
                let dbreference = db.collection("List")
                
                var dateComponents = DateComponents()
                dateComponents.year = 2020
                dateComponents.month = 3
                dateComponents.day = 4
                dateComponents.timeZone = TimeZone(abbreviation: "EST")
                dateComponents.hour = 6
                dateComponents.minute = 30
                
                let userCalendar = Calendar.current
                let someDateTime = userCalendar.date(from: dateComponents)
                
                dbreference.document().setData([
                    "list_Name": "MyList 1",
                    "array_Tasks": [["Completed": 0,
                                      "set_Remainder": 0,
                                      "task_Name": "Sing a song",
                                      "due_Date": someDateTime!],
                            ["Completed": 0,
                                  "set_Remainder": 0,
                                  "task_Name": "Go to IOS Class",
                                  "due_Date":  someDateTime!
                        ]]
                ])
            }

            // Function to drop a collection

            private func deletingDocument(collection: String){
                db.collection(collection).getDocuments(){
                    (querySnapshot, err) in
                    if let err = err{
                        print("Error in fetching documents: \(err)")
                    }
                    else{
                        for document in querySnapshot!.documents{
                            print("Deleting documents \(document.documentID) => \(document.data())")
                             document.reference.delete()
                        }
                    }
                }
            }

            // Function to update data

            private func updateDocument(collection: String, listname: String, taskname: String){
                var dateComponentsOne = DateComponents()
                dateComponentsOne.year = 2020
                dateComponentsOne.month = 3
                dateComponentsOne.day = 4
                dateComponentsOne.timeZone = TimeZone(abbreviation: "EST")
                dateComponentsOne.hour = 10
                dateComponentsOne.minute = 30
                
                let userCalendar = Calendar.current
                let someDateTime = userCalendar.date(from: dateComponentsOne)
                
                 db.collection(collection).document("MyList 1").setData([
                      "list_Name": "MyList 1",
                          "array_Tasks": [["Completed": 0,
                                            "set_Remainder": 0,
                                            "task_Name": "Dance to a tune",
                                            "due_Date": someDateTime!],
                                  ["Completed": 0,
                                        "set_Remainder": 0,
                                        "ta nsk_Name": "Go to new movie",
                                        "due_Date": someDateTime!
                              ]]
                ])
                {
                    err in
                    if let err = err{
                        print("Error writing document: \(err)")
                    }
                    else{
                        print("Document written successfully")
                    }
                }
            }

            // Sample code to fetch all tasks in a list

            private func getallTasks(){
                db.collection("List").whereField("list_Name", isEqualTo: "MyList 1").getDocuments{
                    (snapshot, err) in
                    if let err = err{
                        print("Could not find required document \(err)")
                    }
                    
                }
            }

  
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
