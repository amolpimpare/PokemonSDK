//
//  DetailsView.swift
//  Pokemon
//
//  Created by Amol Pimpare on 02/01/21.
//  Copyright © 2021 Amol Pimpare. All rights reserved.
//

import SwiftUI

public struct DetailsView: View {
    private var name: String
    private var sprite: String
    private var description: String
    
    public init(name: String, sprite: String, description: String) {
        self.name = name
        self.sprite = sprite
        self.description = description
    }
    
    public var body: some View {
        VStack {
            ImageView(withURL: sprite)
                .clipShape(Circle())
                .frame(width: 200, height: 200, alignment: .center)
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 7)
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.title)
                    .fontWeight(.bold)                
                
                Divider()
                
                Text("About \(name)")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding(.bottom)
                
                Text(description)
            }
            .padding()
            
            Spacer()
        }
    }
}
