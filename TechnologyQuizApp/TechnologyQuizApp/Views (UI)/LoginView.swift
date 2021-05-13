//
//  SwiftUIView.swift
//  TechnologyQuizApp
//
//  Created by Scott Benson on 5/8/21.
//

import SwiftUI
import CoreData

struct LoginView: View {
    

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
    @State var user : User
    @State var loggedIn : Bool = false

    @State var isAdmin : Bool = false
    @State private var invalidLogin = false

    
    @State var selection : String? // holds value for Navigation Link tags

    var body: some View {
        if loggedIn {

            SideMenu(user: $user){
                WelcomeView(user: $user)
            }
        }
        else if isAdmin{
            AdminView()
        }
        else {
            NavigationView {
                ZStack {
                    Color.purpleGray
                        .ignoresSafeArea()
                    // Navigation links to each page -- Listens for selection variable value to match tag, then navigates to that page.
                    NavigationLink(destination: ForgotPasswordView(), tag: "forgotPassword", selection: $selection){EmptyView()}
                    NavigationLink(destination: SignUpView(), tag: "signUp", selection: $selection){EmptyView()}

                    VStack {
                        Text("Quiz App")
                            .font(.system(size: 50))
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)

                        Image("rocket")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle()
                                        .stroke(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .bottomTrailing ), lineWidth: 4))
                            .shadow(radius: 10)
                            .padding(.bottom, 20)

                        VStack {
                            if invalidLogin {
                                withAnimation{
                                    Text("Invalid Credentials")
                                        .foregroundColor(.red)
                                }
                            } else {
                                Text(" ")
                            }
                            CustomTextField(
                                isSecure: false,
                                placeholder: Text("Username").foregroundColor(.gray),
                                text: $username
                            ).animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.lightPurpleGray)
                            .cornerRadius(20.0)
                        
                            CustomTextField(
                                isSecure: true,
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

                            FacebookButton()
                                .frame(width: 20, height: 30, alignment: .center)

                            Button(action: {(
                                submit()
                            )}) {
                                Text("Sign In")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(width: 300, height: 50)
                                    .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .bottomTrailing ))
                                    .cornerRadius(15.0)
                            }.offset(x: 0, y: 50)

                            Button(action: {(
                                selection = "forgotPassword"
                            ) }) {

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

                            Button(action: {(
                                selection = "signUp"
                            ) }) {
                                Text("Tap here to sign up!")
                                    .font(.system(size: 30))
                                    .fontWeight(.bold)
                                    .foregroundColor(.purple)
                                    .padding()
                                    .cornerRadius(15.0)
                                    .offset(x: 0, y: 30)
                            }}
                    }
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
            }
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
        
        if user.password != nil && validatePassword(enteredPassword: password, retrievedPassword: user.password!){

                print("Logged in!")

                loggedIn = true
                invalidLogin = false
                selection = "welcome"
        }
            else if username == "Admin" && password == "Pass"{
                isAdmin = true
                print("now this is what I call security")
                invalidLogin = false
            }
            else {
                invalidLogin = true
                print("invalid username/password")
            }
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



struct LoginView_Previews: PreviewProvider {
    @State static var user = User()
    static var previews: some View {
        LoginView(user : user)
    }
}
