//
//  Propina.swift
//  enjoitIos
//
//  Created by developapp on 17/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import Foundation

// MARK: - PropinaResponse
struct PropinaResponse: Codable, Hashable {
    let valores: [Valore]

    enum CodingKeys: String, CodingKey {
        case valores = "Valores"
    }
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Valore
struct Valore: Codable, Hashable {
    let valor: String
}
