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
                    .font(.system(size: 50))
                    .fontWeight(.heavy)
                    .foregroundColor(Color.white)
                
                
                ZStack{ // Large info card
                    Card(shape: "rectangle", width: 350, height: 300, cornerRadius: 30, padding: 0, color: .lightPurpleGray)
                        .padding(.leading, 40)
                    Text("information")
                        .fontWeight(.heavy)
                        .foregroundColor(Color.white)
                        .font(.system(size: 20))
                }
                
                Spacer()
                ZStack { // left-most
                    HStack { // for 3 horizontal cards.
                        ZStack { // left-most
                            Card(shape: "rectangle", width: 110, height: 150, cornerRadius: 30, padding: 0)
                            //                                    .position(x: 60, y: 160)
                            Text("info")
                                .position(x: 55, y: 50)
                                .foregroundColor(Color.white)
                        }
                        ZStack { // middle
                            Card(shape: "rectangle", width: 110, height: 150, cornerRadius: 30, padding: 0)
                            //                                    .position(x: 50, y: 160)
                            Text("info")
                                .position(x: 45, y: 50)
                                .foregroundColor(Color.white)
                        }
                        
                        ZStack { // right
                            Card(shape: "rectangle", width: 110, height: 150, cornerRadius: 30, padding: 0)
                            //                                    .position(x: 40, y: 160)
                            Text("info")
                                .position(x: 35, y: 50)
                                .foregroundColor(Color.white)
                        }
                        
                    }.padding(.leading, 40)
                }
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
