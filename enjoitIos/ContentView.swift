//
//  ContentView.swift
//  enjoitIos
//
//  Created by developapp on 7/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationHost()
        .environmentObject(NavigationStack(
           NavigationItem( view: AnyView(SplashScreenView()))))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
