//
//  FeedbackView.swift
//  TechnologyQuizApp
//
//  Created by Scott Benson on 5/18/21.
//

import SwiftUI

struct FeedbackView: View {
    @State var starOneTapped = false
    @State var starTwoTapped = false
    @State var starThreeTapped = false
    @State var starFourTapped = false
    @State var starFiveTapped = false
    
    var body: some View {
        VStack {
//            Color.purpleGray
//                .ignoresSafeArea()
            Text("Feedback")
            Spacer()
            HStack {
                Image(systemName: starOneTapped ? "star" : "star.fill")      .foregroundColor(starOneTapped ? Color.lightPurpleGray : Color.purpleGray)
                    .imageScale(.large)
                    .onTapGesture {
                        starOneTapped.toggle()
                    }
                Image(systemName: "star")
                    .foregroundColor(.black)
                    .imageScale(.large)
                Image(systemName: "star")
                    .foregroundColor(.black)
                    .imageScale(.large)
                Image(systemName: "star")
                    .foregroundColor(.black)
                    .imageScale(.large)
                Image(systemName: "star")
                    .foregroundColor(.black)
                    .imageScale(.large)
            }
            Spacer()
        }
        Spacer()
    }
}

struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackView()
    }
}
