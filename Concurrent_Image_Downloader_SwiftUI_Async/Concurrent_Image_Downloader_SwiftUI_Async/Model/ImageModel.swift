//
//  ImageModel.swift
//  Concurrent_Image_Downloader_SwiftUI_Async
//
//  Created by Nishanth on 25/08/24.
//

import Foundation


struct RandomImageModel: Decodable{
    let image: Data
    let quote: Quote
}

struct Quote: Decodable {
    let content: String
}


