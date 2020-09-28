//
//  ItemDireccionesView.swift
//  enjoitIos
//
//  Created by developapp on 12/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import SwiftUI

struct ItemDireccionesView: View{
    
    @EnvironmentObject var navigation: NavigationStack
    
    var modelview = ControllerMisDirecciones()
    
    var name:String = "name Address"
    var direccion:Direccion
    @State var showingActionSheet:Bool = false

    init(dir:Direccion){
        self.direccion = dir
        self.name = dir.name ?? "nil"
    }
    
    var body: some View {
        HStack(){
            icono
            Spacer()
            text
            Spacer()
            optionButton
        }.actionSheet(isPresented: self.$showingActionSheet) {
            ActionSheet(title: Text("Seleccione una opcion"), message: Text("Que desea hacer con la direccion : " + self.name), buttons: [
                 .default(Text("Editar")){
                    //UnBoton
                 },
                 .default(Text("Eliminar")){
                    //UnBoton
                    self.modelview.removeDirecciones_request(idDireccion: self.direccion.id)
                 },
                 .default(Text("Ver Detalle")){
                    //UnBoton
                    self.navigation.advance(NavigationItem(view: AnyView(DireccionDetailsView(dir:self.direccion, intent: "preview"))))
                 },
                 .cancel({
                    self.showingActionSheet = false
                 })
            ])
        
        }
    }
    
    var icono : some View {
        VStack(alignment: .center, spacing:0){
            
            Image("ic_direccion")
                .resizable()
                .scaledToFit()
            .frame(width: 35, height: 35)
            .foregroundColor(Color("colorPrimary"))

        }
    }
    
    var text : some View {
        VStack(alignment: .center, spacing:0){
            Text(self.name).font(.headline).foregroundColor(Color("grisOscuro"))
        }
    }
    
    var optionButton : some View {
       VStack(alignment: .center, spacing:0){
           Image("ic_threePoints")
               .resizable()
               .scaledToFit()
            .frame(width: 35, height: 35).onTapGesture {
                self.showingActionSheet = true
            }

       }
    }
    
}

//struct ItemDireccionesView_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemDireccionesView()
//    }
//}
