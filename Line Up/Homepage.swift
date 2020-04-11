//
//  Homepage.swift
//  Line Up
//
//  Created by Sreenikhil Kollu on 4/5/20.
//  Copyright © 2020 Sreenikhil Kollu. All rights reserved.
//

import SwiftUI

struct Homepage: View {
    @ObservedObject var viewRouter: ViewRouter
    var body: some View {
        VStack{
            
                        Button(action: {self.viewRouter.currentPage = "page1"}){
                                   HStack(alignment: .center){
                                                      Spacer()
                                                  Text("Logout").foregroundColor(Color.white).bold()
                                                      Spacer()
                                                  }.padding().background(Color.black).cornerRadius(4.0).frame(width: 370)
                               }.padding(EdgeInsets(top: 25, leading: 0, bottom: 0, trailing: 0))
                }
            }
        }

struct Homepage_Previews: PreviewProvider {
    static var previews: some View {
        Homepage(viewRouter: ViewRouter())
    }
}
