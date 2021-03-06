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
            NSSortDescriptor(keyPath: \User.averageScore, ascending: false),
        ]
    ) var users : FetchedResults<User>
    let dbHelp = DBHelper()
    var body: some View {
        
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
                List(dbHelp.avrgScore()){ data in
                    Text("User: \(data.name!) - Score: \(data.averageScore * 100) %")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .frame(width: 430, height: 85, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color.lightPurpleGray)
                        .cornerRadius(10)
                        .border(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .bottomTrailing), width:4)
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
