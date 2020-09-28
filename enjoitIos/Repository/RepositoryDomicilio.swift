//
//  RepositoryDomicilio.swift
//  enjoitIos
//
//  Created by developapp on 11/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import Foundation
import Alamofire

class RepositoryDomicilio: ObservableObject{
    
    private let key:String = "carritoActualDomicilio"
    private let localStorage = UserDefaults.standard
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    
    @Published var carrito:Carrito?

    init(){

    }

    public func getCarrito()->Carrito{
        self.syncronize()
        if let car:Carrito = self.carrito {
            return car
        }
        return Carrito()
    }


    private func syncronize(){
        self.carrito = getCarritoLocal()
        getCarrito_Request()
    }

    public func updateCarrito(car:Carrito){
        self.saveCarritoLocal(carrito: car)
        self.carrito = car;
    }


    private func saveCarritoLocal(carrito:Carrito){
        if let encodedData = try? encoder.encode(carrito){
            localStorage.set(encodedData, forKey: self.key)
        }
    }

    private func getCarritoLocal()->Carrito{

        if let data = localStorage.value(forKey: self.key) as? Data{
            do {
                let res: Carrito =  try JSONDecoder().decode(Carrito.self ,from: data)
                print(res)
                return res
               } catch let error {
                   print(error)
               }
        }
        return Carrito()
    }

    private func getCarrito_Request() {
        print("getCarrito_Request");
        AF.request(ApiConection.baseUrl+"api/domicilio/confirmarPedidoUser",
                   method:.get,
                   parameters: ["idCliente":DataApp.user!.idUsuario],
                   encoding: URLEncoding.default,
                   headers: ["Authorization": "Bearer "+DataApp.authUser!.accessToken!]).responseString { response in
                    switch response.result {
                    case .success:
                        print(response)
                        switch response.response?.statusCode {
                        case 210://SI HAY CARRITO
                            print("getCarrito_Request exito")
                            do {
                                let res: CarritoResponse =  try JSONDecoder().decode(CarritoResponse.self ,from: response.data!)
                                print(res)
                                if  let carrito = res.data{
                                    self.carrito = carrito;
                                    self.updateCarrito(car: carrito)
                                }

                            } catch let error {
                                print(error)
                            }
                        break
                        case 220://NO HAY CARRITO
                            //si el carrito no se ha enviado entonces no lo borro para que se mantendan local
                            if let carrito = self.carrito{
                                if carrito.idPedido != nil {
                                    self.updateCarrito(car: Carrito())
                                }
                            }
                            
                            //self.updateCarrito(car: Carrito())


                            break

                        default:
                            print("Ocurrio un error con el getCarrito_Request Domicilio")
                            print("\(response)")
                        }

                    case .failure(let error):
                        print (error)
                    }
        }

    }



    
    

    
    
}// endClasss
