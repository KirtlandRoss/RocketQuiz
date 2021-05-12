//
//  AdminView.swift
//  TechnologyQuizApp
//
//  Created by Scott Benson on 5/12/21.
//

import SwiftUI

struct AdminView: View {
    func action() {
        
    }
    var body: some View {
        ZStack {
            Color.purpleGray
                .ignoresSafeArea()
            
            Text("Administrator")
                .font(.system(size: 50))
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .padding(.bottom, 50)
            HStack {
                Button(action: { action() }) {
                  Text("Submit")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 125, height: 100)
                    .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .bottomTrailing ))
                    .cornerRadius(15.0)
                }.offset(x: 0, y: 100)
            }
        }
        
    }
}

struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView()
    }
}
