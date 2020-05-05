//
//  NotificationButton.swift
//  Line Up
//
//  Created by Sreenikhil Kollu on 4/24/20.
//  Copyright © 2020 Sreenikhil Kollu. All rights reserved.
//

import SwiftUI

struct NotificationButton: View {
    @ObservedObject var notificationManager = LocalNotificationManager()
       
       @State var showFootnote = false
       
    var body: some View {
         NavigationView {
                  VStack {
                      Button(action: {
                          withAnimation {
                              self.showFootnote.toggle()
                              //9. Use the send notification function
                            let date = Date(timeIntervalSinceNow: 5)
                            let p = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: date)
                              self.notificationManager.sendNotification(title: "Hurray!", subtitle: nil, body: "If you see this text, launching the local notification worked!", triggerDate: p)
                            
                          }
                      }) {
                          Text("Launch Local Notification 🚀")
                              .font(.title)
                      }
                      if showFootnote {
                          Text("Notification Arrives in 5 seconds")
                              .font(.footnote)
                      }
                  }
                      .navigationBarTitle("Local Notification Demo", displayMode: .inline)
              }
    }
}

struct NotificationButton_Previews: PreviewProvider {
    static var previews: some View {
        NotificationButton()
    }
}
