//
//  ControllerPropina.swift
//  enjoitIos
//
//  Created by developapp on 17/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import Foundation
import Alamofire

class ControllerPropina: ObservableObject{
    @Published var valores:[Valore] = []

    init(idRest:Int){
        self.getPropinasRestaurante_request(idRestaurante: idRest)
    }
    
    func getPropinasRestaurante_request(idRestaurante:Int) {
        print("getPropinasRestaurante_request");
        AF.request(ApiConection.baseUrl+"api/propinarestaurante",
                   method:.get,
                   parameters: ["id" :idRestaurante],
                   encoding: URLEncoding.default,
                   headers: ["Authorization": "Bearer "+DataApp.authUser!.accessToken!]).responseString { response in
                    switch response.result {
                    case .success:
                        print(response)
                        switch response.response?.statusCode {
                        case 200:
                            print("getPropinasRestaurante_request exito")
                            do {
                                
                                let res: PropinaResponse =  try JSONDecoder().decode(PropinaResponse.self ,from: response.data!)
                                print(res)
                                
                                self.valores = res.valores;
                                
                                
                            } catch let error {
                                print(error)
                            }
                            
                            
                        default:
                            
                            print("Ocurrio un error con el getPropinasRestaurante_request")
                            print("\(response)")
                        }
                        
                    case .failure(let error):
                        print (error)
                    }
        }
        
    }
    
    
    
}
