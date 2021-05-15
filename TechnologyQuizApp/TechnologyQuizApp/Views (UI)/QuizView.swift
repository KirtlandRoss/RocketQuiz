//
//  QuizView.swift
//  TechnologyQuizApp
//
//  Created by Scott Benson on 5/11/21.
//

import SwiftUI
import CoreData
struct QuizViewContent: View {


    func action() {
        print("hello")
    }
    var time : String = "2:00"
    
    var questionnumber : Int = 1
    var quizName : String = "SwiftUI Fundamentals"
    var question : Question?
    var cAnswer = String()
    init(question : Question ){
        self.question = question
        print(self.question!.incorrectAnswers![0])
    }
    var body: some View {


        ZStack { // ZStack for whole view
            Color.purpleGray
                .ignoresSafeArea()
            VStack { // Title and question Number
                //vTitle
                Text("Title") // title
                    .font(.system(size: 28))
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
                // Question Number
                Text("Question: \(questionnumber)")
                    .font(.system(size: 20))
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)

                ZStack { // Question text
                    Card(shape: "rectangle", width: 350, height: 200, cornerRadius: 30, padding: 40, color: .lightPurpleGray)
                    Text((self.question?.question)!)
                        .font(.system(size: 22))

                        .fontWeight(.bold)
                        .frame(width: 325, height: 175, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color.white)
                        .position(x: 215, y: 135)
                }

                VStack { // Answers
                    ZStack { // Top(first) answer
                        Button(action:action) {
                            Text((self.question?.incorrectAnswers![0])!)
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 300, height: 75)
                                .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .bottomTrailing ))
                                .cornerRadius(15.0)
                        }
                    }
                    ZStack { // Second answer
                        Button(action:action) {
                            Text((self.question?.incorrectAnswers![1])!)
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 300, height: 75)
                                .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .bottomTrailing ))
                                .cornerRadius(15.0)
                        }
                    }
                    ZStack { // Third answer
                        Button(action:action) {
                            Text((self.question?.incorrectAnswers![2])!)
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 300, height: 75)
                                .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .bottomTrailing ))
                                .cornerRadius(15.0)
                        }
                    }
                    ZStack { // Bottom(last) answer
                        Button(action:action) {
                            Text((self.question?.correctAnswer!)!)
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 300, height: 75)
                                .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .bottomTrailing ))
                                .cornerRadius(15.0)
                        }
                    }
                }.offset(x: 0, y: -10)
                // Display for remaining time to take quiz
                Text("Time remaining: \(time)")
                    .offset(x: 10, y: 10)
                    .foregroundColor(.white)
                    .font(.system(size: 23))
            }
        }
    }
}

struct QuizView: View{
    @Binding var mode : String
    @Environment(\.managedObjectContext) var context
    @FetchRequest(
        entity: User.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \User.name, ascending: true),
        ]
    ) var users : FetchedResults<User>
    @FetchRequest(
        entity: QuestionBank.entity(),
        sortDescriptors: []
    ) var fetchedQBank : FetchedResults<QuestionBank>

    var body: some View{

        NavigationView{
            Form{
                ForEach(fetchedQBank.first?.questions?.array as! [Question]){ q in
                    NavigationLink(
                        destination: QuizViewContent( question: q),
                        label: {
                            Text("Question " + String(q.question!))
                        })

                }
                Button(action: { self.mode = "LI" }){
                    Text("Exit Quiz")
                }

            }
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    @State static var qb = QuestionBank()
    @State static var selector = ""
    static var previews: some View {
        QuizView(mode: $selector)
    }
}
