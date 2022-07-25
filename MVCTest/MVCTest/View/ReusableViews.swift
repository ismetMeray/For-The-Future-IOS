//
//  ReusableViews.swift
//  MVCTest
//
//  Created by Ismet Meray on 06/03/2022.
//

import SwiftUI

struct NewToolBarItem : ToolbarContent{
    var title = ""
    var callback: () -> ()
    
    var body: some ToolbarContent{
        return ToolbarItem(placement: .automatic){
            Button(action: {
                callback()
            }){
                Text(title).padding()
            }.buttonStyle(PlainButtonStyle())
                .background(Color(UIColor.black))
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
}

struct NewNavigationButton<Content: View> : View{
    
    var message = ""
    var destination: Content? = nil
    @State var isActive = false
    var body: some View{
        return HStack{
            Spacer()
            NavigationLink(destination: destination, isActive: $isActive){
                Button(message, action: {
                    self.isActive = true
                })
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .listRowBackground(Color.clear)
                    .ignoresSafeArea()
            }
            Spacer()
        }
    }
}

enum AlertAction {
    case ok
    case cancel
    case others
}

struct AlertView: View {
    
    @Binding var shown: Bool
    @Binding var closureA: AlertAction?
    var message: String
    
    var body: some View {
        VStack {
            
            Spacer()
            Text(message).foregroundColor(Color.white)
            Spacer()
            Divider()
            HStack {
                Button("Close") {
                    closureA = .cancel
                    shown.toggle()
                }.frame(width: UIScreen.main.bounds.width/2-30, height: 40)
                    .foregroundColor(.white)
                
                Button("Ok") {
                    closureA = .ok
                    shown.toggle()
                }.frame(width: UIScreen.main.bounds.width/2-30, height: 40)
                    .foregroundColor(.white)
                
            }
            
        }.frame(width: UIScreen.main.bounds.width-50, height: 200)
        
            .background(Color.black)
            .cornerRadius(8)
            .clipped()
        
    }
}
