//
//  User.swift
//  Line Up
//
//  Created by Sreenikhil Kollu on 2/18/20.
//  Copyright © 2020 Sreenikhil Kollu. All rights reserved.
//

class User: Identifiable{

    var firstname: String
    var lastname: String
    var email: String
    var password: String
    
    init?( firstname: String, lastname: String, email: String, password: String){
        if firstname.isEmpty || lastname.isEmpty || email.isEmpty || password.isEmpty {
            return nil
        }

        self.firstname = firstname;
        self.lastname = lastname;
        self.email = email;
        self.password = password;
        
    }
}
