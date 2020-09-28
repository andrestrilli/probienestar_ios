//
//  ControllerPerfikl.swift
//  enjoitIos
//
//  Created by developapp on 25/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import Foundation
import Alamofire

class ControllerPerfil : ObservableObject{

    var viewModel = ControllerLogin()
    var navigation: NavigationStack?
       
   @Published var generos:[Parametro] = []
   @Published var tiposId:[Parametro] = []
   
   @Published var paises:[Country] = []
   @Published var deptos:[Depto] = []
   @Published var ciudades:[City] = []
   

    @Published var nickname:String = DataApp.user!.userName;
   @Published var email:String = DataApp.user!.email;
  // @Published var password:String = DataApp.user!.userName;
  // @Published var passwordConf:String = "";
    @Published var name:String = DataApp.user!.nombre;
   @Published var lastname:String = DataApp.user!.apellido;
   @Published var gender:String = DataApp.user!.txtGenero ?? "none";
    @Published var birthDate:String = DataApp.user!.fechaN ?? "none";
   @Published var typeIdentification:String = DataApp.user!.txtTipoIdentificacion ?? "none";
   @Published var numIdentification:String = DataApp.user!.numeroDocumento ?? "none";
   @Published var numcellphone:String = DataApp.user!.celular ?? "none";
   @Published var phone:String = DataApp.user!.telefono ?? "none";
    @Published var country:String = DataApp.user!.txtPais ?? "none";
    @Published var depto:String = DataApp.user!.txtDepto ?? "none";
    @Published var city:String = DataApp.user!.txtCiudad ?? "none";
//   @Published var acceptTerminosCondiciones:Bool = false
   @Published var idcountry:Int = DataApp.user!.idPais ?? 0;
   @Published var iddepto:Int = DataApp.user!.idDepartamento ?? 0;
   @Published var idcity:Int = DataApp.user!.idCiudad  ?? 0;
@Published var idtypeIdentification:Int = DataApp.user!.idTipoDocumento ?? 0;
    @Published var idgender:Int = DataApp.user!.idGenero  ?? 0;

    
   @Published var errorString = ""
   @Published var showAlert = false
   @Published var showAlertSaveChanges = false
   @Published var showAlertDiscardChanges = false
   @Published var AlertMessage = ""
    
    @Published var isEditing = false
    
    init() {
        
    }
    
    
    func loadInfoUser(){
        self.nickname = DataApp.user!.userName;
        self.email = DataApp.user!.email;
        //  self.password:String = DataApp.user!.userName;
        //  self.var passwordConf:String = "";
        self.name = DataApp.user!.nombre;
        self.lastname = DataApp.user!.apellido;
        self.gender = DataApp.user!.txtGenero ?? "none";
        self.birthDate = DataApp.user!.fechaN ?? "none";
        self.typeIdentification = DataApp.user!.txtTipoIdentificacion ?? "none";
        self.numIdentification = DataApp.user!.numeroDocumento ?? "none";
        self.numcellphone = DataApp.user!.celular ?? "none";
        self.phone = DataApp.user!.telefono ?? "none";
        self.country = DataApp.user!.txtPais ?? "none";
        self.depto = DataApp.user!.txtDepto ?? "none";
        self.city = DataApp.user!.txtCiudad ?? "none";
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
        
//        if  self.password.isEmpty {
//            self.errorString = "El Campo contraseña no es valido"
//            return false
//        }
//
//        if  self.passwordConf.isEmpty {
//            self.errorString = "El Campo confirmar contraseña no es valido"
//            return false
//        }
        
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
        
//        if  !self.acceptTerminosCondiciones{
//            self.errorString = "Debes aceptar los terminos y condiciones"
//            return false
//        }
//
//
//        if  self.password != self.passwordConf {
//            self.errorString = "Las Contraseñas No coinciden"
//            return false
//        }
        
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
    
    func editarPerfil_request() {
        
        let params:[String:Any] = ["idUsuario": DataApp.user!.idUsuario ,
                                    "nombreUsuario": self.name ,
                                    "apellidoUsuario" : self.lastname ,
                                    "razonSocial" : self.nickname ,
                                    "email" : self.email ,
                                    //"password" :self.password ,
                                    "idTipoDoc" :self.idtypeIdentification ,
                                    "numeroDocumento" :self.numIdentification ,
                                    "telefono" :self.phone ,
                                    "celular" :self.numcellphone ,
                                    "idCiudad" :self.idcity ,
                                    "idPais" :self.idcountry ,
                                    "idDepart" :self.iddepto ,
                                    "idGenero" :self.idgender,
                                    "fechaN" :self.birthDate ]
        
        print("editarPerfil_request");
        AF.request(ApiConection.baseUrl+"api/updateUser",
                   method:.post,
                   parameters: params,
                   encoding: URLEncoding.default,
                   headers: ["Authorization": "Bearer "+DataApp.authUser!.accessToken!]).responseString { response in
                    switch response.result {
                    case .success:
                        print(response)
                        switch response.response?.statusCode {
                        case 200:
                            print("editarPerfil_request exito")
                            self.getUserData_request(email: DataApp.user!.email , psw: "oo")
                            
                        default:
                            print("Ocurrio un error con el editarPerfil_request")
                            print("\(response)")
                        }
                        
                    case .failure(let error):
                        print (error)
                    }
        }
        
    }
    
    func startEditing(){
        self.isEditing = true
        
//        self.getGeneros_request()
//        self.getTiposId_request()
//        self.getCountry_request()
//        if  let idPaiss = DataApp.user!.idPais {
//            self.getDepto_request(idPais: String(idPaiss) )
//        }
//        if  let idepto = DataApp.user!.idDepartamento {
//            self.getCity_request(idDepto: String(idepto))
//        }
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
//        if  !self.isEditing {
            aux.append(DataApp.user!.txtGenero ?? "none")
//        }else{
//            for genero in self.generos {
//                aux.append(genero.nombre)
//                }
//        }
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
//        if  !self.isEditing {
            aux.append(DataApp.user!.txtTipoIdentificacion ?? "none")
//        }else{
//            for tipo in self.tiposId {
//                aux.append(tipo.nombre)
//            }
//        }
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
//        if  !self.isEditing {
            aux.append(DataApp.user!.txtPais ?? "none")
//        }else{
//            for x in self.paises {
//                aux.append(x.nombre)
//            }
//        }
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
//        if  !self.isEditing {
            aux.append(DataApp.user!.txtDepto ?? "none")
//        }else{
//            for x in self.deptos {
//                aux.append(x.nombre)
//            }
//        }
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
//        if  !self.isEditing {
          aux.append(DataApp.user!.txtCiudad ?? "none")
//        }else{
//            for x in self.ciudades {
//                aux.append(x.nombre)
//            }
//        }
        return aux
    }
    
    func guardarCambios(){
        if  self.validacion() {
            self.isEditing = false;
            self.editarPerfil_request()
            
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
                                        self.loadInfoUser()
                                        //KeyChain.saveCredentials(psw: psw, user: email);
//
//                                        FirebaseController.fijarReferencia()
//
//                                        _ = RepositoryDomicilio().getCarrito()
//                                        self.gotoHome()
                                    
                                    } catch let error {
                                        print(error)
                                    }
                                
                                default:
                                    self.errorString = "lo sentimos ocurrio un problema, intente mas tarde"
                             
                                }
                                
                            case .failure(let error):
                                print (error)
                            }
        }
        
    }
    
}
