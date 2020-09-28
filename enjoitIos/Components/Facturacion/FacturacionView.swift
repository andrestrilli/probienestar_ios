//
//  FacturacionView.swift
//  enjoitIos
//
//  Created by developapp on 17/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import SwiftUI
import FirebaseDatabase

struct FacturacionView: View {
    @EnvironmentObject var navigation: NavigationStack
    @ObservedObject var modelview:ControllerFacturacion
    @ObservedObject var controllerDomicilio:ControllerDomicilio

    
    init(carrito:Carrito){
        self.modelview = ControllerFacturacion(carrito: carrito)
        self.controllerDomicilio = ControllerDomicilio()
    }
    
    var body: some View {
        VStack(){
             ToolbarView()
             ScrollView{
                VStack(){
                    encabezado
                    otherInfo
                    detallesInfo
                    totalesInfo
                    btActions
                    Spacer()
                }.padding()
                    .alert(isPresented: self.$controllerDomicilio.pedidoRealizado) {
                        self.alertOrdeDone
                }
            }
        }
    }
        
    var encabezado : some View {
        VStack(alignment: .center, spacing:0){
            Text(self.modelview.encabezado)
                .multilineTextAlignment(.center)
                .font(.body)
        }.padding()
    }
    
    var otherInfo : some View {
        HStack(alignment: .center, spacing:0){
            Spacer()
            Text(self.modelview.otherInfo)
            .multilineTextAlignment(.center)
            .font(.headline)
        }.padding(.vertical)
    }
    
    var detallesInfo : some View {
        VStack(alignment: .center, spacing:0){
            
            HStack(){
                Text("Descripción").frame(minWidth: 0, maxWidth: .infinity,alignment: .leading)
                Spacer()
                Text("Cant").frame(minWidth: 0, maxWidth: .infinity,alignment: .center)
                Spacer()
                Text("Valor").frame(minWidth: 0, maxWidth: .infinity,alignment: .trailing)
            }
            
            ForEach(self.modelview.details) { detail in
                ItemFacturaView(pedido: detail).padding(.vertical,2)
            }
        }
    }
    
    var totalesInfo : some View {
        VStack(alignment: .center, spacing:0){
            HStack{
                Text("Subtotal")
                Spacer()
                Text(self.modelview.subTotal)
            }
            
            HStack{
                Text("Valor de Descuento")
                Spacer()
                Text(self.modelview.descuento)
                       }
            
            HStack{
                Text("Valor Domicilio")
                Spacer()
                Text(self.modelview.domicilio)
                       }
            
            HStack{
                Text("Imp. Consumo 8%")
                Spacer()
                Text(self.modelview.impConsumo)
                       }
            
            HStack{
                Text("Propina")
                Spacer()
                Text(self.modelview.propina)
                       }
            
            HStack{
                Text("Venta Total").font(.headline)
                Spacer()
                Text(self.modelview.ventaTotal).font(.headline)
                       }
            
        }.padding(.vertical)
    }
    
    var btActions : some View {
        VStack(alignment: .center, spacing:0){
            HStack(spacing:30){
                Button(action: {
                    //self.modelview.onPagoRestPressed()
                    
                    if self.controllerDomicilio.realizandoPedido == false{
                        self.controllerDomicilio.hacerDomicilio_request(navigation: self.navigation, carrito: self.modelview.carrito)
                    }else{
                        print("Se esta realizando un pedido")
                    }
                    
                }) {
                    HStack(){
                        Spacer()
                        Text("Pago a Domiciliario").lineLimit(2).font(.headline).multilineTextAlignment(.center)
                        Spacer()
                    }.frame(height: 45)
                }.buttonStyle(ButtonGreenApp(BgColor: Color("colorPrimary"), TextColor: Color.white))
                
                Button(action: {
                    // self.OnloginButtonPress()
                }) {
                    HStack(){
                        Spacer()
                        Text("Pago por Enjoit").font(.headline).multilineTextAlignment(.center)
                        Spacer()
                    }.frame(height: 45)
                }.buttonStyle(ButtonGreenApp(BgColor: Color("verde_bt_inicio"), TextColor: Color.white))
                
            }
        }.padding(.top)
    }
    
    //Alertas
    var alertOrdeDone: Alert {
        Alert(title: Text("Pedido Realizado"), message: Text("Su pedido fue realizado con exito, gracias por utilizar nuestros servicios"), dismissButton: .default(Text("Ok"), action: {
                self.navigation.advance(NavigationItem(view: AnyView(HomeView())))
                self.navigation.advance(NavigationItem(view: AnyView(PedidoDomicilioView())))

        }))
    }
    
    func listener_notificacionesCambioComando()->Void{
        let ref:DatabaseReference = Database.database().reference(withPath: "APP/"+"\(DataApp.user!.idUsuario)")
        var _ = ref.observe( DataEventType.childAdded, with: { (snapshot) in
            
            let node = snapshot.value as AnyObject
            let isvisto:Bool = ((node["is_viewed"] as? Bool) ?? true);
            
            if  isvisto == false {
                let type:Int = node["type_notificacion"] as? Int ?? 0
                let idOrder:String = node["id_order"] as? String ?? "0"
                
                if idOrder == String(self.modelview.carrito.idPedido ?? 0) {
                    switch type {
                        case 21,22://Pedido Anulado
                            self.navigation.advanceNewTask(NavigationItem(view: AnyView(HomeView())))
                            break
                        
                        default:
                            print("Uknown Code RealTime Propina")
                    }
                    
                }
                
            }
            
        })
        
    }

}
struct ItemFacturaView: View {
    
    var pedido:PedidosDetalle
    
    init(pedido:PedidosDetalle){
        self.pedido = pedido
    }

    var body: some View {
        HStack(){
            
            HStack(){
                Text(self.pedido.nombreProducto ?? "none")
            }.frame(minWidth: 0, maxWidth: .infinity,alignment: .leading)//.border(Color.green)
            Spacer()
            HStack(){
            Text(self.pedido.cantidad ?? "none")
            }.frame(minWidth: 0, maxWidth: .infinity,alignment: .center)//.border(Color.green)
            Spacer()
            HStack(){
            Text( "$" + (self.pedido.valorTotal ?? "none"))
            }.frame(minWidth: 0, maxWidth: .infinity,alignment: .trailing)//.border(Color.green)
        }
    }
    
}
