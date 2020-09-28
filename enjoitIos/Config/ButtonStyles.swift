//
//  ButtonStyles.swift
//  enjoitIos
//
//  Created by developapp on 7/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import SwiftUI

struct ButtonStyles: View {
    var body: some View {
        VStack {
            Button("Tap Me!") {
                print("button pressed!")
            }.buttonStyle(ButtonGreenApp())
        }
    }
}

struct ButtonGreenApp: ButtonStyle {
    var BgColor: Color = Color("verde_bt_inicio")
    var TextColor: Color = .white

    public func makeBody(configuration: ButtonGreenApp.Configuration) -> some View {
        configuration.label
            .foregroundColor(TextColor)
            .padding(15)
            .background(RoundedRectangle(cornerRadius: 15).fill(BgColor))
            .compositingGroup()
            .shadow(color: .black, radius: 1)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
    
}

struct ButtonAppNoPadding : ButtonStyle {
    var BgColor: Color = Color("azulapp")
    var TextColor: Color = .white

    public func makeBody(configuration: ButtonAppNoPadding.Configuration) -> some View {

        configuration.label
            .foregroundColor(TextColor)
            .background(RoundedRectangle(cornerRadius: 15).fill(BgColor))
            .compositingGroup()
            .shadow(color: .black, radius: 1)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }

}

//
//struct ButtonAppPlain: ButtonStyle {
//    var BgColor: Color = Color("azulapp")
//    var TextColor: Color = .white
//
//    public func makeBody(configuration: ButtonAzulApp.Configuration) -> some View {
//
//        configuration.label
//            .foregroundColor(TextColor)
//            .padding(15)
//            .background(RoundedRectangle(cornerRadius: 10).fill(BgColor))
//            .compositingGroup()
//       //     .shadow(color: .black, radius: 3)
//            .opacity(configuration.isPressed ? 0.5 : 1.0)
//            //.scaleEffect(configuration.isPressed ? 0.8 : 1.0)
//    }
//
//}
//
//struct ButtonOnlyBorder: ButtonStyle {
//    var BgColor: Color = Color("azulapp")
//    var TextColor: Color = .white
//
//    public func makeBody(configuration: ButtonAzulApp.Configuration) -> some View {
//
//        configuration.label
//            .padding(15)
//            .background(Color.clear)
//            .cornerRadius(10)
//            .foregroundColor(.white)
//            .overlay(
//                RoundedRectangle(cornerRadius: 10)
//                    .stroke(BgColor, lineWidth: 3)
//            )
//            .compositingGroup()
//       //     .shadow(color: .black, radius: 3)
//            .opacity(configuration.isPressed ? 0.5 : 1.0)
//
//            //.scaleEffect(configuration.isPressed ? 0.8 : 1.0)
//    }
//
//}

struct OutlineStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 44, minHeight: 44)
            .padding(.horizontal)
            .foregroundColor(Color.accentColor)
            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.accentColor))
    }
}

struct ButtonStyles_Previews: PreviewProvider {
    static var previews: some View {
        ButtonStyles()
    }
}
