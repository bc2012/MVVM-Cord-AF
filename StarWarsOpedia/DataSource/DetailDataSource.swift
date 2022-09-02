import Foundation
import UIKit

class DetailDataSource : GenericDataSource<DisplayableProtocol>, UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.value.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
    let item = data.value[indexPath.row]
    cell.textLabel?.text = item.titleLabelText
    return cell
  }
}
