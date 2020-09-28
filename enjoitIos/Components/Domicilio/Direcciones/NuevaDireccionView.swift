//
//  NuevaDireccionView.swift
//  enjoitIos
//
//  Created by developapp on 12/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import SwiftUI
import UIKit

struct NuevaDireccionView: View {
    
    @ObservedObject var modelview = ControllerMisDirecciones()
    @EnvironmentObject var navigation: NavigationStack

    @State var dirObject:Direccion?
    
    //Formulario
    @State var direccion:String = ""
    @State var pais:String = ""
    @State var departamento:String = ""
    @State var ciudad:String = ""
    @State var detalle:String = ""
    @State var alias:String = ""
    
    @State var formError:Bool = false
    @State var geoCodeError:Bool = false


    var body: some View {
        VStack(spacing:0){
            ToolbarView()
            encabezado
                ScrollView{
                    VStack(spacing:0){
                        formulario
                        button
                        Spacer()
                        }.padding(0)
                }.padding(0)
        }.alert(isPresented: self.$formError) {
            Alert.init(title: Text("Fomulario Incompleto"), message: Text("Por favor complete el formulario"), dismissButton: .default(Text("Ok"), action: {
                self.formError = false
                }))
        }
        .alert(isPresented: self.$geoCodeError) {
            Alert.init(title: Text("Error"), message: Text("No se encuentra la direccion"), dismissButton: .default(Text("Ok"), action: {
                self.geoCodeError = false
                }))
        }
    }
    
    var encabezado : some View {
     HStack(alignment: .center, spacing:0){
               Spacer()
               Text("Agregar Nueva Direccion").font(.title).foregroundColor(Color.white).padding(10)
               Spacer()
           }.background(Color("colorPrimary"))
    
    }
    
    var formulario : some View {
        VStack(alignment: .center, spacing:15){
            
            VStack(alignment: .leading){
                Text("Escribe tu direccion: ").font(.footnote)
                TextField("Calle 74 # 85 - 46 ", text: $direccion).textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            VStack(alignment: .leading){
                Text("Pais").font(.footnote)
                TextField("Pais", text: $pais).textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            VStack(alignment: .leading){
                Text("Departamento").font(.footnote)
                TextField("Departamento", text: $departamento).textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            VStack(alignment: .leading){
                Text("Ciudad").font(.footnote)
                TextField("Ciudad", text: $ciudad).textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            VStack(alignment: .leading){
                Text("Detalle de entrega").font(.footnote)
                TextField("Ej: nombre de conjunto, Oficina", text: $detalle).textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            VStack(alignment: .leading){
                Text("Alias").font(.footnote)
                TextField("Ej: Direccion Casa", text: $alias).textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
        }.padding(20)
    }
    
    var button : some View {
        HStack(alignment: .center, spacing:0){
            Spacer()
            Button(action: {
                if self.validaFormulario() {
                     self.dirObject = Direccion(name: self.alias, extra: self.detalle, idPais: 126, idCiudad: 0, idDepto: 1, dir1: self.direccion)
                    self.dirObject!.id_user = DataApp.user!.idUsuario
                    
                    self.modelview.geoCodeAddress(address: self.direccion)
                
                }
            }) {
                HStack(){
                    Text("Listo").font(.headline).padding(10).padding(.horizontal, 100)
                }
            }.buttonStyle(ButtonAppNoPadding(BgColor: Color("verde_dark"), TextColor: Color.white))
            
        }.onReceive(self.modelview.$geoCodedDirection) { geoDir in
            self.geoCodeError = false
            if var direc = self.dirObject, let geo = geoDir{
                direc.latitud = String(geo.coordinate.latitude)
                direc.longitud = String(geo.coordinate.longitude)
                print(direc)
                self.navigation.advance(NavigationItem(view: AnyView(DireccionDetailsView(dir:direc,intent:"create"))))

            }else{
                if self.dirObject != nil && geoDir == nil{
                    self.geoCodeError = true
                }
            }
        }

    }
    
    //Spinners
    
    
    func validaFormulario()->Bool{
        self.formError = false
        if self.direccion != nil  && self.direccion != "" {
           return true
        }else{
            self.formError = true
            return false
        }
    }
    
    
    
    
    
}
