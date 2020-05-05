//
//  GoogleLoginView.swift
//  Line Up
//
//  Created by Sreenikhil Kollu on 5/3/20.
//  Copyright © 2020 Sreenikhil Kollu. All rights reserved.
//

import SwiftUI
import GoogleSignIn
import Firebase


struct GoogleLoginView:  UIViewRepresentable {
    
    @State var result: String = "Default"
    @EnvironmentObject var pmail: Email
    // We can pad
    
        
    func makeCoordinator() -> GoogleLoginView.Coordinator {
        
        print("I am called before make UI view")
        return GoogleLoginView.Coordinator()
    }
    
    class Coordinator: NSObject, GIDSignInDelegate  {
            
            
            
            let defaults = UserDefaults.standard
           @EnvironmentObject var viewRouter: ViewRouter
            public static var result3: String = "p"
        func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?)  {
            
          if let error = error {
            print(error.localizedDescription)
            return
          }
          guard let authentication = user.authentication else { return  }
          let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                            accessToken: authentication.accessToken)
          Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
              print(error.localizedDescription)
              return
            }
  
            print("signIn result: " + authResult!.user.email!)
            GoogleLoginView.Coordinator.result3 = authResult!.user.email!
            print("I have assigned")
            self.defaults.set(true, forKey: "isSigned")
            self.defaults.synchronize()
            print("At the class \(self.defaults.bool(forKey: "isSigned"))")
        
          }
            
        }
            func myOwn() -> String{
                print("The value is: \(GoogleLoginView.Coordinator.result3)")
                return (GoogleLoginView.Coordinator.result3)
            }
    }
 
    func makeUIView(context: UIViewRepresentableContext<GoogleLoginView>) -> GIDSignInButton {
        let view = GIDSignInButton()
        pmail.email = "kollu1997@gmail.com"
        GIDSignIn.sharedInstance().delegate = context.coordinator
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
        return view
    }
    
    func updateUIView(_ uiView: GIDSignInButton, context: UIViewRepresentableContext<GoogleLoginView>) {
         let defaults = UserDefaults.standard
         let p = defaults.bool(forKey: "isSigned")
        if(p){
            print("Logged in Successfully")
        }

    }

}

