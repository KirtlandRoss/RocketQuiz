//
//  SideMenu.swift
//  TechnologyQuizApp
//
//  Created by Scott Benson on 5/10/21.
//

import SwiftUI
import CoreData
struct SideMenu<Content: View> : View {
   
    @State private var showMenu = false // holds state for menu toggle
    @Binding var username : String
    @Binding var selector : String
    @ViewBuilder let content : Content
    @Environment(\.managedObjectContext) var context
    @FetchRequest(
        entity: User.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \User.name, ascending: true),
        ]
    ) var users : FetchedResults<User>
    @State private var user : User?

    var body: some View {
        // allows Drag Gesture to close the side menu.
        let drag = DragGesture()
            .onEnded {
                if  $0.translation.width < -100 {
                   withAnimation{
                        self.showMenu = false
                   }
                }
            }
        
        return NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    content
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        // Offset is for the main view size to shrink or grow depending on if the side menu is open, using ternary operator.
                        .offset(x: self.showMenu ? geometry.size.width / 2 : 0)
                        // Disable main view if side menu is open.
                        .disabled(self.showMenu ? true : false)
                    if self.showMenu {
                        MenuView(selector: $selector, username: username)
                            .frame(width: geometry.size.width / 2)
                            // Transition modifier for the menu to move in from the left.
                            .transition(.move(edge: .leading))
                    }
                }
                .gesture(drag) // attaches drag gesture to view.
            }
            // Navigation Bar
            .navigationBarTitle("Side Menu", displayMode: .inline)
            .navigationBarItems(leading: (
                Button(action: {
                    withAnimation{
                        self.showMenu.toggle()
                    }
                }){
                    // Hamburger Button
                    Image(systemName: "line.horizontal.3")
                        .imageScale(.large)
                }
            ))
        }
    }
}

struct MainView: View {
    // Binds main menu to side menu state showMenu variable.
    @Binding var showMenu: Bool
    var body: some View {
        Button(action: {
            // slide animation for side menu open/close.
            withAnimation {
                self.showMenu = true
            }
        }) {
            Text("Show Menu")
        }
    }
}

struct SideMenu_Previews: PreviewProvider {
    @State static var user = User()
    @State static var selector = ""
    static var previews: some View {
       // SideMenu(user: $user){SignUpView()}
        SideMenu(username: $selector, selector: $selector){WelcomeView(selection: $selector, username: $selector)}
    }
}
