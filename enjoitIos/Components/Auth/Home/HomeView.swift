//
//  HomeView.swift
//  enjoitIos
//
//  Created by developapp on 7/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
       @EnvironmentObject var navigation: NavigationStack
    
     //Strings
       let txtCover:String = Values.strings["msgPortada"] ?? "";
       let txtLogin:String = Values.strings["iniciarSesion"] ?? "";
       let txtSignup:String = Values.strings["registrate"] ?? "";

       var body: some View {
        VStack(spacing:0){
            ToolbarView(style:"noback_menuApp").padding(0)
            Divider().background(Color.white)
               toptitle
               centerCards
               Spacer()
           }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
       }
       
       var toptitle: some View{
           ZStack(){
              
               Image("cortina_background_red")
               .resizable()
               .scaledToFit()
               .frame(minWidth: 0, maxWidth: .infinity).padding(0)
               
               VStack(alignment: .center){
                   title_serigrafia
                   msg_portada
               }
           }.padding(0)
       }
       
       var title_serigrafia: some View{
           HStack(){
               Image("icon_title_white")
               Image("title_enjoit_white")
           }
       }
       
       var msg_portada:some View{        Text(txtCover).foregroundColor(Color.white).font(.title).multilineTextAlignment(.center)
       }
       
       var centerCards: some View{
           VStack(spacing:0){
               HStack(spacing:0){
                Image("ordenar_card").resizable().scaledToFit().frame(minWidth: 0, maxWidth: (.infinity/2))
                    .onTapGesture {
                    self.onOrdenarPressed()
                }
                   Image("reservar_card").resizable().scaledToFit().frame(minWidth: 0, maxWidth: (.infinity/2))
               }.frame(minWidth: 0, maxWidth: .infinity)
               HStack(spacing:0){
                   Image("parallevar_card").resizable().scaledToFit().frame(minWidth: 0, maxWidth: (.infinity/2))
                   Image("domicilio_card").resizable().scaledToFit().frame(minWidth: 0, maxWidth: (.infinity/2)).onTapGesture {
                       self.onDomicilioPressed()
                   }
               }.frame(minWidth: 0, maxWidth: .infinity)
           }
       }
    
    private func onAppear() {
        print("")
    }
    
    private func onOrdenarPressed(){
        self.navigation.advance(NavigationItem(view: AnyView(ListRestaurantes(intent:"ORDENAR"))))
    }
    
    private func onDomicilioPressed(){
        if let car:Carrito = RepositoryDomicilio().getCarrito() {
            if car.idPedido == nil {
                self.navigation.advance(NavigationItem(view: AnyView(MyLocationView())))
            }else{
                self.navigation.advance(NavigationItem(view: AnyView(PedidoDomicilioView())))
            }
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
