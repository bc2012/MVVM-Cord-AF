import Foundation

protocol HomeViewModelProtocol {
  func fetchFilms()
  func searchStarships(for name: String)
  func useFilmsCache()
}
