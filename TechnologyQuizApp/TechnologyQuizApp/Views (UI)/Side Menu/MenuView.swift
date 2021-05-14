//
//  MenuView.swift
//  TechnologyQuizApp
//
//  Created by Scott Benson on 5/10/21.
//

import SwiftUI

struct MenuView: View {
    @State private var profileImage = "profileImage"
    @State private var username = "user2123"
    func action() {}
    
    var body: some View {
        
        VStack (alignment: .leading){
            Image(profileImage)
                .resizable()
                .frame(width: 75, height: 75, alignment: .center)
                .cornerRadius(50)
                .offset(y: 50)
            Text(username)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(width: 125, height: 130, alignment: .leading)
                .padding(.top, 10)

            Button(action:  {
                action()
            }){
                HStack {
                    Image(systemName: "person")
                        .foregroundColor(.white)
                        .imageScale(.large)
                    Text("Profile")
                        .foregroundColor(.white)
                        .font(.headline)
                }
            }
                
                Button(action:  {
                action()
            }){
                HStack {
                    Image(systemName: "star")
                        .foregroundColor(.white)
                        .imageScale(.large)
                    Text("Rankings")
                        .foregroundColor(.white)
                        .font(.headline)
                }
                .padding(.top, 20)
            }
            Button(action:  {
                action()
            }){
            HStack {
                Image(systemName: "gear")
                    .foregroundColor(.white)
                    .imageScale(.large)
                Text("Settings")
                    .foregroundColor(.white)
                    .font(.headline)
            }
            .padding(.top, 20)
            }
            Spacer()
            
            Button(action: {(
                action()
            )}) {
                Text("Sign Out")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 150, height: 50)
                    .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .bottomTrailing ))
                    .cornerRadius(15.0)
                    .padding()
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.lightPurpleGray)
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
