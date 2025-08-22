//
//  ContentView.swift
//  ShaadifyApp
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
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10) // Customize corner radius
                        .stroke(
                            Color.black.opacity(0.2),
                            lineWidth: 2
                        ) // Set border color and width
                )
                .autocapitalization(.none)

            SecureField("Password", text: $viewModel.password)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10) // Customize corner radius
                        .stroke(
                            Color.black.opacity(0.2),
                            lineWidth: 2
                        ) // Set border color and width
                )
                .autocapitalization(.none)

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
            .background(
                viewModel.isLoginEnabled ? Color.black : Color.gray.opacity(0.4)
            )
            .foregroundColor(.white)
            .cornerRadius(16)

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
