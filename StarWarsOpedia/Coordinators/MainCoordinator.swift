import Foundation
import UIKit

class MainCoordinator: CoordinatorProtocol {
  var childCoordinators = [CoordinatorProtocol]()
  var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let vc = HomeViewController.instantiate()
    vc.coordinator = self
    navigationController.pushViewController(vc, animated: false)
  }
  
  func showDetail(data: DisplayableProtocol?) {
    let vc = DetailViewController.instantiate()
    vc.coordinator = self
    vc.data = data
    navigationController.pushViewController(vc, animated: true)
  }
}
