//
//  Login.swift
//  Line Up
//
//  Created by Sreenikhil Kollu on 3/26/20.
//  Copyright © 2020 Sreenikhil Kollu. All rights reserved.
//

import SwiftUI
import Firebase
import GoogleSignIn
import FirebaseFirestore

let newuserCollectionRef = Firestore.firestore().collection("User")
struct Login: View{
    let db = Firestore.firestore()
    
    @ObservedObject var viewRouter: ViewRouter
      @ObservedObject private var users =
        FirebaseCollection<User>(collectionRef: newuserCollectionRef)
    
    @ObservedObject var status = AppDelegate()
   
    @State var email: String = ""
    @State var password: String = ""
    @State var SuccessfulSignup: Bool = false
    var body: some View {
        if(status.loggedIn){
            print("Signup Successful")
        }
        else{
            print("Status not successful")
        }
         return VStack(){
            Text("Login").bold().font(.title)
            Text("Organizing Things").bold().font(.subheadline).padding(10.0)
            
            TextField("Email", text:$email).padding(10).cornerRadius(4.0).border(Color.black).frame(width: 350)
                 .autocapitalization(.none)
            
            SecureField("Password", text: $password).padding(10).cornerRadius(4.0).border(Color.black).frame( width: 350)
                .autocapitalization(.none)
            
            Button(action: submit) {
                HStack(alignment: .center){
                    Spacer()
                Text("Login").foregroundColor(Color.white).bold()
                    Spacer()
                }.padding().background(Color.black).cornerRadius(4.0).frame(width: 350)
            }.padding(EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 0))
            
            HStack{
                Button(action: Fclick){
                    HStack(alignment: .center){
                        Spacer()
               Text("Facebook").foregroundColor(Color.white).bold()
                        
                        Spacer()
                    }.padding(12).background(Color.blue).cornerRadius(4.0).frame(width: 150)
                }.padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 20))
                
                
                Button(action: Gclick){
                     HStack(alignment: .center){
                         Spacer()
                Text("Google").foregroundColor(Color.white).bold()
                         
                         Spacer()
                     }.padding(12).background(Color.red).cornerRadius(4.0).frame(width: 150)
                 }.padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
                
            }.padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
            
            Button(action: {self.viewRouter.currentPage = "page2"}){
            HStack(alignment: .center){
                               Spacer()
                               Text("New User"
                               ).foregroundColor(Color.white).bold()
                       
                               Spacer()
                           }.padding(12).background(Color.black)
                               .cornerRadius(4.0).frame(width: 300)
            }.padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
            
           
        }// for V stack
    }// for body view
    
    
    func submit(){
        //I will do the job at any cost
        let email = $email.wrappedValue
        let password = $password.wrappedValue
        var flag = true
        for user in users.items{
            print("Email is: \(user.email) and Password is: \(user.password)")
            if(user.email == email && user.password == password){
                print("You are a Valid User")
                self.viewRouter.currentPage = "page3"
                flag = false
            }
        }
        if(flag) {print("Invalid User")}
      }

    func Fclick(){
        
    }

    func Gclick(){
          SocialLogin.attemptLoginGoogle()
          print("I am clicked, Google")
        
    }

    func NewUser(){
        
    }
}// Foe login



struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login(viewRouter: ViewRouter())
    }
}

// -------------------------------------

struct SocialLogin: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<SocialLogin>) -> UIView {
        return UIView()
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<SocialLogin>) {
    }

    static func attemptLoginGoogle(){
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
        GIDSignIn.sharedInstance()?.signIn()
}
}
