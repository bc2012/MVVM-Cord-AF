import Foundation
import Alamofire

class DetailViewModel: NSObject, DetailViewModelProtocol {
 
  var dataSource: GenericDataSource<DisplayableProtocol>?

  init(dataSource : GenericDataSource<DisplayableProtocol>?) {
      self.dataSource = dataSource
  }
  
  // Since both Film and Starship are Displayable,
  // you can write a generic helper to perform the network request.
  // It needs only to know the type of item its fetching so it can properly decode the result.
  //
  private func fetch<T: Decodable & DisplayableProtocol>(_ list: [String], of: T.Type) {
    var items: [T] = []
    
    // You need to make multiple calls, one per list item,
    // and these calls will be asynchronous and may return out of order.
    // To handle them, you use a dispatch group so you’re notified when all the calls have completed.
    //
    let fetchGroup = DispatchGroup()
    
    // Loop through each item in the list.
    //
    list.forEach { (url) in
      
      // Inform the dispatch group that you are entering.
      //
      fetchGroup.enter()
      
      // Make an Alamofire request to the starship endpoint, validate the response, and
      // decode the response into an item of the appropriate type.
      //
      AF.request(url)
        .validate()
        .responseDecodable(of: T.self) { (response) in
        if let value = response.value {
          items.append(value)
        }
        
        // In the request’s completion handler, inform the dispatch group that you’re leaving.
        //
        fetchGroup.leave()
      }
    }
    
    // Once the dispatch group has received a leave() for each enter(),
    // you ensure you’re running on the main queue, save the list to listData and
    //reload the list table view.
    //
    fetchGroup.notify(queue: .main) {
      self.dataSource?.data.value = items
    }
  }
  
  func fetchList(data: DisplayableProtocol?) {
    // Since data is optional, ensure it’s not nil before doing anything else.
    //
    guard let data = data else { return }
    
    // Use the type of data to decide how to invoke your helper method.
    //
    switch data {
    case is Film:
      // If the data is a Film, the associated list is of starships.
      //
      fetch(data.listItems, of: Starship.self)
    case is Starship:
      fetch(data.listItems, of: Film.self)
    default:
      print("Unknown type: ", String(describing: type(of: data)))
    }
  }
}
