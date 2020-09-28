//
//  MisDireccionesView.swift
//  enjoitIos
//
//  Created by developapp on 12/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import SwiftUI

struct MisDireccionesView: View {
    @EnvironmentObject var navigation: NavigationStack
    @ObservedObject var modelview = ControllerMisDirecciones()
    
    var intent:String // "Select" para seleccionar y volver
    
    init(){
        self.intent = "none"
    }
    
    init(intent:String){
        self.intent = intent
    }
    
    var body: some View {
        VStack(){
            ToolbarView()
            listDirecciones
            Spacer()
            Button(action: {
                self.navigation.advance(NavigationItem(view: AnyView(NuevaDireccionView())))
            }) {
                HStack(){
                    Spacer()
                    Text("Agregar Direccion").font(.headline).padding(15)
                    Spacer()
                }
            }.buttonStyle(ButtonAppNoPadding(BgColor: Color("verde_dark"), TextColor: Color.white))
        }.onAppear{
            self.modelview.getDirecciones_request()
        }
    }
    
    var listDirecciones : some View {
        VStack(alignment: .center, spacing:0){
            List{
                ForEach(self.modelview.direcciones) { direccion in
                    ItemDireccionesView(dir: direccion).onTapGesture {
                        if self.intent == "select"{
                            self.createANewOrderWithDireccion(direccion: direccion)
                        }
                    }
                }
            }
        }
    }
    
    func createANewOrderWithDireccion(direccion:Direccion){
        var carrito:Carrito = RepositoryDomicilio().getCarrito()
        carrito.servicioUsuario = ServicioUsuario(
            direccion: direccion.direccion ?? "",
            direccion2: direccion.direccion2,
            latitud: direccion.latitud ?? "",
            longitud: direccion.longitud ?? "")
        RepositoryDomicilio().updateCarrito(car: carrito)
        
        self.navigation.advance(NavigationItem(view: AnyView( ListRestaurantes(intent:"DOMICILIO"))))
    }
    
    
}

struct MisDireccionesView_Previews: PreviewProvider {
    static var previews: some View {
        MisDireccionesView()
    }
}
