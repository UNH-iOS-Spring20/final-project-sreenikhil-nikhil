//
//  Tasks.swift
//  Line Up
//
//  Created by Sreenikhil Kollu on 2/18/20.
//  Copyright © 2020 Sreenikhil Kollu. All rights reserved.
//

class Task{
    var task_Name : String                                   // Name of the task
    var due_Date:   String                            // Due date of the task
    var completed: Bool         // To check if a task is marked completed or not
    var Remainder: Bool                   // To check if remainder is set or not
    
    init?(task_Name: String, due_Date: String, completed: Bool, Remainder: Bool){
        if task_Name.isEmpty || due_Date.isEmpty  {
            return nil
        }
        self.task_Name = task_Name;
        self.due_Date = due_Date;
        self.completed = completed;
        self.Remainder = Remainder;
    }
}
