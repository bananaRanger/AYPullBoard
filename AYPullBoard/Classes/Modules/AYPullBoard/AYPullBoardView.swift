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

//MARK: AYPullBoardView class
public class AYPullBoardView: UIView {
    
    //MARK: - properties
    public var pullControlView: AYPullControlView?
    public var itemsView: UIStackView?

    public var initialYValueBoardPosition: CGFloat {
        return screenHeight.number(with: _initialPercentBoardPosition)
    }
    
    public var finalYValueBoardPosition: CGFloat {
        return screenHeight.number(with: _finalPercentBoardPosition)
    }
    
    private var configurator: AYPullBoardViewConfigurator?
    
    private var _initialPercentBoardPosition: CGFloat = 0
    private var _finalPercentBoardPosition: CGFloat = 0
    
    private var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    //MARK: - init
    init(with finalPosition: CGFloat,
         and initialPosition: CGFloat) {
        super.init(frame: .zero)
        self.configurator = AYPullBoardViewConfigurator(view: self)
        self.configurator?.setup(with: initialPosition, and: finalPosition)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configurator = AYPullBoardViewConfigurator(view: self)
        self.configurator?.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configurator = AYPullBoardViewConfigurator(view: self)
        self.configurator?.setup()
    }
    
    //MARK: - methods
    override public func updateConstraints() {
        super.updateConstraints()
        configurator?.configurateTopConstraint()
    }
    
    public func add(view: UIView) {
        itemsView?.addArrangedSubview(view)
    }
    
    public func remove(view: UIView) {
        itemsView?.removeArrangedSubview(view)
    }
    
    public func setInitialYPercentBoard(position: CGFloat) {
        _initialPercentBoardPosition = position
        configurator?.configurateTopConstraint()
    }
    
    public func setFinalYPercentBoard(position: CGFloat) {
        _finalPercentBoardPosition = position
        configurator?.configurateTopConstraint()
    }
    
}
