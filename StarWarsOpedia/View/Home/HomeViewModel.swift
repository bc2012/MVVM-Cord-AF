import Foundation
import Alamofire

class HomeViewModel: NSObject, HomeViewModelProtocol {
  
  weak var dataSource : GenericDataSource<DisplayableProtocol>?
  private var filmsCache: [Film] = []

  init(dataSource : GenericDataSource<DisplayableProtocol>?) {
      self.dataSource = dataSource
  }

  func fetchFilms() {
    // Alamofire uses method chaining, which works by connecting the response
    // of one method as the input of another.
    // This not only keeps the code compact, but it also makes your code clearer.
    //
    // This single line not only does exactly what took multiple lines to do before,
    // but you also added validation.
    //
    // From top to bottom, you request the endpoint,
    // validate the response by ensuring the response returned an HTTP status code in the range 200–299 and
    // decode the response into your data model.
    //
    //
    AF.request("https://swapi.dev/api/films")
      .validate()
      .responseDecodable(of: Films.self) { (response) in
        guard let films = response.value else { return }
        self.dataSource?.data.value = films.all
        self.filmsCache = films.all
      }
  }
  
  func searchStarships(for name: String) {
    // Sets the URL that you’ll use to access the starship data.
    //
    let url = "https://swapi.dev/api/starships"
    
    // Sets the key-value parameters that you’ll send to the endpoint.
    //
    let parameters: [String: String] = ["search": name]
    
    // Here, you’re making a request like before, but this time you’ve added parameters.
    // You’re also performing a validate and decoding the response into Starships.
    //
    // Executing this request results in a URL https://swapi.dev/api/starships?search={name}
    // where {name} is the search query passed in.
    //
    AF.request(url, parameters: parameters)
      .validate()
      .responseDecodable(of: Starships.self) { response in
        // Finally, once the request completes, you assign the list of starships
        // as the table view’s data and reload the table view.
        //
        guard let starships = response.value else { return }
        self.dataSource?.data.value = starships.all
        //self.items = starships.all
        //self.tableView.reloadData()
    }
  }
  
  func useFilmsCache() {
    self.dataSource?.data.value = self.filmsCache
  }

}
