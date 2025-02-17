import CoreData
import SwiftUI

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Pokédex")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to load store: \(error.localizedDescription)")
            }
        }
    }
    
    func save() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save context: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchPokemons() -> [PokemonEntity] {
        let context = container.viewContext
        let request: NSFetchRequest<PokemonEntity> = PokemonEntity.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch Pokémon: \(error.localizedDescription)")
            return []
        }
    }
}
