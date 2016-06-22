//: [Previous](@previous)

import UIKit

struct BaseFunctionality<T: UIView where T: SomeProtocol> {
    var add: (T) -> Void
    init() {
        add = { (view) in
            view.property += Int(view.frame.width)
            print("BaseFunctionality [property: \(view.property)]")
        }
    }
}

protocol SomeProtocol: class {
    var property: Int { get set }
}

class CustomView: UIView, SomeProtocol {
    var property: Int = 1
    var baseFunc = BaseFunctionality<CustomView>()

    override func layoutSubviews() {
        super.layoutSubviews()
        print("CustomView.layoutSubviews")
        // Some specific high end code for CustomView
        baseFunc.add(self)
    }
}

class CustomCollectionViewCell: UICollectionViewCell, SomeProtocol {
    var property: Int = 2
    var baseFunc = BaseFunctionality<CustomCollectionViewCell>()

    override func layoutSubviews() {
        super.layoutSubviews()
        print("CustomCollectionViewCell.layoutSubviews")
        // Some specific high end code for CustomCollectionViewCell
        baseFunc.add(self)
    }

}

class SubClassView: CustomView { // Class that can implemented by the third party developer for customisation

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.baseFunc.add = { (view) in
            view.property -= Int(view.frame.width)
            print("SubClassView [property: \(view.property)]")
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

let view = SubClassView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))

//: [Next](@next)
