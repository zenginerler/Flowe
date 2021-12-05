//
//  LoginVC.swift
//  flowe
//
//  Created by Mehmet Yavuz Zenginerler on 11/4/21.
//

import UIKit
import SwiftUI
import FirebaseAuth


struct LoginHC_Temp: View {
  var body: some View {
      NavigationView{
          LoginHome()
              .navigationBarHidden(true)
      }
  }
}

class LoginHC: UIHostingController<LoginHC_Temp> {

    required init?(coder: NSCoder) {
        super.init(coder: coder,rootView: LoginHC_Temp());
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

struct LoginHC_Previews: PreviewProvider {
    static var previews: some View {
        LoginHome()
    }
}


struct LoginHome: View {
    
    let auth = Auth.auth()
    
    @State var email = ""
    @State var password = ""
    @State var loginSuccessful = false

    var body: some View {
        
        VStack {
            Spacer(minLength: 0)
            
            // Logo
            Image("flowe_logo_w")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 16)
            
            // Login Title & description
            HStack {
                VStack (alignment: .leading, spacing: 12, content: {
                    Text("Login")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Please sign in to continue")
                        .foregroundColor(Color.white.opacity(0.5))
                })
                Spacer(minLength: 0)
            }.padding()
                .padding(.leading, 15)
            
            // Email Text Field
            HStack{
                Image(systemName: "envelope")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width:35)
                
                TextField("", text: $email)
                    .placeholder(when: email.isEmpty) {
                        Text("EMAIL").foregroundColor(Color("custom_gray"))
                    }.autocapitalization(.none)
                    .disableAutocorrection(true)
            }.padding()
                .background(Color.white.opacity(email == "" ? 0.06 : 0.24))
                .foregroundColor(Color.white)
                .cornerRadius(15)
                .padding(.horizontal)
            
            // Password Text Field
            HStack{
                Image(systemName: "lock")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width:35)
                
                SecureField("", text: $password)
                    .placeholder(when: password.isEmpty) {
                        Text("PASSWORD").foregroundColor(Color("custom_gray"))
                    }.autocapitalization(.none)
                    .disableAutocorrection(true)
            }.padding()
                .background(Color.white.opacity(password == "" ? 0.06 : 0.24))
                .foregroundColor(Color.white)
                .cornerRadius(15)
                .padding(.horizontal)
                .padding(.top)
            
            // Login Button
            Button (action: {
                guard !email.isEmpty, !password.isEmpty else {
                    print("Password or Email field is empty!")
                    return
                }
                
                // Firebase Sign In Functionality
                auth.signIn(withEmail: email, password: password) {
                    result, error in
                    guard result != nil, error == nil else {
                        print("signIn failed!")
                        print(error!.localizedDescription)
                        return
                    }
                    print("signIn success!")
                    Variables.username = email.lowercased()
                    self.loginSuccessful = true
                    
                    // Reset the values after login
                    email = ""
                    password = ""
                }
                
            }, label: {
                Text("LOGIN")
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 150)
                    .background(Color("custom_gray"))
                    .cornerRadius(15)

            }).padding(.top)
            
            // Forgot my password button
//            Button (action: {}, label: {
//                Text("Forgot my password")
//                    .foregroundColor(.white)
//            }).padding(.top, 8)
//
            Spacer(minLength: 0)
            
            // Sign up Text & Button
            HStack(spacing: 5){
                Text("Don't have an account?")
                    .foregroundColor(Color.white.opacity(0.6))
                
                // Add the SignUpPage to the NavigationView Stack:
                NavigationLink(destination: SignUpPage(), label: {
                    Text("Signup")
                        .fontWeight(.heavy)
                        .foregroundColor(Color("custom_ivory"))
                })
            }.padding(.vertical)
        }
        .background(Image("bg_light").ignoresSafeArea(.all, edges: .all))
        .fullScreenCover(isPresented: $loginSuccessful) {
            // Custom Page Segue from SwiftUI to UIkit
            SegueSwiftUI(storyboard: "Main", VC: "SegueVC").ignoresSafeArea(.all)
        }
    }
}


struct SignUpPage: View {
    
    let auth = Auth.auth()
    
    @State var email = ""
    @State var password = ""
    @State var passwordConfirm = ""
    @State var statusText = ""
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        
        VStack {
//            Spacer(minLength: 0)
            
            // Logo
            Image("flowe_logo_w")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 16)
                .padding(.top)
            
            // Sign Up Title & description
            HStack {
                VStack (alignment: .leading, spacing: 12, content: {
                    Text("Sign Up")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Please sign up to create a new account")
                        .foregroundColor(Color.white.opacity(0.5))
                })
                Spacer(minLength: 0)
            }.padding()
                .padding(.leading, 15)
            
            // Email Text Field
            HStack{
                Image(systemName: "envelope")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width:35)
                
                TextField("", text: $email)
                    .placeholder(when: email.isEmpty) {
                        Text("EMAIL").foregroundColor(Color("custom_gray"))
                    }.autocapitalization(.none)
                    .disableAutocorrection(true)
            }.padding()
                .background(Color.white.opacity(email == "" ? 0.06 : 0.24))
                .foregroundColor(.white)
                .cornerRadius(15)
                .padding(.horizontal)
            
            // Password Text Field
            HStack{
                Image(systemName: "lock")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width:35)
                
                SecureField("", text: $password)
                    .placeholder(when: password.isEmpty) {
                        Text("PASSWORD").foregroundColor(Color("custom_gray"))
                    }.autocapitalization(.none)
                    .disableAutocorrection(true)
            }.padding()
                .background(Color.white.opacity(password == "" ? 0.06 : 0.24))
                .foregroundColor(.white)
                .cornerRadius(15)
                .padding(.horizontal)
                .padding(.top)

            // Confirm Password Text Field
            HStack{
                Image(systemName: "lock")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width:35)
                
                SecureField("", text: $passwordConfirm)
                    .placeholder(when: passwordConfirm.isEmpty) {
                        Text("CONFIRM PASSWORD").foregroundColor(Color("custom_gray"))
                    }.autocapitalization(.none)
                    .disableAutocorrection(true)
            }.padding()
                .background(Color.white.opacity(passwordConfirm == "" ? 0.06 : 0.24))
                .foregroundColor(.white)
                .cornerRadius(15)
                .padding(.horizontal)
                .padding(.top)
            
            // Sign Up Button
            Button (action: {
                guard !email.isEmpty, !password.isEmpty, !passwordConfirm.isEmpty else {
                    print("Password or Email field is empty!")
                    self.statusText = "Password or Email field is empty!"
                    return
                }
                
                if !(password == passwordConfirm) {
                    print("Passwords do not match!")
                    self.statusText = "Passwords do not match!"
                    return
                }
                
                // Firebase Sign Up Functionality
                auth.createUser(withEmail: email, password: password) {
                    result, error in
                    guard result != nil, error == nil else {
                        print("signUp failed!")
                        print(error!.localizedDescription)
                        self.statusText = "Sign Up Failed!"
                        return
                    }
                    print("signUp success!")
                    self.statusText = "Sign Up Successful!"
                    self.presentationMode.wrappedValue.dismiss()
                }
                    
            }, label: {
                Text("SIGN UP")
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 150)
                    .background(Color("custom_gray"))
                    .cornerRadius(15)

            }).padding(.top)
            
            // Status Text
            Text(self.statusText)
                .foregroundColor(.black)
                .padding(.top, 8)
            
            Spacer(minLength: 0)
            
            // Sign up Text & Button
            HStack(spacing: 5){
                Text("Already have an account?")
                    .foregroundColor(Color.white.opacity(0.6))
                
                Button(action:{ self.presentationMode.wrappedValue.dismiss() }){
                    Text("Login")
                        .fontWeight(.heavy)
                        .foregroundColor(Color("custom_ivory"))
                }
            }.padding(.vertical)
            
        }
        .background(Image("bg_dark").ignoresSafeArea(.all, edges: .all))
    }
}


// Additional customization for TextField place holders
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
