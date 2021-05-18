//
//  SwiftUIView.swift
//  TechnologyQuizApp
//
//  Created by Scott Benson on 5/8/21.
//

import SwiftUI
import CoreData
import FBSDKLoginKit

struct LoginView: View {
    
    @Environment(\.managedObjectContext) var context
    //fetch users
    @FetchRequest(
        entity: User.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \User.name, ascending: true),
        ]
    ) var users : FetchedResults<User>

    @State private var username: String = UserDefaults.standard.string(forKey: "rememberedUsername") ?? ""
    @State private var password: String = UserDefaults.standard.string(forKey: "rememberedPassword") ?? ""
    @State private var rememberMe = UserDefaults.standard.bool(forKey: "switchBool")
    @State private var user : User?
    
    @AppStorage("logged") var logged = false
    @AppStorage("email") var email = ""
    @State var manager = LoginManager()

    let userDef = UserDefaults.standard
    
    @State var selector = ""

    
    //    @State var isAdmin : Bool = false

    @State private var invalidLogin = false
    @State var selection : String? // holds value for Navigation Link tags

  
    var body: some View {

        if selector == "LI" {
            SideMenu(username: $username, selector: $selector){
                WelcomeView(selection: $selector, username: $username)
            }
        }
        else if selector == "QZ"{
            QuizView(mode: $selector, username: username)
        }
        else if selector == "AD"{
         AdminView(selector: $selector)
        }
        else if selector == "RK"{
            SideMenu(username: $username, selector: $selector){
                RankingView()
            }
        }
        else if selector == "DS"{
            SideMenu(username: $username, selector: $selector){
                DiscussionBoardUI(user: $username)
            }
        }
        else if selector == "SS"{
            SideMenu(username: $username, selector: $selector){
                SubscriptionView(username: $username)
            }
        }
        else if logged == true && AccessToken.current != nil {
            SideMenu(username: $username, selector: $selector){
                WelcomeView(selection: $selector, username: $username)
            }
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
                        Text("RocketQuiz")
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

//                            FacebookButton()
//                                .frame(width: 20, height: 30, alignment: .center)
                            
                            Button(action: {
                                if logged {
                                    manager.logOut()
                                    email = ""
                                    logged = false
                                } else {
                                    manager.logIn(permissions: ["public_profile", "email"], from: nil) {
                                        (result, err) in
                                        
                                        if err != nil {
                                            print(err!.localizedDescription)
                                            return
                                        }
                                        
                                        if !result!.isCancelled {
                                            logged = true
                                            
                                            let request = GraphRequest(graphPath: "me", parameters: ["fields": "email"])
                                            
                                            request.start {(_, res, _) in
                                                
                                                guard let profileData = res as? [String: Any] else {return}
                                                
                                                email = profileData["email"] as! String
                                                selector = "LI"
                                            }
                                        }
                        
                                    }
                                }
                             }) {
                                Text(logged && invalidLogin ? "Logout" : "Log In With Facebook")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 35)
                                    .background(Color.blue)
                                    .clipShape(Capsule())
                            }

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
                            }
                        }
                    }.padding()
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
            }
        }
    }
    
    func submit(){
        //        checks if data is valid and if database contains a user with the same username
        if users.first(where: { user in
            user.name == username}) != nil {
            user = users.first(where: { user in
                user.name == username
            })! as User


        } else {
            user = User(context: context)
            user!.setupInvalidUser()
            print("username not found")
        }
        
        if user!.password != nil && validatePassword(enteredPassword: password, retrievedPassword: user!.password!) && !adminCheck() {
            invalidLogin = false
            selector = "LI"
            rememberMeSubmit(&username, &password, rememberMe)
            
            print("Logged in!")

        }
        else if adminCheck(){
            selector = "AD"
            print("now this is what I call security")
            let adminUser = User(context: context)
            adminUser.firstName = "admin"
            adminUser.lastName = "admin"
            adminUser.password = "admin"
            adminUser.name = "admin"
            adminUser.hasSubscription = false
            self.user = adminUser
            print(user)
            invalidLogin = false
        }
        else {
            invalidLogin = true
            print("invalid username/password")
        }
    }

    func adminCheck() -> Bool{

        if username == "Admin" && password == user!.password {
            return true
        }
        return false
    }
    
    func validatePassword(enteredPassword: String, retrievedPassword: String) -> Bool {
        if retrievedPassword == enteredPassword {
            return true
        }
        else {
            return false
        }
    }
    
    func rememberMeSubmit(_ enteredUsername: inout String, _ enteredPassword: inout String, _ EnteredRememberMe: Bool){
        let userDef = UserDefaults.standard
        
            if rememberMe {
                userDef.set(enteredUsername, forKey: "rememberedUsername")
                userDef.set(enteredPassword, forKey: "rememberedPassword")
            } else {
                userDef.removeObject(forKey: "rememberedUsername")
                userDef.removeObject(forKey: "rememberedPassword")
            }
            userDef.set(EnteredRememberMe, forKey: "switchBool")
        
        username = userDef.string(forKey: "rememberedUsername") ?? ""
        password = userDef.string(forKey: "rememberedPassword") ?? ""
        rememberMe = userDef.bool(forKey: "switchBool")
    }

}

class GlobalSelector : ObservableObject{
    @Published var selector : String = ""
}

struct LoginView_Previews: PreviewProvider {

    @State static var user = User()
    static var previews: some View {
        LoginView()
    }
}
