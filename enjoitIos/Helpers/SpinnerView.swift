//
//  SpinnerView.swift
//  enjoitIos
//
//  Created by developapp on 25/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import SwiftUI

struct SpinnerView : View{

    @State var showModal = false
    var texttitle = "Texto Prueba"
    var textSelected = "jummm"
    var array:[String] = []
    @State var intSelected:Int
    var onSelected:(_ indexSelected:Int)->Void = {_ in }
    var disable:Bool = false
    
    init(title:String,data:[String],selected:Int,onSelectedItem:@escaping (_ indexSelected:Int)->Void){
        self.texttitle = title;
        self.array = data
        self._intSelected = State(initialValue:  selected)
        self.onSelected = onSelectedItem
    }
    
    init(title:String,data:[String],selected:Int,onSelectedItem:@escaping (_ indexSelected:Int)->Void, disable:Bool){
        self.texttitle = title;
        self.array = data
        self._intSelected = State(initialValue:  selected)
        self.onSelected = onSelectedItem
        self.disable =  disable
    }
    
    var body : some View{
        Button(action: {
            if !self.disable {
                self.showModal = true;
            }
        }) {
            HStack{
                Text(self.texttitle)
                Spacer()
                if !self.array.isEmpty {
                    if  self.intSelected >= 0 && self.intSelected < self.array.count {
                        Text(self.array[self.intSelected])
                    }
                }
            }.padding(10)
        }.buttonStyle(PlainButtonStyle()).background(RoundedRectangle(cornerRadius: 10)
            .fill(Color.white)).sheet(isPresented: self.$showModal) {
                self.content

        }.onAppear {
            if !self.array.isEmpty {
                if  self.intSelected >= 0 && self.intSelected < self.array.count {
                    self.intSelected = 0
                }
            }
        }
    }
    
    var content : some View {
        VStack(alignment: .center, spacing:0){
            Text(self.texttitle).font(.title)
                ScrollView(Axis.Set.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 10){
                        ForEach(0 ..< self.array.count){ index in
                            Text(self.array[index]).fontWeight(index == self.intSelected ? .bold : .thin).tag(index)
                                .font(.title)
                                .multilineTextAlignment(.leading)
                                .onTapGesture {
                                    self.intSelected = index
                                    self.showModal = false;
                                    self.onSelected(index)

                            }.foregroundColor(index == self.intSelected ? Color("colorPrimary") : Color.black)

                        }
                        Spacer()
                        
                    }.padding(10)
                    
                }
        }
    }
    
    
}
