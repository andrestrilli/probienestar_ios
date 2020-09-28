//
//  Restaurant.swift
//  enjoitIos
//
//  Created by developapp on 8/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import Foundation
// MARK: - RestaurantElement
struct RestaurantElement: Codable, Hashable, Identifiable {
    var id: Int { idUsuario }
    let idUsuario, idEstado: Int
    let nombre, apellido, userName, nit: String?
    let email: String?
    let idPerfil, idTipoDocumento: Int?
    let numeroDocumento, telefono, celular: String?
    let idPais, idDepartamento, cerrado: Int?
    let fotoPerfil: String?
    let idDetalleRestaurante, idRestaurante: Int?
    let slug, direccion, descripcion: String?
    let imagenPortada, valorTarifaApp: String?
    let domicilioGratis: Int?
    let valorImpuesto: String?
    let archivoRut, archivoCedula, archivoCamaraComercio, archivoPagare: String? //Ojo null
    let archivoContratoGeneral, archivoComodatoEquipo, archivoPropuestaComercial, archivoCartaDeInstrucciones: String? // Ojo null
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case idUsuario, idEstado, nombre, apellido, userName, nit, email, idPerfil, idTipoDocumento, numeroDocumento, telefono, celular, idPais, idDepartamento, cerrado, fotoPerfil, idDetalleRestaurante, idRestaurante, slug, direccion, descripcion, imagenPortada, valorTarifaApp, domicilioGratis, valorImpuesto, archivoRut, archivoCedula, archivoCamaraComercio, archivoPagare, archivoContratoGeneral, archivoComodatoEquipo, archivoPropuestaComercial, archivoCartaDeInstrucciones
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

typealias Restaurants = [RestaurantElement]
