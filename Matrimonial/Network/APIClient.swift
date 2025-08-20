//
//  APIClient.swift
//  MatrimonialApp
//
//  Created by Sushobhit Jain on 20/08/25.
//

import Foundation

protocol APIClient {
    var urlString: String { get }
}


enum MetrimonialAPIClient: APIClient {
    case getDeviceToken
    
    var domain: String {
        return "https://www.dommy.com"
    }
    
    var path: String {
        switch self {
        case .getDeviceToken:
            return "/PropertyList/RestService/GetDeviceToken/?aid=TTIOSJSON&devInfo=PropertyListiOS"
        }
    }
    
    var urlString: String {
        switch self {
        case .getDeviceToken:
            return domain + path
        }

    }
}
