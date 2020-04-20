//
//  HamburgerOption.swift
//  Line Up
//
//  Created by Sreenikhil Kollu on 4/9/20.
//  Copyright © 2020 Sreenikhil Kollu. All rights reserved.
//

import SwiftUI
import GoogleSignIn

struct HamburgerOption: View {
    @ObservedObject var viewRouter: ViewRouter
    @State var showMenu: Bool = false
    var body: some View {
        let drag = DragGesture()
                    .onEnded {
                        if $0.translation.width < -70 {
                            withAnimation {
                                self.showMenu = false
                            }
                        }
                    }
        return NavigationView{
          GeometryReader { geometry in
             ZStack(alignment: .leading){
            MainView(showMenu: self.$showMenu)
            .frame(width: geometry.size.width, height: geometry.size.height)
            .offset(x: self.showMenu ? geometry.size.width/2 : 0)
             .disabled(self.showMenu ? true : false)
            
            if self.showMenu{
                
               MenuView(viewRouter: ViewRouter()).frame(width: geometry.size.width/2)
                   .transition(.move(edge: .leading))
               
            }
                
            
            }.gesture(drag)
        }.navigationBarTitle("Welcome", displayMode: .inline)
          /*  .navigationBarItems(trailing:
                           Button(action: {
                               self.viewRouter.currentPage = "page1"
                           }) {
                               Text("Logout")
                           }
                       )*/
            
       .navigationBarItems(leading:
       
            Button(action: {
                withAnimation {
                    self.showMenu.toggle()
                }
            }) {
                Image(systemName: "line.horizontal.3")
                    .imageScale(.large)
            }
            , trailing:
            
            Button(action: {
                GIDSignIn.sharedInstance()?.signOut()
                self.viewRouter.currentPage = "page1"
            }) {
                Text("Logout")
            }
            )
            
           

            
            
    }
    }
        
}

struct MainView: View{
       @Binding var showMenu: Bool
    
    var body: some View{
        Button(action:{
            withAnimation{
            self.showMenu = true
            }
        }){
            Text("Show Menu")
        }
    }
}

struct HamburgerOption_Previews: PreviewProvider {
    static var previews: some View {
        HamburgerOption(viewRouter: ViewRouter())
    }
}
