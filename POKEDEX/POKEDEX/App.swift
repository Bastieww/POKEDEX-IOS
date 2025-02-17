import SwiftUI

@main
struct PokedexApp: App {
    // Crée une instance de PersistenceController pour accéder au conteneur Core Data
    let persistenceController = PersistenceController.shared
    
    // Crée une instance de PokemonFetcher en lui passant le conteneur Core Data
    @StateObject private var fetcher = PokemonFetcher(container: PersistenceController.shared.container)

    var body: some Scene {
        WindowGroup {
            // Passe le fetcher à ContentView
            ContentView(fetcher: fetcher)
                .environment(\.managedObjectContext, persistenceController.container.viewContext) // Passe le contexte Core Data
        }
    }
}
