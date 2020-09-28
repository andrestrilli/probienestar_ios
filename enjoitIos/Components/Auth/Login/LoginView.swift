//
//  LoginView.swift
//  enjoitIos
//
//  Created by developapp on 7/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import SwiftUI
struct LoginView: View {
    
    @EnvironmentObject var navigation: NavigationStack
    @ObservedObject var viewModel = ControllerLogin()

    //@State var user:String = "andres.padilla@developapp.co";
    //@State var password:String = "123";

    @State var user:String = "";
    @State var password:String = "";

    // Strings
    let txtdescrip:String = "Te extrañamos!\nEstas listo para disfrutar\nde tu experiencia?"
    let txtOlvidoContrasena:String = "¿Has olvidado tu contraseña?"
    let txtSignup:String = Values.strings["registrate"] ?? "";

    var body: some View {
           KeyboardHost {
        VStack(){
            VStack{
                Image("title_enjoit").padding()
            Text(txtdescrip).multilineTextAlignment(.center).foregroundColor(Color("grisOscuro")).font(.title)
                }
            Spacer()
            VStack(spacing:15){
                
                TextField("Usuario", text: $user).textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("Contraseña", text: $password).textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    self.OnloginButtonPress()
                }) {
                    HStack(){
                        Spacer()
                        Text("Listo").font(.headline)
                        Spacer()
                    }
                }.buttonStyle(ButtonGreenApp())
                
                
                Button(action: {
                    //self.OnRegisterButtonPress
                }) {
                    Text(txtOlvidoContrasena).multilineTextAlignment(.center).foregroundColor(Color("grisOscuro")).font(.headline)
                }.buttonStyle(PlainButtonStyle())
                
                
            }.padding()
            Spacer()
            
            Button(action: {
                //Action here
                self.OnRegisterButtonPress()

            }, label: {
                Text(txtSignup).foregroundColor(Color("colorPrimary")).font(.title)
                }).buttonStyle(PlainButtonStyle()).padding()
            
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .background(background)
            .onAppear{
                self.OnAppear()
            }
            
        }
        }
    
    
  
    var background: some View{
        Image("corbatin_gris_background").resizable().scaledToFill()
    }
    
    private func OnloginButtonPress(){
        print("Hacer Login")
        self.viewModel.Token_request(id: self.user, psw: self.password)
        //self.navigation.advance(NavigationItem(view: AnyView(HomeView())))
    }
    
    
    private func OnRegisterButtonPress(){
        print("Tocado")
        self.navigation.advance(NavigationItem(view: AnyView(RegisterView())))
    }
    
    private func OnAppear(){
        self.viewModel.navigation = self.navigation
    }
   
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
