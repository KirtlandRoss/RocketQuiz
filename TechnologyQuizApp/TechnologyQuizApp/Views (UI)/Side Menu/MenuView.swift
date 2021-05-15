//
//  MenuView.swift
//  TechnologyQuizApp
//
//  Created by Scott Benson on 5/10/21.
//

import SwiftUI

struct MenuView: View {

    @Binding var selector : String
    func action() {}
    
    func quiz() {
        selector = "QZ"
    }
    
    func ranking() {
        selector = "RK"
    }
    
    func logout () {
        selector = "LV"
    }
    
    func discussion () {
        selector = "DS"
    }

    var body: some View {
        VStack (alignment: .leading){
            
            VStack {
                Image("profileImage")
                .resizable()
                .frame(width: 75, height: 75)
                .clipShape(Circle())
                .overlay(Circle()
                            .stroke(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .bottomTrailing ), lineWidth: 4))
                .shadow(radius: 10)
                Text("User")
                    .font(.system(size: 20))
                    .fontWeight(.heavy)
                    .padding(.top, 10)
                    .foregroundColor(Color.white)
            }.padding(.top, 125).padding(.leading, 40)
            Button(action:  {
                discussion()
            }){
                HStack {
                    Image(systemName: "mail")
                        .foregroundColor(.white)
                        .imageScale(.large)
                    Text("Discussion")
                        .foregroundColor(.white)
                        .font(.headline)
                }
                .padding(.top, 100)
            }
            Button(action:  {
                ranking()
            }){
                HStack {
                    Image(systemName: "star")
                        .foregroundColor(.white)
                        .imageScale(.large)
                    Text("Rankings")
                        .foregroundColor(.white)
                        .font(.headline)
                }
                .padding(.top, 30)
            }
            Button(action:  {
                quiz()
            }){
            HStack {
                Image(systemName: "questionmark")
                    .foregroundColor(.white)
                    .imageScale(.large)
                Text("Quiz")
                    .foregroundColor(.white)
                    .font(.headline)
            }
            .padding(.top, 30)
            }
            Spacer()
            
            Button(action: {
                logout()
            }){
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
    @State static var selector =  ""
    static var previews: some View {
        MenuView(selector: $selector)
    }
}
