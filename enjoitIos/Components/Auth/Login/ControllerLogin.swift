//
//  ControllerLogin.swift
//  enjoitIos
//
//  Created by developapp on 8/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import Foundation
import Alamofire
import SwiftUI

class ControllerLogin : ObservableObject{
    
    var navigation:NavigationStack?
    public var errorMessage:String = "";
    
    init(){
        
    }
    

    //Resquest
    
    func Token_request(id: String, psw: String) {
        print("Login_request");
        AF.request(ApiConection.baseUrl+"oauth/token",
                          method:.post,
                          parameters: ["client_id": "2",
                                       "client_secret": "JNpDl93WpwZj5GWRohqFGU3oQwfmVyirm7Mgq3nU",
                                       "grant_type": "password",
                                       "username": id,
                                       "password": psw],
                          encoding: URLEncoding.httpBody).responseString { response in
                            switch response.result {
                            case .success:
                                print(response)
                                switch response.response?.statusCode {
                                case 200:
                                    print("login realizado con exito")
                                    do {
                                        let auth: AuthResponse =  try JSONDecoder().decode(AuthResponse.self ,from: response.data!)
                                        print(auth)
                                       DataApp.authUser = auth;
                                        
                                        self.getUserData_request(email: id, psw: psw);
                                                                     
                                    } catch let error {
                                        print(error)
                                    }
                                case 401:
                                    self.errorMessage = "Credenciales invalidas"
                                    KeyChain.saveCredentials(psw: "", user: "")

                                    
                                default:
                                    self.errorMessage = "lo sentimos ocurrio un problema, intente mas tarde"
                                    
                                    print("Ocurrio un error con el loggeo")
                                    print("\(response)")
                                }
                                
                            case .failure(let error):
                                print (error)
                            }
        }
        
    }
    
    func getUserData_request(email: String, psw:String) {
        print("getUserData_request");
        AF.request(ApiConection.baseUrl+"api/obtenerUser",
                          method:.get,
                          parameters: ["email": email],
                          encoding: URLEncoding.default,
                          headers: ["Authorization": "Bearer "+DataApp.authUser!.accessToken!])
            .responseString { response in
                            switch response.result {
                            case .success:
                                print(response)
                                switch response.response?.statusCode {
                                case 200:
                                    do {
                                        let res: User =  try JSONDecoder().decode(User.self ,from: response.data!)
                                        print(res)
                                        
                                        DataApp.user = res;
                                        KeyChain.saveCredentials(psw: psw, user: email);

                                        FirebaseController.fijarReferencia()

                                        _ = RepositoryDomicilio().getCarrito()
                                        self.gotoHome()
                                    
                                    } catch let error {
                                        print(error)
                                    }
                                
                                default:
                                    self.errorMessage = "lo sentimos ocurrio un problema, intente mas tarde"
                             
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
