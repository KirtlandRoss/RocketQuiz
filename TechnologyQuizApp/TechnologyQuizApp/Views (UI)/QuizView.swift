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
    @State var question : String = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s."
    var iAnswers = ["The answer to this question is A, because thats what I am saying.", "The answer to this question is B, because thats what I am saying.", "The answer to this question is C, because thats what I am saying.", "The answer to this question is D, because thats what I am saying."]
    var cAnswer = String()
    init(question : Question ){
        self.question = question.question!
        self.iAnswers = question.incorrectAnswers!
        self.cAnswer = question.correctAnswer!
    }
    var body: some View {


        ZStack { // ZStack for whole view
            Color.purpleGray
                .ignoresSafeArea()
            VStack { // Title and question Number
                //vTitle
                Text(quizName) // title
                    .font(.system(size: 28))
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
                    .offset(x: 0, y: 150)
                // Question Number
                Text("Question: \(questionnumber)")
                    .font(.system(size: 20))
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
                    .offset(x: 0, y: 170)

                ZStack { // Question text
                    Card(shape: "rectangle", width: 350, height: 200, cornerRadius: 30, padding: 40, color: .lightPurpleGray)
                    Text(question)
                        .font(.system(size: 22))

                        .fontWeight(.bold)
                        .frame(width: 325, height: 175, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color.white)
                        .position(x: 215, y: 135)
                }.offset(x: 0, y: 140)

                VStack { // Answers
                    ZStack { // Top(first) answer
                        Button(action:action) {
                            Text(iAnswers[0])
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
                            Text(iAnswers[1])
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
                            Text(iAnswers[2])
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
                            Text(iAnswers[3])
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
            }.offset(y: -60)
        }
    }


}

struct QuizView: View{

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
            }
        }
    }


}

struct QuizView_Previews: PreviewProvider {
    @State static var user = User()
    @State static var qb = QuestionBank()
    static var previews: some View {
        let user = User()
        QuizView()
    }
}
