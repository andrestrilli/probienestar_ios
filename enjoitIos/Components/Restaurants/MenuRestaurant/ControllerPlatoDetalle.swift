//
//  ControllerPlatoDetalle.swift
//  enjoitIos
//
//  Created by developapp on 10/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import Foundation
import Alamofire
import SwiftUI

class ControllerPlatoDetalle: ObservableObject{
    
    private let product:Producto?
    @Published private(set) var ingredientes:Ingredientes?
    @Published public var comment:String = ""

    @Published private(set) var error:Error?
    
    var ingredientesSelecteds:[IngredienteElement] = []
    
    init(product:Producto){
        self.product = product
        getIngredientes_request(idProduct: String(product.id))
    }
    
    func getIngredientes_request(idProduct:String) {
        print("getIngredientes_request");
        AF.request(ApiConection.baseUrl+"api/ingredientesPlatos",
                   method:.get,
                   parameters: ["id":idProduct],
                   encoding: URLEncoding.default,
                   headers: ["Authorization": "Bearer "+DataApp.authUser!.accessToken!]).responseString { response in
                    switch response.result {
                    case .success:
                        print(response)
                        switch response.response?.statusCode {
                            
                        case 200:
                            print("getIngredientes_request exito")
                            do {
                                
                                let res: Ingredientes =  try JSONDecoder().decode(Ingredientes.self ,from: response.data!)
                                print(res)
                                self.ingredientes = res
                                
                            } catch let error {
                                print(error)
                            }
                            
                            
                        default:
                            //   self.errorMessage = "lo sentimos ocurrio un problema, intente mas tarde"
                            print("Ocurrio un error con el getIngredientes_request")
                            print("\(response)")
                        }
                        
                    case .failure(let error):
                        print (error)
                    }
        }
        
    }
    
    func onPedirButtonPressed(intent:String,navigation: NavigationStack){
        switch intent {
        case "DOMICILIO":
            PedidosParaDomicilio(navigation:navigation)
        default:
            print("No se detecto el tipo de pedido")
        }
    }
    
    func PedidosParaDomicilio(navigation: NavigationStack){
        
        //Preparo los ingredientes en configPeddios para envuiarlos
        var configSelecteds:[ConfigPedidoDetalle] = []
        
        for ingre in self.ingredientesSelecteds {
            let config:ConfigPedidoDetalle = ConfigPedidoDetalle(idConfig: ingre.idConfigProducto, nombre: ingre.nombre, valor: ingre.valor, tipo: ingre.tipo)
            configSelecteds.append(config)
            
        }
        
        print(self.comment)
        
        ControllerDomicilio.AgregarItemParaDomicilio(navigation: navigation, product: self.product!,ingreSelecteds: configSelecteds, comment: self.comment)

    }
    
    
    
    
}

