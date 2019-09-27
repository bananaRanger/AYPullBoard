// MIT License
//
// Copyright (c) 2019 Anton Yereshchenko
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit

extension UIView {
    public func addAllSidesAnchors(to parent: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        rightAnchor.constraint(equalTo: parent.rightAnchor).isActive = true
        bottomAnchor.constraint(equalTo: parent.bottomAnchor).isActive = true
        leftAnchor.constraint(equalTo: parent.leftAnchor).isActive = true
        topAnchor.constraint(equalTo: parent.topAnchor).isActive = true
    }
}

extension UIView {
    var innerTopConstraint: NSLayoutConstraint? {
        return innerTopConstraint(for: self)
    }
    
    var outerTopConstraint: NSLayoutConstraint? {
        return outerTopConstraint(for: self)
    }
    
    func innerTopConstraint(for view: UIView) -> NSLayoutConstraint? {
        var top: NSLayoutConstraint? = nil
        let currentType = type(of: view)
        constraints.forEach { constraint in
            guard let firstItem = constraint.firstItem,
                let secondItem = constraint.secondItem
                else { return }
            
            if constraint.firstAttribute == .top &&
                ((firstItem.isMember(of: currentType)) ||
                    (secondItem.isMember(of: currentType)))  {
                top = constraint
                return
            }
        }
        return top
    }
    
    func outerTopConstraint(for view: UIView) -> NSLayoutConstraint? {
        var top: NSLayoutConstraint? = nil
        let currentType = type(of: view)
        superview?.constraints.forEach { constraint in
            guard let firstItem = constraint.firstItem,
                let secondItem = constraint.secondItem
                else { return }
            
            if constraint.firstAttribute == .top &&
                ((firstItem.isMember(of: currentType)) ||
                    (secondItem.isMember(of: currentType)))  {
                top = constraint
                return
            }
        }
        return top
    }
}
