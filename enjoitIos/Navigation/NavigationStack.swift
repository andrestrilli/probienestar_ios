//
//  NavigationStack.swift
//  enjoitIos
//
//  Created by developapp on 8/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import Foundation
import SwiftUI

final class NavigationStack: ObservableObject {
    
    @Published var viewStack: [NavigationItem] = []
    @Published var currentView: NavigationItem
    
    init(_ currentView: NavigationItem ){
        self.currentView = currentView
    }
    
    func unwind(){
        if viewStack.count == 0{
            return }
        let last = viewStack.count - 1
        currentView = viewStack[last]
        viewStack.remove(at: last)
    }
    
    //Recibe un navigation Item
    func advance(_ view:NavigationItem){
        viewStack.append( currentView)
        currentView = view

    }
    
    //Recibe una view EASIER
    func advance(_ anyview:AnyView){
        viewStack.append( currentView)
        let newview : NavigationItem = NavigationItem(view: anyview)
        currentView = newview
    }
    
    func advanceNewTask(_ view:NavigationItem){
        viewStack.removeAll()
        viewStack.append(currentView)
        currentView = view
    }
    
//    func advanceClearTop(_ view:NavigationItem){
////        viewStack.removeAll()
////        viewStack.append(currentView)
////        currentView = view
//
//        if let index = viewStack.firstIndex(of: view) {
//
//        }
//
//
//        print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX")
//        for item in viewStack{
//            print(item.view)
//        }
//
//    }
    
    func home(){
        currentView = NavigationItem(view: AnyView(LoginView()))
        viewStack.removeAll()
    }
}


struct NavigationItem{
    var view: AnyView
}

///view 1
struct NavigationHost: View{
    @EnvironmentObject var navigation: NavigationStack
    
    var body: some View {
        self.navigation.currentView.view
    }
}


//backbar

struct BackView: View{
    var title: String
    var action: ()->Void
    var homeAction: ()->Void
    var body: some View {
        ZStack{
            Rectangle().fill(Color.white).frame( height: 50 ).shadow(color: .black, radius: 1)
            HStack{ Button( action: action){
                Image("up-arrow").resizable().scaledToFit()
                    .frame(width: 27, height: 27)
                    .foregroundColor(Color("azulapp"))
                    .rotationEffect(.degrees(-90))
                    .padding(.leading, 16)
                }
                
                
                Spacer()
                Text(title).padding(.leading, 20)
                    .font(Font.system(size: 20))
                    .padding(.trailing, 20)
                Spacer()
                Button( action: homeAction){
                    Image("ic_setting_toolbar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                        .padding(.trailing, 20) }
                    .foregroundColor(Color("azulapp"))
            }
        }
    }
}

struct OnlyBackButton: View{
    var title: String
    var action: ()->Void
    var body: some View {
        ZStack{
            Rectangle().fill(Color.white).frame( height: 50 ).shadow(color: .black, radius: 1)
            
            HStack{ Button( action: action){
                Image("up-arrow").resizable().scaledToFit()
                    .frame(width: 27, height: 27)
                    .foregroundColor(Color.black)
                    .rotationEffect(.degrees(-90))
                    .padding(.leading, 16) }
                
                Spacer()
                Text(title).padding(.leading, 20)
                    .font(Font.system(size: 20))
                    .padding(.trailing, 20)
                Spacer()
            }
        }
    }
}

struct BackButtonNoBar: View{
    var bgColor:Color = Color("azulapp")
    var action: ()->Void
    var body: some View {
        ZStack{
            HStack{ Button( action: action){
                Image("up-arrow").resizable().scaledToFit()
                    .frame(width: 27, height: 27)
                    .foregroundColor(bgColor)
                    .rotationEffect(.degrees(-90))
                    .padding(.leading, 16) }
                Spacer()
            }
        }
    }
}
//
//struct ToolBar: View{
//
//    @State var ciudadSelected:CiudadElement = DataApp.ciudadSelected
//    @State var changeCiudad = false
//    @State var showCiudades: Bool = false
//
//    var ciudades:[CiudadElement] = DataApp.ciudades
//    @State var idSelec:Int = DataApp.ciudadSelectedPos
//
//    @EnvironmentObject var navigation: NavigationStack
//    @ObservedObject var remoteUrl : ImageFromUrl;
//
//    init(){
//        self.remoteUrl =  ImageFromUrl(imageURL: "users/"+(DataApp.loggedUser!.fotoPerfil ?? "") )
//    }
//
//    var body: some View {
//        ZStack{
//            Rectangle().fill(Color.white).frame( height: 50 )
//            HStack{
//                Button(action: {
//                    self.navigation.advance(NavigationItem( view: AnyView(EditarPerfil())))
//                }) {
//                  Image(uiImage: ((remoteUrl.dataimg.isEmpty) || UIImage(data: remoteUrl.dataimg) == nil)  ?
//                    UIImage(imageLiteralResourceName: "logoProbi") :
//                    UIImage(data: remoteUrl.dataimg)!).resizable()
//                    .scaledToFill()
//                    .frame(width: 45, height: 45)
//                    .background(Color("azulapp"))
//                    .clipShape(Circle())
//                    .overlay(
//                        Circle().stroke(Color("azulapp"), lineWidth: 1))
//                    .padding(.leading, 20)
//                }.buttonStyle(PlainButtonStyle())
//
//
//                Spacer()
//                Button(action: {
//                    self.changeCiudad.toggle()
//                }) {
//                    Text(self.ciudadSelected.nombreCiudad)
//                }
//                .sheet(isPresented: self.$changeCiudad) {
//                    //SelecCity()
//                    Picker(selection:  self.$idSelec, label:
//                    Text("Ciudad")) {
//                        ForEach(0 ..< self.ciudades.count) { index in
//                            Text(self.ciudades[index].nombreCiudad).tag(index)
//                        }
//                    }.onDisappear {
//                        print("here")
//                        DataApp.ciudadSelected = self.ciudades[self.idSelec]
//                        DataApp.ciudadSelectedPos = self.idSelec
//                        self.ciudadSelected = self.ciudades[self.idSelec]
//                        print(self.ciudades[self.idSelec].nombreCiudad)
//                    }
//                }
//                Spacer()
//
//                Button(action:
//                    {
//                        self.navigation.advance(
//                            NavigationItem( view: AnyView(Notificaciones())))            }
//                ) {
//                    Image("ic_bell_toolbar")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 30, height: 30)
//                        .padding(5)
//                        .foregroundColor(Color("azulapp"))
//                }.buttonStyle(PlainButtonStyle())
//                    .padding(5)
//
//                Button(action: {
//                    self.navigation.advance(
//                        NavigationItem( view: AnyView(Ajustes())))            }) {
//                            Image("ic_setting_toolbar")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 30, height: 30)
//                                .padding(5)
//                                .foregroundColor(Color("azulapp"))
//                }.buttonStyle(PlainButtonStyle())
//                    .padding(5)
//
//                //                            }.padding(.all, 0)
//            }
//        }
//    }
//}

struct TitleView: View{
    var title: String
    var homeAction: ()->Void
    var body: some View {
        ZStack{
            Rectangle().fill(Color.gray).frame( height: 40 )
            HStack{
                Spacer()
                Text(title).padding(.leading, 20)
                    .font(Font.system(size: 20.0))
                Spacer()
                Button( action: homeAction){
                    Image(uiImage: UIImage(systemName: "house", withConfiguration: UIImage.SymbolConfiguration(
                        pointSize: 15,   weight: .bold,
                        scale: .large))! )
                        .padding(.trailing, 20) }
                    .foregroundColor(Color.black)
            }
        }
    }
}

