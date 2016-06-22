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

class CustomViewBase: UIView, SomeProtocol {
    var property: Int = 1
}

class CustomView: CustomViewBase {
    func add() {
        super.add()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("CustomView.layoutSubviews 2")
        // Some specific high end code for CustomView
        add()
    }
}

class CustomCollectionViewCell: UICollectionViewCell, SomeProtocol {
    var property: Int = 2
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("CustomCollectionViewCell.layoutSubviews")
        // Some specific high end code for CustomCollectionViewCell
        add()
    }
}

class SubClassView: CustomView { // Class that can implemented by the third party developer for customisation
    override func add() {
        property += 10
        print("SubClassView.add [property: \(property)]")
    }
}

let view = SubClassView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))

//: [Next](@next)
