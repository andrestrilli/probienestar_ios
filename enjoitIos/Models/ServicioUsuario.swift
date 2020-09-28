//
//  ServicioUsuario.swift
//  enjoitIos
//
//  Created by developapp on 14/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import Foundation
// MARK: - ServicioUsuario
struct ServicioUsuario: Codable, Hashable {
    let id:Int
    let idPedido: Int?
    let nombre: String?
    let documento: Int?
    let telefono, direccion, direccion2, latitud: String?
    let longitud, extra: String?
    let observacion: String?
    let tipo, estadoPago, tipoPedido: Int?
    let horaEntrega, idDomiciliario: String?
    let createdAt, updatedAt: String?

    init(direccion: String?, direccion2: String?, latitud: String?, longitud: String?) {
        self.id = 0
        self.idPedido = nil
        self.nombre = nil
        self.documento = nil
        self.telefono = nil
        self.direccion = direccion
        self.direccion2 = direccion2
        self.latitud = latitud
        self.longitud = longitud
        self.extra = nil
        self.observacion = nil
        self.tipo = nil
        self.estadoPago = nil
        self.tipoPedido = nil
        self.horaEntrega = nil
        self.idDomiciliario = nil
        self.createdAt = nil
        self.updatedAt = nil
    }
    enum CodingKeys: String, CodingKey {
        case id, idPedido, nombre, documento, telefono, direccion, direccion2, latitud, longitud, extra, observacion, tipo, estadoPago, tipoPedido, horaEntrega, idDomiciliario
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    
    
}
