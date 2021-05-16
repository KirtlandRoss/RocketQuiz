//
//  SwiftUIView.swift
//  TechnologyQuizApp
//
//  Created by Scott Benson on 5/13/21.
//

import SwiftUI

struct UserScores : Identifiable {
    var id = UUID()
    let name: String
    let score: String
}

struct ScoreRow: View {
    var score : UserScores
    var body: some View {
        List {
            HStack {
                Text("Username: \(Text(score.name)) - Score: \(Text(String(score.score)))")
            }
        }.frame(width: 360, height: 45).listStyle(PlainListStyle())
    }
}

struct UserScoreAdminView: View {
    
    @Environment(\.managedObjectContext) var context
    @State var user : User?
    
    @FetchRequest(
        entity: User.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \User.name, ascending: true),
        ]
    ) var users : FetchedResults<User>

    var body: some View {
        let userData = users.map({ (users) -> UserScores in
            return UserScores(name: users.name!, score: String(users.quizScore ?? 0.0))
        })
        VStack {
            Text("User Scores")
            HStack{
                List(userData){ data in
                    Text("User: \(data.name) - Score: \(data.score)")
                }
            }
        }
    }
}

struct UserScoreAdminView_Previews: PreviewProvider {
    static var previews: some View {
        UserScoreAdminView()
    }
}
