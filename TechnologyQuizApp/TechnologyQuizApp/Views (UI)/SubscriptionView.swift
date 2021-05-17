//
//  SubscriptionView.swift
//  TechnologyQuizApp
//
//  Created by Scott Benson on 5/16/21.
//

import SwiftUI

struct SubscriptionView: View {
    @State private var fullname : String = ""
    @State private var cardNumber : String = ""
    @State private var expiration : String = ""
    @State private var cvvNumber : String = ""
    @State private var warningText: String = ""
    @State private var validFields : Bool = false
    @Binding var username : String
    
    var body: some View {

        VStack{
            VStack {
    
                ZStack {
                    Spacer()
                    RoundedRectangle(cornerRadius: 25.0)

                        .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple, Color.red, Color.purple, Color.blue, Color.red, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        
                        .frame(width: 400, height: 250)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10) // positive numbers, down and right
                        .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                        .blur(radius: 0.1)
                        .cornerRadius(25)
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(Color.white)
                        .frame(width: 400, height: 250)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10) // positive numbers, down and right
                        .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                        .blur(radius: 0.1)
                        .opacity(0.7)
                        .cornerRadius(25)
                    Text("Mastercard")
                        .foregroundColor(.white)
                        .font(.system(size: 35))
                        .fontWeight(.heavy)
                        .offset(x: -85, y: -80)
                    Text(cardNumber)
                        .foregroundColor(.white)
                        .font(.system(size: 35))
                    Text("Expiration")
                        .foregroundColor(.white)
                        .font(.system(size: 10))
                        .fontWeight(.black)
                        .offset(x: -150, y: 70)
                    Text(expiration)
                        .foregroundColor(.white)
                        .font(.system(size: 10))
                        .fontWeight(.black)
                        .offset(x: -150, y: 90)
                    Text(fullname)
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .fontWeight(.black)
                        .offset(x: 60, y: 80)
                    Text("CVV")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .fontWeight(.black)
                        .offset(x: 120, y: -80)
                    Text(cvvNumber)
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .fontWeight(.black)
                        .offset(x: 120, y: -50)

                }
                .offset(y: 120)
            }
            VStack {
                Spacer()
                Text("Enter payment information below")
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .padding()
                CustomTextField(isSecure: false, placeholder: Text("Name (Character limit: 20)").foregroundColor(.gray), text: $fullname)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.lightPurpleGray)
                    .cornerRadius(20.0)
                CustomTextField(isSecure: false, placeholder: Text("Card Number (ex: 1234567890123412)").foregroundColor(.gray), text: $cardNumber)
                    .keyboardType(.numberPad)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.lightPurpleGray)
                    .cornerRadius(20.0)
                CustomTextField(isSecure: false, placeholder: Text("Expiration Date - MMYY (ex: 1231)").foregroundColor(.gray), text: $expiration)
                    .keyboardType(.numberPad)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.lightPurpleGray)
                    .cornerRadius(20.0)
                CustomTextField(isSecure: false, placeholder: Text("CVV (ex: 123)").foregroundColor(.gray), text: $cvvNumber)
                    .keyboardType(.numberPad)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.lightPurpleGray)
                    .cornerRadius(20.0)
                
            }.padding()
            VStack {
                Text(warningText)
                    .padding()
                    .foregroundColor(validFields ? .green : .red)
                
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
            expiration.insert("/", at: expiration.index(expiration.startIndex, offsetBy: 2)) // adds "/" to date, ex: 12/22"
            validFields = true
            warningText = "Submitted"
            DBHelper.inst.updateSubscriptionStatus(name: username, subscriptionStatus: true)
            fullname = ""
            cardNumber = ""
            expiration = ""
            cvvNumber = ""
        } else {
            validFields = false
            warningText = "Invalid entry"
        }
    }
    
    func validateData() -> Bool {

        if fullname.count < 1 || fullname.count > 30 {
            print("first name invalid")
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

//struct SubscriptionView_Previews: PreviewProvider {
//    static var previews: some View {
//        SubscriptionView(username: "")
//    }
//}
