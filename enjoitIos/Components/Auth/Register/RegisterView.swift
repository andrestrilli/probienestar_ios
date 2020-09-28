//
//  RegisterView.swift
//  enjoitIos
//
//  Created by developapp on 7/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import SwiftUI

struct RegisterView: View {
    
    @EnvironmentObject var navigation: NavigationStack
    @ObservedObject var modelview = ControllerRegistro()
    
    let txtdescrip:String = "Completa tu registro y disfruta\nde todas las formas de realizar\ntu pedido"
    let sss = Values.strings["iniciarSesion"] ?? ""
    
//    @State var nickname:String = "";
//    @State var email:String = "";
//    @State var password:String = "";
//    @State var passwordConf:String = "";
//    @State var name:String = "";
//    @State var lastname:String = "";
//    @State var gender:String = "";
//    @State var birthDate:String = "";
//    @State var typeIdentification:String = "";
//    @State var numIdentification:String = "";
//    @State var numcellphone:String = "";
//    @State var phone:String = "";
//    @State var country:String = "";
//    @State var depto:String = "";
//    @State var city:String = "";

    
    var body: some View {
           KeyboardHost {
        ScrollView(){
           VStack(){
            HStack(){
                Button(action: self.navigation.unwind ){
                    Image("up-arrow").resizable().scaledToFit()
                        .frame(width: 22, height: 22)
                        .foregroundColor(Color("colorPrimary"))
                        .rotationEffect(.degrees(-90))
                        .padding(.leading, 12)
                    }
                Spacer()
                
            }
            
            
            VStack{
                Image("title_enjoit").padding()
                Text(txtdescrip).multilineTextAlignment(.center).foregroundColor(Color("grisOscuro")).font(.title)
            }
            Spacer()
            cuenta
            infoPersonal
            opcionesVivienda
            VStack(spacing:20){
                HStack(){
                    Toggle(isOn: self.$modelview.acceptTerminosCondiciones) {
                        Text(Values.strings["msgAceptarTerminos"] ?? "").multilineTextAlignment(.center).foregroundColor(Color("grisOscuro")).font(.body)
                    }
                }
                
                if  self.modelview.errorString != "" {
                    Text(self.modelview.errorString).multilineTextAlignment(.center).foregroundColor(Color.red).font(.body)
                }
                
                Button(action: {
                    self.modelview.hacerRegistro(navigation: self.navigation)
                }) {
                    HStack(){
                        Spacer()
                        Text("Listo").font(.headline)
                        Spacer()
                    }
                }.buttonStyle(ButtonGreenApp()).padding(Edge.Set.horizontal, 40)
            }
            Spacer()
            }.padding()
        }.onAppear{
            self.modelview.getGeneros_request()
            self.modelview.getTiposId_request()
            self.modelview.getCountry_request()
            }
        .alert(isPresented: self.$modelview.showAlert, content: { () -> Alert in
            self.alertRegisterError
        })
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(background)
        }
    }
    
    var cuenta: some View{
        VStack(alignment: .leading){ Text("Cuenta").foregroundColor(Color("colorPrimary")).font(.title)
            VStack(spacing:15){
                TextField("Nickname", text: self.$modelview.nickname).textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("E-mail", text: self.$modelview.email).keyboardType(.emailAddress).textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("Contraseña", text: self.$modelview.password).textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("Confirmar Contraseña", text: self.$modelview.passwordConf).textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            Divider().background(Color("colorPrimary"))
        }.padding()
    }
    
    var infoPersonal: some View{
        VStack(alignment: .leading){ Text("Información Personal").foregroundColor(Color("colorPrimary")).font(.title)
                   VStack(spacing:15){
                       TextField("Nombre", text: self.$modelview.name).textFieldStyle(RoundedBorderTextFieldStyle())
                       TextField("Apellido", text: self.$modelview.lastname).textFieldStyle(RoundedBorderTextFieldStyle())
                        SpinnerView(title: "Genero", data: self.modelview.getGenerosString(), selected: 0, onSelectedItem: {
                            indexSelected in print(indexSelected)
                            self.modelview.gender = String(self.modelview.generos[indexSelected].idValorParametro)
                        })
                       TextField("Fecha de Nacimiento", text: self.$modelview.birthDate).textFieldStyle(RoundedBorderTextFieldStyle())
                        SpinnerView(title: "Tipo Id", data: self.modelview.getTiposIdString(), selected: 0, onSelectedItem: {
                                                   indexSelected in print(indexSelected)
                            self.modelview.typeIdentification = String(self.modelview.tiposId[indexSelected].idValorParametro)
                                               })
                    TextField("Identificación", text: self.$modelview.numIdentification).keyboardType(.numberPad).textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("No. Celular", text: self.$modelview.numcellphone).keyboardType(.phonePad).textFieldStyle(RoundedBorderTextFieldStyle())
                        
                   }
                   
                   Divider().background(Color("colorPrimary"))
               }.padding()
    }
    
    var opcionesVivienda: some View{
        VStack(alignment: .leading){ Text("Opciones de vivienda").foregroundColor(Color("colorPrimary")).font(.title)
                   VStack(spacing:15){
                       TextField("Telefono", text: self.$modelview.phone).keyboardType(.phonePad).textFieldStyle(RoundedBorderTextFieldStyle())
                        SpinnerView(title: "Pais", data: self.modelview.getCountryString(), selected: 0, onSelectedItem: {
                                               indexSelected in print(indexSelected)
                            self.modelview.country = String(self.modelview.paises[indexSelected].idPais)
                            self.modelview.getDepto_request(idPais: self.modelview.country)
                                           })
                        
                    SpinnerView(title: "Departamento", data: self.modelview.getDeptoString(), selected: 0, onSelectedItem: {
                                       indexSelected in print(indexSelected)
                        self.modelview.depto = String(self.modelview.deptos[indexSelected].idDepartamento)
                        self.modelview.getCity_request(idDepto: self.modelview.depto)
                                   })
                    
                    SpinnerView(title: "Ciudad", data: self.modelview.getCiudadesString(), selected: 0, onSelectedItem: {
                                       indexSelected in print(indexSelected)
                    self.modelview.city = String(self.modelview.ciudades[indexSelected].idCiudad)
                                   })
                       //TextField("Pais", text: self.$modelview.lastname).textFieldStyle(RoundedBorderTextFieldStyle())
//                       TextField("Departamento", text: self.$modelview.gender).textFieldStyle(RoundedBorderTextFieldStyle())
//                       TextField("Ciudad", text: self.$modelview.birthDate).textFieldStyle(RoundedBorderTextFieldStyle())
                        
                   }
                   
                   Divider().background(Color("colorPrimary"))
               }.padding()
    }

    
    var background: some View{
        Image("corbatin_gris_background").resizable().scaledToFill()
    }
    
    var alertRegisterError : Alert {
        Alert(title: Text("Error en el Registro"), message: Text(self.modelview.AlertMessage), dismissButton: .default(Text("OK")))
    }
    
    
    
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}




