//
//  FacebookButton.swift
//  TechnologyQuizApp
//
//  Created by Kirtland Ross on 5/12/21.
//

import SwiftUI
import UIKit
import FBSDKLoginKit
struct FacebookButton: UIViewRepresentable {
    func updateUIView(_ uiView: UIViewType, context: Context) {
        FBLoginButton()
    }

    func makeUIView(context: Context) -> some UIView {
        FBLoginButton()
    }
   
}

struct FacebookButton_Previews: PreviewProvider {
    static var previews: some View {
        FacebookButton()
    }
}
