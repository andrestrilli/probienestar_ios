//
//  FontTextStyles.swift
//  enjoitIos
//
//  Created by developapp on 7/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import SwiftUI

struct FontTextStyles: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}



struct aButtonGreenApp: ButtonStyle {
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

struct FontTextStyles_Previews: PreviewProvider {
    static var previews: some View {
        FontTextStyles()
    }
}
