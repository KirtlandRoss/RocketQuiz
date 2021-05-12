//
//  DiscussionBoardUI.swift
//  TechnologyQuizApp
//
//  Created by Scott Benson on 5/11/21.
//

import SwiftUI

struct DiscussionBoardUI: View {
    @State var messages: Array = ["hello", "does", "this", "work?"]
    @State var usernames: Array = ["hello", "does", "this", "work?"]
    
    var body: some View {
        NavigationView {
        List(messages, id: \.self) {
            Text($0)
        }
    }
    }
}

struct DiscussionBoard_Previews: PreviewProvider {
    static var previews: some View {
        DiscussionBoardUI()
    }
}
