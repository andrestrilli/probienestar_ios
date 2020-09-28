//
//  Direccion.swift
//  enjoitIos
//
//  Created by developapp on 12/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import Foundation
// MARK: - DireccionesResponse
struct DireccionesResponse: Codable, Hashable {
    let message: String
    let data: [Direccion]
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Datum
struct Direccion: Codable, Hashable, Identifiable {
    var id, id_user: Int
    var name, extra, direccion, direccion2: String?
    var latitud, longitud: String?
    var idPais, idDpto: Int?
    var idCiudad: Int?
    var idState: Int?
    var createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case id_user = "id_user"
        case name, extra, direccion, direccion2, latitud, longitud
        case idPais = "id_pais"
        case idDpto = "id_dpto"
        case idCiudad = "id_ciudad"
        case idState = "id_state"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(name:String,extra:String,idPais:Int, idCiudad:Int, idDepto:Int, dir1:String){
        id = 0
        id_user = 0
        self.name = name
        self.extra = extra
        self.idPais = 1
        self.idCiudad = 4
        self.idDpto = 12
        self.direccion = dir1
        
        self.direccion2 = nil
        self.latitud = nil
        self.longitud = nil
        self.idState = nil
        self.createdAt = nil
        self.updatedAt = nil

    }
    
}
