//
//  ForgotPasswordView.swift
//  TechnologyQuizApp
//
//  Created by Scott Benson on 5/9/21.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State var forgotUsername: String = ""
    @State var forgotPassword: String = ""
    
    func action () {
        print("hello")
    }
    
    var body: some View {
        NavigationView {
        ZStack {
            Color.purpleGray
                .ignoresSafeArea()
            
            VStack {
                
                Text("Reset Password")
                    .font(.system(size: 50))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .padding(.bottom, 50)

                CustomTextField(
                    placeholder: Text("Username").foregroundColor(.gray),
                    text: $forgotUsername
                )
                  .padding()
                  .foregroundColor(.white)
                  .background(Color.lightPurpleGray)
                  .cornerRadius(20.0)
                
                CustomTextField(
                    placeholder: Text("New Password").foregroundColor(.gray),
                    text: $forgotPassword
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
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
