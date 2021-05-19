//
//  FeedbackView.swift
//  TechnologyQuizApp
//
//  Created by Scott Benson on 5/18/21.
//

import SwiftUI
import AVFoundation

struct FeedbackView: View {
    @State private var starOneTapped = false
    @State private var starTwoTapped = false
    @State private var starThreeTapped = false
    @State private var starFourTapped = false
    @State private var starFiveTapped = false
    @State private var submittedText = " "
    @State private var isSubmitted = false
    
    @State private var transcript = ""
    private let speechRecognizer = SpeechRecognizer()
    @State private var isRecording = false
    
    @State private var count = 1
    
    var body: some View {
        VStack {
            Spacer()
            Text("Feedback")
                .foregroundColor(.white)
                .font(.system(size: 30))
                .fontWeight(.bold)
            Text("Select rating from 1-5 below")
                .foregroundColor(.white)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .padding()
            HStack {
                Image(systemName: count >= 1 ? "star.fill" : "star")      .foregroundColor(count >= 1 ? .purple : .white)
                    .font(.system(size: 30))
                    .onTapGesture {
                        count = 1
                    }
                Image(systemName: count >= 2 ? "star.fill" : "star")      .foregroundColor(count >= 2 ? .purple : .white)
                    .foregroundColor(.black)
                    .font(.system(size: 30))
                    .onTapGesture {
                        count = 2
                    }
                Image(systemName: count >= 3 ? "star.fill" : "star")      .foregroundColor(count >= 3 ? .purple : .white)
                    .foregroundColor(.black)
                    .font(.system(size: 30))
                    .onTapGesture {
                        count = 3
                    }
                Image(systemName: count >= 4 ? "star.fill" : "star")      .foregroundColor(count >= 4 ? .purple : .white)
                    .foregroundColor(.black)
                    .font(.system(size: 30))
                    .onTapGesture {
                        count = 4
                    }
                Image(systemName: count >= 5 ? "star.fill" : "star")      .foregroundColor(count >= 5 ? .purple : .white)
                    .foregroundColor(.black)
                    .font(.system(size: 30))
                    .onTapGesture {
                        count = 5
                    }
                
            }.disabled(isSubmitted == true)
            Text(submittedText)
                .foregroundColor(.green)
                .font(.system(size: 20))
                .padding()
        Spacer()
        VStack{
        Text("Type feedback below or record voice(optional)")
            .foregroundColor(.white)
        TextEditor(text: $transcript)
            .frame(width: 400, height: 150, alignment: .leading)
            .foregroundColor(.black)
            .padding()
            .disabled(isSubmitted == true)
        HStack {
            Button(action: {
                if !isRecording {
                    speechRecognizer.record(to: $transcript)
                    isRecording = true
                } else {
                    speechRecognizer.stopRecording()
                    isRecording = false
                }
                
            }){
                Text(isRecording ? "Stop Recording" : "Start Recording")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width: 175, height: 50)
                    .background(isRecording ? LinearGradient(gradient: Gradient(colors: [.red, .purple]), startPoint: .leading , endPoint: .bottomTrailing ) : LinearGradient(gradient: Gradient(colors: [.green, .blue]), startPoint: .leading , endPoint: .bottomTrailing ))
                    .cornerRadius(15.0)
            }.disabled(isSubmitted == true)
        }
            Button(action: {submit()}){
                Text("Submit")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width: 350, height: 50)
                    .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .bottomTrailing ))
                    .cornerRadius(15.0)
                    .padding()
            }.disabled(isSubmitted == true)
        }
        Spacer()
    }.background(Color.purpleGray)
        .ignoresSafeArea()
    }

    func submit() -> Int {
        submittedText = "Feedback Submitted"
        isSubmitted = true
        print("Submitted", count)
        submitTranscript(transcript: transcript)
        return count
    }
    
    func submitTranscript(transcript: String) -> String {
        print(transcript)
        return transcript
    }
    
}

struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackView()
    }
}
