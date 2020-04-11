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
      @ObservedObject var viewRouter: ViewRouter
   @ObservedObject private var tasks =
        FirebaseCollection<Tasks>(collectionRef: newtaskCollectionRef)
    
  
    var body: some View {
        VStack{
                List {
                    ForEach(tasks.items){
                        task in
                        Text(task.task_Name)
                        }.padding(10)
                    .background(Color.gray)
                      .cornerRadius(4.0).frame(width: 300)
                   
            }
        }.padding(EdgeInsets(top: 80, leading: 30, bottom: 0, trailing: 0))
           
        
        }
    }



struct ViewTasks_Previews: PreviewProvider {
    static var previews: some View {
        ViewTasks(viewRouter: ViewRouter())
    }
}
