//
//  ControllerMisDirecciones.swift
//  enjoitIos
//
//  Created by developapp on 12/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import CoreLocation
import SwiftUI

class ControllerMisDirecciones: UIViewController, ObservableObject{
    
    @Published var direcciones:[Direccion] = []
    
    let geocoder = CLGeocoder()
    @Published var geoCodedDirection:CLLocation?
    var placemark : CLPlacemark?
    @Published var isPerformingGeocoding = false
    var lastGeocodingError: Error?

    func getDirecciones_request() {
        print("getDirecciones_request");
        AF.request(ApiConection.baseUrl+"api/direcciones/user",
                   method:.get,
                   parameters: ["idUser":DataApp.user!.idUsuario],
                   encoding: URLEncoding.default,
                   headers: ["Authorization": "Bearer "+DataApp.authUser!.accessToken!]).responseString { response in
                    switch response.result {
                    case .success:
                        print(response)
                        switch response.response?.statusCode {
                        case 200:
                            print("getRestaurants_request exito")
                            do {
                                let res: DireccionesResponse =  try JSONDecoder().decode(DireccionesResponse.self ,from: response.data!)
                                print(res)
                                self.direcciones = res.data;
                            } catch let error {
                                print(error)
                            }
                            
                        default:
                            //self.errorMessage = "lo sentimos ocurrio un problema, intente mas tarde"
                            
                            print("Ocurrio un error con el getDirecciones_request")
                            print("\(response)")
                        }
                        
                    case .failure(let error):
                        print (error)
                    }
        }
        
    }
    
    //peticion parametros de ciudad
    
    
    func removeDirecciones_request(idDireccion:Int) {
        print("removeDirecciones_request");
        AF.request(ApiConection.baseUrl+"api/direcciones/removeAddress",
                   method:.post,
                   parameters: ["iduser":DataApp.user!.idUsuario,
                                "idDireccion":idDireccion],
                   encoding: URLEncoding.default,
                   headers: ["Authorization": "Bearer "+DataApp.authUser!.accessToken!]).responseString { response in
                    switch response.result {
                    case .success:
                        print(response)
                        switch response.response?.statusCode {
                        case 200:
                            self.showAlert(title: "Eliminacion Exitosa", descrip: "Usted ha eliminado la direccion")
                            self.getDirecciones_request()
                        default:
                            //self.errorMessage = "lo sentimos ocurrio un problema, intente mas tarde"
                            
                            print("Ocurrio un error con el removeDirecciones_request")
                            print("\(response)")
                        }
                        
                    case .failure(let error):
                        print (error)
                    }
        }
        
    }
    
    func addDirecciones_request(idDireccion:Int) {
        print("removeDirecciones_request");
        AF.request(ApiConection.baseUrl+"api/direcciones/removeAddress",
                   method:.post,
                   parameters: ["iduser":DataApp.user!.idUsuario,
                                "idDireccion":idDireccion],
                   encoding: URLEncoding.default,
                   headers: ["Authorization": "Bearer "+DataApp.authUser!.accessToken!]).responseString { response in
                    switch response.result {
                    case .success:
                        print(response)
                        switch response.response?.statusCode {
                        case 200:
                            self.showAlert(title: "Eliminacion Exitosa", descrip: "Usted ha eliminado la direccion")
                            self.getDirecciones_request()
                        default:
                            //self.errorMessage = "lo sentimos ocurrio un problema, intente mas tarde"
                            
                            print("Ocurrio un error con el removeDirecciones_request")
                            print("\(response)")
                        }
                        
                    case .failure(let error):
                        print (error)
                    }
        }
        
    }
    
    func showAlert(title:String, descrip:String) {
        let alert = UIAlertController(title: title, message: descrip, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    func geoCodeAddress(address:String){
        geocoder.geocodeAddressString(address) { (addresses, error) in
            self.lastGeocodingError = error
            if  error == nil , let addresses = addresses, !addresses.isEmpty {
                var addressResponse = addresses.last!
                self.geoCodedDirection = addressResponse.location
            }else{
                print(error)
                self.geoCodedDirection = nil
                self.showAlert(title: "Oops", descrip: "No se pudo determinar la ubicacion de la direccion indicada")
            }
        }
    }
    
    func addDireccion_request( address:Direccion, navigation:NavigationStack ) {
        print("addDireccion_request");
        AF.request(
            ApiConection.baseUrl+"api/direcciones/addAddress",
                   method:.post,
                   parameters: ["id_user" : address.id_user,
                                "name" : address.name ?? "",
                                "extra" : address.extra ?? "",
                                "direccion" : address.direccion ?? "",
                                "direccion2" : address.direccion2 ?? "",
                                "latitud" : address.latitud ?? "",
                                "longitud" : address.longitud ?? "",
                                "id_pais" : address.idPais!,
                                "id_dpto" : address.idDpto!,
                                "id_ciudad" : address.idCiudad!],
                   encoding: URLEncoding.httpBody,
                   headers: ["Authorization": "Bearer "+DataApp.authUser!.accessToken!]
        ).responseString { response in
                    switch response.result {
                    case .success:
                        print(response)
                        switch response.response?.statusCode {
                        case 200:
                            print("addDireccion_request exito")
                            do {
                                navigation.advance(NavigationItem(view: AnyView(MisDireccionesView())));
                                
                            } catch let error {
                                print(error)
                            }
                            
                            
                        default:
                            print("Ocurrio un error con el addDireccion_request")
                            print("\(response)")
                            print(response.request)
                        }
                        
                    case .failure(let error):
                        print (error)
                    }
        }
        
    }
    
}
