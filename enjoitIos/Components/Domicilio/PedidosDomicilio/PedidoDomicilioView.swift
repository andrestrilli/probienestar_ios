//
//  PedidoDomicilioView.swift
//  enjoitIos
//
//  Created by developapp on 11/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import SwiftUI
import FirebaseDatabase

struct PedidoDomicilioView: View {
    
    @EnvironmentObject var navigation: NavigationStack
    
    @ObservedObject var modelView:ControllerDomicilio = ControllerDomicilio()
    @ObservedObject var repository:RepositoryDomicilio = RepositoryDomicilio()
    
    @State var openChat = false;
    
    @State var total:String = ""
    
    init(){
    
    }
    
    var body: some View {
        VStack(){
            ToolbarView(style: "reload", action: {
               _ = self.repository.getCarrito()
            })
            ScrollView{
                VStack(){
                    encabezado
                    if self.repository.carrito != nil {
                        listOfItems
                        if self.repository.carrito!.idPedido != nil{
                            infoPedido
                        }
                        
                        Spacer()
                        actionButtons
                    }
                }
            }
        }.onAppear {
            let carrito:Carrito = self.repository.getCarrito()
            self.modelView.updateInfoRest(carrito: carrito)
            self.listener_notificacionesCambioComando()
        }.onReceive(self.repository.$carrito) { carrito in
            if var car = carrito {
                self.total = String(car.getPrecio())
            }
        }
        .sheet(isPresented: self.$openChat, content: {
            self.chatPostView
        })
        
    }

    //encabezado
    var encabezado : some View {
        VStack(alignment: .center, spacing:0){
            Text("TOTAL: " + self.total ).font(.title).foregroundColor(Color("verde_bt_inicio"))
            Divider()
                .frame(height: 4)
                .background(Color("colorPrimary"))
        }
    }
    
    //ListOfItems
    var listOfItems : some View {
        VStack(alignment: .center, spacing:0){
            ForEach(self.repository.carrito!.pedidosDetalle ?? []){ pedidoDetalle in
                ItemListPedidoView(detalle: pedidoDetalle, intent:"DOMICILIO",repository: self.repository).onAppear {
                    print(pedidoDetalle.idEstado ?? 0)
                }
            }
        }
    }
    
    //ActionsButtons
    var actionButtons : some View {
        VStack(alignment: .center, spacing:20){
            if self.repository.carrito!.idPedido == nil {
                Button(action: {
                    if let restaurante = self.repository.getCarrito().restauranteObject {
                        self.navigation.advance(NavigationItem(view: AnyView(MenuRestaurantView(rest: restaurante, intent:"DOMICILIO"))))
                    }
                }) {
                    HStack(){
                        Spacer()
                        Text("Seguir Pidiendo").font(.headline)
                        Spacer()
                    }
                }.buttonStyle(ButtonGreenApp())
                
                Button(action: {
                    self.navigation.advance(NavigationItem(view: AnyView(PropinaView(intent: "DOMICILIO"))))
                    //self.modelView.hacerDomicilio_request(carrito: self.repository.carrito!)
                }) {
                    HStack(){
                        Spacer()
                        Text("Ordenar").font(.headline)
                        Spacer()
                    }
                }.buttonStyle(ButtonGreenApp())
                
            }else{
                
                Button(action: {
                    self.openChat = true
                }) {
                    HStack(){
                        Spacer()
                        Text("Chat").font(.headline)
                        Spacer()
                    }
                }.buttonStyle(ButtonGreenApp(BgColor: Color("colorPrimary"), TextColor: Color.white))
                
                Button(action: {
                    
                   // self.navigation.advance(NavigationItem(view: AnyView(PropinaView(intent: "DOMICILIO"))))
                    //self.modelView.hacerDomicilio_request(carrito: self.repository.carrito!)
                }) {
                    HStack(){
                        Spacer()
                        Text("Pagar").font(.headline)
                        Spacer()
                    }
                }.buttonStyle(ButtonGreenApp())
                
            }
            
            
        }.padding(.horizontal, 20)
    }
    
    //InfoPedido
    var infoPedido : some View {
        VStack(alignment: .center, spacing:0){
            HStack(){
                Text("Datos de Entrega: ").font(.headline)
                Spacer()
            }.padding(.bottom ,20)
            Text(self.repository.carrito!.servicioUsuario!.direccion ?? "No Direction").font(.subheadline)
        }.padding(20)
    }
    
    
    var chatPostView : some View {
        VStack(alignment: .center, spacing:0){
            Webview(url: ApiConection.baseUrl+"api/webview/chat?"+"idRestaurant="+String(self.repository.carrito!.idRestaurante!)+"&"+"idOrder="+String(self.repository.carrito!.idPedido!))
        }
    }
    
    
    func listener_notificacionesCambioComando()->Void{
        
        let ref:DatabaseReference = Database.database().reference(withPath: "APP/"+"\(DataApp.user!.idUsuario)")
        var _ = ref.observe( DataEventType.childAdded, with: { (snapshot) in
            
            let node = snapshot.value as AnyObject
            let isvisto:Bool = ((node["is_viewed"] as? Bool) ?? true);
            
            if  isvisto == false {
                let type:Int = node["type_notificacion"] as? Int ?? 0
                let idOrder:String = node["id_order"] as? String ?? "0"
                
                if idOrder == String(self.repository.carrito!.idPedido ?? 0) {
                    switch type {
                        case 13: // comanda
                            _ = self.repository.getCarrito()
                            break
                        
                        case 20: //Pagado por POS
                            _ = self.repository.getCarrito()
                            break
                        
                        case 21,22://Pedido Anulado
                            _ = self.repository.getCarrito()
                            self.navigation.advanceNewTask(NavigationItem(view: AnyView(HomeView())))
                            break
                        
                        default:
                            print("aa")
                    }
                    
                }
                
            }
            
        })
        
    }
    
}

struct PedidoDomicilioView_Previews: PreviewProvider {
    static var previews: some View {
        PedidoDomicilioView()
    }
}
