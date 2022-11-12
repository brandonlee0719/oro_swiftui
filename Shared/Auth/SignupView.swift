//
//  SignupView.swift
//  ORO
//
//  Created by MAC on 2022/11/11.
//

import SwiftUI
import Firebase

let containerWidth:CGFloat = UIScreen.main.bounds.width
let containerHeight:CGFloat = UIScreen.main.bounds.height

struct SignupView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var selection: Int? = 0

    @State var email = ""
    @State var password = ""
    @State var passwordConfirmation = ""
    
    @State var signUpProcessing = false
    @State var signUpErrorMessage = ""

    let main = MainView(viewRouter: MainRouter(), audioRecorder: AudioRecorder())
    let background = LinearGradient(gradient: Gradient(colors: [Color(red: 86/255, green: 183/255, blue: 230/255), Color(red: 121/255, green: 211/255, blue: 255/255)]), startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        ZStack {
            background
            .edgesIgnoringSafeArea(.all)
            VStack(spacing: 15) {
                Spacer()
                LogoView()
                Spacer()
                SignUpCredentialFields(email: $email, password: $password, passwordConfirmation: $passwordConfirmation)
                NavigationLink(destination: main.navigationBarHidden(true), tag: 1, selection: $selection) {
                    Button(action: {
                        signUpUser(userEmail: email, userPassword: password)
                    }) {
                        if signUpProcessing {
                            ProgressView()
                                .padding()
                                .frame(minWidth: 0, maxWidth: .infinity)
                        } else {
                            Text("Create Account")
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .font(.system(size: 18))
                                .padding()
                                .foregroundColor(Color(red: 0.337, green: 0.718, blue: 0.902))
                        }
                    }
                        .background(.white)
                        .cornerRadius(8)
                }
                if !signUpErrorMessage.isEmpty {
                    Text("Failed creating account: \(signUpErrorMessage)")
                        .foregroundColor(.red)
                }
                Spacer()
                HStack {
                    Text("Already have an account?")
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Sign In")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }
                }
                    .opacity(0.9)
            }
                .padding()
        }
    }
    
    func signUpUser(userEmail: String, userPassword: String) {
        
        signUpProcessing = true
        
        Auth.auth().createUser(withEmail: userEmail, password: userPassword) { authResult, error in
            guard error == nil else {
                signUpErrorMessage = error!.localizedDescription
                signUpProcessing = false
                return
            }
            
            switch authResult {
            case .none:
                print("Could not create account.")
                signUpProcessing = false
            case .some(_):
                print("User created")
                signUpProcessing = false
                self.selection = 1
//                viewRouter.currentPage = .homePage
            }
        }
        
    }
    
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}

struct LogoView: View {
    var body: some View {
        VStack {
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 0.352 * containerWidth)
            HStack(alignment: .center)
            {
                Image("Letter_o")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 0.096 * containerWidth)
                Image("Letter_r")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 0.065 * containerWidth)
                Image("Letter_o")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 0.096 * containerWidth)
            }
                .padding(EdgeInsets(top: 0.022 * containerHeight, leading: 0, bottom: 0, trailing: 0))
        }
    }
}

struct SignUpCredentialFields: View {
    
    @Binding var email: String
    @Binding var password: String
    @Binding var passwordConfirmation: String
    
    var body: some View {
        Group {
            TextField("Email", text: $email)
                .padding()
                .background(Color(red: 1, green: 1, blue: 1, opacity: 0.21))
                .cornerRadius(8)
                .textInputAutocapitalization(.never)
                .foregroundColor(.white)
            SecureField("Password", text: $password)
                .padding()
                .background(Color(red: 1, green: 1, blue: 1, opacity: 0.21))
                .cornerRadius(8)
                .foregroundColor(.white)
            SecureField("Confirm Password", text: $passwordConfirmation)
                .padding()
                .background(Color(red: 1, green: 1, blue: 1, opacity: 0.21))
                .cornerRadius(8)
                .padding(.bottom, 30)
                .foregroundColor(.white)
        }
    }
}
