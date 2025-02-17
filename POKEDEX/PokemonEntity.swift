import Foundation
import CoreData

@objc(PokemonEntity)
public class PokemonEntity: NSManagedObject {
    
    @NSManaged public var attack: Int16
    @NSManaged public var defense: Int16
    @NSManaged public var hp: Int16
    @NSManaged public var id: Int32
    @NSManaged public var imageURL: String
    @NSManaged public var name: String
    @NSManaged public var speed: Int16
    @NSManaged public var types: [String]
}
