//
//  Tasks.swift
//  Line Up
//
//  Created by Sreenikhil Kollu on 2/18/20.
//  Copyright © 2020 Sreenikhil Kollu. All rights reserved.
//
import FirebaseFirestore

class Tasks: FirebaseCodable {
    var id: String
   @Published var task_Name : String                                   // Name of the task
   @Published   var due_Date :  Timestamp                           // Due date of the task
    @Published  var completed: Bool         // To check if a task is marked completed or not
    @Published  var Remainder: Bool         // To check if remainder is set or not
     @Published var Notes: String
    @Published var ssid: String
    
    var data: [String: Any]{
        return[
            "task_Name": task_Name,
            "due_Date": due_Date,
             "completed" :  completed,
             "Remainder" : Remainder,
             "Notes" :  Notes,
             "ssid": ssid
        ]
    }
    required init?(id: String, data: [String: Any]){
             guard let task_Name = data["task_Name"] as? String,
              let due_Date = data["due_Date"] as? Timestamp,
              let completed = data["completed"] as? Bool,
              let Remainder = data["Remainder"] as? Bool,
              let Notes = data["Notes"] as? String,
              let ssid = data["ssid"] as? String
                else{
                   return nil
               }
        self.id = id
        self.task_Name = task_Name
        self.due_Date = due_Date
        self.completed = completed
        self.Remainder = Remainder
        self.Notes =  Notes
        self.ssid = ssid
          }
    
    #if DEBUG
      static let example = Tasks(id: "1", data:["task_Name": "IOSClass",
                                       "due_Date": Date(),
                                       "completed": false,
                                       "Remainder": false,
                                       "Notes": "Take Notes with you",
                                       "ssid": "sessions"
      ])!
    #endif
    
}
    
    
