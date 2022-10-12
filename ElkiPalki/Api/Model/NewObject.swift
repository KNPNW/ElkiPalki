import Foundation

struct NewObject: Codable {
    let mainInfo: info
    let linksOnImages: [link]
    let prices: price
}

struct info: Codable {
    let id: Int
    let name: String
    let size: String
    let numberOfRooms: Int
    let numberOfFloors: String
    let square: Int
    let linkOnMainImage: String
}

struct links: Codable {
    let links: [link]
}

struct link: Codable {
    let linkOnImage: String
}

struct price: Codable {
    let fullFirstPrice: String
    let fullSecondPrice: String
    let fullThridPrice: String
    let creditFirstPrice: String
    let creditSecondPrice: String
    let creditThridPrice: String
}




