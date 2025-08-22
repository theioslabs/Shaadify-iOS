//
//  LoginViewModel.swift
//  Shaadify
//
//  Created by Sushobhit Jain on 20/08/25.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    // Input from the View
    @Published var email: String = ""
    @Published var password: String = ""

    // Output to the View
    @Published var isLoginEnabled: Bool = false
    @Published var loginError: String?
    @Published var isLoading: Bool = false
    @Published var isLoggedIn: Bool = false
    let service: LoginServiceProtocol

    private var cancellables = Set<AnyCancellable>()

    init(service: LoginServiceProtocol) {
        self.service = service
        start()
    }
    
    // Validation of email and password to enable login button
    func start() {
        Publishers.CombineLatest($email, $password)
            .map { email, password in
                return self.isValidEmail(email) && password.count >= 6
            }
            .assign(to: \.isLoginEnabled, on: self)
            .store(in: &cancellables)
    }

    func login() {
        guard isLoginEnabled else { return }
        isLoading = true
        loginError = nil
        Task {
            do {
                let status = try await self.service.hitLoginAPI(email: self.email, password: self.password)
                self.isLoading = false
                self.isLoggedIn = status
            } catch LoginService.LoginError.invalidCredentials {
                self.isLoggedIn = false
                self.loginError = "Invalid email or password"
            } catch {
                print(error)
            }
        }
    }

    private func isValidEmail(_ email: String) -> Bool {
        // Basic email validation pattern
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: email)
    }
}


