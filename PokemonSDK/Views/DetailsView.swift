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
    
    public enum AccessibilityIdentifier {
        public static let sprite = "com.pokemonsdk.details.sprite"
        public static let name = "com.pokemonsdk.label.name"
        public static let description = "com.pokemonsdk.label.desc"
    }
    
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
                .accessibility(identifier: AccessibilityIdentifier.sprite)
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.title)
                    .fontWeight(.bold)                
                    .accessibility(identifier: AccessibilityIdentifier.name)
                
                Divider()
                
                Text("About \(name)")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding(.bottom)
                    .accessibility(identifier: AccessibilityIdentifier.description)

                Text(description)
            }
            .padding()
            
            Spacer()
        }
    }
}
