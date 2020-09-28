//
//  PlatoDetalle.swift
//  enjoitIos
//
//  Created by developapp on 9/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import SwiftUI

struct PlatoDetalleView: View {
    

     
    @EnvironmentObject var navigation: NavigationStack
    @ObservedObject var modelview: ControllerPlatoDetalle
    
    @ObservedObject var remoteImg = ImageFromUrl();
    var nombre:String = ""
    var descrip:String = ""
    var precio:String = ""
    let intent:String = "DOMICILIO"
    
    @State var txtcomment:String = ""
    
    init(product:Producto){
        UISwitch.appearance().onTintColor = .red
        
        self.nombre = product.nombre ?? ""
        self.descrip = product.descripcion ?? ""
        self.precio = product.valor ?? ""
        self.modelview = ControllerPlatoDetalle(product: product)
        
        if  let perfil:String = product.imagen{
            let url = ApiConection.urlImage + "filesProduct/" + perfil
            remoteImg = ImageFromUrl(imageURL: url)
        }
    }
    
    var body: some View {
           KeyboardHost {
        VStack(){
            encabezado
            ScrollView{
                VStack(){
                    if modelview.ingredientes != nil{
                        if modelview.ingredientes!.obligatorios.count > 0{
                            ingredientesBase
                        }
                        if modelview.ingredientes!.ingredientes.count > 0{
                            quitarIngredientes
                        }
                        if modelview.ingredientes!.adicionales.count > 0{
                            ingredientesAdicionales
                        }
                        if modelview.ingredientes!.acompañantes.count > 0{
                            acompanantesOpcionales
                        }
                    }
                    comentarioAdicional

                }
            }
            Spacer()
            Button(action: {
                self.modelview.onPedirButtonPressed(intent: self.intent, navigation: self.navigation)
                }) {
                HStack(){
                    Spacer()
                    Text("Pedir").font(.headline).padding(0)
                    Spacer()
                }
            }.buttonStyle(ButtonGreenApp())
        }
        }
    }
    
    var encabezado: some View{
        VStack(){
            ZStack(alignment: .top){
                Image(uiImage: remoteImg.dataimg )
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 250)
                    .padding(.top,50)
                    .clipped()
                    
                    ToolbarView()
            }
            
            HStack(){
                Text(self.nombre).font(.title).foregroundColor(Color("grisOscuro"))
                Spacer()
            }.padding(10)
            
            Text(self.descrip).font(.body).foregroundColor(Color("grisOscuro"))
            
            HStack(){
                Spacer()
                Text("Precio: $"+self.precio).font(.body).foregroundColor(Color("grisOscuro"))
            }.padding(10)
            
            VStack(){
                Text("Personalizar Ingredientes").font(.title).foregroundColor(Color("colorPrimary")).padding(2)
                Divider().frame(height: 3).background(Color("colorPrimary"))
            }
        }
    }
    
    var ingredientesBase: some View{
        VStack(alignment: .center){
            Text("Escoger Ingrediente Base").font(.headline).foregroundColor(Color("grisOscuro")).padding(10)
            
            HStack(){
                Text("Selecciona un ingrediente base para tu plato:").font(.footnote).foregroundColor(Color("grisOscuro"))
                Spacer()
            }
            
            ForEach(self.modelview.ingredientes!.obligatorios) { ingre in
                ItemIngrediente(ingre: ingre, showPrecio: false, tipo: "0",modelView: self.modelview).padding(0)
            }
    
        }.frame(minWidth: 0,  maxWidth: .infinity).padding()
    }
    
    var quitarIngredientes: some View{
        VStack(alignment: .center){
            Text("Quitar Ingredientes").font(.headline)
            Text("¿Deseas eliminar algún ingrediente de tu plato?")
            Text("Deselecciona los ingredientes que no deseas en tu plato:")
            
            ForEach(self.modelview.ingredientes!.ingredientes) { ingre in
                ItemIngrediente(ingre: ingre, showPrecio: false, tipo: "N",modelView: self.modelview).padding(0)
                //CheckboxField(id: String(ingre.idConfigProducto), label: ingre.nombre, callback: self.checkboxSelected)
            }
        }.frame(minWidth: 0,  maxWidth: .infinity).padding()
    }
    
    var ingredientesAdicionales: some View{
        VStack(alignment: .center){
            Text("Ingredientes Adicionales").font(.headline)
            Text("¿Deseas adicionar algún ingrediente a tu plato?")
            Text("Selecciona el (los) ingrediente(s) que deseas adicionar:")
            
            ForEach(self.modelview.ingredientes!.adicionales) { ingre in
                ItemIngrediente(ingre: ingre, showPrecio: true, tipo: "A",modelView: self.modelview).padding(0)
            }

        }.frame(minWidth: 0,  maxWidth: .infinity).padding()
    }
    
    var acompanantesOpcionales : some View{
        VStack(alignment: .center){
            Text("Acompañantes Opcionales").font(.headline)
            Text("¿Deseas algún acompañante de tu plato?")
            Text("Selecciona el (los) acompañante(s) que deseas con tu plato:")
            
            ForEach(self.modelview.ingredientes!.acompañantes) { ingre in
                ItemIngrediente(ingre: ingre, showPrecio: false, tipo: "AC",modelView: self.modelview).padding(0)
            }
        }.frame(minWidth: 0,  maxWidth: .infinity).padding()
    }
    
    var comentarioAdicional : some View{
        VStack(alignment: .center){
            Text("Comentario Adicional").font(.headline)
            
            MultilineTextView(placeholderText: "Algun Comentario", text: self.$modelview.comment)
                .font(.body)
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 80, maxHeight: .infinity, alignment: .leading)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                    .stroke(Color("colorPrimary"), lineWidth: 1)
                )
           
            
        }.frame(minWidth: 0,  maxWidth: .infinity).padding()
    }
    
    func onPedirButtonPressed(){
        print("opcion de ordenar")
        
        
    }
    
    func checkboxSelected(id: String, isMarked: Bool) {
           print("\(id) is marked: \(isMarked)")
    }
    
}

struct ItemIngrediente: View {
    @ObservedObject var modelview: ControllerPlatoDetalle

    @State private var selected:Bool {
        didSet {
            // Here's where any code goes that needs to run when a switch is toggled
            self.funcion(estado: selected)
        }
    }
    private var ingre:IngredienteElement
    private var tipo:String
    private var showPrecio:Bool

    init(ingre:IngredienteElement,showPrecio:Bool,tipo:String, modelView:ControllerPlatoDetalle){
        self.ingre = ingre
        self.showPrecio = showPrecio
        self.tipo = tipo
        self.modelview = modelView
        if self.tipo == "N"{
            _selected = State(initialValue: true)
        }else{
            _selected = State(initialValue: false)

        }
    }
    
    var body: some View {
        
        let bind = Binding<Bool>(
              get:{self.selected},
              set:{self.selected = $0}
            )
        
        return HStack {
            if self.showPrecio == true{
                Toggle(isOn: bind) {
                    HStack(){
                        Text(self.ingre.nombre)
                        Spacer()
                        Text("$ "+self.ingre.valor).foregroundColor(Color("colorPrimaryDark")).padding(.trailing, 30)
                    }
                }.padding(5)
            }else{
                Toggle(isOn: bind) {
                    Text(self.ingre.nombre)
                }.padding(5)
            }
        }
    }
    
    func funcion(estado:Bool) {
        if self.tipo == "N" { //Mando los que el usuario quiere quitar
            if estado == false {
                self.modelview.ingredientesSelecteds.append(self.ingre)
                print("added "+self.ingre.nombre)
            }else{
                if let index = self.modelview.ingredientesSelecteds.firstIndex(of: self.ingre) {
                    self.modelview.ingredientesSelecteds.remove(at: index)
                    print("remove "+self.ingre.nombre)
                }
            }
        }else{//Mando los que el usuario selecciona
            if estado == true {
                self.modelview.ingredientesSelecteds.append(self.ingre)
                print("added "+self.ingre.nombre)
            }else{
                if let index = self.modelview.ingredientesSelecteds.firstIndex(of: self.ingre) {
                    self.modelview.ingredientesSelecteds.remove(at: index)
                    print("remove "+self.ingre.nombre)
                }
            }
        }
        
        
        print(self.modelview.ingredientesSelecteds)
    }
}

struct MultilineTextView: UIViewRepresentable {
    typealias UIViewType = UITextView
    
    var placeholderText: String = "Text View"
    @Binding var text: String
    
    func makeUIView(context: UIViewRepresentableContext<MultilineTextView>) -> UITextView {
        let textView = UITextView()
        
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero
        textView.font = UIFont.systemFont(ofSize: 17)
        
        textView.text = placeholderText
        textView.textColor = .placeholderText
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<MultilineTextView>) {
        
        if text != "" || uiView.textColor == .label {
            uiView.text = text
            uiView.textColor = .label
        }
        
        uiView.delegate = context.coordinator
    }
    
    func frame(numLines: CGFloat) -> some View {
        let height = UIFont.systemFont(ofSize: 17).lineHeight * numLines
        return self.frame(height: height)
    }
    
    func makeCoordinator() -> MultilineTextView.Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: MultilineTextView
        
        init(_ parent: MultilineTextView) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == .placeholderText {
                textView.text = ""
                textView.textColor = .label
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text == "" {
                textView.text = parent.placeholderText
                textView.textColor = .placeholderText
            }
        }
    }
}
