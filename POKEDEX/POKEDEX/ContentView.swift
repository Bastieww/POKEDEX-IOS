import SwiftUI

struct ContentView: View {
    @StateObject public var fetcher: PokemonFetcher
    @State private var selectedType: String? = nil
    @State private var selectedSortOption: SortOption = .alphabetical
    @State private var searchText: String = ""

    enum SortOption {
        case alphabetical, byStrength, byFavorites
    }

    var filteredPokemons: [Pokemon] {
        var filteredPokemons = fetcher.pokemons.filter { pokemon in
            searchText.isEmpty || pokemon.name.lowercased().contains(searchText.lowercased())
        }

        if let selectedType = selectedType {
            filteredPokemons = filteredPokemons.filter { pokemon in
                pokemon.types.contains { $0.type.name == selectedType }
            }
        }

        switch selectedSortOption {
        case .alphabetical:
            return filteredPokemons.sorted { $0.name.lowercased() < $1.name.lowercased() }
        case .byStrength:
            return filteredPokemons.sorted { pokemon1, pokemon2 in
                let strength1 = pokemon1.stats.reduce(0) { $0 + $1.base_stat }
                let strength2 = pokemon2.stats.reduce(0) { $0 + $1.base_stat }
                return strength1 > strength2
            }
        case .byFavorites:
            return filteredPokemons.sorted { $0.isFavorite && !$1.isFavorite }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                // Barre de recherche
                SearchBar(text: $searchText)
                    .padding()

                // Filtre par type
                Picker("Filtrer par type", selection: $selectedType) {
                    Text("Tous").tag(String?.none)
                    Text("Eau").tag("water" as String?)
                    Text("Feu").tag("fire" as String?)
                    Text("Plante").tag("grass" as String?)
                    Text("Electrik").tag("electric" as String?)
                    // Ajouter d'autres types ici
                }
                .pickerStyle(MenuPickerStyle())
                .padding()

                // Liste déroulante pour le tri
                Picker("Trier par", selection: $selectedSortOption) {
                    Text("Alphabétique").tag(SortOption.alphabetical)
                    Text("Force").tag(SortOption.byStrength)
                    Text("Favoris").tag(SortOption.byFavorites)
                }
                .pickerStyle(MenuPickerStyle())
                .padding()

                // Liste des Pokémon filtrée et triée
                List(filteredPokemons) { pokemon in
                    HStack {
                        AsyncImage(url: URL(string: pokemon.imageURL))
                            .frame(width: 50, height: 50)
                        Text(pokemon.name.capitalized)
                        Spacer()
                        Button(action: {
                            fetcher.toggleFavorite(pokemon: pokemon)
                        }) {
                            Image(systemName: pokemon.isFavorite ? "star.fill" : "star")
                                .foregroundColor(pokemon.isFavorite ? .yellow : .gray)
                        }
                    }
                    .padding()
                }
                .navigationTitle("Pokédex")
            }
        }
    }
}


struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Rechercher un Pokémon", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .padding(.vertical, 10)

            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
                .padding(.trailing)
            }
        }
    }
}
