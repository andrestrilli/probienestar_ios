//
//  ToolbarView.swift
//  enjoitIos
//
//  Created by developapp on 7/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import SwiftUI

struct ToolbarView: View {
    @EnvironmentObject var navigation: NavigationStack
    
    @State var showingActionSheet:Bool = false
    @State var showingNoCarDomiclio:Bool = false

    
    var style:String = "main"
    var action:()->Void = {}
//    var homeAction: ()->Void
    
    init(){
        
    }
    
    init(style:String){
        self.style = style
    }
    
    init(style:String,action:@escaping ()->Void ){
        self.style = style
        self.action = action
    }
    
    var body: some View {
        main
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
        .background(Color("colorPrimary"))
        .sheet(isPresented: self.$showingActionSheet, content: {
            self.menuApp
        })
        .alert(isPresented:self.$showingNoCarDomiclio, content: {
                self.AlertPedidoVacio
        })
    
        
    }
    
    var main : some View {
        HStack(){

            if !style.contains("noback"){
            Button(action:{ self.unwind()}){
                Image("up-arrow").resizable().scaledToFit()
                    .frame(width: 22, height: 22)
                    .foregroundColor(Color.white)
                    .rotationEffect(.degrees(-90))
                    .padding(.leading, 12)
                }
            }
            
            if style.contains("menuApp"){
                Button(action:{ self.showingActionSheet = true }){
                Image("ic_menuapp").resizable().scaledToFit()
                    .frame(width: 22, height: 22)
                    .foregroundColor(Color.white)
                    .padding(.leading, 12)
                }
            }
            
            Spacer()
            
            HStack(){
                Image("icon_title_white")
                    .resizable()
                    .scaledToFit()
                    
                Image("title_enjoit_white")
                    .resizable()
                    .scaledToFit()
            }.padding(10)
            .frame(height: 50)
                .onTapGesture {
                    self.goToHome()
                }
            
            Spacer()
            
            
            Button( action: {
                if !self.style.contains("reload"){
                    self.gotopedido()
                }else{
                    self.action()
                }
            }
            ){
            Image("ic_shoppingcart").resizable().scaledToFit()
                .frame(width: 22, height: 22)
                .foregroundColor(Color.white)
                .padding(.trailing, 12)
            }
            
            
            
        }
    }
    
 
    var noback : some View {
        HStack(){
            
            Button(action:{ self.unwind()}){
                Image("up-arrow").resizable().scaledToFit()
                .frame(width: 22, height: 22)
                .foregroundColor(Color.white)
                .rotationEffect(.degrees(-90))
                .padding(.leading, 12)
            }
            
            Spacer()
            
            HStack(){
                Image("icon_title_white")
                    .resizable()
                    .scaledToFit()
                    
                Image("title_enjoit_white")
                    .resizable()
                    .scaledToFit()
            }.padding(10)
            .frame(height: 50)
                .onTapGesture {
                    self.goToHome()
                }
            
            Spacer()
            
            Image("icon_title_white").frame(height: 50)
            
        }
    }
    
    var menuApp : some View {
        VStack(){
            HStack(alignment: VerticalAlignment.center){
                Image("perfil_image").resizable().frame(width: 100, height: 100).padding(10)
                Spacer()
                Text(DataApp.user!.nombre + " " + DataApp.user!.apellido).font(.title).foregroundColor(Color.white)
                Spacer()
                Text("X").font(.title).foregroundColor(Color.white).padding().onTapGesture {
                    self.showingActionSheet = false
                }
            }.background(Color("colorPrimary")).onTapGesture {
                self.navigation.advance(NavigationItem(view: AnyView(PerfilView())))
            }

            VStack(){
                Button(action: {
                    self.navigation.advance(NavigationItem(view: AnyView(HomeView())))
                }) {
                    HStack(){
                        Text("Ir al Inicio").font(.headline).padding(0)
                        Spacer()
                    }.padding()
                }.buttonStyle(ButtonAppNoPadding(BgColor: Color.white, TextColor: Color("grisOscuro")))
                
                Button(action: {
                    //self.navigation.advance(NavigationItem(view: AnyView(HomeView())))
                }) {
                    HStack(){
                        Text("Mis Reservas").font(.headline).padding(0)
                        Spacer()
                    }.padding()
                }.buttonStyle(ButtonAppNoPadding(BgColor: Color.white, TextColor: Color("grisOscuro")))
                
                Button(action: {
                    //self.navigation.advance(NavigationItem(view: AnyView(HomeView())))
                }) {
                    HStack(){
                        Text("Redimir Cupon").font(.headline).padding(0)
                        Spacer()
                    }.padding()
                }.buttonStyle(ButtonAppNoPadding(BgColor: Color.white, TextColor: Color("grisOscuro")))
                
                Button(action: {
                    //self.navigation.advance(NavigationItem(view: AnyView(HomeView())))
                }) {
                    HStack(){
                        Text("Facturas Generadas").font(.headline).padding(0)
                        Spacer()
                    }.padding()
                }.buttonStyle(ButtonAppNoPadding(BgColor: Color.white, TextColor: Color("grisOscuro")))
                
                Button(action: {
                    self.navigation.advance(NavigationItem(view: AnyView(MisDireccionesView())))
                }) {
                    HStack(){
                        Text("Mis Direcciones").font(.headline).padding(0)
                        Spacer()
                    }.padding()
                }.buttonStyle(ButtonAppNoPadding(BgColor: Color.white, TextColor: Color("grisOscuro")))
            }
            Button(action: {
                //self.navigation.advance(NavigationItem(view: AnyView(MisDireccionesView())))
            }) {
                HStack(){
                    Text("Favoritos").font(.headline).padding(0)
                    Spacer()
                }.padding()
            }.buttonStyle(ButtonAppNoPadding(BgColor: Color.white, TextColor: Color("grisOscuro")))
            
            Button(action: {
                //self.navigation.advance(NavigationItem(view: AnyView(MisDireccionesView())))
            }) {
                HStack(){
                    Text("Enjoit Points").font(.headline).padding(0)
                    Spacer()
                }.padding()
            }.buttonStyle(ButtonAppNoPadding(BgColor: Color.white, TextColor: Color("grisOscuro")))
            
            Button(action: {
                //self.navigation.advance(NavigationItem(view: AnyView(MisDireccionesView())))
            }) {
                HStack(){
                    Text("Escribir a Soporte").font(.headline).padding(0)
                    Spacer()
                }.padding()
            }.buttonStyle(ButtonAppNoPadding(BgColor: Color.white, TextColor: Color("grisOscuro")))
            
            Button(action: {
                self.cerrarSesion()
            }) {
                HStack(){
                    Text("Cerrar Sesion").font(.headline).padding(0)
                    Spacer()
                }.padding()
            }.buttonStyle(ButtonAppNoPadding(BgColor: Color.white, TextColor: Color("grisOscuro")))
            Spacer()
        }.background(Color("colorPrimary"))
    }
    
    var AlertPedidoVacio: Alert{
        
        Alert(title: Text("No Hay Pedidos"), message: Text("Actualmente no cuentas con un pedido en proceso"), dismissButton: .default(Text("cerrar")))
     
    }
    
    
    func unwind(){
        self.navigation.unwind()
    }
    
    func goToHome(){
        self.showingActionSheet = true
       // self.navigation.home()
    }
    
    func gotopedido(){
        let repository:RepositoryDomicilio = RepositoryDomicilio()
        if repository.getCarrito().pedidosDetalle != nil,
            (repository.getCarrito().pedidosDetalle ?? []).count > 0{
            self.navigation.advance(NavigationItem(view: AnyView(PedidoDomicilioView())))
        }else{
            self.showingNoCarDomiclio = true
        }
        
    }
    
    func cerrarSesion() {
         self.navigation.advanceNewTask(NavigationItem(view: AnyView(LoginView())))
         KeyChain.saveCredentials(psw: "", user: "")
         DataApp.user = nil
         FirebaseController.ref!.removeAllObservers()
    }
}

struct ToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarView()
    }
}


