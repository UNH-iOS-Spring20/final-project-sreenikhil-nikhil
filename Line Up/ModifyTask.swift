//
//  ModifyTask.swift
//  Line Up
//
//  Created by Sreenikhil Kollu on 4/12/20.
//  Copyright © 2020 Sreenikhil Kollu. All rights reserved.
//

import SwiftUI
import FirebaseFirestore


let taskCollectionRef1 = Firestore.firestore().collection("NewList")

struct ModifyTask: View {
    @State private var Completion_Date = Date()
    @State private var Notification_on = false
    @State private var SetValue = false
    @State private var isCompleted = false
    @State var jobId = ""
    @ObservedObject var task:Tasks
    @State var TName = ""
    @State var Notes = ""
    @ObservedObject private var tasklist =
           FirebaseCollection<Tasks>(collectionRef: taskCollectionRef1)
    @EnvironmentObject var session: SessionClass
       @ObservedObject var notificationManager = LocalNotificationManager()
    @EnvironmentObject var msgobj: Message
     

    var body: some View {
        VStack{
            Text("Modify Task").padding(10)
            Form{
        DatePicker("Completion_Date", selection: $Completion_Date)
            
            Toggle(isOn: $Notification_on) {
               Text("Enable Notification")
            }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 60))
                
            Button(action: {
                self.isCompleted.toggle()
                               }) {
                                HStack{
                                    Text("Mark Completed").foregroundColor(Color.black)
                                if self.isCompleted {
                                       Image(systemName: "star.fill")
                                           .foregroundColor(Color.yellow)
                                          .padding(EdgeInsets(top: 0, leading: 150, bottom: 0, trailing: 0))
                                   } else {
                                       Image(systemName: "star")
                                           .foregroundColor(Color.gray)
                                .padding(EdgeInsets(top: 0, leading: 150, bottom: 0, trailing: 0))
                                   }
                               }
                  }
                
                 HStack{
                                   Text("Task Name")
                                 TextField("Task Name", text: $TName).padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                                                      
                                                          .cornerRadius(5.0)
                                                          .padding()
                                                          .frame(width:250)
                                                          .autocapitalization(.none)
                               }
                                            
                               HStack{
                                     Text("Notes")
                                            TextField("Notes", text: $Notes).padding(EdgeInsets(top: 0, leading: 60, bottom: 0, trailing: 0))
                                                       
                                                          .cornerRadius(5.0)
                                                          .padding()
                                                          .frame(width:250)
                                                          .autocapitalization(.none)
                                                    
                               }
                Button(action: notify){
                            HStack(alignment: .center){
                                                    Spacer()
                                           Text("Update Task").foregroundColor(Color.white).bold()
                                                    
                                                    Spacer()
                                }.padding(12).background(Color.green).cornerRadius(4.0).frame(width: 150)
                     .padding(EdgeInsets(top: 0, leading: 110, bottom: 0, trailing: 0))
                        }
            }
           
            
            
            
            Spacer()
            Text("I will do it: \(task.task_Name)")
        }
        
    }
    
    func notify(){
        
        print("I will print all the details that are to be updates:")
        print("I will be notified")
        print("Completion date is: \($Completion_Date.wrappedValue)")
     
       /* print("New Date is: \(UTCToLocal(currentDate:($Completion_Date.wrappedValue)))")*/
        print("Notification on: \($Notification_on.wrappedValue)")
        print("Is completed: \($isCompleted.wrappedValue)")
        print("Task Name is \(TName)")
        print("Notes is: \(Notes)")
        
        if(TName == ""){
            TName = task.task_Name
        }
        if(Notes == ""){
            Notes = task.Notes
        }
    
    
        for job in tasklist.items{
            print(job.task_Name)
            if(job.task_Name == task.task_Name){
                print(job.id)
                jobId = job.id
            }
        }
        
            
        
        print("The job id is: \(jobId)")
        let newref = Firestore.firestore().collection("NewList").document(jobId)
        
        
        newref.updateData(["due_Date":$Completion_Date.wrappedValue
            , "Remainder": $Notification_on.wrappedValue, "completed":$isCompleted.wrappedValue,
              "task_Name": TName,
              "Notes": Notes]){ err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        
        
    }
    
     func setNotifications(){
        // The best thing would be to set notifications on log out
            // I will look for tasks which have notifications
            // Code to load all the tasks
        print("I will print all scheduled tasks")
           for q in msgobj.msg{
             print(q)
        }
                
            for item in tasklist.items{
                if(session.email == item.ssid && item.Remainder){
              
                 let epochTime = item.due_Date
                 //let timezoneOffset =  TimeZone.current.secondsFromGMT()
                 // let newepoch = Int(epochTime.seconds) + Int(timezoneOffset)
         
                 //var newTime = Date(timeIntervalSince1970:TimeInterval(newepoch))
                 let newTime1 = Date(timeIntervalSince1970:TimeInterval(epochTime.seconds))
                 
                //let date = Date(timeIntervalSinceNow: 60)
                 
                let p = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,], from: newTime1)
                    
                            msgobj.msg.append(item.task_Name)
                        self.notificationManager.sendNotification(title: "Hurray!", subtitle: nil, body: "You have to finish \(item.task_Name)", triggerDate: p)
                        print("*********  I am called now ********")
                    
                 
                }
            }
        }
    
     
     func UTCToLocal(currentDate:Date) -> String {
         let dateFormatter = DateFormatter()
         dateFormatter.timeZone = .current
         dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss +0000"
         let localDate = dateFormatter.string(from: currentDate)
         print("The local date is: \(localDate)")
         let date_converted_date = dateFormatter.date(from: localDate)
         print("Date converted date is: \(date_converted_date!)")
         return localDate
     }

    
    
    // Function to convert date from UTC to Newyork timings
    // Source: Stack Overflow: https://stackoverflow.com/questions/42803349/swift-3-0-convert-server-utc-time-to-local-time-and-vice-versa
    
   /* func UTCToLocal(currentDate:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateString =  dateFormatter.string(from: currentDate)
        return dateString
    }*/
}

struct ModifyTask_Previews: PreviewProvider {
    static var previews: some View {
        ModifyTask(task: Tasks.example)
        
    }
}

// task_Name
// due_Date
// completed
//  Remainder
//  Notes


// Write logic in such a way that if only he/she makes any changes update only them
