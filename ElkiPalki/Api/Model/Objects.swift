import Foundation

struct Objects: Codable {
    let objects: [object]
}

struct object: Codable {
    let id: Int
    let name: String
    let size: String
    let numberOfRooms: Int
    let numberOfFloors: String
    let square: Int
    let linkOnMainImage: String
}

//struct linksOnImages: Codable {
//    let links: [link]
//}
//
//struct link: Codable {
//    let linkOnImage: String
//}
//
//struct prices: Codable {
//    let fullFirstPrice: String
//    let fullSecondPrice: String
//    let fullThridPrice: String
//    let creditFirstPrice: String
//    let creditSecondPrice: String
//    let creditThridPrice: String
//}
//
//
//struct object: Codable {
//    let info: mainInfo
//    let links: linksOnImages
//    let prices: prices
//}


