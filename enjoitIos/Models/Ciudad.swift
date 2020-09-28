//
//  Ciudad.swift
//  enjoitIos
//
//  Created by developapp on 25/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import Foundation

// MARK: - CityResponse
struct CityResponse: Codable, Hashable {
    let code: Int
    let data: [City]
    let message: String
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Datum
struct City: Codable, Hashable {
    let idCiudad, idDepartamento: Int
    let codigo, nombre: String
    let idEstado: Int
    let createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case idCiudad, idDepartamento, codigo, nombre, idEstado
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
