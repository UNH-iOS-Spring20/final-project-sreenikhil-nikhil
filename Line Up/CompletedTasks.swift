//
//  CompletedTasks.swift
//  Line Up
//
//  Created by Sreenikhil Kollu on 5/3/20.
//  Copyright © 2020 Sreenikhil Kollu. All rights reserved.
//

import SwiftUI
import FirebaseFirestore

let newtaskCollectionRef3 = Firestore.firestore().collection("NewList")

struct CompletedTasks: View {
    @ObservedObject private var tasks =
           FirebaseCollection<Tasks>(collectionRef: newtaskCollectionRef3)
      @EnvironmentObject var session: SessionClass
    
    var body: some View {
        var list: [Tasks] = []
               for items in tasks.items{
                if(items.ssid == session.email && items.completed){
                       list.append(items)
                   }
               }
         return(
                       
               VStack{
                   Text("Completed Tasks").padding(EdgeInsets(top: 120, leading: 0, bottom: 0, trailing: 0))
                               List {
                                   ForEach(list){
                                      items in
                                    Text(items.task_Name).padding(10)
                                     .background(Color.gray)
                                     .cornerRadius(4.0)
                                          
                                   
                                           
                           }
                                   
                       }.padding(EdgeInsets(top: 80, leading: 30, bottom: 0, trailing: 0))
                  
                                                      
                                  
                       
                           
                       }
    )
}
}

struct CompletedTasks_Previews: PreviewProvider {
    static var previews: some View {
        CompletedTasks()
    }
}
