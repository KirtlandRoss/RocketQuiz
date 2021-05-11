//
//  SwiftUIView.swift
//  TechnologyQuizApp
//
//  Created by Scott Benson on 5/8/21.
//

import SwiftUI

struct LoginView: View {

    @State var username: String = ""
    @State var password: String = ""
    @State private var rememberMe = true

    func action () {
        print("hello")
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color.purpleGray
                    .ignoresSafeArea()
                VStack {
                    Text("Quiz App")
                        .font(.system(size: 60))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)

                    Image("rocket")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle()
                                    .stroke(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .bottomTrailing ), lineWidth: 4))
                        .shadow(radius: 10)
                        .padding(.bottom, 50)

                    VStack {
                        CustomTextField(
                            placeholder: Text("Username").foregroundColor(.gray),
                            text: $username
                        )
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.lightPurpleGray)
                        .cornerRadius(20.0)

                        CustomTextField(
                            placeholder: Text("Password").foregroundColor(.gray),
                            text: $password
                        )
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.lightPurpleGray)
                        .cornerRadius(20.0)

                        Toggle("Remember Me", isOn: $rememberMe)
                            .toggleStyle(SwitchToggleStyle(tint: .purple))
                            .foregroundColor(.white)
                            .offset(x: 0, y: 5)
                            .padding([.leading, .trailing], 5)
                        if rememberMe {
                        }
                    }.padding([.leading, .trailing], 27.5)

                    Button(action: { action() }) {
                        AppImage(width: 50, height: 50, cornerRadius: 0, name: "facebook")
                    }

                    Button(action: { action() }) {
                        Text("Sign In")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .bottomTrailing ))
                            .cornerRadius(15.0)
                    }.offset(x: 0, y: 50)

                    Button(action: { action() }) {
                        Text("Forgot Password")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .bottomTrailing ))
                            .cornerRadius(15.0)
                    }.offset(x: 0, y: 50)

                    Text("Dont have an account?")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .padding()
                        .cornerRadius(15.0)
                        .offset(x: 0, y: 70)

                    NavigationLink(destination: SignUpView()){
                        Text("Tap here to sign up!")
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .foregroundColor(.purple)
                            .padding()
                            .cornerRadius(15.0)

                    }.offset(x: 0, y: 30)

                    }
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
