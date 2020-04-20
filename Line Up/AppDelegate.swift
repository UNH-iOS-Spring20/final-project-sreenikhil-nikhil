//
//  AppDelegate.swift
//  Line Up
//
//  Created by Sreenikhil Kollu on 2/18/20.
//  Copyright © 2020 Sreenikhil Kollu. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate, ObservableObject {
   
    @Published var loggedIn = false
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("First function is called")
        FirebaseApp.configure()
        //Override point for customization after application launch
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = self
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
      -> Bool {
        print("Second function is called")
      return GIDSignIn.sharedInstance().handle(url)
    }
    
    
   func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
      // ...
        print("I am a google login and I am called")
      if let error = error {
        print("\(error.localizedDescription)")
        return
      }
     
      guard let authentication = user.authentication else { return }
        
      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                        accessToken: authentication.accessToken)
         Auth.auth().signIn(with: credential)
         {  (authResult, error) in
          if let error = error {
              print("Firebase sign in error")
              print(error)
              return
              
          }
        // Logic to make user enter in to the homepage
          print("User is signed in with Firebase")
            print("The email is: \(String(describing: user.profile.email))")
            self.loggedIn = true
            
      }
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
          print("Fourth function is called")
           print("User has disconnected")
    }

    
    

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

