# PokemonSDK
Pokemon API - Uses Combine and SwiftUI framework starting in iOS 13.


## About SDK

PokemonSDK provide Swift API for fetching Pokemon from PokéAPI (https://pokeapi.co/docs/v2). It also provide API for translating given text into its Shakespearean description. Lastly it provide built-in UI to display remmote image and Pokemon details such as sprite, name, and description.

## Usage

1. Downloading PokemonSDK.xcframework-1.0.0.zip and unarchive.
2. Add unarchived PokemonSDK.xcframework into your porojects embeded frameworks section.

Use the `PokemonAPI` class to access Pokenmon and translation web services.

## Examples

```swift

import PokemonSDK

// Example of calling a fetchPokemon service using pokemon name
PokemonAPI().pokemonService.fetchPokemon("Pikachu")
  .sink(receiveCompletion: { completion in
    if case .failure(let error) = completion {
        print(error.localizedDescription)
    }
  }, receiveValue: { pokemon in
      print(pokemon.sprites)
  })

```

```swift
// Example of calling a translation web service
PokemonAPI().translatorService.translate("Text to be translated")
  .sink(receiveCompletion: { completion in
      if case .failure(let error) = completion {
          print(error.localizedDescription)
      }
  }, receiveValue: { description in
        print(description)
  })
```


### Response

All webservices functions return an `AnyPublisher`. Success values decoded from the JSON response. Errors returned as `HTTPError`.


### How to Run Sample Apps - `Pokemon`

- Search for pokemon an
- Long press on searched result to add it to favrites
- Showpokemon detials with Shakespearean description and image

Steps

1. Download sample `Pokemon` app in examples folder. Open `Pokemon.xcodeproj` in Xcode and install it on device
2. Launch application, You will see `Search Screen`
3. Tap into search field to seach for pokemon. You will see loading indicator and then will see 
4. Long press on Row, to add it to favorites.
5. Tap on each row to navigate to pokemon details.


## TODO

- Improve Error handlling
- Add unit tests
- Create swift pakage to distribute binary SDK



## Author

Amol Pimpare, pimpareac@gmail.com
