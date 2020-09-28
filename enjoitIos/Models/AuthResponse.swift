//
//  AuthResponse.swift
//  enjoitIos
//
//  Created by developapp on 8/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import Foundation

// MARK: - AuthResponse
struct AuthResponse: Decodable{
    let tokenType: String?
    let expiresIn: Int?
    let accessToken, refreshToken: String?

    enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}
