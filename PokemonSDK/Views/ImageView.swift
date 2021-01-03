//
//  ImageView.swift
//  Pokemon
//
//  Created by Amol Pimpare on 02/01/21.
//  Copyright © 2021 Amol Pimpare. All rights reserved.
//

import SwiftUI

public struct ImageView: View {
    @ObservedObject var imageLoader:ImageLoader
    @State var image: UIImage = UIImage()
    
    public init(withURL url:String) {
        imageLoader = ImageLoader(urlString:url)
    }
    
    public var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .onReceive(imageLoader.didChange) { data in
                self.image = UIImage(data: data) ?? UIImage()
            }
    }
}
