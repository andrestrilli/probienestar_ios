//
//  ControllerMenuRestaurante.swift
//  enjoitIos
//
//  Created by developapp on 8/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import Foundation
import Alamofire
class ControllerMenuRestaurante: ObservableObject{
    
    @Published var menu:MenuResponse?
    var infoRestaurante:RestaurantElement
    
    init(info:RestaurantElement){
        self.infoRestaurante = info
        getMenu_request(idUsuario: String(info.idUsuario))
    }
    
    func getMenu_request(idUsuario:String){
        print("getMenu_request");
        AF.request(ApiConection.baseUrl+"api/menurestaurante",
                   method:.get,
                   parameters: ["id":idUsuario],
                   encoding: URLEncoding.default,
                   headers: ["Authorization": "Bearer "+DataApp.authUser!.accessToken!])
            .responseString { response in
                    switch response.result {
                    case .success:
                        print(response)
                        switch response.response?.statusCode {
                        case 200:
                            print("getMenu_request exito")
                            do {
                                let res:MenuResponse =  try JSONDecoder().decode(MenuResponse.self ,from: response.data!)
                                self.menu = res;
                                
                            } catch let error {
                                print(error)
                            }
                            
                        default:
                            print("Ocurrio un error con el getRestaurants_request")
                            print("\(response)")
                        }
                        
                    case .failure(let error):
                        print (error)
                    }
        }
        
    }
    
    
    
}
