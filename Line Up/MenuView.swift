//
//  MenuView.swift
//  Line Up
//
//  Created by Sreenikhil Kollu on 4/9/20.
//  Copyright © 2020 Sreenikhil Kollu. All rights reserved.
//

import SwiftUI

struct MenuView: View {
     @ObservedObject var viewRouter: ViewRouter
    var body: some View {
        VStack(alignment: .leading){
            
            NavigationLink(destination: NewTask(viewRouter: ViewRouter())) {
               Text("Add Task")
                .foregroundColor(.gray)
                .font(.headline)
                .padding(.top, 100)
            }
            
            
            Text("Edit Task")
            .foregroundColor(.gray)
            .font(.headline)
             .padding(.top, 30)
            
            Text("Delete Task")
            .foregroundColor(.gray)
            .font(.headline)
            .padding(.top, 30)
            
            NavigationLink(destination: ViewTasks(viewRouter: ViewRouter())) {
            Text("View Task")
            .foregroundColor(.gray)
            .font(.headline)
            .padding(.top, 30)
            }
            
            Spacer() //Adding spacer moved eveything up
        }.padding()
        .frame(maxWidth: .infinity, alignment: .leading)
             .background(Color(red: 32/255, green: 32/255, blue: 32/255))
           .edgesIgnoringSafeArea(.all)
    }
    func addTask(){
        print("I will add a task")
        
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(viewRouter: ViewRouter())
    }
}
