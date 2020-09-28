//
//  CoverView.swift
//  enjoitIos
//
//  Created by developapp on 7/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import SwiftUI

struct CoverView: View {
    
    //Strings
    let txtCover:String = Values.strings["msgPortada"] ?? "";
    let txtLogin:String = Values.strings["iniciarSesion"] ?? "";
    let txtSignup:String = Values.strings["registrate"] ?? "";

    var body: some View {
        VStack(){
            toptitle
            centerCards
            btOptions
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
                Image("reservar_card").resizable().scaledToFit().frame(minWidth: 0, maxWidth: (.infinity/2))
            }.frame(minWidth: 0, maxWidth: .infinity).border(Color.black)
            HStack(spacing:0){
                Image("parallevar_card").resizable().scaledToFit().frame(minWidth: 0, maxWidth: (.infinity/2))
                Image("domicilio_card").resizable().scaledToFit().frame(minWidth: 0, maxWidth: (.infinity/2))
            }.frame(minWidth: 0, maxWidth: .infinity)
        }
    }
    
    var btOptions: some View{
        VStack(spacing: 10){
            Button(action: {
                //Action here
            }, label: {
                Text(txtLogin).foregroundColor(Color("colorPrimary")).font(.title)
                }).buttonStyle(PlainButtonStyle())
            
            Button(action: {
                //Action here
            }, label: {
                Text(txtSignup).foregroundColor(Color("colorPrimary")).font(.title)
            }).buttonStyle(PlainButtonStyle())
        }
    }
    
}

struct CoverView_Previews: PreviewProvider {
    static var previews: some View {
        CoverView()
    }
}
