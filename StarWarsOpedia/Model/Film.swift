import Foundation

struct Film: Decodable {
  
  // Stored properties
  //
  let id: Int
  let title: String
  let openingCrawl: String
  let director: String
  let producer: String
  let releaseDate: String
  let starships: [String]
  
  // CodingKeys is the special enum.
  // It conforms to CodingKey and has String raw values.
  // Here’s where you map one name to another name e.g. openingCrawl maps to opening_crawl
  //
  // If this enum exists, only the cases present here will be used for encoding and decoding,
  // so even if your property doesn’t require mapping, it has to be included in the enum i.e. as title and director are here.
  //
  // The JSON doesn’t depend on your stored properties anymore, thanks to custom coding keys.
  //
  enum CodingKeys: String, CodingKey {
    case id = "episode_id"
    case title
    case openingCrawl = "opening_crawl"
    case director
    case producer
    case releaseDate = "release_date"
    case starships
  }
}

// This extension allows HomeViewController to get the correct labels and values for a Film from the model itself.
//
extension Film: DisplayableProtocol {
  
  // The closure {} sets the value of titleLabelText equal to title
  //
  var titleLabelText: String {
    title
  }
  
  var subtitleLabelText: String {
    "Episode \(String(id))"
  }
  
  var item1: (label: String, value: String) {
    ("DIRECTOR", director)
  }
  
  var item2: (label: String, value: String) {
    ("PRODUCER", producer)
  }
  
  var item3: (label: String, value: String) {
    ("RELEASE DATE", releaseDate)
  }
  
  var listTitle: String {
    "STARSHIPS"
  }
  
  var listItems: [String] {
    starships
  }
}
