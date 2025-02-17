import Foundation

// Modèle de Pokémon qui correspond à l'entité Core Data
struct Pokemon: Identifiable {
    var id: Int
    var name: String
    var types: [PokemonType]
    var stats: [PokemonStat]
    var imageURL: String
    var isFavorite: Bool = false
}

struct PokemonType: Identifiable {
    var id: String { return type.name }
    var type: PokemonTypeInfo
}

struct PokemonTypeInfo: Codable {
    var name: String
}

struct PokemonStat: Identifiable {
    var id: String { return stat.name }
    var stat: StatInfo
    var base_stat: Int
}

struct StatInfo: Codable {
    var name: String
}
