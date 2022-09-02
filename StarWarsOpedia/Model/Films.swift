import Foundation

struct Films: Decodable {
  // Stored properties
  //
  let count: Int
  let all: [Film]
  
  enum CodingKeys: String, CodingKey {
    case count
    case all = "results"
  }
}
