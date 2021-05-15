//
//  SwiftUIView.swift
//  TechnologyQuizApp
//
//  Created by Scott Benson on 5/11/21.
//

import SwiftUI

struct WelcomeView: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(
        entity: User.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \User.name, ascending: true),
        ]
    ) var users : FetchedResults<User>
    @Binding var selection : String
    @Binding var username : String
    //    @ObservedObject var selector : GlobalSelector
    
    var body: some View {
        
        ZStack { // ZStack for whole view
            Color.purpleGray
                .ignoresSafeArea()
            
            VStack { // Title
                Text("Welcome")
                    .font(.system(size: 40))
                    .fontWeight(.heavy)
                    .padding(.top, 40)
                    .foregroundColor(Color.white)
                
                ZStack { // Large info card
                    Image("profileImage")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                        .overlay(Circle()
                                    .stroke(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .bottomTrailing ), lineWidth: 4))
                        .shadow(radius: 10)
                }
                Text("User")
                    .font(.system(size: 30))
                    .fontWeight(.heavy)
                    .padding(.top, 40)
                    .foregroundColor(Color.white)
                Spacer()
                VStack {
                    Text("Use the side menu to navigate the app")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .padding(35)
                .border(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .bottomTrailing), width: 4)
                .cornerRadius(10)
                
                Spacer()
                Spacer()
                Spacer()
            }
        }
    }
    func setSelector(_ st : String){
        self.selection = st
    }
    
}

struct WelcomeView_Previews: PreviewProvider {
    @State static var user = User()
    @State static var st = ""
    static var previews: some View {
        
        WelcomeView( selection: $st, username: $st)
        
    }
}
