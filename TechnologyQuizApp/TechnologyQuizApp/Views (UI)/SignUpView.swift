//
//  SwiftUIView.swift
//  TechnologyQuizApp
//
//  Created by Scott Benson on 5/9/21.
//

import SwiftUI

struct SignUpView: View {
    
    @State var signUpUsername: String = ""
    @State var signUpPassword: String = ""
    @State var signUpFirstName: String = ""
    @State var signUpLastName: String = ""
    @State var signUpEmail: String = ""
    @State var signUpPhoneNumber: String = ""
    
    func action () {
        print("hello")
    }
    
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
                    placeholder: Text("First Name").foregroundColor(.gray),
                    text: $signUpFirstName
                )
                  .padding()
                  .foregroundColor(.white)
                  .background(Color.lightPurpleGray)
                  .cornerRadius(20.0)
                
                CustomTextField(
                    placeholder: Text("Last Name").foregroundColor(.gray),
                    text: $signUpLastName
                )
                  .padding()
                  .foregroundColor(.white)
                  .background(Color.lightPurpleGray)
                  .cornerRadius(20.0)
                
                CustomTextField(
                    placeholder: Text("Email").foregroundColor(.gray),
                    text: $signUpEmail
                )
                  .padding()
                  .foregroundColor(.white)
                  .background(Color.lightPurpleGray)
                  .cornerRadius(20.0)
                
                CustomTextField(
                    placeholder: Text("Phone Number").foregroundColor(.gray),
                    text: $signUpPhoneNumber
                )
                  .padding()
                  .foregroundColor(.white)
                  .background(Color.lightPurpleGray)
                  .cornerRadius(20.0)
                
                CustomTextField(
                    placeholder: Text("Username").foregroundColor(.gray),
                    text: $signUpUsername
                )
                  .padding()
                  .foregroundColor(.white)
                  .background(Color.lightPurpleGray)
                  .cornerRadius(20.0)
                
                CustomTextField(
                    placeholder: Text("Password").foregroundColor(.gray),
                    text: $signUpPassword
                )
                  .padding()
                  .foregroundColor(.white)
                  .background(Color.lightPurpleGray)
                  .cornerRadius(20.0)
                
                Button(action: { action() }) {
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
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
