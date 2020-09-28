//
//  User.swift
//  enjoitIos
//
//  Created by developapp on 8/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import Foundation
struct User: Codable, Hashable {
    
    let idUsuario: Int
    let nombre, apellido, userName, slug: String
    let email: String
    let idPerfil, idTipoDocumento: Int
    let numeroDocumento, fechaN, telefono, celular: String?
    let idPais, idDepartamento, idCiudad, idEstado: Int?
    let fechaRegistro, ipRegistro: String?
    let terminosCondiciones, idPerfilPadre: Int?
    let fotoPerfil: String?
    let idGenero, idCategoriaCM: Int?
    let latitud, longitud, search, confirmToken: String?
    let active: Int?
    let cerrado, fechaBloqueo, intentos, fechaActualizar: String?
    let emailVerifiedAt: String?
    let createdAt, updatedAt, txtGenero, txtTipoIdentificacion: String?
    let txtPais, txtDepto, txtCiudad: String?

    enum CodingKeys: String, CodingKey {
        case idUsuario, nombre, apellido, userName, slug, email, idPerfil, idTipoDocumento, numeroDocumento, fechaN, telefono, celular, idPais, idDepartamento, idCiudad, idEstado, fechaRegistro, ipRegistro, terminosCondiciones, idPerfilPadre, fotoPerfil, idGenero
        case idCategoriaCM = "idCategoriaCm"
        case latitud, longitud, search, confirmToken, active, cerrado, fechaBloqueo, intentos, fechaActualizar
        case emailVerifiedAt = "email_verified_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case txtGenero, txtTipoIdentificacion, txtPais, txtDepto, txtCiudad
    }
}
