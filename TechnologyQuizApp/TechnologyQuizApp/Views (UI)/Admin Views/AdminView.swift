//
//  AdminView.swift
//  TechnologyQuizApp
//
//  Created by Scott Benson on 5/12/21.
//

import SwiftUI

struct AdminView: View {
    @State var blockUsername: String = ""
    @State private var selection: String? = nil
    
    func action() {
    }
    
    var body: some View {
        
        NavigationView {
        ZStack {
            NavigationLink(destination: UserScoreAdminView(), tag: "getScores", selection: $selection){EmptyView()}
            Color.purpleGray
                .ignoresSafeArea()
            
            Text("Administrator")
                .font(.system(size: 50))
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .padding(.bottom, 50)
                .position(x: 220)
            
            VStack {
                Text("Create Quiz")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Button(action: { action() }) {
                  Text("Create Quiz")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 150, height: 50)
                    .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .bottomTrailing ))
                    .cornerRadius(15.0)
                }.frame(width: 200, height: 100, alignment: .center)
            }
            .padding(20)
            .border(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .bottomTrailing), width: 4)
            .cornerRadius(10)
            .offset(y: -240)
            
            // View User Scores
            VStack {
                Text("Get User Scores")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Button(action: {
                    self.selection = "getScores"
                }) {
                  Text("Get Scores")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 150, height: 50)
                    .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .bottomTrailing ))
                    .cornerRadius(15.0)
                }.frame(width: 200, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            .padding(20)
            .border(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .bottomTrailing), width: 4)
            .cornerRadius(10)
            .offset(y: -60)
            
            // Block User
            VStack {
                Text("Block User")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                CustomTextField(
                    isSecure: false,
                    placeholder: Text("Username to block").foregroundColor(.gray),
                    text: $blockUsername
                )
                .padding()
                .foregroundColor(.white)
                .background(Color.lightPurpleGray)
                .cornerRadius(20.0)
                .frame(width: 200, height: 100, alignment: .leading)
                
                Button(action: { action() }) {
                  Text("Block")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 150, height: 50)
                    .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .bottomTrailing ))
                    .cornerRadius(15.0)
                }
            }
            .padding(20)
            .border(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .bottomTrailing ), width: 4)
            .cornerRadius(10)
            .offset(y: 150)
            
            // Sign Out Button
            Button(action: {action()}) {
              Text("Sign Out")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .frame(width: 250, height: 70)
                .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .bottomTrailing ))
                .cornerRadius(15.0)
            }.offset(x: 0, y: 320)
        }
        }
    }
}

struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView()
    }
}
