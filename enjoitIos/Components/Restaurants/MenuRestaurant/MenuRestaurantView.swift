//
//  MenuRestaurantView.swift
//  enjoitIos
//
//  Created by developapp on 8/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import SwiftUI
import WaterfallGrid

struct MenuRestaurantView: View {
    
    @EnvironmentObject var navigation: NavigationStack
    
    //Data
    @ObservedObject var modelView:ControllerMenuRestaurante;
    @ObservedObject var remoteImg = ImageFromUrl();
    var txtName:String = ""
    var txtDireccion:String = ""
    
    let intent:String

    
    //ViewCustoms
    @State var page:Bool = true // True == Bebidas;  False Platos//
    @State var catPlatoSelected:MenuCategory?// False == Hide;  True Show//
    
    init(rest:RestaurantElement, intent:String){
        
        self.txtName = rest.userName ?? ""
        self.txtDireccion = rest.direccion ?? "cra none"
        self.modelView = ControllerMenuRestaurante(info:rest)
        
        if  let fotoPerfil:String = rest.fotoPerfil{
            let url = ApiConection.urlImage + "fotoPerfil/" + fotoPerfil
            remoteImg = ImageFromUrl(imageURL: url)
        }
        
        self.intent = intent

    }
    
    var body: some View {
            VStack(){
            encabezado
            tabsTitles
            if self.modelView.menu != nil {
                if self.page {
                    tabBebidas
                }else{
                    if self.catPlatoSelected == nil {
                        tabPlatos
                    }else{
                        platoCategorySelected
                    }
                }
            }
            Spacer()
            }
            
        
    }
    
    var encabezado: some View{
        VStack(){
            ZStack(alignment: .bottom){
                ZStack(alignment: .top){

                Image(uiImage: remoteImg.dataimg )
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 150)
                .padding(.top,50)
                .clipped()
                    
                ToolbarView()
                }

                HStack(){
                    Text(txtName).font(.body).padding(.horizontal, 10).foregroundColor(Color.white)
                    Spacer()
                    Text(txtDireccion).font(.body).padding(.horizontal, 10).foregroundColor(Color.white)
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 35)
                .background(Color("grisOscuro"))

            }
        }
    }
    
    var tabsTitles: some View{
        HStack(){
            Button(action: {
                self.page = true
            }) {
                VStack{
                    
                    Spacer()
                    Text("BEBIDAS").font(.footnote).fontWeight(.bold)
                    Spacer()
                    
                    VStack{EmptyView()}
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 5,  maxHeight: 5)
                    .background(self.page ? Color("colorPrimary") : Color("grisOscuro"))
                    
                }.foregroundColor(Color.black).frame(minWidth: 0, maxWidth: .infinity, minHeight: 45,  maxHeight: 45).background(Color.clear)
                }
            
            Button(action: {
                self.page = false
                self.catPlatoSelected = nil
            }) {
                VStack{
                    
                    Spacer()
                    Text("PLATOS").font(.footnote).fontWeight(.bold)
                    Spacer()
                    
                    VStack{EmptyView()}
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 5,  maxHeight: 5)
                        .background(self.page ? Color("grisOscuro") : Color("colorPrimary"))
                    
                }.foregroundColor(Color.black).frame(minWidth: 0, maxWidth: .infinity, minHeight: 45,  maxHeight: 45).background(Color.clear)
                }
        }
    }
    
    var tabBebidas: some View{
        //ScrollView{
          VStack(){
                List{
                    ForEach(self.modelView.menu!.bebidas.subCategorias!){ menuCategory in
                        SubCategoriaView(subCat:menuCategory,tipo:"bebida")
                    }.listRowInsets(EdgeInsets())
                }
            }
        //}
    }
    
    var tabPlatos: some View{
        WaterfallGrid(self.modelView.menu!.menu.subCategorias!){ cat in
            CategoriesPortada(subCat:cat).onTapGesture {
                self.catPlatoSelected = cat
            }
        }
        .gridStyle(columns: 2)
    }
    
    var platoCategorySelected: some View{
        ScrollView{
            SubCategoriaView(subCat: self.catPlatoSelected!,tipo:"plato")
        }
    }
    
}

struct MenuRestaurantView_Previews: PreviewProvider {
    static var previews: some View {
       // MenuRestaurantView()
        EmptyView()
    }
}
