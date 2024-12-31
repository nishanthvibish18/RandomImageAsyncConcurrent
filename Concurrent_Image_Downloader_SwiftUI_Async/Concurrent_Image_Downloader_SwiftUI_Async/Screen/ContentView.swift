//
//  ContentView.swift
//  Concurrent_Image_Downloader_SwiftUI_Async
//
//  Created by Nishanth on 25/08/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var imageVm: RandomImageViewModel = RandomImageViewModel()
    var body: some View {
        List {
            ForEach(imageVm.imageArray, id: \.id){ imageData in
            
                HStack(alignment: .center,spacing: 10, content: {
                    imageData.imageData.map { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                    }
                    
                    Text(imageData.randomTextString)
                        .fontWeight(.medium)
                })
            }
        }
        .task {
            await imageVm.loadImagedata(number: Array(100...120))

        }
        .navigationTitle("Random Image Datas")
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    Task{
                        await imageVm.loadImagedata(number: Array(100...120))
                    }
                }, label: {
                    Image(systemName: "arrow.clockwise.circle")
                })
            }
        })
    }
}

#Preview {
    ContentView()
}
