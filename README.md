# PokemonSDK
Pokemon API - Uses Combine and SwiftUI framework starting in iOS 13.


## About SDK

PokemonSDK provide Swift API for fetching Pokemon from PokéAPI (https://pokeapi.co/docs/v2). It also provide API for translating given text into its Shakespearean description. Lastly it provide built-in UI to display remmote image and Pokemon details such as sprite, name, and description.

## Usage

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


## Author

Amol Pimpare, pimpareac@gmail.com
