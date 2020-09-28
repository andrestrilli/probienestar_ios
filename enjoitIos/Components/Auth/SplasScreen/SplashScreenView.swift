//
//  SplasScreenView.swift
//  enjoitIos
//
//  Created by developapp on 7/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import SwiftUI

struct SplashScreenView: View {
    
    @EnvironmentObject var navigation: NavigationStack
    @ObservedObject var viewModel = ControllerLogin()

    
    var body: some View {
        VStack(){
            Spacer()
            logo
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .background(Color("colorPrimary"))
        .onAppear {
            print("Aparece")
            self.onAppear()
           // self.navigation.advance(NavigationItem(view: AnyView(LoginView())))

        }
    }
    
    var logo: some View  {
        Image("icon_title_white")
            .resizable()
        .scaledToFit()
            .frame(width: 200, height: 200, alignment: .center)
    }
    
    func onAppear() {
        self.viewModel.navigation = self.navigation

        
        guard let localDataUser = KeyChain.load(key:"user"),
            let resultStringUser = String.init(data: localDataUser, encoding:  String.Encoding.utf8) else {
                print("Error User")
                KeyChain.saveCredentials(psw: "", user: "")
                self.navigation.advance(NavigationItem(view: AnyView(LoginView())))
                return
        }
        
        guard let localDataPsw = KeyChain.load(key: "psw"),
            let resultStringPsw = String.init(data: localDataPsw, encoding:  String.Encoding.utf8) else {
                print("Erro Psw")
                KeyChain.saveCredentials(psw: "", user: "")
                self.navigation.advance(NavigationItem(view: AnyView(LoginView())))
                return
        }
        
        if ( resultStringUser != ""  || resultStringPsw != "" ){
            let id:String = resultStringUser as String
            let psw:String = resultStringPsw as String
            self.viewModel.Token_request(id: id, psw: psw)
            
        }else{
            
          print("Credenciales vacias")
          KeyChain.saveCredentials(psw: "", user: "")
          self.navigation.advance(NavigationItem(view: AnyView(LoginView())))
            
        }
        
        
    }
    
    
    
}

struct SplasScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
