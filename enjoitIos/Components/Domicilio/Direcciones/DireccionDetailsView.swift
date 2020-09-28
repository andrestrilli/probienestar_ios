//
//  DireccionDetailsView.swift
//  enjoitIos
//
//  Created by developapp on 12/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import SwiftUI
import MapKit

struct DireccionDetailsView: View {
    
    @ObservedObject var modelview = ControllerMisDirecciones()
    @EnvironmentObject var navigation: NavigationStack

    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var actualLocation = MKPointAnnotation()
    
    private var mapViewcont = MKMapView()
    
    var dir:Direccion
    var info:String = ""
    var intent:String = ""
    
    init(dir:Direccion,intent:String){
        self.dir = dir
        self.intent = intent
        self.info = ""
        self.info += (dir.direccion ?? "") + "\n"
        self.info += (dir.name ?? "") + "\n"
        self.info += (dir.extra ?? "") + "\n"
    }

    var body: some View {
        VStack(spacing: 0){
            ToolbarView()
            encabezado
            ZStack(){
                map.onAppear{
                    self.updateCurrentPoint(dir: self.dir)
                }
                
                VStack(){
                    Spacer()
                    bottonInfo
                    if intent == "create" {
                        btAgregarDireccion
                    }
                }
            }
        }
    }
    
    var encabezado : some View {
        HStack(alignment: .center, spacing:0){
            Spacer()
            Text("Visualizar Direccion").font(.title).foregroundColor(Color.white).padding(10)
            Spacer()
        }.background(Color("colorPrimary"))
    }
    
    var bottonInfo : some View {
        VStack(alignment: .center, spacing:0) {
            HStack(){
                Spacer()
                Text(self.info).font(.headline).multilineTextAlignment(.center)
                .foregroundColor(Color("grisOscuro"))
                Spacer()
            }.background(Color("blancoTrans")).padding()
        }
    }
    
    var btAgregarDireccion : some View {
        Button(action: {
            self.modelview.addDireccion_request(address: self.dir, navigation: self.navigation)
        }) {
            HStack(){
                Spacer()
                Text("Guardar Direccion").font(.headline).padding(15)
                Spacer()
            }
        }.buttonStyle(ButtonAppNoPadding(BgColor: Color("verde_dark"), TextColor: Color.white))
    }
    
    var map: some View {
        MapView(centerCoordinate: $centerCoordinate, annotation: actualLocation, mapView: mapViewcont)
    }
    
    func updateCurrentPoint(dir:Direccion){
        
        let latDouble:Double = Double(dir.latitud ?? "0.0") ?? 0.0
        let longDouble:Double = Double(dir.longitud ?? "0.0") ?? 0.0
        let annotation = MKPointAnnotation()
        annotation.title = "Yo"
        annotation.subtitle = "Ubicacion Actual"
        annotation.coordinate = CLLocationCoordinate2D(latitude: latDouble, longitude: longDouble)
        self.actualLocation = annotation
        self.mapViewcont.addAnnotation(annotation)
        var cc:[MKAnnotation] = []
        cc.append(annotation)
        self.mapViewcont.showAnnotations(cc, animated: true)
    }
}


