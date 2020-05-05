//
//  ViewTasks.swift
//  Line Up
//
//  Created by Sreenikhil Kollu on 4/10/20.
//  Copyright © 2020 Sreenikhil Kollu. All rights reserved.
//

import SwiftUI
import FirebaseFirestore

let newtaskCollectionRef = Firestore.firestore().collection("NewList")



struct ViewTasks: View {
    
   @ObservedObject private var tasks =
        FirebaseCollection<Tasks>(collectionRef: newtaskCollectionRef)
      @EnvironmentObject var viewRouter: ViewRouter
        @EnvironmentObject var session: SessionClass
      @ObservedObject var notificationManager = LocalNotificationManager()
    
    var body: some View {
        var list: [Tasks] = []
        for items in tasks.items{
            if(items.ssid == session.email){
                list.append(items)
            }
        }
        
        
        return(
        VStack{
                List {
                    ForEach(list){
                        task in
                        NavigationLink(destination:DetailedTask(task: task))
                        {
                         Text(task.task_Name)
                        }.padding(10)
                      .background(Color.gray)
                      .cornerRadius(4.0)
                      .frame(width: 300)
                            
                
                        
                      
            }.onDelete(perform : deleteTask)
                    
        }.padding(EdgeInsets(top: 80, leading: 30, bottom: 0, trailing: 0))
       
            
        }
        )
    }
    func setNotifications(){
           // I will look for tasks which have notifications
           // Code to load all the tasks
          print("I am in notifications option")
           for item in tasks.items{
            if(session.email == item.ssid && item.Remainder){
               print(item.task_Name)
               print(item.Remainder)
               print(item.due_Date)
                let epochTime = item.due_Date
                let timezoneOffset =  TimeZone.current.secondsFromGMT()
                let newepoch = Int(epochTime.seconds) + Int(timezoneOffset)
                print(newepoch)
                let newTime = Date(timeIntervalSince1970:TimeInterval(newepoch))
                let newTime1 = Date(timeIntervalSince1970:TimeInterval(epochTime.seconds))
                 print("The new time is: \(newTime)")
                 print("The new time1 is: \(newTime1)")
                
               //let date = Date(timeIntervalSinceNow: 60)
                
               let p = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,], from: newTime1)
                
                print("The time at which I will pop the notification is: \(p)")
               print("Notification set at: \(newTime)")
               print("Notification is set at: \(newTime1)")
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
    
    
    func deleteTask(at offsets: IndexSet){
        print("I will delete this task")
        let index = offsets.first!
     let id = tasks.items[index].id
        print(id)
        newtaskCollectionRef.document(id).delete(){
            error in
            if let error = error {
                print("Error removing document: \(error)")
            } else {
                print("Document successfully removed")
            }
        }
    }
}





struct ViewTasks_Previews: PreviewProvider {
    static var previews: some View {
        ViewTasks().environmentObject(ViewRouter())
    }
}

/*
 .contextMenu{
 NavigationLink(destination: ModifyTask(task: task)){
     Text("Edit Task")
 }
     }
 */
