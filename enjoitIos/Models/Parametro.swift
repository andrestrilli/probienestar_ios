//
//  Parametro.swift
//  enjoitIos
//
//  Created by developapp on 25/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//


import Foundation

// MARK: - ParametroResponse
struct ParametroResponse: Codable, Hashable {
    let code: Int
    let data: [Parametro]
    let message: String
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Datum
struct Parametro: Codable, Hashable {
    let idValorParametro: Int
    let nombre: String
}
