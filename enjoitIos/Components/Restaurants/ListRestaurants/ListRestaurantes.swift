//
//  ListRestaurantes.swift
//  enjoitIos
//
//  Created by developapp on 8/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import SwiftUI

struct ListRestaurantes: View {
    
    @EnvironmentObject var navigation: NavigationStack
    @ObservedObject var modelview = ControllerLisRestaurantes()
    
    let intent:String
    
    init(intent:String){
        self.intent = intent
    }
    
    var body: some View {
        VStack(){
            ToolbarView().padding(0)
            List {
                ForEach(modelview.restaurantes){ restaurante in
                    Item_ListRestaurantesView(itemRest: restaurante) {
                        self.onItemSelected(restaurante: restaurante)
                    }.listRowInsets(EdgeInsets())
                }
            }
        }.onAppear{
            self.onAppear();
        }
    
    }
    
    private func onAppear(){
        
    }
    
    private func onItemSelected(restaurante:RestaurantElement)->Void{
        self.navigation.advance(NavigationItem(view: AnyView(MenuRestaurantView(rest: restaurante, intent:self.intent))))
    }
}

struct ListRestaurantes_Previews: PreviewProvider {
    static var previews: some View {
        ListRestaurantes(intent:"DOMICILIO")
    }
}
