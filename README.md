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


### Sample Apps - Pokemon

Checkout sample app `Pokemon` in examples folder. It provides follwoing functionalities 

- Search for pokemon an
- Long press on searched result to add it to favrites
- Showpokemon detials with Shakespearean description and image
 

## TODO

- Improve Error handlling
- Add unit tests
- Create swift pakage to distribute binary SDK



## Author

Amol Pimpare, pimpareac@gmail.com
