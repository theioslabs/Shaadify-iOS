//
//  LoginService.swift
//  Matrimonial
//
//  Created by Sushobhit Jain on 20/08/25.
//

import Foundation

protocol LoginServiceProtocol {
    func hitLoginAPI(email: String, password: String) async throws -> Bool
}

class LoginService: LoginServiceProtocol {
    enum LoginError: Error {
        case invalidCredentials
        
        func description() -> String {
            switch self {
            case .invalidCredentials:
                return "Invalid email or password"
            }
        }
    }
    func hitLoginAPI(email: String, password: String) async throws -> Bool {
        try await Task.sleep(for: .milliseconds(500))
        if email == "test@jeevansathi.com" && password == "password" {
            return true
        } else {
            throw LoginError.invalidCredentials
        }
    }
}
