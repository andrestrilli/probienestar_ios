//
//  ItemListPedidoView.swift
//  enjoitIos
//
//  Created by developapp on 11/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import SwiftUI

struct ItemListPedidoView: View {
    
    var repository:RepositoryDomicilio
    @State var detalle:PedidosDetalle
   // @State var carrito:Carrito? = nil
    var intent:String = "DOMICILIO"
    var name:String = "Article Name"
    @State var count:Int
    @State var preciototal:Double
    var estado:Int = 0
    var precio:Double = 1
    
    @State var alertItemDelete:Bool = false
    
    init(detalle:PedidosDetalle, intent:String, repository:RepositoryDomicilio){
        
        self.repository = repository
        _detalle = State(wrappedValue: detalle)
        //_carrito = State(initialValue: carrito)
        self.intent = intent
        self.name = detalle.nombreProducto ?? "xxx";
        _count = State(initialValue: Int(detalle.cantidad ?? "0") ?? 0)
        self.precio = Double(detalle.valorNeto ?? "0.0") ?? 0.0
        _preciototal = State(initialValue:  Double(Double( Int(detalle.cantidad ?? "0") ?? 0 ) * precio))
        
        self.estado = detalle.idEstado ?? 0
    }
    
    var body: some View {
        ZStack(){
            HStack(){
                nombre
                Spacer()
                buttons
                VStack(alignment: .center, spacing: 1){
                    Text("\(self.preciototal, specifier: "%.2f")").font(.headline).fontWeight(.medium).foregroundColor(Color("verde_bt_inicio")).padding(0)
                    barras.padding(0)
                }
            }
            
            if  self.detalle.idEstado != 0 { // color gris arriba de todo el detalle
                HStack(){
                    Spacer()
                    VStack(alignment: .center, spacing: 1){
                     Text("\(self.preciototal, specifier: "%.2f")").font(.headline).fontWeight(.medium).foregroundColor(Color("verde_bt_inicio")).padding(0)
                     barras.padding(0)
                    }.hidden()
                }.background(Color("grisTransparente"))
            }
        }.padding(.horizontal,20).padding(.vertical,10).alert(isPresented: self.$alertItemDelete) {
            self.alertViewItemDelete
        
        }
    }
    
    var nombre : some View {
        VStack(alignment: .center, spacing:0){
            Text(self.name).font(.headline).fontWeight(.regular)
        }.padding(.horizontal,10)
    }
    
    var buttons : some View {
        VStack(alignment: .center, spacing:0){
            HStack(){
                   Button(action: {
                    
                    self.onButtonMenosPressed()
                    
                    }) {
                        HStack(){
                            Text("-").font(.largeTitle).padding(3).padding(.horizontal,3).foregroundColor(Color.white)
                        }.frame(width: 30, height: 30, alignment: .center)
                        .background(Color("colorPrimary"))
                    }.buttonStyle(PlainButtonStyle())
                

                Text("\(self.count)").font(.title).padding(3)
               
                    Button(action: {
                         self.onButtonMasPressed()
                    }) {
                        HStack(){
                            Text("+").font(.largeTitle).padding(3).foregroundColor(Color.white)
                        }.frame(width: 30, height: 30, alignment: .center)
                        .background(Color("colorPrimary"))
                    }.buttonStyle(PlainButtonStyle())
                
            }
        }.padding(.trailing,10)
    }
    
    var barras : some View {
        HStack(spacing:0){
            VStack(){
                Text("Ordenado")
                    .font(.system(size:10))
                    .foregroundColor(Color("grisOscuro"))
                    .lineLimit(1)
                
                Divider()
                    .frame(width: 30, height: 7)
                    .background(coloresPrimerEstado(estado: self.estado))
                
            }.frame(width: 30)
            
            VStack(){
                Text("EnProceso")
                    .font(.system(size:10))
                    .foregroundColor(Color("grisOscuro"))
                    .lineLimit(1)
                
                Divider()
                    .frame(width: 30, height: 7)
                    .background(coloresSegundoEstado(estado: self.estado))
            
            }.frame(width: 30)
            
            VStack(){
                
                Text("EnCamino")
                    .font(.system(size:10))
                    .foregroundColor(Color("grisOscuro"))
                    .lineLimit(1)
                
                Divider()
                    .frame(width: 30, height: 7)
                    .background(coloresTercerEstado(estado: self.estado))
                
            }.frame(width: 30)
        }
    }
    
    var alertViewItemDelete:Alert {
        Alert(title: Text("¿Desea eliminar este producto del pedido?"), primaryButton: Alert.Button.default( Text("SI"), action: {
        self.removeITem()
        }), secondaryButton: Alert.Button.cancel())
    }

    func onButtonMasPressed(){
        if self.detalle.idEstado == 0 {
            if let index = (self.repository.carrito!.pedidosDetalle ?? []).firstIndex(of: self.detalle) {
                self.repository.carrito!.pedidosDetalle![index].agregar(cant: 1)
                self.detalle.agregar(cant: 1)
                    self.count = Int(self.detalle.cantidad!)!
                    self.preciototal = Double(self.detalle.valorTotal!)!
             
            }
            saveCarrito(carrito: self.repository.carrito!)
        }
    }
    
    func onButtonMenosPressed(){
        if self.detalle.idEstado == 0 {
            if let index = (self.repository.carrito!.pedidosDetalle ?? []).firstIndex(of: self.detalle) {
                if self.count == 1 {
                    self.alertItemDelete = true
                }else{
                    self.repository.carrito!.pedidosDetalle![index].quitar(cant: 1) //del carrito real
                    self.detalle.quitar(cant: 1) //del detalle de la vista
                    self.count = Int(self.detalle.cantidad!)!
                    self.preciototal = Double(self.detalle.valorTotal!)!
                    saveCarrito(carrito: self.repository.carrito!)
                }
            }
        }
    }
    
    func removeITem(){
        var carrito:Carrito = self.repository.carrito!
        carrito.removeDetallePedido(pedido: self.detalle)
        saveCarrito(carrito: carrito)
    }
    
    func saveCarrito(carrito:Carrito){
        switch self.intent {
        case "DOMICILIO":
            self.repository.updateCarrito(car: carrito)
        default:
            print("No se identidifica el repository")
        }
    }
    
    func coloresPrimerEstado(estado:Int)->Color{
        let estados:[Int] = [17,18,19,33,20]
        if estados.contains(estado) {
            return Color("verdeSolicitado")
        }else{
            return Color("gris")
        }
    }
    
    func coloresSegundoEstado(estado:Int)->Color{
        let estados:[Int] = [18,19,33,20]
        if estados.contains(estado) {
            return Color("naranjaEnProceso")
        }else{
            return Color("gris")
        }
    }
    
    func coloresTercerEstado(estado:Int)->Color{
        let estados:[Int] = [19,33,20]
        if estados.contains(estado) {
            return Color("azulAlaMesa")
        }else{
            return Color("gris")
        }
    }
    
}

//struct ItemListPedidoView_Previews: PreviewProvider {
//    static var previews: some View {
//            ItemListPedidoView()
//    }
//}
