//
//  Signup.swift
//  Line Up
//
//  Created by Sreenikhil Kollu on 3/26/20.
//  Copyright © 2020 Sreenikhil Kollu. All rights reserved.
//

import SwiftUI
import FirebaseFirestore

let userCollectionRef = Firestore.firestore().collection("User")

struct Signup: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State var email: String = ""
    @State var password: String = ""
    @State var firstname: String = ""
    @State var lastname: String = ""
       var body: some View {
           VStack{
               HStack{
                   TextField("FirstName", text: $firstname).padding(12).frame(width: 180).border(Color.black)
                       .autocapitalization(.none)

                   
                   TextField("LastName", text: $lastname).padding(12).frame(width:180).border(Color.black)
                      .autocapitalization(.none)
                   
               }.padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
               
               TextField("Email", text: $email).padding(12).frame(width:370).border(Color.black)
                   .autocapitalization(.none)
               
               SecureField("Password", text: $password).padding(12).frame(width:370).border(Color.black).padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                   .autocapitalization(.none)
               
               Button(action: DoSignUp){
                   HStack(alignment: .center){
                                      Spacer()
                                  Text("Sign Up").foregroundColor(Color.white).bold()
                                      Spacer()
                                  }.padding().background(Color.black).cornerRadius(4.0).frame(width: 370)
               }.padding(EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 0))
               
               Button(action: {self.viewRouter.currentPage = "page1"}){
                              HStack(alignment: .center){
                                                 Spacer()
                                             Text("Alreay a User").foregroundColor(Color.white).bold()
                                                 Spacer()
                                             }.padding().background(Color.black).cornerRadius(4.0).frame(width: 370)
                          }.padding(EdgeInsets(top: 25, leading: 0, bottom: 0, trailing: 0))
           }
       }
    func DoSignUp(){
        let email: String = $email.wrappedValue
        let password: String = $password.wrappedValue
        let firstname: String = $firstname.wrappedValue
        let lastname: String = $lastname.wrappedValue
        
        let data = ["firstname": firstname, "lastname": lastname, "email": email, "password": password]as [String : Any]
        
        userCollectionRef.addDocument(data: data)
    }
     
}


struct Signup_Previews: PreviewProvider {
    static var previews: some View {
        Signup().environmentObject(ViewRouter())
    }
}
