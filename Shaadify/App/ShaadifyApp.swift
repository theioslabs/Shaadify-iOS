//
//  ShaadifyApp.swift
//  Shaadify
//
//  Created by Sushobhit Jain on 20/08/25.
//

import SwiftUI

@main
struct ShaadifyApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                let loginService = LoginService()
                let viewModel = LoginViewModel(service: loginService)
                LoginView(viewModel: viewModel)
                    .navigationBarTitle("Shaadify")
            }
        }
    }
}
