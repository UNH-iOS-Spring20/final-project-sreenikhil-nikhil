//
//  ViewRouter.swift
//  Line Up
//
//  Created by Sreenikhil Kollu on 3/26/20.
//  Copyright © 2020 Sreenikhil Kollu. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class ViewRouter: ObservableObject{
    let objectWillChange = PassthroughSubject<ViewRouter,Never>()
    var currentPage: String = "page1"{
        didSet{
            objectWillChange.send(self)
        }
        
    }
}
