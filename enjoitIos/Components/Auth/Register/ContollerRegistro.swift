//
//  ContollerRegistro.swift
//  enjoitIos
//
//  Created by developapp on 25/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import Foundation
import Alamofire

class ControllerRegistro:ObservableObject {
    var viewModel = ControllerLogin()

    var navigation: NavigationStack?
    
    @Published var generos:[Parametro] = []
    @Published var tiposId:[Parametro] = []
    
    @Published var paises:[Country] = []
    @Published var deptos:[Depto] = []
    @Published var ciudades:[City] = []
    

    @Published var nickname:String = "";
    @Published var email:String = "";
    @Published var password:String = "";
    @Published var passwordConf:String = "";
    @Published var name:String = "";
    @Published var lastname:String = "";
    @Published var gender:String = "";
    @Published var birthDate:String = "";
    @Published var typeIdentification:String = "";
    @Published var numIdentification:String = "";
    @Published var numcellphone:String = "";
    @Published var phone:String = "";
    @Published var country:String = "";
    @Published var depto:String = "";
    @Published var city:String = "";
    @Published var acceptTerminosCondiciones:Bool = false
    
    @Published var errorString = ""
    @Published var showAlert = false
    @Published var AlertMessage = ""

    
    func hacerRegistro(navigation:NavigationStack){
        self.navigation = navigation
        if self.validacion() {
            self.postRegister_request()
        }
    }
    
    func validacion() -> Bool {
        
        if  self.name.isEmpty || !self.name.isAlphabetic {
            self.errorString = "El Campo nombre no es valido"
            return false
        }
        
        if  self.lastname.isEmpty || !self.lastname.isAlphabetic {
            self.errorString = "El Campo apellido no es valido"
            return false
        }
        
        if  self.nickname.isEmpty {
            self.errorString = "El Campo nickname no es valido"
            return false
        }
        
        if  self.email.isEmpty {
            self.errorString = "El Campo Correo electronico no es valido"
            return false
        }
        
        if  self.numcellphone.isEmpty || !self.numcellphone.isNumeric || self.numcellphone.count != 10 {
            self.errorString = "El Campo celular no es valido"
            return false
        }
        
        if  self.password.isEmpty {
            self.errorString = "El Campo contraseña no es valido"
            return false
        }
        
        if  self.passwordConf.isEmpty {
            self.errorString = "El Campo confirmar contraseña no es valido"
            return false
        }
        
        if  self.typeIdentification.isEmpty {
            self.errorString = "seleccione un Tipo de idenficacion"
            return false
        }
        
        if  self.gender.isEmpty {
             self.errorString = "seleccione un Genero"
             return false
        }
        

        
        if  self.numIdentification.isEmpty || !self.numIdentification.isNumeric {
            self.errorString = "El Campo Identificacion no es valido"
            return false
        }
        
        if  self.birthDate.isEmpty {
            self.errorString = "El Campo nombre no es valido"
            return false
        }
        
        if  !self.acceptTerminosCondiciones{
            self.errorString = "Debes aceptar los terminos y condiciones"
            return false
        }
        
        
        if  self.password != self.passwordConf {
            self.errorString = "Las Contraseñas No coinciden"
            return false
        }
        
        if self.phone != "" && !self.phone.isNumeric{
            self.errorString = "El campo telefono es invalido"
            return false
        }
        
        if  self.country.isEmpty  {
             self.errorString = "Seleccion un Pais"
             return false
        }
             
        if  self.depto.isEmpty  {
           self.errorString = "Seleccion un Departamento"
           return false
        }
        
        if self.city.isEmpty  {
           self.errorString = "Seleccion una ciudad"
           return false
        }
        
        return true
    }
    
    func postRegister_request() {
        
        let params:[String:Any] = [ "nombreUsuario": self.name ,
                                    "apellidoUsuario" : self.lastname ,
                                    "razonSocial" : self.nickname ,
                                    "email" : self.email ,
                                    "password" :self.password ,
                                    "idTipoDoc" :self.typeIdentification ,
                                    "numeroDocumento" :self.numIdentification ,
                                    "telefono" :self.phone ,
                                    "celular" :self.numcellphone ,
                                    "idCiudad" :self.city ,
                                    "idPais" :self.country ,
                                    "idDepart" :self.depto ,
                                    "idGenero" :self.gender,
                                    "fechaN" :self.birthDate ]
                                    
        
        
        print("postRegister_request");
        AF.request(ApiConection.baseUrl+"api/registro/usuario",
                   method:.post,
                   parameters: params,
                   encoding: URLEncoding.default,
                   headers: [:]).responseString { response in
                    switch response.result {
                    case .success:
                        switch response.response?.statusCode {
                        case 200:
                            print("postRegister_request exito")
                            do {
                                
                                self.viewModel.navigation = self.navigation
                                self.viewModel.Token_request(id: self.email, psw: self.password)

                            } catch let error {
                                print(error)
                            }
                        case 501:
                            self.AlertMessage = "Ya se encuentra un usuario registrado con el correo electronico"
                            self.showAlert = true
                            break
                        default:
//                            self.errorMessage = "lo sentimos ocurrio un problema, intente mas tarde"
                            
                            print("Ocurrio un error con el postRegister_request")
                            print("\(response)")
                        }
                        
                    case .failure(let error):
                        print (error)
                    }
        }
        
    }
    
    func getGeneros_request() {
        let idParametro:String = "3"
        print("getGeneros_request");
        AF.request(ApiConection.baseUrl+"api/getParameters",
                   method:.get,
                   parameters: ["idParameter":idParametro],
                   encoding: URLEncoding.default,
                   headers: []).responseString { response in
                    switch response.result {
                    case .success:
                        print(response)
                        switch response.response?.statusCode {
                        case 200:
                            print("getGeneros_request exito")
                            do {
                                let res: ParametroResponse =  try JSONDecoder().decode(ParametroResponse.self ,from: response.data!)
                                self.generos = res.data;
                                
                            } catch let error {
                                print(error)
                            }
                            
                            
                        default:
                            print("Ocurrio un error con el getGeneros_request")
                            print("\(response)")
                        }
                        
                    case .failure(let error):
                        print (error)
                    }
        }
        
    }
    func getGenerosString() -> [String] {
        var aux:[String] = []
        for genero in self.generos {
            aux.append(genero.nombre)
        }
        return aux
    }
    
    
    func getTiposId_request() {
        let idParametro:String = "2"
        print("getTiposId_request");
        AF.request(ApiConection.baseUrl+"api/getParameters",
                   method:.get,
                   parameters: ["idParameter":idParametro],
                   encoding: URLEncoding.default,
                   headers: []).responseString { response in
                    switch response.result {
                    case .success:
                        print(response)
                        switch response.response?.statusCode {
                        case 200:
                            print("getTiposId_request exito")
                            do {
                                let res: ParametroResponse =  try JSONDecoder().decode(ParametroResponse.self ,from: response.data!)
                                self.tiposId = res.data;
                                
                            } catch let error {
                                print(error)
                            }
                            
                            
                        default:
                            print("Ocurrio un error con el getTiposId_request")
                            print("\(response)")
                        }
                        
                    case .failure(let error):
                        print (error)
                    }
        }
        
    }
    func getTiposIdString() -> [String] {
        var aux:[String] = []
        for tipo in self.tiposId {
            aux.append(tipo.nombre)
        }
        return aux
    }
    
    func getCountry_request() {
        print("getCountry_request");
        AF.request(ApiConection.baseUrl+"api/getCountries",
                   method:.get,
                   parameters: [:],
                   encoding: URLEncoding.default,
                   headers: []).responseString { response in
                    switch response.result {
                    case .success:
                        print(response)
                        switch response.response?.statusCode {
                        case 200:
                            print("getCountry_request exito")
                            do {
                                let res: CountryResponse =  try JSONDecoder().decode(CountryResponse.self ,from: response.data!)
                                self.paises = res.data;
                                
                            } catch let error {
                                print(error)
                            }
                            
                            
                        default:
                            print("Ocurrio un error con el getCountry_request")
                            print("\(response)")
                        }
                        
                    case .failure(let error):
                        print (error)
                    }
        }
        
    }
    func getCountryString() -> [String] {
        var aux:[String] = []
        for x in self.paises {
            aux.append(x.nombre)
        }
        return aux
    }
    
    func getDepto_request(idPais:String) {
        print("getCountry_request");
        AF.request(ApiConection.baseUrl+"api/getDepartamento",
                   method:.get,
                   parameters: ["idPais":idPais],
                   encoding: URLEncoding.default,
                   headers: []).responseString { response in
                    switch response.result {
                    case .success:
                        print(response)
                        switch response.response?.statusCode {
                        case 200:
                            print("getDepto_request exito")
                            do {
                                let res: DeptoResponse =  try JSONDecoder().decode(DeptoResponse.self ,from: response.data!)
                                self.deptos = res.data;
                                
                            } catch let error {
                                print(error)
                            }
                            
                            
                        default:
                            print("Ocurrio un error con el getDepto_request")
                            print("\(response)")
                        }
                        
                    case .failure(let error):
                        print (error)
                    }
        }
        
    }
    func getDeptoString() -> [String] {
        var aux:[String] = []
        for x in self.deptos {
            aux.append(x.nombre)
        }
        return aux
    }
    
    func getCity_request(idDepto:String) {
        print("getCity_request");
        AF.request(ApiConection.baseUrl+"api/getCity",
                   method:.get,
                   parameters: ["idDpto":idDepto],
                   encoding: URLEncoding.default,
                   headers: []).responseString { response in
                    switch response.result {
                    case .success:
                        print(response)
                        switch response.response?.statusCode {
                        case 200:
                            print("getCity_request exito")
                            do {
                                let res: CityResponse =  try JSONDecoder().decode(CityResponse.self ,from: response.data!)
                                self.ciudades = res.data;
                                
                            } catch let error {
                                print(error)
                            }
                            
                            
                        default:
                            print("Ocurrio un error con el getCity_request")
                            print("\(response)")
                        }
                        
                    case .failure(let error):
                        print (error)
                    }
        }
        
    }
    func getCiudadesString() -> [String] {
        var aux:[String] = []
        for x in self.ciudades {
            aux.append(x.nombre)
        }
        return aux
    }
    
}



