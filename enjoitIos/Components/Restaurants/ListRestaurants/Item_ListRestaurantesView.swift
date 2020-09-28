//
//  Item_ListRestaurantesView.swift
//  enjoitIos
//
//  Created by developapp on 8/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import SwiftUI
import Alamofire
import AlamofireImage

struct Item_ListRestaurantesView: View {
    @ObservedObject var remoteImg = ImageFromUrl();

    var OnItemPressed:()->Void =  {}
    
    var img = "cortina_background_red"
    var text:String = ""
    var state = "---"
    var dir = "---"

    var ProfileImage:UIImage = UIImage(imageLiteralResourceName: "cortina_background_red")

    init(){
        
    }
    
    init(itemRest:RestaurantElement){
        self.text = itemRest.userName ?? "none"
        self.state = itemRest.cerrado == 1 ? "Cerrado" : "Abierto";
        self.dir = "---"
        if  let fotoPerfil:String = itemRest.fotoPerfil{
            let url = ApiConection.urlImage + "fotoPerfil/" + fotoPerfil
            remoteImg = ImageFromUrl(imageURL: url)
        }
    }
    
    init(itemRest:RestaurantElement,onItemPressed:@escaping ()->Void){
        self.text = itemRest.userName ?? "none"
        self.state = itemRest.cerrado == 1 ? "Cerrado" : "Abierto";
        self.dir = "---"
        if  let fotoPerfil:String = itemRest.fotoPerfil{
            let url = ApiConection.urlImage + "fotoPerfil/" + fotoPerfil
            remoteImg = ImageFromUrl(imageURL: url)
        }
        self.OnItemPressed = onItemPressed
    }
    

    var body: some View {
        ZStack(alignment: .bottom){
            
            Image(uiImage: remoteImg.dataimg )
            .resizable()
            .scaledToFill()
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 160)
            .clipped()
            
            HStack(){
                Text(text).font(.headline).padding(.horizontal, 10).foregroundColor(Color.white)
                Spacer()
                Text(self.state).font(.headline).padding(.horizontal, 10).foregroundColor(Color.white)
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 35)
            .background(Color("rojo_franjaitemres"))
            
        }.onTapGesture {
            self.OnItemPressed()
        }
    }
    
}

struct Item_ListRestaurantesView_Previews: PreviewProvider {
    static var previews: some View {
        Item_ListRestaurantesView()
    }
}
