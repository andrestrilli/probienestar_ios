//
//  Carrito.swift
//  enjoitIos
//
//  Created by developapp on 10/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import Foundation

// MARK: - CarritoResponse
struct CarritoResponse: Codable, Hashable {
    let msg: String?
    let data: Carrito?
    let res: Bool?
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - DataClass
struct Carrito: Codable, Hashable {
    var idMesaPedido, idRestaurante, idMesa, idPedido: Int?
    var referencia: String?
    var idCliente: Int?
    var client: String?
    var orderFrom, typeOfOrder, idZona: Int?
    var nombre, numeroMesa: String?
    var estadoMesa, mainTable, isPrincipal: Int?
    var tables: String?
    var mesaobject: Mesaobject?
    var servicioUsuario: ServicioUsuario?
    var restauranteObject: RestaurantElement?
    var pedidosDetalle: [PedidosDetalle]?
    var valorPropina:Double?

    //Agregadas
    var precioTotal:Double? = 0
    
    enum CodingKeys: String, CodingKey {
        case idMesaPedido, idRestaurante, idMesa, idPedido, referencia, idCliente, client, orderFrom, typeOfOrder, idZona, nombre, numeroMesa, estadoMesa, mainTable, isPrincipal, tables, mesaobject
        case servicioUsuario = "servicio_usuario"
        case restauranteObject, pedidosDetalle
        case precioTotal
        case valorPropina
    }
    
    init(){
        
    }
    
    mutating func añadirProducto(producto:Producto,ingreSelecteds:[ConfigPedidoDetalle], comment:String){
        if  pedidosDetalle == nil || pedidosDetalle!.count == 0 {
            
            let pediDetalle = PedidosDetalle(idDetallePedido: 0,
                                             idProducto: producto.id,
                                             nombreProducto: producto.nombre!,
                                             observaciones: comment,
                                             valorNeto: producto.valor,
                                             cantidad: "1",
                                             idEstado: 0,
                                             toPrint: 0,
                                             productObject: producto,
                                             configPedidoPosts: ingreSelecteds)
            
            var pedidos:[PedidosDetalle] = [];
            pedidos.append(pediDetalle)
            self.pedidosDetalle = pedidos
            
        }else{
            
            let pediDetalle = PedidosDetalle(idDetallePedido: pedidosDetalle!.count,
                                            idProducto: producto.id,
                                            nombreProducto: producto.nombre!,
                                            observaciones: comment,
                                            valorNeto: producto.valor,
                                            cantidad: "1",
                                            idEstado: 0,
                                            toPrint: 0,
                                            productObject: producto,
                                            configPedidoPosts: ingreSelecteds)
                       
                       self.pedidosDetalle!.append(pediDetalle)
                     
        }
    }
    
    mutating func getPrecio()->Double{
        var aux:Double = 0.0
        
        if  let pedidosDet = pedidosDetalle{
            for detalle in pedidosDet{
                aux += Double(detalle.valorTotal ?? "0.0") ?? 0.0
            }
        }
        
        self.precioTotal = aux;
        return aux;
    }
    
    func isEmpty() -> Bool {
        if self.pedidosDetalle != nil && self.pedidosDetalle!.count > 0{
            return false
        }
        return true
    }
    
    func updateDetallePedido(pedido:PedidosDetalle){
        for var ped:PedidosDetalle in self.pedidosDetalle ?? []{
            if ped.id == pedido.id {
                ped = pedido
            }
        }
    }
    
    mutating func removeDetallePedido(pedido:PedidosDetalle){
        if let index = (self.pedidosDetalle ?? []).firstIndex(of: pedido) {
            self.pedidosDetalle!.remove(at: index)
            print("remove " + (pedido.nombreProducto ?? ""))
        }
    }
    
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Mesaobject
struct Mesaobject: Codable, Hashable {
    let idMesa, idRestaurante, idZona: Int
    let nombre, numeroMesa: String
    let estadoMesa, idEstado: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case idMesa, idRestaurante, idZona, nombre, numeroMesa, estadoMesa, idEstado
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - PedidosDetalle
struct PedidosDetalle: Codable, Hashable, Identifiable{
    var id:Int {idDetallePedido!}
    var idDetallePedido, idPedido, idProducto: Int?
    var nombreProducto, observaciones, valorNeto, cantidad: String?
    var valorTotal: String?
    var idEstado: Int?
    var fecha: String?
    var toPrint: Int?
    var dateState: String?
    var notificacion: Int?
    var createdAt, updatedAt: String?
    var configPedidoDetalle: [ConfigPedidoDetalle]?
    var productObject: Producto?
    var configPedidoPosts: [ConfigPedidoDetalle]?

    
    init(idDetallePedido: Int?, idProducto: Int?, nombreProducto: String?, observaciones: String?, valorNeto: String?, cantidad: String?, idEstado: Int?, toPrint: Int?, productObject: Producto?,configPedidoPosts: [ConfigPedidoDetalle]?) {
        self.idDetallePedido = idDetallePedido
        self.idPedido = nil
        self.idProducto = idProducto
        self.nombreProducto = nombreProducto
        self.observaciones = observaciones
        self.cantidad = cantidad
        self.idEstado = idEstado
        self.fecha = nil
        self.toPrint = toPrint
        self.dateState = nil
        self.notificacion = nil
        self.createdAt = nil
        self.updatedAt = nil
        self.configPedidoDetalle = configPedidoPosts
        self.productObject = productObject
        self.configPedidoPosts = configPedidoPosts
        
        var precioAux:Double = 0.0
        
        for ingre in (configPedidoPosts ?? []) {
            if ingre.tipo == "A" {
                precioAux += (Double(ingre.valor ?? "0.0") ?? 0.0)
            }
        }
        
        self.valorNeto = String((Double(valorNeto ??  "0.0") ?? 0.0) + precioAux)
        self.valorTotal = String(Double(valorNeto!)! * Double(cantidad!)!)

        
    }

    enum CodingKeys: String, CodingKey {
        case idDetallePedido, idPedido, idProducto, nombreProducto, observaciones, valorNeto, cantidad, valorTotal, idEstado, fecha
        case toPrint = "to_print"
        case dateState = "date_state"
        case notificacion
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case configPedidoDetalle, productObject,configPedidoPosts
    }
    
    mutating func agregar(cant:Int){
        cantidad = String(Int(cantidad ?? "0")! + cant)
        self.valorTotal = String(Double(valorNeto!)! * Double(cantidad!)!)
    }
    
    mutating func quitar(cant:Int){
        cantidad = String(Int(cantidad ?? "0")! - cant)
        self.valorTotal = String(Double(valorNeto!)! * Double(cantidad!)!)
    }
    
    func calcularTotal(){
    
        var total:String = String(Double(valorNeto!)! * Double(cantidad!)!)
    }
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - ConfigPedidoDetalle
struct ConfigPedidoDetalle: Codable, Hashable {
    let idSelecConfigProducto, idDetallePedido, idConfig: Int?
    let nombre, valor, tipo, createdAt: String?
    let updatedAt: String?
    
    init(idConfig: Int, nombre: String, valor: String, tipo: String) {
        self.idSelecConfigProducto = nil
        self.idDetallePedido = nil
        self.idConfig = idConfig
        self.nombre = nombre
        self.valor = valor
        self.tipo = tipo
        self.createdAt = nil
        self.updatedAt = nil
    }
    
    enum CodingKeys: String, CodingKey {
        case idSelecConfigProducto, idDetallePedido, idConfig, nombre, valor, tipo
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).


