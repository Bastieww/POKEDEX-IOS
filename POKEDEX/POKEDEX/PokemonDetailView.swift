import SwiftUI

struct PokemonDetailView: View {
    var pokemon: Pokemon
    
    var body: some View {
        VStack {
            // Affichage de l'image du Pokémon
            AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemon.id).png"))
                .frame(width: 200, height: 200)
                .padding()
            
            Text(pokemon.name.capitalized)
                .font(.largeTitle)
                .bold()
                .padding(.bottom)
            
            // Affichage des types
            Text("Types:")
                .font(.headline)
            ForEach(pokemon.types, id: \.type.name) { type in
                Text(type.type.name.capitalized)
                    .padding(5)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(8)
            }
            
            // Affichage des statistiques
            Text("Stats:")
                .font(.headline)
            ForEach(pokemon.stats, id: \.stat.name) { stat in
                HStack {
                    Text(stat.stat.name.capitalized)
                        .frame(width: 120, alignment: .leading)
                    Text("\(stat.base_stat)")
                }
                .padding(.vertical, 2)
            }
            
            // Bouton pour ajouter en favoris (à implémenter)
            Button(action: {
                // Ajouter à CoreData ou à la liste des favoris
            }) {
                Text("Ajouter aux favoris")
                    .font(.title2)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle(pokemon.name.capitalized)
    }
}

