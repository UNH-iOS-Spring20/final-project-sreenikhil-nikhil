//
//  MotherView.swift
//  Line Up
//
//  Created by Sreenikhil Kollu on 3/26/20.
//  Copyright © 2020 Sreenikhil Kollu. All rights reserved.
//

import SwiftUI

struct MotherView: View {
  // @ObservedObject var viewRouter: ViewRouter    // The classic conceot of binding
    @EnvironmentObject var viewRouter: ViewRouter
       
       var body: some View {
           VStack{
           if  viewRouter.currentPage == "page1"{
            Login()
                 }
                 else if viewRouter.currentPage == "page2"{
                  Signup()
                 }
                 else if viewRouter.currentPage == "page3"{
                  HamburgerOption()
                }
                 else if(viewRouter.currentPage == "page5"){
                   NewTask()
              }
              else if(viewRouter.currentPage == "page6"){
                  ModifyTask(task: Tasks.example)
            }
            
        }
       }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView().environmentObject(ViewRouter())
    }
}
