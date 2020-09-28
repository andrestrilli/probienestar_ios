//
//  ControllerDomicilio.swift
//  enjoitIos
//
//  Created by developapp on 11/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import Alamofire

class ControllerDomicilio: UIViewController,ObservableObject{
    
    @ObservedObject var repository:RepositoryDomicilio = RepositoryDomicilio()
    @Published var listPedidos:[PedidosDetalle] = []
    @Published var carrito:Carrito?
    @Published var realizandoPedido:Bool = false
    @Published var pedidoRealizado:Bool = false

    
    override func viewDidLoad() {
        print("didload")
        self.carrito = repository.carrito
        repository.getCarrito()
        
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func pedidosToPost(pedidos:[PedidosDetalle])->[Any]{
        var aux:[Any] = []
        for ped in pedidos{
            let encodedData = try! JSONEncoder().encode(ped)
            let letData = String(data: encodedData, encoding: .utf8)!
            let auxDict:[String: Any] = self.convertToDictionary(text:letData)!
            aux.append(auxDict)
        }
        return aux
    }
    
    func hacerDomicilio_request(navigation:NavigationStack,carrito:Carrito) {
        self.realizandoPedido = true
//        print("hacerDomicilio_request");
        let encodedData = try! JSONEncoder().encode(carrito.pedidosDetalle ?? [])
        let letData = String(data: encodedData, encoding: .utf8)!
//        print(self.convertToDictionary(text:letData))
        let parameters:[String:Any] = [
        "referencia":"",
        "idCliente":DataApp.user!.idUsuario,
        "latitude":carrito.servicioUsuario!.latitud ?? "0",
        "longitude":carrito.servicioUsuario!.longitud ?? "0",
        "idRestaurante":carrito.idRestaurante!,
        "idPropina":"",
        "valorPropina":"",
        "valorDomicilio":"",
        "estadoGlobal":"",
        "idMesa":"",
        "pedidosDetalle": letData,
        "nameReceiver":"",
        "idReceiver":"",
        "cellReceiver":"",
        "fechaEntrega":"",
        "direccion1":carrito.servicioUsuario!.direccion!,
        "direccion2":carrito.servicioUsuario!.direccion2 ?? "",
        "extra":carrito.servicioUsuario!.extra ?? "",
        ]
        
        AF.request(ApiConection.baseUrl+"api/domicilio/hacerDomicilio/ios",
                   method:.post,
                   parameters: parameters,
                   encoding: URLEncoding.httpBody,
                   headers: ["Authorization": "Bearer "+DataApp.authUser!.accessToken!]).responseString { response in
                    switch response.result {
                    case .success:
                        print(response)
                        self.realizandoPedido = false
                        switch response.response?.statusCode {
                        case 200:
                            print("hacerDomicilio_request exito")
                            do {
                                
                                let resp = try JSONSerialization.jsonObject(with: response.data!, options: []) as? [String: Any]
                                print(resp!["idPedido"]!)
                                self.pedidoRealizado = true
                                
                                var car:Carrito = carrito;
                                
                                car.idPedido = resp!["idPedido"]! as! Int
                                for var det in (car.pedidosDetalle ?? []) {
                                    det.idEstado = 16
                                }
                                
                                RepositoryDomicilio().updateCarrito(car: carrito)
                                
                                _ = RepositoryDomicilio().getCarrito()
                                
                                
                            } catch let error {
                                print(error)
                            }
                            
                            
                        default:
                            //self.errorMessage = "lo sentimos ocurrio un problema, intente mas tarde"
                            
                            print("Ocurrio un error con el hacerDomicilio_request")
                            print("\(response)")
                        }
                        
                    case .failure(let error):
                        self.realizandoPedido = false
                        print (error)
                    }
        }
            
            
        
            
        
    }
    
    func updateInfoRest(carrito:Carrito){
        
        if carrito.restauranteObject == nil {
            let idRest:Int = carrito.idRestaurante!
            print("updateInfoRest_request");
            AF.request(ApiConection.baseUrl+"api/indexrestaurantes",
                       method:.get,
                       parameters: [:],
                       encoding: URLEncoding.default,
                       headers: ["Authorization": "Bearer "+DataApp.authUser!.accessToken!]).responseString { response in
                        switch response.result {
                        case .success:
                            print(response)
                            switch response.response?.statusCode {
                            case 200:
                                print("updateInfoRest_request exito")
                                do {
                                    let res: Restaurants =  try JSONDecoder().decode(Restaurants.self ,from: response.data!)
                                    print(res)
                                    
                                    for restaurant in res {
                                        if restaurant.id == idRest {
                                            var carrito:Carrito = RepositoryDomicilio().getCarrito()
                                            carrito.restauranteObject = restaurant
                                            RepositoryDomicilio().updateCarrito(car: carrito)
                                        }
                                    }
                                    
                                } catch let error {
                                    print(error)
                                }
                                
                                
                            default:
                                
                                print("Ocurrio un error con el updateInfoRest_request")
                                print("\(response)")
                            }
                            
                        case .failure(let error):
                            print (error)
                        }
            }
            
        }
    }
    
    //METODOS GENERALES DEL PEDIDO
    static func AgregarItemParaDomicilio(navigation: NavigationStack, product:Producto, ingreSelecteds:[ConfigPedidoDetalle], comment:String){
        var carrito:Carrito = RepositoryDomicilio().getCarrito()
        
        if carrito.idRestaurante == nil { //Si el carrito es nuevo, porque no tiene restaurante asignado
            carrito.añadirProducto(producto: product,ingreSelecteds: ingreSelecteds,comment: comment)
            carrito.idRestaurante = product.idRestaurante
            RepositoryDomicilio().updateCarrito(car: carrito)
            navigation.advance(NavigationItem(view: AnyView(PedidoDomicilioView())))
            
        }else if carrito.idRestaurante == product.idRestaurante{
            carrito.añadirProducto(producto: product,ingreSelecteds: ingreSelecteds,comment: comment)
            RepositoryDomicilio().updateCarrito(car: carrito)
            navigation.advance(NavigationItem(view: AnyView(PedidoDomicilioView())))
            
        }else{
            print("Carrito De otro Restaurante")
        }
    }
    
           
    
    
}
