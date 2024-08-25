//
//  RandomImageViewModel.swift
//  Concurrent_Image_Downloader_SwiftUI_Async
//
//  Created by Nishanth on 25/08/24.
//

import Foundation
import UIKit
@MainActor
class RandomImageViewModel: ObservableObject{
    
    @Published var imageArray: [RandomImageVM] = []
    private let webService = Webservice.sharedInstance
    func loadImagedata(number: [Int]) async{
        self.imageArray = []
        do{
            try await withThrowingTaskGroup(of: (Int,RandomImageModel).self) { group in
                for numbers in number{
                    group.addTask { [self] in
                        return (numbers, try await webService.webRequest(id: numbers))
                    }
                }
                
                for try await (_, images) in group{
                    imageArray.append(RandomImageVM.init(randomImageModel: images))
                }
            }
        }
        catch{
            print("error: \(error.localizedDescription)")
        }
    }
    
}


struct RandomImageVM: Identifiable{
    
    let id = UUID()
    
    fileprivate var randomImageModel: RandomImageModel
    
    
    var imageData: UIImage?{
        return UIImage(data: randomImageModel.image)
    }
    
    var randomTextString: String{
        return randomImageModel.quote.content
    }
}
