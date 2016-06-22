//: [Previous](@previous)

import UIKit

protocol SomeProtocol: class {
    var property: Int { get set }
    func add() // Method that can be override for custom behaviour
}

extension SomeProtocol where Self: UIView {
    // Default implementation
    func add() {
        property += Int(frame.width)
        print("SomeProtocol.add [property: \(property)]")
    }
}

class CustomView: UIView, SomeProtocol {
    var property: Int = 1
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("CustomView.layoutSubviews")
        // Some specific high end code for CustomView
        add() // Here will be always called method from extension even if subclass of the CustomView implements add method
    }
}

class CustomCollectionViewCell: UICollectionViewCell, SomeProtocol {
    var property: Int = 2
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("CustomCollectionViewCell.layoutSubviews")
        // Some specific high end code for CustomCollectionViewCell
        add() // Here will be always called method from extension even if subclass of the CustomCollectionViewCell implements add method
    }
    
}

// Class that can implemented by the third party developer for customisation
class SubClassView: CustomView {
    // PROBLEM is that this methow will not be called
    func add() {
        property += 10
        print("SubClassView.add [property: \(property)]")
    }
}

let view = SubClassView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
// prints:
// CustomView.layoutSubviews
// SomeProtocol.add [property: 101]

// but expected is to print "SubClassView.add [property: 12]"

//: [Next](@next)
