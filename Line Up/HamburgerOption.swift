//
//  HamburgerOption.swift
//  Line Up
//
//  Created by Sreenikhil Kollu on 4/9/20.
//  Copyright © 2020 Sreenikhil Kollu. All rights reserved.
//

import SwiftUI
import GoogleSignIn
import FirebaseFirestore
import Firebase

let newtaskCollectionRef2 = Firestore.firestore().collection("NewList")

struct HamburgerOption: View {
     @EnvironmentObject var viewRouter: ViewRouter
    @State var showMenu: Bool = false
       @EnvironmentObject var session: SessionClass
    @ObservedObject private var tasks =
          FirebaseCollection<Tasks>(collectionRef: newtaskCollectionRef2)
       @ObservedObject var notificationManager = LocalNotificationManager()
    @EnvironmentObject var msgobj: Message
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
                
               MenuView().frame(width: geometry.size.width/2)
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
            
             // Logout
            Button(action: {
                self.setNotifications()
                
                try! Auth.auth().signOut()
                GIDSignIn.sharedInstance()?.signOut()
                UserDefaults.standard.set(false, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
               
                self.viewRouter.currentPage = "page1"
              
               
            }) {
                Text("Logout")
            }
        
        
            )
            
        }
    }
    func setNotifications(){
        for item in tasks.items{
            if(session.email == item.ssid && item.Remainder){
             let epochTime = item.due_Date
             let newTime1 = Date(timeIntervalSince1970:TimeInterval(epochTime.seconds))
             
            let p = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,], from: newTime1)
                print("Notification is set at \(p)")
                    self.notificationManager.sendNotification(title: "Hurray!", subtitle: nil, body: "You have to finish \(item.task_Name)", triggerDate: p)
                    print("*********  I am called now ********")
            }
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
        HamburgerOption().environmentObject(ViewRouter())
    }
}
