//
//  ImageFromUrl.swift
//  enjoitIos
//
//  Created by developapp on 8/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//
//

import Foundation
import Combine
import AlamofireImage
import Alamofire

class ImageFromUrl: ObservableObject {
    @Published var didChange = PassthroughSubject<UIImage, Never>()
    @Published var dataimg = UIImage(){
        didSet{
            didChange.send(dataimg)
        }
    }
    
    init(imageURL: String){
        guard let url = URL(string: imageURL) else{return}
        print(url)
//        URLSession.shared.dataTask(with: url){
//            (data, response, error) in
//            guard let data = data else { return }
//
//            DispatchQueue.main.async {
//                self.dataimg = data
//            }
//        }.resume()
        
        AF.request(url).responseImage { response in
        //            debugPrint(response)
        //            print(response.request!)
        //            print(response.response!)
        //            debugPrint(response.result)

                    if case .success(let image) = response.result {
                        print("image downloaded: \(image)")
                            DispatchQueue.main.async {
                                self.dataimg = image
                            }
                        
                    }
                }
    }
    
    init(){
        
    }
    
}
