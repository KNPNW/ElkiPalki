import Foundation

struct Objects: Codable {
    let objects: [Info]
}

struct Object: Codable {
    let mainInfo: Info?
    let linksOnImages: [Link]?
    let prices: Price?
}

struct Info: Codable {
    let id: Int
    let name: String
    let size: String
    let numberOfRooms: String
    let numberOfFloors: String
    let square: String
    let linkOnMainImage: String
}

struct Links: Codable {
    let links: [Link]
}

struct Link: Codable {
    let linkOnImage: String
}

struct Price: Codable {
    let fullFirstPrice: String
    let fullSecondPrice: String
    let fullThridPrice: String
    let creditFirstPrice: String
    let creditSecondPrice: String
    let creditThridPrice: String
}




