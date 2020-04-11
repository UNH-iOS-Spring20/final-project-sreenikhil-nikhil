//
//  NewTask.swift
//  Line Up
//
//  Created by Sreenikhil Kollu on 4/10/20.
//  Copyright © 2020 Sreenikhil Kollu. All rights reserved.
//


import SwiftUI
import FirebaseFirestore

let taskCollectionRef = Firestore.firestore().collection("NewList")

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
struct NewTask: View {
    @ObservedObject var viewRouter: ViewRouter
     @State var TName = ""
     @State var Notes = ""
  
    
 
    var body: some View {
        VStack{
            Text("Adding a new Task").padding(EdgeInsets(top:200, leading: 0, bottom: 0, trailing: 0))
            
            TextField("Task Name", text: $TName).padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding()
                .frame(width:400)
                .autocapitalization(.none)
            
            TextField("Notes", text: $Notes).padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding()
            .frame(width:400)
            .autocapitalization(.none)
            
            Button(action: addTask){
                HStack(alignment: .center){
                                        Spacer()
                               Text("Submit Task").foregroundColor(Color.white).bold()
                                        
                                        Spacer()
                                    }.padding(12).background(Color.green).cornerRadius(4.0).frame(width: 150)
            }
                
            Spacer()
            
        }
        
    }
    // All Items to add
    // task_Name, due_Date, completed, Remainder, Notes
    func addTask(){
        print("Adding Tasks")
        let date = "Default"
        if !TName.isEmpty && !Notes.isEmpty{
            let data = ["task_Name": TName, "due_Date": date, "completed": false, "Remainder": false, "Notes": Notes] as [String : Any]
            taskCollectionRef.addDocument(data: data)
        }
    }
}

struct NewTask_Previews: PreviewProvider {
    static var previews: some View {
        NewTask(viewRouter: ViewRouter())
    }
}
