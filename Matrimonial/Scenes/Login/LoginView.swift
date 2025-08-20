//
//  ContentView.swift
//  MatrimonialApp
//
//  Created by Sushobhit Jain on 19/08/25.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject private var viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: 16) {
            TextField("Email", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .background(Color(white: 0.9))
                .cornerRadius(5)

            SecureField("Password", text: $viewModel.password)
                .padding()
                .background(Color(white: 0.9))
                .cornerRadius(5)

            if let error = viewModel.loginError {
                Text(error)
                    .foregroundColor(.red)
                    .font(.footnote)
            }

            Button(action: {
                viewModel.login()
            }) {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .frame(maxWidth: .infinity)
                } else {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                }
            }
            .disabled(!viewModel.isLoginEnabled || viewModel.isLoading)
            .padding()
            .background(viewModel.isLoginEnabled ? Color.blue : Color.gray)
            .foregroundColor(.white)
            .cornerRadius(5)

            Spacer()
        }
        .padding()
        .alert(isPresented: $viewModel.isLoggedIn) {
            Alert(title: Text("Welcome"), message: Text("Login successful"), dismissButton: .default(Text("OK")))
        }
        .navigationTitle(Text("Login"))
    }
}

#Preview {
    NavigationStack {
        LoginView(viewModel: LoginViewModel(service: LoginService()))
    }
}
