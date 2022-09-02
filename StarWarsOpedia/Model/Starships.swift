import Foundation

struct Starships: Decodable {
  // Stored properties
  //
  var count: Int
  var all: [Starship]
  
  enum CodingKeys: String, CodingKey {
    case count
    case all = "results"
  }
}
