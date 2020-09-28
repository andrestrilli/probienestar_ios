//
//  MyLocationView.swift
//  enjoitIos
//
//  Created by developapp on 11/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import SwiftUI
import MapKit

struct MyLocationView: View {
    @EnvironmentObject var navigation: NavigationStack
    @ObservedObject private var locationController = LocationViewController()
    
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var actualLocation = MKPointAnnotation()
    
    private var txtGreeting:String = "Hola " + DataApp.user!.userName
    private var txtother:String = "¿A dónde quieres que llevemos tu pedido?"
    private var mapViewcont = MKMapView()
    
    init(){
       locationController.findLocation()
    }
    
    var body: some View {
        ZStack() {
            map
            encabezado
            buttonBottom
        }.onReceive(locationController.$location){ locat in
            if let loc = locat{
                self.updateCurrentPoint(loc: loc)
            }
        }
        
    }
    
    var encabezado: some View{
        VStack(spacing:0){
            ToolbarView()
            
            ZStack(){
                Image("curtain_inverse_background")
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 0, maxWidth: .infinity).padding(0)
                
                VStack(){
                    Text(txtGreeting).foregroundColor(Color.white).font(.title).fontWeight(.bold).multilineTextAlignment(.center)
                    Text(txtother).foregroundColor(Color.white).font(.title).fontWeight(.medium).multilineTextAlignment(.center)
                }
            }
            Spacer()
        }
    }
    
    
    
    var map: some View {
        MapView(centerCoordinate: $centerCoordinate, annotation: actualLocation, mapView: mapViewcont)
    }
    
    var buttonBottom:some View{
    VStack(){
        Spacer()
        VStack(){
            
            HStack(){
                Spacer()
                
                Text(self.locationController.locationString ?? "***")
                .foregroundColor(Color.black)
                .font(.footnote)
                .multilineTextAlignment(.center)
                
                Spacer()
                
                Image("ic_direccion")
                    .resizable()
                    .scaledToFit()
                .frame(width: 35, height: 35)
                    .foregroundColor(Color("colorPrimary"))
                    .padding(.trailing, 15)
                    .onTapGesture {
                        self.goToMyDirections()
                }
            }

            Button(action: {
                
                if self.locationController.location == nil {
                    self.locationController.findLocation()
                }else{
                    self.createANewOrderWithDireccion()
                    self.navigation.advance(NavigationItem(view: AnyView( ListRestaurantes(intent:"DOMICILIO"))))
                }
                
            }) {
            HStack(){
                Spacer()
                Text("Direccion Actual").font(.headline).padding(8)
                Spacer()
            }
    
            }.buttonStyle(ButtonAppNoPadding(BgColor: Color.white, TextColor: Color.black))
    
            }.padding()
        .background(Color.white)
    
        }
    }
    
    func updateCurrentPoint(loc:CLLocation){
        let annotation = MKPointAnnotation()
        annotation.title = "Yo"
        annotation.subtitle = "Ubicacion Actual"
        annotation.coordinate = CLLocationCoordinate2D(latitude: loc.coordinate.latitude, longitude: loc.coordinate.longitude)
        self.actualLocation = annotation
        self.mapViewcont.addAnnotation(annotation)
        var cc:[MKAnnotation] = []
        cc.append(annotation)
        self.mapViewcont.showAnnotations(cc, animated: true)
    }
    
    func createANewOrderWithDireccion(){
        var carrito:Carrito = RepositoryDomicilio().getCarrito()
        let point:CLLocation = self.locationController.location!
        let poitn_String = self.locationController.locationString
        carrito.servicioUsuario = ServicioUsuario(direccion: poitn_String, direccion2: poitn_String, latitud: String(point.coordinate.latitude) , longitud: String(point.coordinate.longitude))
        
        RepositoryDomicilio().updateCarrito(car: carrito)
    }
    
    func goToMyDirections()->Void {
        self.navigation.advance(NavigationItem(view: AnyView(MisDireccionesView(intent:"select"))))
    }
    
    
}


