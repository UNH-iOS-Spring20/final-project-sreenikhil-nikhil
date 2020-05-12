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
 
   
   @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    
    @EnvironmentObject var viewRouter: ViewRouter
      @ObservedObject private var users =
       FirebaseCollection<User>(collectionRef: newuserCollectionRef)
    
    @EnvironmentObject var session: SessionClass
    @EnvironmentObject var pmail : Email
    @State var email: String = ""
    @State var password: String = ""
    @State var NotSuccessfulSignup: Bool = false
    @State var isLoggedIn: Bool = false
  

    
    var alert: Alert {
           Alert(title: Text("Result"), message: Text("Invalid User"), dismissButton: .default(Text("Dismiss")))
       }
   
    
    var body: some View {
        if(status){
            session.email = UserDefaults.standard.value(forKey: "Gmail") as! String
           self.viewRouter.currentPage = "page3"
        }
        
        return VStack(){
            Text("Login").bold().font(.title)
            Text("Organizing Things").bold().font(.subheadline).padding(10.0)
            
            // Email
            TextField("Email", text:$email).padding(10).cornerRadius(4.0).border(Color.black).frame(width: 350)
                 .autocapitalization(.none)
            
            // Password
            SecureField("Password", text: $password).padding(10).cornerRadius(4.0).border(Color.black).frame( width: 350)
                .autocapitalization(.none)
            
            //Submit
            Button(action: submit) {
                HStack(alignment: .center){
                    Spacer()
                Text("Login").foregroundColor(Color.white).bold()
                    Spacer()
                }.padding().background(Color.black).cornerRadius(4.0).frame(width: 350)
            }.padding(EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 0))
              .alert(isPresented: $NotSuccessfulSignup, content: { self.alert })
            
              
            HStack{
                Button(action: Fclick){
                
                    HStack(alignment: .center){
                        Spacer()
               Text("Facebook").foregroundColor(Color.white).bold()
                        
                        Spacer()
                    }.padding(12).background(Color.blue).cornerRadius(4.0).frame(width: 150)
                }.padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 20))
                
                
          
               GoogleSignView()
                    .frame(width: 140, height: 70,alignment: .center).padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                
                
               
                
                
                    
                
                
                
                
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
            
           
        }.onAppear {
                
            NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"), object: nil, queue: .main) { (_) in
                
                let status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                self.status = status
            }
        }// for V stack
    }// for body view
    
    
  
    
    // Submit function
    func submit(){
        //I will do the job at any cost
        let email = $email.wrappedValue
        let password = $password.wrappedValue
        var flag = true
        // Data from database
        for user in users.items{
            print("Email is: \(user.email) and Password is: \(user.password)")
            if(user.email == email && user.password == password){
                print("You are a Valid User")
                self.viewRouter.currentPage = "page3"
                session.email = $email.wrappedValue
                flag = false
            }
        }
        if(flag){
            NotSuccessfulSignup = true
          print("Invalid user")
      }
    }

    func Fclick(){
        
    }

    func Gclick(){
          //SocialLogin.attemptLoginGoogle()
          print("I am clicked, Google")
        
    }
    
}// Foe login



struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login().environmentObject(ViewRouter())
               
    }
}


struct GoogleSignView : UIViewRepresentable {

    func makeUIView(context:
        UIViewRepresentableContext<GoogleSignView>) -> GIDSignInButton {
        
        let button = GIDSignInButton()
        button.colorScheme = .dark
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
        return button
        
    }
    
    func updateUIView(_ uiView: GIDSignInButton, context:
        UIViewRepresentableContext<GoogleSignView>) {
        
    }
}




// -------------------------------------


 
