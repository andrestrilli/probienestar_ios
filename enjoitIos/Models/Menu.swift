//
//  MenuResponse.swift
//  enjoitIos
//
//  Created by developapp on 8/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import Foundation

// MARK: - Restaurant
struct MenuResponse: Codable, Hashable {
    let bebidas, menu: MenuCategory

    enum CodingKeys: String, CodingKey {
        case bebidas = "Bebidas"
        case menu = "Menu"
    }
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Bebidas
struct MenuCategory: Codable, Hashable, Identifiable {
    var id:Int { idCategoria }
    let idCategoria, idRestaurante: Int
    let nombre, slug, images: String?
    let idEstado, tipoCat, idPadre: Int?
    let createdAt, updatedAt: String?
    let subCategorias: [MenuCategory]?
    let productos: [Producto]?

    enum CodingKeys: String, CodingKey {
        case idCategoria, idRestaurante, nombre, slug, images, idEstado, tipoCat, idPadre
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case subCategorias = "SubCategorias"
        case productos = "Productos"
    }
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Producto
struct Producto: Codable, Hashable,Identifiable {
    var id:Int { idProducto }
    let idProducto, idRestaurante, idSubCategoria, idComanda: Int!
    let nombre, slug, descripcion, valor: String?
    let imagen: String?
    let tiempo: Int?
    let valoracion: Int?
    let idEstado: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case idProducto, idRestaurante, idSubCategoria, idComanda, nombre, slug, descripcion, valor, imagen, tiempo, valoracion, idEstado
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
