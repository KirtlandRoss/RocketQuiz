//
//  MenuView.swift
//  TechnologyQuizApp
//
//  Created by Scott Benson on 5/10/21.
//

import SwiftUI
import FBSDKLoginKit

struct MenuView: View {
    @Environment(\.managedObjectContext) var context
    @Binding var selector : String
    var username : String = ""
    private var quizHandler : QuizHandler

    @FetchRequest(
        entity: User.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \User.name, ascending: true),
        ]
    ) var users : FetchedResults<User>
    @FetchRequest(
        entity: QuestionBank.entity(),
        sortDescriptors:[]
    ) var fetchedQBank : FetchedResults<QuestionBank>
    

    init(_ un : String, _ sel : Binding<String>, _ qh: QuizHandler){
        _selector = sel
        quizHandler = qh
        username = un
    }
    func quiz() {
        let dbhelp = DBHelper()
//        quizHandler.generateShuffledAnswers(username, context)
        dbhelp.createQuiz(username)
        selector = "QZ"
    }
    
    func ranking() {
        for user in users{
            user.calculateScore()
        }
        try! context.save()
        selector = "RK"
    }
    
    func logout () {
        AccessToken.current = nil
        selector = "LV"
    }
    
    func discussion () {
        selector = "DS"
    }
    
    func subscribe () {
        selector = "SS"
    }
    
    func welcome () {
        selector = "LI"
    }
    
    func feedback() {
        let dbhelp = DBHelper()
        dbhelp.createQuiz(username)
        selector = "FD"
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
                Text(username)
                    .font(.system(size: 20))
                    .fontWeight(.heavy)
                    .padding(.top, 10)
                    .foregroundColor(Color.white)
            }.padding(.top, 125).padding(.leading, 40)
            Button(action:  {
                welcome()
            }){
                HStack {
                    Image(systemName: "house")
                        .foregroundColor(.white)
                        .imageScale(.large)
                    Text("Home")
                        .foregroundColor(.white)
                        .font(.headline)
                }
                .padding(.top, 30)
            }
            Button(action:  {
                discussion()
            }){
                HStack {
                    Image(systemName: "text.bubble")
                        .foregroundColor(.white)
                        .imageScale(.large)
                    Text("Discussion")
                        .foregroundColor(.white)
                        .font(.headline)
                }
                .padding(.top, 30)
            }
            Button(action: {
                ranking()
            }){
                HStack {
                    Image(systemName: "rosette")
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
            Button(action:  {
                subscribe()
            }){
                HStack {
                    Image(systemName: "creditcard")
                        .foregroundColor(.white)
                        .imageScale(.large)
                    Text("Subscribe")
                        .foregroundColor(.white)
                        .font(.headline)
                }
                .padding(.top, 30)
            }
            Button(action:  {
                feedback()
            }){
                HStack {
                    Image(systemName: "star")
                        .foregroundColor(.white)
                        .imageScale(.large)
                    Text("Rate The App")
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
    @State static var qh =  QuizHandler()
    static var previews: some View {
        MenuView( selector,  $selector, qh)
    }
}
