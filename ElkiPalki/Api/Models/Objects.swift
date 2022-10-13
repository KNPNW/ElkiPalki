import Foundation

struct Objects: Codable {
    let objects: [MainInfo]
}

struct Object: Codable {
    let mainInfo: MainInfo?
    let linksOnImages: [LinksOnImages]?
    let prices: Price?
}

// MARK: - MainInfo
struct MainInfo: Codable {
    let id: Int
    let name, size, numberOfRooms, numberOfFloors: String
    let square, linkOnMainImage: String
    let linkOnSite: String
}

// MARK: - LinksOnImage
struct LinksOnImages: Codable {
    let linkOnImage: String
}

// MARK: - Prices
struct Price: Codable {
    let fullFirstPrice, fullSecondPrice, fullThridPrice : String
    let creditFirstPrice, creditSecondPrice, creditThridPrice: String
}




