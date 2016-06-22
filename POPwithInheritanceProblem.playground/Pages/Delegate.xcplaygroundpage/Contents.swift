//: Playground - noun: a place where people can play

import UIKit

protocol Functionality: class {
    func add()
}

// Default implementation
extension SomeProtocol where Self: UIView {
    func add() {
        property = -5
        print("Functionality.add [property = \(property)]")
    }
}

protocol SomeProtocol: class {
    var property: Int { get set }
    var delegate: Functionality? { get set }
}

class CustomView: UIView, SomeProtocol {
    var property: Int = 1
    weak var delegate: Functionality?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("CustomView.layoutSubviews")
        // Some specific high end code for CustomView
        if let delegate = delegate {
            delegate.add()
        } else {
            self.add()
        }
    }
}

class CustomCollectionViewCell: UICollectionViewCell, SomeProtocol {
    var property: Int = 2
    weak var delegate: Functionality?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("CustomCollectionViewCell.layoutSubviews")
        // Some specific high end code for CustomCollectionViewCell
        if let delegate = delegate {
            delegate.add()
        } else {
            self.add()
        }
    }
}

class SubClassView: CustomView { // Class that can implemented by the third party developer for customisation
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SubClassView: Functionality {
    func add() {
        property = 5
        print("SubClassView.add [property = \(property)]")
    }
    func doNothing() { print("SubClassView.doNothing [\(property)]") }
}

let view = SubClassView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
