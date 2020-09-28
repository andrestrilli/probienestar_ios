//
//  IngredienteResponse.swift
//  enjoitIos
//
//  Created by developapp on 10/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import Foundation

// MARK: - Ingredientes
struct Ingredientes: Codable, Hashable {
    let obligatorios, ingredientes, adicionales, acompañantes: [IngredienteElement]
    let numAC: String?

    enum CodingKeys: String, CodingKey {
        case obligatorios = "Obligatorios"
        case ingredientes = "Ingredientes"
        case adicionales = "Adicionales"
        case acompañantes = "Acompañantes"
        case numAC
    }
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Acompañante
struct IngredienteElement: Codable, Hashable, Identifiable {
    var id:Int { idConfigProducto }
    let idConfigProducto, idProducto: Int
    let nombre, tipo, valor: String
    let idEstado: Int
    let createdAt, updatedAt: String
    var setted:Bool?
    
    enum CodingKeys: String, CodingKey {
        case idConfigProducto, idProducto, nombre, tipo, valor, idEstado, setted
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
