//
//  ImageLoader.swift
//  Pokemon
//
//  Created by Amol Pimpare on 03/01/21.
//  Copyright © 2021 Amol Pimpare. All rights reserved.
//

import Foundation
import Combine

public class ImageLoader: ObservableObject {
    private var cancellables: AnyCancellable?
    
    public var didChange = PassthroughSubject<Data, Never>()
    public var data = Data() {
        didSet {
            didChange.send(data)
        }
    }
    
    public init(urlString: String) {
        fetchImage(at: urlString)
    }
    
    private func fetchImage(at urlString: String) {
        guard let url = URL(string: urlString) else { return }
        cancellables = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { data in
                self.data = data
            })
    }
}
