import UIKit
import Alamofire

class DetailViewController: UIViewController, StoryBoardedProtocol {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!
  @IBOutlet weak var item1TitleLabel: UILabel!
  @IBOutlet weak var item1Label: UILabel!
  @IBOutlet weak var item2TitleLabel: UILabel!
  @IBOutlet weak var item2Label: UILabel!
  @IBOutlet weak var item3TitleLabel: UILabel!
  @IBOutlet weak var item3Label: UILabel!
  @IBOutlet weak var listTitleLabel: UILabel!
  @IBOutlet weak var listTableView: UITableView!
  
  weak var coordinator: MainCoordinator?
  
  // Set from HomeVC by prepare(for segue:)
  //
  var data: DisplayableProtocol?
  
  let dataSource = DetailDataSource()
  
  lazy var viewModel : DetailViewModelProtocol = {
    let viewModel = DetailViewModel(dataSource: dataSource)
    return viewModel
  }()
  
  func fillUI() {
    commonInit()
    self.listTableView.delegate = self.dataSource
    self.listTableView.dataSource = self.dataSource
    
    self.dataSource.data.bind{ [unowned self] in
      if $0.count != 0 {
        self.listTableView.reloadData()
      }
    }
    
    viewModel.fetchList(data: data!)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    fillUI()
  }
  
  
  private func commonInit() {
    guard let data = data else { return }
    
    titleLabel.text = data.titleLabelText
    subtitleLabel.text = data.subtitleLabelText
    
    item1TitleLabel.text = data.item1.label
    item1Label.text = data.item1.value
    
    item2TitleLabel.text = data.item2.label
    item2Label.text = data.item2.value
    
    item3TitleLabel.text = data.item3.label
    item3Label.text = data.item3.value
    
    listTitleLabel.text = data.listTitle
  }
  
}
