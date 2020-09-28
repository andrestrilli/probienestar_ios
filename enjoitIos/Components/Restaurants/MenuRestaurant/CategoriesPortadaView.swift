//
//  CategoriesPortada.swift
//  enjoitIos
//
//  Created by developapp on 9/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import SwiftUI
import WaterfallGrid

struct CategoriesPortada: View {
    @EnvironmentObject var navigation: NavigationStack
    @ObservedObject var remoteImg = ImageFromUrl();
    var title = ""
    var cat:MenuCategory?
    
    init(){
        
    }
    
    init(subCat:MenuCategory){
        self.cat = subCat
        self.title = subCat.nombre ?? ""
        if  let perfil:String = subCat.images{
            let url = ApiConection.urlImage + "filesCat/" + perfil
            remoteImg = ImageFromUrl(imageURL: url)
        }
    }
    
    var body: some View {            
            ZStack(alignment: .bottom){
                Image(uiImage: self.remoteImg.dataimg)
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 150)
                .clipped()
                
                
                HStack(){
                    Text(self.title).font(.headline).padding(.horizontal, 10).foregroundColor(Color.white)
        
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 40)
                .background(Color("rojo_franjaitemres"))
                
            }
            
        
    }
}

struct CategoriesPortada_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesPortada()
    }
}
