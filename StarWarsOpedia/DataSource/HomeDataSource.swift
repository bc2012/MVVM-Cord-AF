import Foundation
import UIKit

class HomeDataSource : GenericDataSource<DisplayableProtocol>, UITableViewDataSource, UITableViewDelegate {
  
  var coordinator: MainCoordinator?
  var selectedItem: DisplayableProtocol?
  
  func setCoordinator(coordinator: MainCoordinator) {
    self.coordinator = coordinator
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.value.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath)
    let item = data.value[indexPath.row]
    cell.textLabel?.text = item.titleLabelText
    cell.detailTextLabel?.text = item.subtitleLabelText
    return cell
  }
  
  /*
  func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    selectedItem = data.value[indexPath.row]
    return indexPath
  }
  */
  
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectedItem = data.value[indexPath.row]
    coordinator?.showDetail(data: selectedItem)
  }
  
}
