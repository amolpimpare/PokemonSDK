//
//  SearchBar.swift
//  Pokemon
//
//  Created by Amol Pimpare on 30/12/20.
//  Copyright © 2020 Amol Pimpare. All rights reserved.
//

import SwiftUI

struct SearchBar: View {
    var placeholder: String = "Search..."
    
    @Binding var searchText: String
    @State var isEditing: Bool = false
    
    var body: some View {
        HStack {
            TextField("Search...", text: $searchText)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
            }
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 15)
                    
                    if isEditing && searchText.isEmpty == false {
                        Button(action: {
                            self.searchText = ""
                        }) {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing)
                        }
                    }
                }
            )
            if isEditing {
                Button("Cancel") {
                    self.isEditing = false
                    self.searchText = ""
                }
                .padding(.trailing)
                .transition(.move(edge: .trailing))
            }
        }
    }
}
