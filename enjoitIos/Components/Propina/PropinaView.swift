//
//  PropinaView.swift
//  enjoitIos
//
//  Created by developapp on 17/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import SwiftUI
import WaterfallGrid
import FirebaseDatabase

struct PropinaView: View {
    
    @EnvironmentObject var navigation: NavigationStack
    
    @State var propWritten:String = ""
    @ObservedObject var modelView:ControllerPropina
    private var carrito:Carrito
    private var intent:String
    
    @State var alertPropinaInvalidaBool:Bool = false
    
    
    init(intent:String){
        if intent == "DOMICILIO" {
            self.carrito = RepositoryDomicilio().getCarrito()
        }else{
            self.carrito = RepositoryDomicilio().getCarrito()
        }
        self.intent = intent
        _ = self.carrito.getPrecio()
        if let idRest = carrito.idRestaurante {
           self.modelView = ControllerPropina(idRest: idRest)
        }else{
            self.modelView = ControllerPropina(idRest: 0)
            print("No id Restaurante")
        }
    }
    
    var body: some View {
         VStack(){
               KeyboardHost {
               ToolbarView()
               ScrollView{
                   VStack(){
                        encabezado//.border(Color.green)
                        gridPrpinasItems.frame()//.border(Color.green)
                        bottomAction.padding(30)//.border(Color.green)
                       Spacer()
                   }//.border(Color.green)
                }
            }
         }.alert(isPresented: self.$alertPropinaInvalidaBool) { () -> Alert in
            self.alertPropinaInvalida
        }
    }
    
    var encabezado : some View {
        VStack(alignment: .center, spacing:0){
            Text("TOTAL: "+String(self.carrito.precioTotal ?? 0.0)).font(.title).foregroundColor(Color("verde_bt_inicio"))
            Divider()
                .frame(height: 4)
                .background(Color("colorPrimary"))
            
            Text("¿Quieres Incluir Propina?").font(.title).padding()
        }
    }
    
    var gridPrpinasItems : some View {
        VStack{
            WaterfallGrid(self.modelView.valores, id: \.self){ val in
                PropinaItem(item: String( val.valor + "%"), color:Color("moradoPropina"))
                    //.border(Color.yellow)
                    .onTapGesture {
                        var car:Carrito = self.carrito
                        car.valorPropina = Double(val.valor)
                        RepositoryDomicilio().updateCarrito(car: car)
                        print("propina " + val.valor)
                        self.gotoDomicilioFacturacion()
                    }
             }
            .gridStyle(columns: 3).scaledToFit()
        }//.border(Color.green)
    }
    
    var bottomAction : some View {
        VStack(alignment: .center, spacing:0){
            TextField("Otro Valor", text: self.$propWritten)
            .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .padding()
            
            Button(action: {
                self.setPropina(prop: self.propWritten)
            }) {
                HStack(){
                    Text("Continuar").font(.headline)
                }
            }.buttonStyle(ButtonGreenApp())
        }
    }
    
    var alertPropinaInvalida : Alert {
        Alert(title: Text("Valor Invalido"), message: Text("El valor ingresado para la propina es invalido"), dismissButton: .destructive(Text("OK")))
    }
    
    func setPropina(prop:String) -> Void {
        if let propD:Double = Double(prop),
        propD >= 0.0 {
            let proptotalD:Double = propD / (self.carrito.precioTotal ?? 0.0)
            var car:Carrito = self.carrito
            car.valorPropina = Double(proptotalD)
            RepositoryDomicilio().updateCarrito(car: car)
            print("propina " + String(proptotalD))
            self.gotoDomicilioFacturacion()
        }else{
            self.alertPropinaInvalidaBool = true
            print("La propina ingresada es invalida")
        }
    }
    
    func gotoDomicilioFacturacion(){
        var carrito:Carrito = RepositoryDomicilio().getCarrito()
        carrito.getPrecio()
        self.navigation.advance(NavigationItem(view: AnyView(FacturacionView(carrito: carrito))))
    }
    
    func listener_notificacionesCambioComando()->Void{
        
        let ref:DatabaseReference = Database.database().reference(withPath: "APP/"+"\(DataApp.user!.idUsuario)")
        var _ = ref.observe( DataEventType.childAdded, with: { (snapshot) in
            
            let node = snapshot.value as AnyObject
            let isvisto:Bool = ((node["is_viewed"] as? Bool) ?? true);
            
            if  isvisto == false {
                let type:Int = node["type_notificacion"] as? Int ?? 0
                let idOrder:String = node["id_order"] as? String ?? "0"
                
                if idOrder == String(self.carrito.idPedido ?? 0) {
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



struct PropinaItem: View {

    var valor:String
    var color:Color

    init(item:String, color:Color){
        self.valor = item
        self.color = color
    }

    var body: some View {
        HStack(){
            Spacer()
            Text(self.valor).font(.title).foregroundColor(Color.white).padding(30)
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
            .background(Color("moradoPropina"))
            .clipShape(Circle())
    }

}
