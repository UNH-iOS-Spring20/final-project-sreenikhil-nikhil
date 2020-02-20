//
//  List.swift
//  Line Up
//
//  Created by Sreenikhil Kollu on 2/18/20.
//  Copyright © 2020 Sreenikhil Kollu. All rights reserved.
//

class List{
    var tasks = [Task]()
    func addTask(task: Task){
        tasks.append(task)
    }
    
    // To tell how many tasks in a list have remainder set to true
    func remaindeIsTrue() -> Double {
        var total: Double = 0.0
        for task in tasks{
            if task.Remainder == true{
                total = total + 1
            }
        }
        return total
    }
}
