//
// https://codepen.io/wangdu1005/pen/abboLZX
//

import Foundation

// This is an example of 'boxing'
// https://en.wikipedia.org/wiki/Boxing_(computer_science)#Boxing

// Marked it as a generic class by appending <T>
//
// Our Dynamic type can now wrap any other type and expand it with the listener mechanism.
// let name = Observable("Steve")
// let alive = Observable(false)
// let products = Observable(["Macintosh", "iPod", "iPhone"])
//
// products.bind {
//  println("First product is \($0.first)")
// }
//
class Observable<T> {
    // Use a typealias command to introduce a new type, Listener,
    // which is a closure that accepts a Generic Type and returns nothing.
    //
    // Generics enables us to write flexible, reusable functions and types
    // that can work with any type.
    //
    typealias Listener = (T) -> ()
    
    // With that type we declare a listener property,
    // making it an Optional so it’s not required to be set
    // (our Observable object does not have to have a listener).
    //
    var listener: Listener?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    var value: T {
        // Use property observer to inform interested parties, let’s call them listeners, that change occurred.
        // Listeners in the MVVM are view controllers.
        // A VC is interested in changes in ViewModel so that it can update its views accordingly.
        //
        didSet {
            // When the value changes let the listener know too
            //
            listener?(value)
        }
    }
    
    // Using Parameters without External Name
    // When an external name is not needed for an initializer,
    // underscore ‘_’ is used to indicate the same, as shown below.
    //
    init(_ v: T) {
        value = v
    }
}
