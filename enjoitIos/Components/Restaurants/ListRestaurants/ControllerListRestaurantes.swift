//
//  ControllerListRestaurantes.swift
//  enjoitIos
//
//  Created by developapp on 8/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import Foundation
import Alamofire
import SwiftUI

class ControllerLisRestaurantes : ObservableObject{
    
    var navigation:NavigationStack?
    public var errorMessage:String = "";
    
    @Published var restaurantes:Restaurants = []
    
    init(){
        //self.restaurantes = DataApp
        getRestaurants_request();
    }
    
    
    //Resquest
    
    func getRestaurants_request() {
        print("getRestaurants_request");
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
                                    print("getRestaurants_request exito")
                                    do {
                                        let res: Restaurants =  try JSONDecoder().decode(Restaurants.self ,from: response.data!)
                                        print(res)
                                        self.restaurantes = res;
                                        
                                    } catch let error {
                                        print(error)
                                    }
    
                                    
                                default:
                                    self.errorMessage = "lo sentimos ocurrio un problema, intente mas tarde"
                                    
                                    print("Ocurrio un error con el getRestaurants_request")
                                    print("\(response)")
                                }
                                
                            case .failure(let error):
                                print (error)
                            }
        }
        
    }
    
    
    private func gotoHome(){
        if  let navigation = self.navigation {
            navigation.advance(NavigationItem(view: AnyView(HomeView())))
        }
    }
    
    
}
