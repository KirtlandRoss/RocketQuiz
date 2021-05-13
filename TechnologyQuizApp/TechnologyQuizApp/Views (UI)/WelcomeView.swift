//
//  SwiftUIView.swift
//  TechnologyQuizApp
//
//  Created by Scott Benson on 5/11/21.
//

import SwiftUI

struct WelcomeView: View {

    @Binding var user : User
    @State var selection : String = "welcome"


    var body: some View {

        ZStack { // ZStack for whole view
            Color.purpleGray
                .ignoresSafeArea()
            
            VStack { // Title
                Text("Welcome")
                    .font(.system(size: 50))
                    .fontWeight(.heavy)
                    .foregroundColor(Color.white)
                    .padding(.bottom, 20)
                    .padding(.top, 70)
                
                ZStack{ // Large info card
                    Card(shape: "rectangle", width: 350, height: 300, cornerRadius: 30, padding: 0, color: .lightPurpleGray)
                        .padding(.leading, 40)
                    Text("information")
                        .fontWeight(.heavy)
                        .foregroundColor(Color.white)
                        .font(.system(size: 20))
                }

                HStack { // for 3 horizontal cards.
                    ZStack { // left-most
                        Card(shape: "rectangle", width: 110, height: 150, cornerRadius: 30, padding: 0)
                            .position(x: 60, y: 160)
                        Text("info")
                            .position(x: 55, y: 50)

                            .foregroundColor(Color.white)
                            .padding(.bottom, 20)
                            .padding(.top, 70)

                        ZStack{ // Large info card
                            Card(shape: "rectangle", width: 350, height: 300, cornerRadius: 30, padding: 0, color: .lightPurpleGray)
                                .padding(.leading, 40)
                            Text("information")
                                .fontWeight(.heavy)
                                .foregroundColor(Color.white)
                                .font(.system(size: 20))
                        }
                        HStack { // for 3 horizontal cards.
                            ZStack { // left-most
                                Card(shape: "rectangle", width: 110, height: 150, cornerRadius: 30, padding: 0)
                                    .position(x: 60, y: 160)
                                Text("info")
                                    .position(x: 55, y: 50)
                                    .foregroundColor(Color.white)

                            }
                            ZStack { // middle
                                Card(shape: "rectangle", width: 110, height: 150, cornerRadius: 30, padding: 0)
                                    .position(x: 50, y: 160)
                                Text("info")
                                    .position(x: 45, y: 50)
                                    .foregroundColor(Color.white)
                            }

                            ZStack { // right
                                Card(shape: "rectangle", width: 110, height: 150, cornerRadius: 30, padding: 0)
                                    .position(x: 40, y: 160)
                                Text("info")
                                    .position(x: 35, y: 50)
                                    .foregroundColor(Color.white)
                            }

                        }.padding(.leading, 40)

                        ZStack { // Buttons to start quizzes
                            // top button
                            NavigationLink(destination: QuizView( user)){
                                Text("Start Quiz 1")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(width: 350, height: 75)
                                    .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .bottomTrailing ))
                                    .cornerRadius(15.0)
                            }.offset(x: 0, y: -90)

                            // bottom button
                            Text("Start Quiz 2")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 350, height: 75)
                                .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .bottomTrailing ))
                                .cornerRadius(15.0)

                        }

                    }
                }


        }.navigationBarTitle("")
        .navigationBarHidden(true)

    }
        }

        
}
struct WelcomeView_Previews: PreviewProvider {
    @State static var user = User()
    static var previews: some View {

            WelcomeView(user: $user)

    }
}
