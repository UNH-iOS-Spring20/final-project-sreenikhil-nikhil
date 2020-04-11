//
//  MotherView.swift
//  Line Up
//
//  Created by Sreenikhil Kollu on 3/26/20.
//  Copyright © 2020 Sreenikhil Kollu. All rights reserved.
//

import SwiftUI

struct MotherView: View {
   @ObservedObject var viewRouter: ViewRouter    // The classic conceot of binding
       
       var body: some View {
           VStack{
               if  viewRouter.currentPage == "page1"{
                Login(viewRouter: viewRouter, Cobject: Controller())
               }
               else if viewRouter.currentPage == "page2"{
                Signup(viewRouter: viewRouter, Cobject: Controller())
               }
               else if viewRouter.currentPage == "page3"{
                HamburgerOption(viewRouter: viewRouter)
              }
               else if(viewRouter.currentPage == "page5"){
                 NewTask(viewRouter: viewRouter)
            }
            
        }
       }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView(viewRouter: ViewRouter())
    }
}
