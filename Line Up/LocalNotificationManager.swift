//
//  LocalNotificationManager.swift
//  Line Up
//
//  Created by Sreenikhil Kollu on 4/24/20.
//  Copyright © 2020 Sreenikhil Kollu. All rights reserved.
//

import Foundation
import SwiftUI

class  LocalNotificationManager: ObservableObject{
    var notifications = [Notification]()
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted == true && error == nil {
                print("Notifications permitted")
            } else {
                print("Notifications not permitted")
            }
        }
    }
    
    func sendNotification(title: String, subtitle: String?, body: String, triggerDate: DateComponents) {
        let content = UNMutableNotificationContent()
               content.title = title
               if let subtitle = subtitle {
                   content.subtitle = subtitle
               }
               content.body = body
                  
         
        
                print("I will print notification")
               
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        print("I am adding to the notifications array")
    
     
         UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
}
