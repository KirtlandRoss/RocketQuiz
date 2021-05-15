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
    @FetchRequest(
        entity: QuestionBank.entity(),
        sortDescriptors: []
    ) var fetchedQBank : FetchedResults<QuestionBank>
    @State var username: String = ""
    @State var password: String = ""
    @State private var rememberMe = true
    @State private var user : User?
    @State var selector = ""


    @State private var questionBank = QuestionBank(context: SceneDelegate().context!)
    //    @State var isAdmin : Bool = false
    @State private var invalidLogin = false

    
    @State var selection : String? // holds value for Navigation Link tags

    init(){
        questionBank.addQ()
    }
    var body: some View {
        if selector == "LI" {
            SideMenu(username: $username, selector: $selector){
                WelcomeView(selection: $selector, username: $username)
            }
        }
        else if selector == "QZ"{
            QuizView(mode: $selector)
        }

        else if selector == "AD"{
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
                                isSecure: false,
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
            questionBank = fetchedQBank.first!



        } else {
            user = User(context: context)
            user!.setupInvalidUser()
            print("username not found")
        }
        
        if user!.password != nil && validatePassword(enteredPassword: password, retrievedPassword: user!.password!) && !adminCheck(){

            print("Logged in!")

            invalidLogin = false
            selector = "LI"
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
    let pass = "Pass"
    if username == "Admin" && password == pass{

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
