//
//  ControllerFacturacion.swift
//  enjoitIos
//
//  Created by developapp on 17/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import Foundation
import Alamofire
import SwiftUI
class ControllerFacturacion:ObservableObject{
    
    @Published var encabezado:String = ""
    @Published var otherInfo:String = ""
    @Published var details:[PedidosDetalle] = []
    @Published var subTotal:String = "$ 0"
    @Published var descuento:String = "0"
    @Published var domicilio:String = "$ 0"
    @Published var impConsumo:String = ""
    @Published var propina:String = ""
    @Published var ventaTotal:String = ""
    
    
    var carrito:Carrito
    
    init(carrito:Carrito) {
        self.carrito = carrito
        self.hacerEncabezado(carrito: carrito)
        self.otherInfo(carrito: carrito)
        self.details = carrito.pedidosDetalle ?? []
        self.valoresFinales(carrito: carrito)
    }
    
    
    func hacerEncabezado(carrito:Carrito){
        if let rest = carrito.restauranteObject {
            let name:String = (rest.userName ?? "none") + "\n"
            let nit:String = (rest.nit ?? "none") + "\n"
            let imp:String = ("Impuesto nacional al consumo") + "\n"
            let reg:String = ("Regimen Comun") + "\n"
            let dir:String = (rest.direccion ?? "none") + "\n"
            
            self.encabezado = name + nit + imp + reg + dir
        }
    }
    
    func otherInfo(carrito:Carrito){
        self.otherInfo = "FAC. No. 00001"
    }
    
    func valoresFinales(carrito:Carrito){
        self.subTotal = "$ " + String(carrito.precioTotal!)
        self.descuento = "$ 0.0"
        self.propina = "$ " + String((carrito.valorPropina ?? 0.0)/100 * carrito.precioTotal!)
        if let rest = carrito.restauranteObject {
            self.domicilio = (rest.valorTarifaApp ?? "none")
            print(rest.valorImpuesto ?? "0")
            self.impConsumo = ("$ " + String ( ( (Double(rest.valorImpuesto ?? "0") ?? 0.0) / 100 ) * carrito.precioTotal! ) ?? "none")
       }
        
        self.ventaTotal = "$ " + String(calculartotal(carrito: carrito))
    }
    
    func calculartotal(carrito:Carrito) -> Double {
        var total:Double = 0.0
        let subTotal = carrito.precioTotal!
        let valorprop = (carrito.valorPropina ?? 0.0)/100 * carrito.precioTotal!
        
        total += subTotal
        total += valorprop

        if let rest = carrito.restauranteObject {
            let domi = Double(rest.valorTarifaApp ?? "0.0") ?? 0.0
            let imp = Double(Double(rest.valorImpuesto ?? "0") ?? 0.0 / 100 * carrito.precioTotal! )
            total += domi
            total += imp
        }
        
        return total
    }

    func onPagoRestPressed(){
        
    }
    
}
