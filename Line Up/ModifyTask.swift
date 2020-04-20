//
//  ModifyTask.swift
//  Line Up
//
//  Created by Sreenikhil Kollu on 4/12/20.
//  Copyright © 2020 Sreenikhil Kollu. All rights reserved.
//

import SwiftUI

struct ModifyTask: View {
    @State private var Completion_Date = Date()
    @State private var Notification_on = false
    @State private var SetValue = false
    @State private var isCompleted = false
    var body: some View {
        VStack{
        Text("Modify Task")
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
            }
            Spacer()
        }.onDisappear(perform:notify)
    }
    
    func notify(){
        print("I will print all the details that are to be updates:")
        print("I will be notified")
        print("Completion date is: \($Completion_Date.wrappedValue)")
        print("Notification on: \($Notification_on.wrappedValue)")
        print("Is completed: \($isCompleted.wrappedValue)")
    }
    
}

struct ModifyTask_Previews: PreviewProvider {
    static var previews: some View {
        ModifyTask()
    }
}
