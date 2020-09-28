//
//  Depto.swift
//  enjoitIos
//
//  Created by developapp on 25/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import Foundation

// MARK: - CountryResponse
struct DeptoResponse: Codable, Hashable {
    let code: Int
    let data: [Depto]
    let message: String
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Datum
struct Depto: Codable, Hashable {
    let idDepartamento, idPais: Int
    let codigo, nombre: String
    let idEstado: Int
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case idDepartamento, idPais, codigo, nombre, idEstado
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
