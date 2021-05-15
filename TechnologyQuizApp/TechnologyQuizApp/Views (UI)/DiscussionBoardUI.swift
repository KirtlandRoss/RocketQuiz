//
//  DiscussionBoardUI.swift
//  TechnologyQuizApp
//
//  Created by Scott Benson on 5/11/21.
//

import SwiftUI

struct MessageInfo: Identifiable {
    var id = UUID()
    let message: String
}

struct MessageRow: View {
    @Environment(\.managedObjectContext) var context

    @FetchRequest(
        entity: User.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \User.posts, ascending: true),
        ]
    ) var users : FetchedResults<User>

    var message : MessageInfo
    
    var body: some View {
            List {
                HStack {
                    Text("\(Text(message.message))")
                }
            }.frame(width: 360, height: 45).listStyle(PlainListStyle())
    }
}

struct DiscussionBoardUI: View {
    @State var user : String = "Scott"
    @State var newMessage: String = ""
    let message = [MessageInfo]()
    
    var body: some View {
        VStack{
            List {
                ForEach(message){ message in
                    MessageRow(message: message)
                }.frame(width: 320).disabled(true)
            }
            VStack {
                Button(action: {
                    print(DBHelper.inst.getAllDiscussionPosts())
                }) {
                    Text("Get Posts")
                }
                CustomTextField(
                    isSecure: false,
                    placeholder: Text("Enter new post here...").foregroundColor(.gray),
                    text: $newMessage
                )
                .padding()
                .foregroundColor(.white)
                .background(Color.lightPurpleGray)
                .cornerRadius(20.0)
                .frame(width: 350)
                .padding(.top, 30)
                
                Button(action: { (
                    submit(name: user, message: newMessage)
                ) }) {
                    Text("Submit")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 350, height: 50)
                        .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .bottomTrailing ))
                        .cornerRadius(15.0)
                        .padding()
                }
            }
        }.background(Color.purpleGray)
    }
    func submit(name: String, message: String) {
        DBHelper.inst.addDiscussionPost(name, message)
    }
}

struct DiscussionBoard_Previews: PreviewProvider {
    static var previews: some View {
        DiscussionBoardUI()
    }
}
