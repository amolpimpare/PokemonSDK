//
//  CircleImage.swift
//  Pokemon
//
//  Created by Amol Pimpare on 02/01/21.
//  Copyright © 2021 Amol Pimpare. All rights reserved.
//

import SwiftUI

struct CircleImage: View {
    var image: Image
    
    var body: some View {
        image
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 7)
    }
}
