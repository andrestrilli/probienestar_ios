//
//  PerfilView.swift
//  enjoitIos
//
//  Created by developapp on 25/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import SwiftUI

struct PerfilView: View {
    
    @ObservedObject var modelview = ControllerPerfil()
    @EnvironmentObject var navigation: NavigationStack
    
    var body: some View {
        KeyboardHost {
            ScrollView(){
                VStack(spacing:10){
                    topPart.border(Color.blue)
                    cuenta
                    infoPersonal
                    opcionesVivienda
                    if  self.modelview.isEditing {
                        btGuardar
                    }
                    
                }.alert(isPresented: self.$modelview.showAlertDiscardChanges) { () -> Alert in
                    alertDescartarCambios
                }
                
            }.border(Color.green)
            .alert(isPresented: self.$modelview.showAlertSaveChanges) { () -> Alert in
                alertGuardarCambios
            }
        }.border(Color.yellow)
    }
    
    var topPart : some View {
        VStack(alignment: .center, spacing:0){
            ToolbarView()
            
            ZStack(alignment: .top){
                Image("cortina_background_red")
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity).padding(0)
                
                VStack(alignment: .center, spacing: 10){
                    Image("perfil_image")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    
                    Text(self.modelview.nickname).font(.title).foregroundColor(Color.white)
                }
                
                HStack(){
                    Spacer()
                    Image("pencil")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .onTapGesture {
                        if self.modelview.isEditing {
                            self.modelview.showAlertDiscardChanges = true
                        }else{
                            self.modelview.startEditing()
                        }
                    }
                    
                }.padding()
            }
            
        }
    }
    
    var cuenta: some View{
            VStack(alignment: .leading){ Text("Cuenta").foregroundColor(Color("colorPrimary")).font(.title)
                VStack(spacing:15){
                    TextField("Nickname", text: self.$modelview.nickname).textFieldStyle(RoundedBorderTextFieldStyle()).disabled(true)
                    TextField("E-mail", text: self.$modelview.email).keyboardType(.emailAddress).textFieldStyle(RoundedBorderTextFieldStyle()).disabled(true)
                //    SecureField("Contraseña", text: self.$modelview.password).textFieldStyle(RoundedBorderTextFieldStyle())
                //    SecureField("Confirmar Contraseña", text: self.$modelview.passwordConf).textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Divider().background(Color("colorPrimary"))
            }.padding()
        }
        
    var infoPersonal: some View{
        VStack(alignment: .leading){ Text("Información Personal").foregroundColor(Color("colorPrimary")).font(.title)
                    VStack(spacing:15){
                        
                        TextField("Nombre", text: self.$modelview.name).textFieldStyle(RoundedBorderTextFieldStyle()).disabled(!self.modelview.isEditing)
                        
                        TextField("Apellido", text: self.$modelview.lastname).textFieldStyle(RoundedBorderTextFieldStyle()).disabled(!self.modelview.isEditing)
                        
                        SpinnerView(title: "Genero", data: self.modelview.getGenerosString(), selected: 0, onSelectedItem: {
                            indexSelected in print(indexSelected)
                            self.modelview.gender = String(self.modelview.generos[indexSelected].idValorParametro)
                        },disable: true)
                        
                        TextField("Fecha de Nacimiento", text: self.$modelview.birthDate).textFieldStyle(RoundedBorderTextFieldStyle()).disabled(!self.modelview.isEditing)
                        
                        SpinnerView(title: "Tipo Id", data: self.modelview.getTiposIdString(), selected: 0, onSelectedItem: {
                                                    indexSelected in print(indexSelected)
                            self.modelview.typeIdentification = String(self.modelview.tiposId[indexSelected].idValorParametro)
                                                },disable: true)
                        
                        TextField("Identificación", text: self.$modelview.numIdentification).keyboardType(.numberPad).textFieldStyle(RoundedBorderTextFieldStyle()).disabled(!self.modelview.isEditing)
                        
                        TextField("No. Celular", text: self.$modelview.numcellphone).keyboardType(.phonePad).textFieldStyle(RoundedBorderTextFieldStyle()).disabled(!self.modelview.isEditing)
                    }
                    
                    Divider().background(Color("colorPrimary"))
                }.padding()
    }
        
    var opcionesVivienda: some View{
        VStack(alignment: .leading){ Text("Opciones de vivienda").foregroundColor(Color("colorPrimary")).font(.title)
                    VStack(spacing:15){
                        
                    TextField("Telefono", text: self.$modelview.phone).keyboardType(.phonePad).textFieldStyle(RoundedBorderTextFieldStyle()).disabled(!self.modelview.isEditing)
                        
                    SpinnerView(title: "Pais", data: self.modelview.getCountryString(), selected: 0, onSelectedItem: {
                            indexSelected in print(indexSelected)
                            self.modelview.country = String(self.modelview.paises[indexSelected].idPais)
                            self.modelview.getDepto_request(idPais: self.modelview.country)
                            },disable:  true)
                        
                    SpinnerView(title: "Departamento", data: self.modelview.getDeptoString(), selected: 0, onSelectedItem: {
                            indexSelected in print(indexSelected)
                            self.modelview.depto = String(self.modelview.deptos[indexSelected].idDepartamento)
                            self.modelview.getCity_request(idDepto: self.modelview.depto)
                            },disable: true)
                    
                    SpinnerView(title: "Ciudad", data: self.modelview.getCiudadesString(), selected: 0, onSelectedItem: {
                            indexSelected in print(indexSelected)
                            self.modelview.city = String(self.modelview.ciudades[indexSelected].idCiudad)
                            },disable: true)

                        
                    }
                    
                    Divider().background(Color("colorPrimary"))
                }.padding()
    }
    
    var btGuardar : some View {
        VStack(alignment: .center, spacing:0){
            if  self.modelview.errorString != "" {
                Text(self.modelview.errorString).foregroundColor(Color.red).padding(.bottom, 10)
            }
            Button(action: {
                self.modelview.showAlertSaveChanges = true
            }, label: {
                Text("Guardar Cambios")
            }).buttonStyle(ButtonGreenApp())
        }
    }
    
    var alertGuardarCambios: Alert {
        Alert(
            title: Text("Guardar Cambios"),
            message: Text("Desea guardar los cambios realizados?"),
            primaryButton:
            .default(Text("Guardar"), action: self.modelview.guardarCambios),
            secondaryButton: .destructive(Text("Cancelar")))
    }
    
    var alertDescartarCambios: Alert {
        Alert(
            title: Text("Descartar Cambios"),
            message: Text("Hay Cambios sin guardarse, deseas decartar estos cambios?"),
            primaryButton:
            .default(Text("Descartar"), action: {
                self.modelview.isEditing = false
                self.modelview.loadInfoUser()
            }),
            secondaryButton: .destructive(Text("Seguir Editando")))
    }
    
}

struct PerfilView_Previews: PreviewProvider {
    static var previews: some View {
        PerfilView()
    }
}
