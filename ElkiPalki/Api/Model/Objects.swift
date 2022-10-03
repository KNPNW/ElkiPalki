import Foundation

struct Objects: Codable {
    let objects: [object]
}

struct object: Codable {
    let name: String
    let size: String
    let numberOfRooms: Int
    let numberOfFloors: String
    let square: Int
    let linkOnMainImage: String
}
