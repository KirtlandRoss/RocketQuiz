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
    var body: some View {
        VStack (alignment: .leading){
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
                .padding(.top, 100)
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

                .padding(.top, 30)
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
    @State static var selector =  ""
    static var previews: some View {
        MenuView(selector: $selector)
    }
}
