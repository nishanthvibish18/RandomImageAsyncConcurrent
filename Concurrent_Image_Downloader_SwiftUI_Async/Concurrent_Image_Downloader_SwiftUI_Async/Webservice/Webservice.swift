//
//  Webservice.swift
//  Concurrent_Image_Downloader_SwiftUI_Async
//
//  Created by Nishanth on 25/08/24.
//

import Foundation

enum WebURL: String{
    
    case randomImageURL = "https://picsum.photos/200/300"
    case randomTextURL = "https://api.quotable.io/random"
}

enum NetworkError: Error, LocalizedError{
    case urlNotFound
    case decodingError
    case noDataFound
    
    var localizedError: String{
        switch self {
        case .urlNotFound:
            return "URL Not Found"
        case .decodingError:
            return "Decoding Error"
        case .noDataFound:
            return "No Data Found"
        }
    }
}


final class Webservice{
    static let sharedInstance = Webservice()
    
    private init(){}
    
    func webRequest(id: Int) async throws -> RandomImageModel{
        guard let randomImageUrl = URL(string: "\(WebURL.randomImageURL.rawValue)?uuid=\(UUID().uuidString)") else{
            throw NetworkError.urlNotFound
        }
        guard let randomText = URL(string: WebURL.randomTextURL.rawValue) else{
            throw NetworkError.urlNotFound
        }
        
        async let (randomImageData, _) = URLSession.shared.data(from: randomImageUrl)
        
        async let (randomTextData, _) = URLSession.shared.data(from: randomText)

        guard let randomTextModel = try? JSONDecoder().decode(Quote.self, from: try await randomTextData) else{
            throw NetworkError.decodingError
        }
        
        return RandomImageModel(image: try await randomImageData, quote: randomTextModel)
        
    }
}
