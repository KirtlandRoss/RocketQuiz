//
//  QuizView.swift
//  TechnologyQuizApp
//
//  Created by Scott Benson on 5/11/21.
//

import SwiftUI
import CoreData
import UIKit


//need to figure out a way to save all questions and then submit
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
        sortDescriptors: [ ]
    ) var fetchedQBank : FetchedResults<QuestionBank>
    @FetchRequest(
        entity: Quiz.entity(),
        sortDescriptors: []

    ) var fetchedQuizes : FetchedResults<Quiz>


    private var dbHelp = DBHelper()
    @Binding var mode : String
    @State private var quizHandler : QuizHandler?
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var timeRemaining = 1800
    var username : String

    init (mode: Binding<String>, username : String, _ quizHand : QuizHandler) {
        self._mode = mode
        self.username = username
        self.quizHandler = quizHand
        quizHandler!.generateShuffledAnswers(username, context)
        UITableView.appearance().backgroundColor = .clear


    }

    var body: some View{
        ZStack{
            Color.purpleGray
                .ignoresSafeArea()
            NavigationView{
                Form{
                    Text("Time left: \(timeRemaining/60): \(timeRemaining%60)")
                        .onReceive(timer) { _ in
                            if timeRemaining > 0 {
                                timeRemaining -= 1
                            }
                            else{
                                submitQuiz()
                            }
                        }
                    //get questions out of quiz for correct user
                    ForEach(fetchedQuizes.first(where: {$0.user?.name == username})!.questions?.array as! [QuizQuestion]){ q in
                        NavigationLink(
                            destination: QuizViewContent(question: q, username: username, quizHandler!, Int(q.number)),
                            label: {
                                Text("Question " + String(q.number + 1) + ": " + String(q.question!))
                            })
                    }
                    Button(action: { submitQuiz() }){
                        Text("Submit Quiz")
                    }

                } .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top , endPoint: .bottom ))
                .ignoresSafeArea()

                Text("Time left: \(timeRemaining/60): \(timeRemaining%60)")
                    .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .trailing ))
                    .foregroundColor(.white)
                    .font(.system(size: 23))
            }
        }
    }
    //MARK: Submit quiz
    func submitQuiz(){
        self.mode = "LI"
        print(quizHandler!.correctAnswers)
        dbHelp.updateQuizQuestions(username, quizHandler!.correctAnswers)

        //Submit all questions

    }
}

//MARK: QuizContent
struct QuizViewContent: View {
    @Environment(\.managedObjectContext) var context

    @FetchRequest(
        entity: QuizQuestion.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \QuizQuestion.quiz?.user, ascending: true),
        ]
    ) var users : FetchedResults<QuizQuestion>

    func action() {
        print("hello")
    }

    var username : String
    var questionnumber : Int
    var question : QuizQuestion
    var cAnswer : Int?


    private var qHandler : QuizHandler
    @State private var selected = 5
    var ans = [String]()

    init(question : QuizQuestion, username: String, _ corAnsArray : QuizHandler, _ questionNum : Int){

        qHandler = corAnsArray
        questionnumber = questionNum
        self.username = username
        self.question = question

//       // put all answers in an array
//        self.ans = [question.correctAnswer!] + question.incorrectAnswers!
//        //shuffle
//        ans.shuffle()

        //find correct answer in shuffled answers
        for i in 0...3{
            if qHandler.answerDict[questionnumber]![i] == question.correctAnswer{
                cAnswer = i
            }
        }
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
                Text("Question: \(question.number)")
                    .font(.system(size: 20))
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)

                ZStack { // Question text
                    Card(shape: "rectangle", width: 350, height: 200, cornerRadius: 30, padding: 40, color: .lightPurpleGray)
                    Text((self.question.question)!)
                        .font(.system(size: 22))

                        .fontWeight(.bold)
                        .frame(width: 325, height: 175, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color.white)
                        .position(x: 215, y: 135)
                }

                VStack { // Answers
                    ZStack { // Top(first) answer
                        Button(action:{checkAnswer(0)}) {
                            Text(ans[0])
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 300, height: 75)
                                .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .bottomTrailing ))
                                .cornerRadius(15.0)
                                .colorMultiply(Color(white: 1, opacity: (selected == 0 ? 0.4 : 1)))
                        }
                    }
                    ZStack { // Second answer
                        Button(action:{checkAnswer(1)}) {
                            Text(ans[1])
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 300, height: 75)
                                .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .bottomTrailing ))
                                .cornerRadius(15.0)
                                .colorMultiply(Color(white: 1, opacity: (selected == 1 ? 0.4 : 1)))
                        }
                    }
                    ZStack { // Third answer
                        Button(action:{checkAnswer(2)}) {
                            Text(ans[2])
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 300, height: 75)
                                .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .bottomTrailing ))
                                .cornerRadius(15.0)
                                .colorMultiply(Color(white: 1, opacity: (selected == 2 ? 0.4 : 1)))
                        }
                    }
                    ZStack { // Bottom(last) answer
                        Button(action:{checkAnswer(3)}) {
                            Text(ans[3])
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 300, height: 75)
                                .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .bottomTrailing ))
                                .cornerRadius(15.0)
                                .colorMultiply(Color(white: 1, opacity: (selected == 3 ? 0.4 : 1)))
                        }
                    }
                }.offset(x: 0, y: -10)
                // Display for remaining time to take quiz
                Spacer()
                    .offset(x: 10, y: 10)

            }
        }
    }
    func checkAnswer(_ a : Int){
        selected = a
        if a == cAnswer{
            qHandler.updateScore(Int(question.number))
        }
    }
}


struct QuizView_Previews: PreviewProvider {
    @State static var qb = QuestionBank()
    @State static var qh = QuizHandler()
    @State static var selector = ""
    static var previews: some View {
        QuizView(mode: $selector, username: selector, qh)
    }
}
