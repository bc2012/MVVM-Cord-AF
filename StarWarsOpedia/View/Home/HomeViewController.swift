import UIKit

class HomeViewController: UITableViewController, StoryBoardedProtocol {
  @IBOutlet weak var searchBar: UISearchBar!
  
  weak var coordinator: MainCoordinator?
  
  let dataSource = HomeDataSource()
  
  lazy var viewModel : HomeViewModelProtocol = {
    let viewModel = HomeViewModel(dataSource: dataSource)
    return viewModel
  }()
  
  func fillUI(){
    self.searchBar.delegate = self
    self.tableView.delegate = self.dataSource
    self.tableView.dataSource = self.dataSource
    
    dataSource.setCoordinator(coordinator: coordinator!)
    
    self.dataSource.data.bind{ [unowned self] in
      if $0.count != 0 {
        self.tableView.reloadData()
      }
    }
    
    viewModel.fetchFilms()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    fillUI()
  }
}

// MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let shipName = searchBar.text else { return }
    viewModel.searchStarships(for: shipName)
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.text = nil
    searchBar.resignFirstResponder()
    viewModel.useFilmsCache()
  }
}
