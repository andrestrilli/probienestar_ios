//
//  RepositoryOrdenar.swift
//  enjoitIos
//
//  Created by developapp on 10/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import Foundation
import Alamofire

class RepositoryOrdenar: ObservableObject{
    
    private static let key:String = "carritoActualOrdenar"
    private static let localStorage = UserDefaults.standard
//    
//    @Published private(set) static var carrito:Carrito?
//    
//    init(){
//        
//    }
//    
//    public static func getCarrito()->Carrito{
//        self.syncronize()
//        if let car:Carrito = self.carrito {
//            return car
//        }
//        return Carrito()
//    }
//    
//    
//    private static func syncronize(){
//        self.carrito = getCarritoLocal()
//        getCarrito_Request()
//    }
//    
////    private static func updateCarrito(car:Carrito){
////        saveCarritoLocal(carrito: car)
////        self.carrito = car;
////    }
//    
//    
//    private static func saveCarritoLocal(carrito:Carrito){
//        localStorage.set(carrito, forKey: self.key)
//    }
//    
//    private static func getCarritoLocal()->Carrito{
//        
//        if let carrito = localStorage.object(forKey: self.key),
//            let aux = carrito as? Carrito{
//            return aux
//        }
//        
//        return Carrito()
//    }
//    
//    
//    
//    private static func getCarrito_Request() {
//        print("getCarrito_Request");
//        AF.request(ApiConection.baseUrl+"api/verificarUserPedidoExistente",
//                   method:.get,
//                   parameters: ["idCliente":DataApp.user!.idUsuario],
//                   encoding: URLEncoding.default,
//                   headers: ["Authorization": "Bearer "+DataApp.authUser!.accessToken!]).responseString { response in
//                    switch response.result {
//                    case .success:
//                        print(response)
//                        switch response.response?.statusCode {
//                        case 210:
//                            print("getCarrito_Request exito")
//                            do {
//                                let res: CarritoResponse =  try JSONDecoder().decode(CarritoResponse.self ,from: response.data!)
//                                print(res)
//                                if  let carrito = res.data{
//                                    self.carrito = carrito;
//                                }
//                                
//                            } catch let error {
//                                print(error)
//                            }
//                        break
//                        case 220:
//                            
//                            //si el carrito no se ha enviado entonces no lo borro para que se mantendan local
////                            if self.carrito.idPedido != nil {
////                                //self.updateCarrito(carrito: Carrito())
////                            }
////                            
//                            
//                            break
//                            
//                        default:
//                            print("Ocurrio un error con el getCarrito_Request Ordenar")
//                            print("\(response)")
//                        }
//                        
//                    case .failure(let error):
//                        print (error)
//                    }
//        }
//        
//    }
//    
//    
//    
//    
//    
    
    
}
