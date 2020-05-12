//
//  DetailedTask.swift
//  Line Up
//
//  Created by Sreenikhil Kollu on 4/23/20.
//  Copyright © 2020 Sreenikhil Kollu. All rights reserved.
//

import SwiftUI
import FirebaseFirestore


let taskCollectionRef2 = Firestore.firestore().collection("NewList")

struct DetailedTask: View {
       @ObservedObject var task:Tasks
    @ObservedObject private var tasklist =
              FirebaseCollection<Tasks>(collectionRef: taskCollectionRef2)
    
   
    var body: some View {
        let epochTime = task.due_Date
        let newTime = Date(timeIntervalSince1970:TimeInterval(epochTime.seconds))
        print(newTime)
        func UTCToLocal(currentDate:Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = .current
            dateFormatter.dateFormat = "MM/dd/YYYY HH:mm"
            let dateString =  dateFormatter.string(from: currentDate)
            return dateString
        }
        let value = (UTCToLocal(currentDate: newTime))
        let split = value.components(separatedBy: " ")
        let date = split[0]
        let time = split[1]
       print("Time in Newyork Format is: \(UTCToLocal(currentDate: newTime))")
        
        
        
        
        return(
            ZStack{
                RoundedRectangle(cornerRadius: 25,
                                 style: .continuous)
                                 .fill(Color.white)
                                .shadow(radius: 10)
                
        VStack{
            Text("Task Name is:  \(task.task_Name)").padding(10)
            Text("Notes is: \(task.Notes)").padding(10)
            Text("Due_Date:  \(date)").padding(10)
              Text("Time:  \(time)").padding(10)
                Text("Completed is: \(String(task.completed))").padding(10)
                Text("Notification set is: \(String(task.Remainder))").padding(10)
        
                        NavigationLink(destination: ModifyTask(task: task)) {
                               Text("Edit Task")
                           }
               
                }.padding(20)
            
            .multilineTextAlignment(.center)
            }.frame(width: 350, height: 250)
        )
    }
   
}

struct DetailedTask_Previews: PreviewProvider {
    static var previews: some View {
    
      ModifyTask(task: Tasks(id:"1", data:["task_Name": "IOSClass",
                                                 "due_Date": Date(),
                                                 "completed": false,
                                                 "Remainder": false,
                                                 "Notes": "Take Notes with you"
                ])!
            )
    }
}
