//
//  DiscussionBoardUI.swift
//  TechnologyQuizApp
//
//  Created by Scott Benson on 5/11/21.
//

import SwiftUI

struct MessageInfo: Identifiable {
    var id = UUID()
    let name: String
    let message: String
}

struct MessageRow: View {

    var message : MessageInfo
    
    var body: some View {
            List {
                HStack {
                    Text("\(message.name): \(message.message)")
                }
            }.frame(width: 360, height: 45).listStyle(PlainListStyle())
    }
}

struct DiscussionBoardUI: View {
    @State var user : String = "Scott"
    @State var newMessage: String = ""
    let message = [MessageInfo]()
    let messages = DBHelper.inst.getAllDiscussionPosts()

    var body: some View {
        
        let userData = messages.map({ (message) -> MessageInfo in
            return MessageInfo(name: message["name"]!, message: message["content"]!)
        })
        
        VStack{
            Color.purpleGray
            .ignoresSafeArea()
            Text("Discussion")
                .foregroundColor(.white)
                .font(.system(size: 40))
                .fontWeight(.bold)
                .padding(.top, 50)
            
            HStack{
                List(userData){ data in
                    Text("\(data.name): \(data.message)")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .frame(width: 420, height: 50, alignment: .leading)
                        .padding(.leading, 10)
                        .background(Color.lightPurpleGray)
                        .cornerRadius(10)
                        .border(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .bottomTrailing), width:7)
                        .cornerRadius(10)
                        .offset(x: -20)
                }
                .listStyle(InsetGroupedListStyle())
                .frame(width: 470, height: 560)
                
            }.border(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .trailing), width:7)
            VStack {
//                Button(action: {
//                    print(messages)
//                }) {
//                    Text("Get Posts")
//                }
                Text("Enter message below to add to the discussion.")
                    .foregroundColor(.white)
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                    
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
                    submit(name: user, message: newMessage),
                    newMessage = ""
                ) }) {
                    Text("Submit")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 350, height: 50)
                        .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .bottomTrailing ))
                        .cornerRadius(15.0)
                        .padding(.top, 10)
                        .padding(.bottom, 60)
                }
            }.frame(height: 260)
        }.background(Color.purpleGray)
    }
    func submit(name: String, message: String) {
        DBHelper().addDiscussionPost(name, message)
    }
}

struct DiscussionBoard_Previews: PreviewProvider {
    static var previews: some View {
        DiscussionBoardUI()
    }
}
