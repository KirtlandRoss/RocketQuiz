//
//  DiscussionBoardUI.swift
//  TechnologyQuizApp
//
//  Created by Scott Benson on 5/11/21.
//

import SwiftUI

struct MessageInfo: Identifiable {
    var id = UUID()
    let username: String
    let message: String
}

struct MessageRow: View {
    var message : MessageInfo
    var body: some View {
            List {
                HStack {
                    Text("\(Text(message.username)): \(Text(message.message))")
                }
            }.frame(width: 360, height: 45).listStyle(PlainListStyle())
    }
}

struct DiscussionBoardUI: View {
    @State var userInfo = [MessageInfo(username: "user1", message: "message 1"), MessageInfo(username: "user2", message: "message 2")]
    
    var body: some View {
        
        
            
        List {
            
            ForEach(userInfo){ message in
                MessageRow(message: message)
            }.frame(width: 320).disabled(true)
        }

    }
        
}

struct DiscussionBoard_Previews: PreviewProvider {
    static var previews: some View {
        DiscussionBoardUI()
    }
}
