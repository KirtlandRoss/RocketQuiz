//
//  SwiftUIView.swift
//  TechnologyQuizApp
//
//  Created by Scott Benson on 5/8/21.
//

import SwiftUI
import CoreData

struct LoginView: View {
    @Environment(\.managedObjectContext) var context

    //fetch users
    @FetchRequest(
        entity: User.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \User.name, ascending: true),
        ]
    ) var users : FetchedResults<User>
//    private var dbHelper = DBHelper()
    @State var username: String = ""
    @State var password: String = ""
    @State private var rememberMe = true
    @State var user : User?
    @State var loggedIn : Bool = false
    
    func action () {
        print("hello")
    }

    var body: some View {
        if loggedIn {
            WelcomeView()
        } else {
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

                    Button(action: { (
                        submit()
                    ) }) {
                        Text("Sign In")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .bottomTrailing ))
                            .cornerRadius(15.0)
                    }.offset(x: 0, y: 50)

                    
                    Button(action: { (
                        action()
                    ) }) {
                        NavigationLink(destination: ForgotPasswordView()){
                        Text("Forgot Password")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .bottomTrailing ))
                            .cornerRadius(15.0)
                    }}.offset(x: 0, y: 50)

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
    
    func submit(){
//        checks if data is valid and if database contains a user with the same username
        if users.first(where: { user in
            user.name == username
        }) != nil {
            user = users.first(where: { user in
                user.name == username
            })! as User

        } else {
            print("username not found")
        }
        
        if user?.password != nil {
            if validatePassword(enteredPassword: password, retrievedPassword: user!.password!) {
                print("Logged in!")
                loggedIn = true
            } else {
                print("invalid username/password")
            }
        } else{
            print("no")
        }
    }
    
    func validatePassword(enteredPassword: String, retrievedPassword: String) -> Bool {
        if retrievedPassword == enteredPassword {
            return true
        }
        else {
            return false
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
