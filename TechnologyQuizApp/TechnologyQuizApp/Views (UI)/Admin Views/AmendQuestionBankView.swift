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


    var body: some View {
        VStack{
            VStack{
                Text("Enter Question")
                TextEditor(text: $question)
            }
            VStack{
                Text("Enter Incorrect answers")
                TextEditor(text: $incorrectAnswers1)

            }
            VStack{
            Text("Enter Incorrect answers")
                TextEditor(text: $incorrectAnswers1)}
        }
    }
}

struct AmendQuestionBankView_Previews: PreviewProvider {
    static var previews: some View {
        AmendQuestionBankView()
    }
}
