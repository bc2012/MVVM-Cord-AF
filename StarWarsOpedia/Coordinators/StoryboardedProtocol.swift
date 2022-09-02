import Foundation
import UIKit

protocol StoryBoardedProtocol {
  static func instantiate() -> Self
}

// Allows us to create ViewControllers in a storyboard with the same storyboard id as their class name
//
// These must match
// When we call someViewController.instantiate() it will use the someViewController as a storyboard id in main.storyboard
// So it will find that ViewController in the storyboard, put out, instantiate it and typecast it
//
extension StoryBoardedProtocol where Self: UIViewController {
  static func instantiate() -> Self {
  
    // A String called UIViewController for the class name UIViewController
    //
    let id = String(describing: self)
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    
    // Forced typecast is safe here
    // The ViewControllers class must always match it's storyboard's id
    return storyboard.instantiateViewController(withIdentifier: id) as! Self
  }
  
}
