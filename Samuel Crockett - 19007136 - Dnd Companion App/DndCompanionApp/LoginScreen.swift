//
//  LoginScreen.swift
//  DndCompanionApp
//
//  Created by Samuel Crockett on 5/10/22.
//

import SwiftUI

struct LoginScreen: View {
    
    @EnvironmentObject var viewModel: AppViewModel    
    
    var body: some View {
        NavigationView{
            if viewModel.signedIn{
                HomePage()
            }
            else {
                SignInView()
            }
        }
        .onAppear{
            viewModel.signedIn = viewModel.isSignedIn
        }
    }



    func AccountsPage()->some View{
        VStack{
        Text("You are signed in")
        Button(action:{
            viewModel.signOut()
        }, label: {
            Text("Sign Out")
                .frame(width: 200, height: 50)
                .foregroundColor(Color.blue)
        })
    }
    }
}

struct SignInView: View {
    
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        ZStack{
            Color("Grey").ignoresSafeArea()
            VStack(spacing: 50){
                Text("Sign In")
                    .frame(width: 300, height: 200, alignment: .center)
                    .font(.custom("Vecna", size: 30))
                    .offset(y: -50)
                
                Image("Dnd Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                
                VStack{
                    TextField("Email Address", text: $email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    
                    SecureField("Password", text: $password)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    
                    Button(action: {
                        guard !email.isEmpty, !password.isEmpty else{
                            return
                        }
                        
                        viewModel.signIn(email: email, password: password)
                        
                    }, label: {
                        Text("Sign In")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .cornerRadius(8)
                            .background(Color.blue)
                    })
                    
                    NavigationLink("Create Account", destination: SignUpView())
                        .padding()
                    
                }
                .padding()
                
                Spacer()
            }
        }
            .font(.custom("Vecna", size: 20))
    }
}

struct SignUpView: View {
    
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        ZStack{
            Color("Grey").ignoresSafeArea()
            VStack{
                Text("Create Account")
                    .frame(width: 300, height: 200, alignment: .center)
                    .font(.custom("Vecna", size: 30))
                    .offset(y: -50)
                
                Image("Dnd Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                
                VStack{
                    TextField("Email Address", text: $email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    
                    SecureField("Password", text: $password)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    
                    Button(action: {
                        guard !email.isEmpty, !password.isEmpty else{
                            return
                        }
                        
                        viewModel.signUp(email: email, password: password)
                        
                    }, label: {
                        Text("Create Account")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .cornerRadius(8)
                            .background(Color.blue)
                    })
                }
                .padding()
                
                Spacer()
            }
        }
            .font(.custom("Vecna", size: 20))
    }
}



struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
