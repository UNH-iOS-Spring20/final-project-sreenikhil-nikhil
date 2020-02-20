//
//  User.swift
//  Line Up
//
//  Created by Sreenikhil Kollu on 2/18/20.
//  Copyright © 2020 Sreenikhil Kollu. All rights reserved.
//

class User{
    var firstname: String
    var lastname: String
    var email: String
    var username: String
    var password: String
    
    init?(firstname: String, lastname: String, email: String, username: String, password: String){
        if firstname.isEmpty || lastname.isEmpty || email.isEmpty || username.isEmpty || password.isEmpty {
            return nil
        }
        self.firstname = firstname;
        self.lastname = lastname;
        self.email = email;
        self.username = username;
        self.password = password;
        
    }
}
