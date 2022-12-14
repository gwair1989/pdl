//
//  ContentView.swift
//  pdl
//
//

import SwiftUI

struct CreateRequestView: View {
    @State private var currentStep = 1
    @State private var selectedLoan = 2500.0
    @State private var isEditing = false
    @State private var isShowProfileView = false
    @State private var selectedTenure = 3.0
    @State private var selectedIncome = 2000.0
    @State private var email: String = ""
    @State private var lasnNum: String = ""
    @State private var isShowWebView: Bool = false
    @State private var ssnPlaceholder = ""
    @State private var isValidSNN: Bool = false
    @State private var isValidEmail: Bool = false
    @State private var isShowCheckmarkValidSnn: Bool = false
    @State private var isShowCheckmarkValidEmail: Bool = false
    @StateObject private var model: LoanViewModel = LoanViewModel()
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    var body: some View {
        Background {
            VStack(spacing: 0) {
                HeaderView(step: currentStep, title: "Create a request", imageSize: model.getWidthEqualScreen(52))
                if !isShowWebView {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 10) {
                            SelectAmountView()
                                .shadow(radius: 4)
                            PersonalDetailsView()
                                .shadow(radius: 4)
                            Spacer()
                        }
                    }
                } else {
                    LoanWebView(urlString: model.getURlfromRemoteConfig(url: firebaseManager.urlString, email: email, snn: lasnNum, loanAmount: selectedLoan))
                }
            }
        }
        .background(Color(hex: "F7F7F7")
            .ignoresSafeArea(.all)
        )
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        
    }
    
    
    private func SelectAmountView() -> some View {
        VStack(alignment: .center) {
            VStack(spacing: 25) {
                VStack(spacing: 8) {
                    Text("Select a Loan Amount")
                        .font(.semibold18())
                        .foregroundColor(.black)
                    Text("Move the slider to select your loan amount.")
                        .font(.regular18())
                        .foregroundColor(Color(hex: "ACACAC"))
                        .multilineTextAlignment(.center)
                }
                Text("$\(Int(selectedLoan))")
                    .font(.bold30())
                    .foregroundColor(.black)
            }
            
            Slider(
                value: $selectedLoan,
                in: 200...5000,
                step: 100
            ) {
                
            } minimumValueLabel: {
                Text("200")
                    .font(.semibold18())
                    .foregroundColor(Color(hex: "828282"))
            } maximumValueLabel: {
                Text("5000")
                    .font(.semibold18())
                    .foregroundColor(Color(hex: "828282"))
            } onEditingChanged: { editing in
                isEditing = editing
            }
            .accentColor(Color(hex: "34CB81"))
            .accessibilityIdentifier("SelectAmountSlider")
            
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .padding()
    }
    
    
    private func PersonalDetailsView() -> some View {
        VStack(alignment: .center, spacing: 25) {
            Text("Personal Details")
                .font(.semibold18())
                .foregroundColor(.black)
            
            emailView
            ssnView
            Button {
                print("Tap: Next")
                if isValidSNN && isValidEmail {
                    if firebaseManager.isEnabled {
                        withAnimation {
                            isShowWebView = true
                        }
                    }
                }
                
            } label: {
                Text("Next")
                    .font(.semibold22())
                    .foregroundColor(isValidEmail && isValidSNN ? .white : Color(hex: "E0E0E0"))
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background (
                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                            .fill(Color(hex: isValidEmail && isValidSNN ? "34CB81" : "BDBDBD")))
            }
            .accessibilityIdentifier("nextButton")
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .padding(.horizontal)
    }
    
    private var ssnView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Last 4 numbers of SSN")
                .font(.regular16())
                .foregroundColor(Color(hex: "BDBDBD"))
            
            ZStack {
                TextField("", text: isValidSNN ? $ssnPlaceholder : $lasnNum, onEditingChanged: { isEditing in
                    if isEditing {
                        lasnNum = ""
                        ssnPlaceholder = ""
                    }
                }, onCommit: {
                    
                })
                .placeholder(when: lasnNum.isEmpty && !isShowCheckmarkValidSnn) {
                    HStack {
                        Text("?????????-??????-1234")
                            .font(.medium18())
                            .foregroundColor(Color(hex: "BDBDBD"))
                    }
                }
                .accessibilityIdentifier("ssnTextField")
                .keyboardType(.numbersAndPunctuation)
                .padding()
                .background(Color(hex: "F5F8F9"))
                .cornerRadius(5)
                .foregroundColor(.black)
                .onChange(of: lasnNum) { newValue in
                    isShowCheckmarkValidSnn = true
                    let snnPlace = "?????????-??????-"
                    ssnPlaceholder = ""
                    if ssnPlaceholder.isEmpty {
                        isValidSNN = model.isSSNValid(newValue)
                    }
                    if isValidSNN {
                        ssnPlaceholder = snnPlace + lasnNum
                    }
                }
                
                if isShowCheckmarkValidSnn {
                    HStack {
                        Spacer()
                        Image(systemName: isValidSNN ? "checkmark" : "xmark")
                            .accessibilityIdentifier("validImageSnn")
                            .font(.system(size: 17))
                            .foregroundColor(Color(hex: isValidSNN ? "34CB81" : "FF0000"))
                    }
                    .padding(.trailing)
                }
            }
        }
    }
    
    private var emailView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Your e-mail address")
                .font(.regular16())
                .foregroundColor(Color(hex: "BDBDBD"))
            
            ZStack {
                TextField("", text: $email)
                    .placeholder(when: email.isEmpty) {
                        Text(verbatim: "zuza@yahoo.com")
                            .font(.medium18())
                            .foregroundColor(Color(hex: "BDBDBD"))
                    }
                    .accessibilityIdentifier("emailTextField")
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .padding()
                    .background(Color(hex: "F5F8F9"))
                    .cornerRadius(5)
                    .foregroundColor(.black)
                    .onChange(of: email) { newValue in
                        isValidEmail = model.isEmailValid(newValue)
                        isShowCheckmarkValidEmail = true
                    }
                if isShowCheckmarkValidEmail {
                    HStack {
                        Spacer()
                        Image(systemName: isValidEmail ? "checkmark" : "xmark")
                            .accessibilityIdentifier("validImageEmail")
                            .font(.system(size: 17))
                            .foregroundColor(Color(hex: isValidEmail ? "34CB81" : "FF0000"))
                    }
                    .padding(.trailing)
                }
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRequestView()
    }
}
