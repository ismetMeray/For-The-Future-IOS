//
//  ContentView.swift
//  MVCTest
//
//  Created by Ismet Meray on 22/01/2022.
//

import SwiftUI

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

struct ContentView : View {
    
    @State var userName: String = "Boomblaadje"
    @State var passWord: String = "Yeet"
    @EnvironmentObject var viewModel: LoginViewModel
    
    var body: some View {
        
        VStack {
            WelcomeText()
            UserImage()
            TextField("Username or Email", text: $userName)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            SecureField("Password", text: $passWord)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            Button("login", action:{
                self.viewModel.login(userName: userName, passWord: passWord)})
        }
        .padding()
        .alert(item: $viewModel.error) { error in
            Alert(title: Text("Invalid login"), message: Text(error.localizedDescription))
        }
    }
}

struct WelcomeText : View {
    var body: some View {
        return Text("Welcome!")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
    }
}

struct UserImage : View {
    var body: some View {
        return Image("UserImage")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipped()
            .cornerRadius(150)
            .padding(.bottom, 75)
    }
}

struct LoginButtonContent : View {
    var body: some View {
        return Text("LOGIN")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(15.0)
    }
}

struct ContentView_Previews : PreviewProvider {
    static var viewModel: LoginViewModel = LoginViewModel(AppState(auth: true))

    static var previews: some View {
        ContentView().environmentObject(viewModel)
    }
}
