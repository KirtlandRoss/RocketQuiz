//
//  RankingView.swift
//  TechnologyQuizApp
//
//  Created by Scott Benson on 5/13/21.
//

import SwiftUI

struct UserRankings : Identifiable {
    var id = UUID()
    let name: String
    let score: String
}

struct RankingRow: View {
    var score : UserScores
    var body: some View {
        List {
            HStack {
                Text("Username: \(Text(score.name)) - Score: \(Text(String(score.score)))")
            }
        }
    }
}

struct RankingView: View {
    
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(
        entity: User.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \User.quizScore, ascending: true),
        ]
    ) var users : FetchedResults<User>

    var body: some View {

        let userData = users.map({ (users) -> UserScores in
            return UserScores(name: users.name!, score: String(users.quizScore ?? 0.0))
        })
        
        VStack {
            Color.lightPurpleGray
                .ignoresSafeArea()
            Text("Ranking")
                .foregroundColor(.white)
                .font(.system(size: 40))
                .fontWeight(.bold)
                .padding(.top, 180)
                .frame(height: 0)
            
            HStack{
                List(userData){ data in
                    Text("User: \(data.name) - Score: \(data.score)")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .frame(width: 430, height: 85, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color.lightPurpleGray)
                        .cornerRadius(10)
                        .border(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .bottomTrailing), width:7)
                        .cornerRadius(10)
                        .offset(x: -20)
                }
                .listStyle(InsetGroupedListStyle())
                .frame(width: 470)
                .border(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .trailing), width:7)
            }
            .position(x: 225, y: 500)
            .frame(width: 450, height: 775, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
        .background(Color.lightPurpleGray)
        .colorScheme(.dark)
    }
}

struct RankingView_Previews: PreviewProvider {
    static var previews: some View {
        RankingView()
    }
}
