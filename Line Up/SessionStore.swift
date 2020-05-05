//
//  SessionStore.swift
//  Line Up
//
//  Created by Sreenikhil Kollu on 4/24/20.
//  Copyright © 2020 Sreenikhil Kollu. All rights reserved.
//

import Foundation
import Firebase
import Combine

class SessionStore : BindableObject {
    var didChange = PassthroughSubject<SessionStore, Never>()
    var session: User? { didSet { self.didChange.send(self) }}
    var handle: AuthStateDidChangeListenerHandle?

    
    func listen () {
        // monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                // if we have a user, create a new user model
                print("Got user: \(user)")
                self.session = User(
                    id: user.id,
                    data: user.data,
                )
            } else {
                // if we don't have a user, set our session to nil
                self.session = nil
            }
        }
    }

    // additional methods (sign up, sign in) will go here
}
