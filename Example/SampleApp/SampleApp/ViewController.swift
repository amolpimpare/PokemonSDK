//
//  ViewController.swift
//  SampleApp
//
//  Created by Amol Pimpare on 01/01/21.
//

import UIKit
import PokemonSDK
import Combine

class ViewController: UIViewController {
    var cancellable: AnyCancellable?
    
    @IBOutlet var translatedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cancellable = PokemonAPI().translatorService.translate("Hello sir! my mother goes with me to the ocean.")
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print(error.localizedDescription)
                }
            }, receiveValue: { description in
                self.translatedLabel.text = description.contents.translated.removingPercentEncoding
            })
    }
}

