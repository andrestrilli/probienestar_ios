//
//  ItemProductoView.swift
//  enjoitIos
//
//  Created by developapp on 9/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import SwiftUI

struct ItemProductoView: View {
    @EnvironmentObject var navigation: NavigationStack
    @ObservedObject var remoteImg = ImageFromUrl();
    
    var producto:Producto?
    var productname:String = "Manzana Postobon"
    var descrip:String = "Gaseosa Sabor a manzana"
    var numStar:Double = 5.0
    var precio:String = "2500"
    var type:String = ""
    
    init(){
        
    }
    
    init(producto:Producto,type:String){
        self.producto = producto
        self.productname = producto.nombre ?? ""
        self.descrip = producto.descripcion ?? ""
        self.numStar = 5.0
        self.precio = producto.valor ?? "0"
        self.type = type
        if  let perfil:String = producto.imagen{
            let url = ApiConection.urlImage + "filesProduct/" + perfil
            remoteImg = ImageFromUrl(imageURL: url)
        }
    }

    var body: some View {
        HStack(){

            Image(uiImage: remoteImg.dataimg )
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: 100, minHeight: 0, maxHeight: 100)
                .cornerRadius(20)
                .clipped()
                .padding()
            
            VStack(alignment: .leading){
                
                Text(self.productname).font(.headline).lineLimit(1)
                Text(self.descrip).font(.subheadline).lineLimit(1)
                Spacer()
                RatingBar(numStar: 3)
                Spacer()
                
                HStack(){
                    Spacer()
                    Text("$"+self.precio).font(.headline).foregroundColor(Color("verde_bt_inicio")).padding(.horizontal, 20).padding(.vertical, 5)
                    Spacer()
                    Button(action: {
                        
                        if  self.type == "plato" {
                            self.navigation.advance(NavigationItem(view: AnyView(PlatoDetalleView(product: self.producto!))))
                        }else{
                            ControllerDomicilio.AgregarItemParaDomicilio(navigation: self.navigation, product: self.producto!,ingreSelecteds: [],comment: "")
                        }

                    }) {
                        HStack(){
                            Text("Pedir").font(.headline).padding(.horizontal, 20).padding(.vertical, 5)
                        }
                    }.buttonStyle(ButtonAppNoPadding(BgColor:Color("colorPrimary"), TextColor: Color.white))
                }
                
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 80).padding()
            
            }.frame(minWidth: 0, maxWidth: .infinity)
        
    }
    
    
}

struct ItemProductoView_Previews: PreviewProvider {
    static var previews: some View {
        ItemProductoView()
    }
}
