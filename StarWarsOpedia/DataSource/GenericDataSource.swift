// A generic dataSource that we can reuse regardless the data we would like to update.
//
// https://benoitpasquier.com/ios-swift-mvvm-pattern/
//
import Foundation

class GenericDataSource<T> : NSObject {
  // It’s OK to declare these properties as constants with let since you won’t change the actual property.
  //You will change the value property on the Observable object.
  //
  let data: Observable<[T]> = Observable([])
}
