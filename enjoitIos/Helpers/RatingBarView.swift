//
//  RatingBarView.swift
//  enjoitIos
//
//  Created by developapp on 9/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import SwiftUI

struct RatingBar: View {
    var num:Int
    
    init(numStar:Int) {
        num = numStar;
    }
    
    var body: some View {
        HStack{
            ForEach((1...num), id: \.self){_ in
                Image("star")
                    .resizable()
                    .frame(width: 14, height: 14)
            }
        }.frame(minWidth: 0, maxWidth: 100, alignment: Alignment.center)
        
    }
}

struct RatingBarView_Previews: PreviewProvider {
    static var previews: some View {
        RatingBar(numStar: 3)
    }
}
