//
//  Tasks.swift
//  Line Up
//
//  Created by Sreenikhil Kollu on 2/18/20.
//  Copyright © 2020 Sreenikhil Kollu. All rights reserved.
//
import FirebaseFirestore

class Tasks: FirebaseCodable{
    var id: String
   @Published var task_Name : String                                   // Name of the task
   @Published   var due_Date :  String                           // Due date of the task
    @Published  var completed: Bool         // To check if a task is marked completed or not
    @Published  var Remainder: Bool         // To check if remainder is set or not
     @Published var Notes: String
    
    var data: [String: Any]{
        return[
            "task_Name": task_Name,
            "due_Date": due_Date,
             "completed" :  completed,
             "Remainder" : Remainder,
             "Notes" :  Notes,
        ]
    }
    required init?(id: String, data: [String: Any]){
             guard let task_Name = data["task_Name"] as? String,
              let due_Date = data["due_Date"] as? String,
              let completed = data["completed"] as? Bool,
              let Remainder = data["Remainder"] as? Bool,
              let Notes = data["Notes"] as? String
                else{
                   return nil
               }
        self.id = id
        self.task_Name = task_Name
        self.due_Date = due_Date
        self.completed = completed
        self.Remainder = Remainder
        self.Notes =  Notes
                  
          }
}
    
    
