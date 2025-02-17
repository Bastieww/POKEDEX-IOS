import CoreData
import SwiftUI

class PokemonFetcher: ObservableObject {
    @Published var pokemons: [Pokemon] = []
    @Published var favorites: [Pokemon] = []
    
    let container: NSPersistentContainer
    
    init(container: NSPersistentContainer) {
        self.container = container
        self.fetchPokemons()
    }
    
    func fetchPokemons() {
        // Simuler une récupération des données de l'API et les ajouter à Core Data
        // Pour l'exemple, on suppose que tu as déjà les Pokémon dans une liste ou venant d'une API.
    }
    
    func toggleFavorite(pokemon: Pokemon) {
        let context = container.viewContext
        let request: NSFetchRequest<PokemonEntity> = PokemonEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", pokemon.id)
        
        do {
            let result = try context.fetch(request)
            if let existingPokemon = result.first {
                existingPokemon.isFavorite.toggle()
                try context.save()
                fetchFavorites()
            }
        } catch {
            print("Erreur lors de la mise à jour du favori : \(error.localizedDescription)")
        }
    }
    
    func fetchFavorites() {
        let context = container.viewContext
        let request: NSFetchRequest<PokemonEntity> = PokemonEntity.fetchRequest()
        request.predicate = NSPredicate(format: "isFavorite == true")
        
        do {
            let result = try context.fetch(request)
            favorites = result.map { pokemon in
                Pokemon(id: Int(bitPattern: pokemon.id), name: pokemon.name ?? "", types: [], stats: [], imageURL: pokemon.imageURL ?? "", isFavorite: pokemon.isFavorite)
            }
        } catch {
            print("Erreur lors de la récupération des favoris : \(error.localizedDescription)")
        }
    }
}
