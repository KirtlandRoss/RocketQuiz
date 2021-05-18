//
//  AmendQuestionBankView.swift
//  TechnologyQuizApp
//
//  Created by Kirtland Ross on 5/17/21.
//

import SwiftUI

struct AmendQuestionBankView: View {
    @State private var question : String = ""
    @State private var answer : String = ""
    @State private var incorrectAnswers1 : String = ""
    @State private var incorrectAnswers2 : String = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var incorrectAnswers3 : String = ""
    private var dbHanlder = DBHelper()
    var body: some View {
        Form{
            VStack{
                Text("Enter Question")
                TextEditor(text: $question).border(Color.black, width: 5)
            }
            VStack{
                Text("Enter Answer")
                TextEditor(text: $answer).border(Color.black, width: 5)
            }
            VStack{
                Text("Enter Incorrect answers")
                TextEditor(text: $incorrectAnswers1).border(Color.black, width: 5)

                TextEditor(text: $incorrectAnswers2).border(Color.black, width: 5)

                TextEditor(text: $incorrectAnswers3).border(Color.black, width: 5)
            }
            VStack {
                Button(action: {submit()}) {
                    Text("Submit")
                }
            }
        }.background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top , endPoint: .bottom ))

    }
    func submit(){
        let incorrectAnswers = [incorrectAnswers1, incorrectAnswers2, incorrectAnswers3]
        dbHanlder.appendQuestionBank(question: question, answer: answer, incorrectAnswers: incorrectAnswers)
        self.presentationMode.wrappedValue.dismiss()
        
    }
}

struct AmendQuestionBankView_Previews: PreviewProvider {
    static var previews: some View {
        AmendQuestionBankView()
    }
}
