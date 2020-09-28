//
//  CategoriaView.swift
//  enjoitIos
//
//  Created by developapp on 9/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import SwiftUI

struct SubCategoriaView: View {
    @EnvironmentObject var navigation: NavigationStack
    
    let tipo:String //me ayuda a saber si debo abrir la vista plato detalle o si debo agregar el item al carrito directamente (Bebidas)
    let subCategoria:MenuCategory
    var productos:[Producto] = []
    
    @State var open:Bool
        
    init(subCat:MenuCategory,tipo:String){
        self.subCategoria = subCat
        self.productos = subCategoria.productos ?? []
        self.tipo = tipo
        if tipo == "plato" {
            _open = State(initialValue: true)
        }else{
            _open = State(initialValue: false)
        }
    }
    
    var body: some View {
        VStack(){
            barTitle.onTapGesture {
                if self.tipo != "plato" {
                    self.open.toggle()
                }
            }
            if open {
                listItems
            }
        } 
    }
    
    var barTitle: some View {
        VStack(spacing:0){
            
            HStack(){
                
                Text(self.subCategoria.nombre ?? "")
                    .font(.headline)
                    .foregroundColor(Color("grisOscuro"))
                    .padding(.horizontal,7)
                
                Spacer()
                
                Image("below-arrow")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding(.trailing, 5)
                
            }.padding(.vertical,5)

            Divider().frame(height: 2)
            .background(Color("colorPrimary"))
            .padding(0)
        }.padding(10)
        
    }
    
    var listItems: some View {
        VStack(){
            //List{
                ForEach(self.productos){ producto in
                    ItemProductoView(producto: producto,type: self.tipo).onTapGesture {
                       // self.onItemPressed(product: producto)
                    }
                }
            //}
        }.onAppear{
            self.onAppear();
        }
    }
    
    func onItemPressed(product:Producto){
        if  self.tipo == "plato" {
            self.navigation.advance(NavigationItem(view: AnyView(PlatoDetalleView(product: product))))
        }else{
            ControllerDomicilio.AgregarItemParaDomicilio(navigation: self.navigation, product: product,ingreSelecteds: [],comment: "")
        }
    }
    
    private func onAppear() {
        print("aparece subcategoria")
    }
}

//struct SubCategoriaView_Previews: PreviewProvider {
//    static var previews: some View {
//       // SubCategoriaView()
//    }
//}
