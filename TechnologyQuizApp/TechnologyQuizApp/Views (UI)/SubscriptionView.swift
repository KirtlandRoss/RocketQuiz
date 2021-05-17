//
//  SubscriptionView.swift
//  TechnologyQuizApp
//
//  Created by Scott Benson on 5/16/21.
//

import SwiftUI

struct SubscriptionView: View {
    @State private var firstName : String = ""
    @State private var lastName : String = ""
    @State private var cardNumber : String = ""
    @State private var expiration : String = ""
    @State private var cvvNumber : String = ""
    @State private var warningText: String = ""
    @State private var validFields : Bool = false
    var username: String = "scott"
    
    var body: some View {
        
        VStack{
            Spacer()
            Text("Subscribe")
                .foregroundColor(.white)
                .font(.system(size: 40))
                .fontWeight(.bold)
                .padding(.top, 110)
            VStack {
                Spacer()
                Text("Enter payment information below")
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .padding()
                Spacer()
                CustomTextField(isSecure: false, placeholder: Text("First Name"), text: $firstName)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.lightPurpleGray)
                    .cornerRadius(20.0)
                CustomTextField(isSecure: false, placeholder: Text("Last Name"), text: $lastName)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.lightPurpleGray)
                    .cornerRadius(20.0)
                CustomTextField(isSecure: false, placeholder: Text("Card Number (ex: 1234567890123412)"), text: $cardNumber)
                    .keyboardType(.numberPad)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.lightPurpleGray)
                    .cornerRadius(20.0)
                CustomTextField(isSecure: false, placeholder: Text("Expiration Date - MMYY (ex: 1231)"), text: $expiration)
                    .keyboardType(.numberPad)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.lightPurpleGray)
                    .cornerRadius(20.0)
                CustomTextField(isSecure: false, placeholder: Text("CVV (ex: 123)"), text: $cvvNumber)
                    .keyboardType(.numberPad)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.lightPurpleGray)
                    .cornerRadius(20.0)
                Spacer()
                
            }.padding()
            VStack {
                Text(warningText)
                    .padding()
                    .foregroundColor(validFields ? .green : .red)
                
                Spacer()
                
                Button(action: {(
                    submit()
                ) }) {
                    Text("Submit")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 350, height: 50)
                        .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading , endPoint: .bottomTrailing ))
                        .cornerRadius(15.0)
                        .padding(.top, 10)
                        .padding(.bottom, 60)
                }
            }
        }.background(Color.purpleGray)
        .ignoresSafeArea()
    }
    
    func submit() {
        if validateData() {
            validFields = true
            warningText = "Submitted"
            DBHelper.inst.updateSubscriptionStatus(name: username, subscriptionStatus: true)
            firstName = ""
            lastName = ""
            cardNumber = ""
            expiration = ""
            cvvNumber = ""
        } else {
            validFields = false
            warningText = "Invalid entry"
        }
    }
    
    func validateData() -> Bool {

        if firstName.count < 1 || firstName.count > 20 {
            print("first name invalid")
            return false
        }
        else if lastName.count < 1 || lastName.count > 20 {
            print("Last Name  invalid")
            return false
        }
        else if cardNumber.count != 16 {
            print("Card Number invalid")
            return false
        }
        else if expiration.count != 4 {
            print("Expiration invalid")
            return false
        }
        else if cvvNumber.count != 3 {
            print("CVV  invalid")
            return false
        } else {
            return true
        }
    }
    
}

struct SubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionView()
    }
}
