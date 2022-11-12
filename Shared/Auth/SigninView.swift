//
//  SigninView.swift
//  ORO
//
//  Created by mac on 2022/10/26.
//

import SwiftUI
import Firebase

struct SigninView: View {
    @State private var selection: Int? = 0
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State var signInProcessing = false
    @State var signInErrorMessage = ""
    
    let main = MainView(viewRouter: MainRouter(), audioRecorder: AudioRecorder())
    let signup = SignupView()
    
    let background = LinearGradient(gradient: Gradient(colors: [Color(red: 86/255, green: 183/255, blue: 230/255), Color(red: 121/255, green: 211/255, blue: 255/255)]), startPoint: .top, endPoint: .bottom)
    let containerWidth:CGFloat = UIScreen.main.bounds.width
    let containerHeight:CGFloat = UIScreen.main.bounds.height

    var body: some View {
        NavigationView {
            ZStack {
                background
                .edgesIgnoringSafeArea(.all)
                VStack(spacing: 15) {
                    Spacer()
                    LogoView()
                    Spacer()
                    SignInCredentialFields(email: $email, password: $password)
                    NavigationLink(destination: main.navigationBarHidden(true), tag: 1, selection: $selection) {
                        Button(action: {
                            signInUser(userEmail: email, userPassword: password)
                        }) {
                            if(signInProcessing) {
                                ProgressView()
                                    .padding()
                                    .frame(minWidth: 0, maxWidth: .infinity)
                            } else {
                                Text("Log In")
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .font(.system(size: 18))
                                    .padding()
                                    .foregroundColor(Color(red: 0.337, green: 0.718, blue: 0.902))
                            }
                            
                        }
                        .background(.white)
                        .cornerRadius(8)
                    }
                    if !signInErrorMessage.isEmpty {
                        Text("Failed creating account: \(signInErrorMessage)")
                            .foregroundColor(.red)
                    }
                    Spacer()
                    HStack {
                        Text("Don’t have an account?")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                        NavigationLink(destination: signup.navigationBarHidden(true), tag: 2, selection: $selection) {
                            Button(action: {
                                self.selection = 2
                            }) {
                                Text("Sign Up")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                }
                    .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    

    func signInUser(userEmail: String, userPassword: String) {
        signInProcessing = true
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            guard error == nil else {
                signInProcessing = false
                signInErrorMessage = error!.localizedDescription
                return
            }
            switch authResult {
                case .none:
                    print("Could not sign in user.")
                    signInProcessing = false
                case .some(_):
                    print("User signed in")
                    signInProcessing = false
                    self.selection = 1
            }
        }
    }
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView()
    }
}

struct SignInCredentialFields: View {
    
    @Binding var email: String
    @Binding var password: String
    
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
                .padding(.bottom, 30)
                .foregroundColor(.white)
        }
    }
}
