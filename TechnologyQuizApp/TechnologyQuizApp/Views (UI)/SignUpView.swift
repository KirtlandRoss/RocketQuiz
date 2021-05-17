//
//  SwiftUIView.swift
//  TechnologyQuizApp
//
//  Created by Scott Benson on 5/9/21.
//

import SwiftUI
import CoreData

struct SignUpView: View {
    //setup context and variable for holding data
    @Environment(\.managedObjectContext) var context
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State var signUpUsername: String = ""
    @State var signUpPassword: String = ""
    @State var signUpFirstName: String = ""
    @State var signUpLastName: String = ""
    @State var signUpEmail: String = ""
    @State var signUpPhoneNumber: String = ""
    //fetch users
    @FetchRequest(
        entity: User.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \User.name, ascending: true)]
    ) var users : FetchedResults<User>

    var body: some View {
        ZStack {

            Color.purpleGray
                .ignoresSafeArea()
            VStack {
                Text("Sign Up Below")
                    .font(.system(size: 50))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .padding(.bottom, 50)

                CustomTextField(
                    isSecure: false,
                    placeholder: Text("First Name").foregroundColor(.gray),
                    text: $signUpFirstName
                )
                .padding()
                .foregroundColor(.white)
                .background(Color.lightPurpleGray)
                .cornerRadius(20.0)
                
                CustomTextField(
                    isSecure: false,
                    placeholder: Text("Last Name").foregroundColor(.gray),
                    text: $signUpLastName
                )
                .padding()
                .foregroundColor(.white)
                .background(Color.lightPurpleGray)
                .cornerRadius(20.0)
                
                CustomTextField(
                    isSecure: false,
                    placeholder: Text("Email").foregroundColor(.gray),
                    text: $signUpEmail
                )
                .padding()
                .foregroundColor(.white)
                .background(Color.lightPurpleGray)
                .cornerRadius(20.0)
                
                CustomTextField(
                    isSecure: false,
                    placeholder: Text("Phone Number").foregroundColor(.gray),
                    text: $signUpPhoneNumber
                )
                .padding()
                .foregroundColor(.white)
                .background(Color.lightPurpleGray)
                .cornerRadius(20.0)
                
                CustomTextField(
                    isSecure: false,
                    placeholder: Text("Username").foregroundColor(.gray),
                    text: $signUpUsername
                )
                .padding()
                .foregroundColor(.white)
                .background(Color.lightPurpleGray)
                .cornerRadius(20.0)
                
                CustomTextField(
                    isSecure: false,
                    placeholder: Text("Password").foregroundColor(.gray),
                    text: $signUpPassword
                )
                .padding()
                .foregroundColor(.white)
                .background(Color.lightPurpleGray)
                .cornerRadius(20.0)
                
                Button(action: { (
                    submit()
                ) }) {
                    Text("Submit")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .bottomTrailing ))
                        .cornerRadius(15.0)
                }.offset(x: 0, y: 50)
                
            }.padding([.leading, .trailing], 27.5)
        }
    }
    func submit(){

        //checks if data is valid and if database contains a user with the same username
        if validateData() && !users.contains(where: { user in
            user.name == signUpUsername
        }){
            let user = User(context: context)
            user.name = signUpUsername
            user.password = signUpPassword
            user.firstName = signUpFirstName
            user.lastName = signUpLastName
            user.hasSubscription = false

            //creates admin account if doesn't already exist
            if !users.contains(where: {user in
                user.name == "Admin"
            }){
            let admin = User(context: context)
            admin.name = "Admin"
            admin.firstName = "admin"
            admin.lastName = "admin"
                admin.password = "Pass"}

            do{
                try context.save()
                print("user created?!")
                print(users)
                self.presentationMode.wrappedValue.dismiss()

            }
            catch{
                print("SignUpView.submit save error")
            }

        }
        else{  print("user already exists")}
    }

    //data validation, basic to make sure it doesn't crash. Can be changed later
    func validateData() -> Bool{
        if signUpUsername.count < 3
        {
            print("Username is too short")
            return false
        }
        else if signUpPassword.count < 3{
            print("Password is too short")
            return false
        }
        else if signUpFirstName.count < 3{
            print("First Name is too short")
            return false
        }
        else if signUpLastName.count < 3{
            print("Last Name is too short")
            return false
        }
        return true
    }
    

}



struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
