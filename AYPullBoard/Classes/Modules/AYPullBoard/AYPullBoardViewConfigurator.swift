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

//MARK: AYPullBoardViewConfigurator class
class AYPullBoardViewConfigurator: NSObject {
    
    //MARK: - AYConfiguratorDefault fileprivate struct
    fileprivate struct AYConfiguratorDefault {
        static let pullViewHeight: CGFloat = 32
        static let itemsSpacing: CGFloat = 10
    }
    
    //MARK: - properties
    weak var view: AYPullBoardView?
    var delegate: AYPullBoardViewDelegate?
  
    var draggingAnimationDuration: Double = 0.16
    var movingAnimationDuration: Double = 0.64
    
    //MARK: - init
    init(view: AYPullBoardView?) {
        self.view = view
    }
    
    //MARK: - methods
    func setup(with finalPosition: CGFloat = 0.08,
               and initialPosition: CGFloat = 0.64) {
        
        guard let view = view else { return }
        
        view.setInitialYPercentBoard(position: max(initialPosition, finalPosition))
        view.setFinalYPercentBoard(position: min(initialPosition, finalPosition))
        
        let pullView = AYPullControlView(frame: .zero)
        view.addSubview(pullView)
        
        pullView.add(arrow: AYDirectionalLineView(frame: .zero))
        
        pullView.translatesAutoresizingMaskIntoConstraints = false
        
        pullView.heightAnchor.constraint(
            equalToConstant: AYConfiguratorDefault.pullViewHeight
            ).isActive = true
        
        pullView.topAnchor.constraint(
            equalTo: view.topAnchor
            ).isActive = true
        
        pullView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor
            ).isActive = true
        
        pullView.trailingAnchor.constraint(
            equalTo: view.trailingAnchor
            ).isActive = true
        
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(AYPullBoardViewConfigurator.pullViewTouchUpInside(gestureRecognizer:))
        )
        
        let panGesture = UIPanGestureRecognizer(
            target: self,
            action: #selector(AYPullBoardViewConfigurator.wasDragged(gestureRecognizer:))
        )
        
        pullView.addGestureRecognizer(tapGesture)
        pullView.addGestureRecognizer(panGesture)
        pullView.isUserInteractionEnabled = true
        
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = AYConfiguratorDefault.itemsSpacing
        
        let scrollView = UIScrollView(frame: .zero)
        scrollView.delegate = self
        scrollView.addSubview(stackView)
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.topAnchor.constraint(
            equalTo: stackView.topAnchor
            ).isActive = true
        
        scrollView.bottomAnchor.constraint(
            equalTo: stackView.bottomAnchor
            ).isActive = true
        
        scrollView.leadingAnchor.constraint(
            equalTo: stackView.leadingAnchor
            ).isActive = true
        
        scrollView.trailingAnchor.constraint(
            equalTo: stackView.trailingAnchor
            ).isActive = true
        
        scrollView.widthAnchor.constraint(
            equalTo: stackView.widthAnchor
            ).isActive = true
        
        let heightAnchor = scrollView.heightAnchor.constraint(equalTo: stackView.heightAnchor)
        heightAnchor.priority = .defaultLow
        heightAnchor.isActive = true
        
        view.pullControlView = pullView
        view.itemsView = stackView

        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.topAnchor.constraint(
            equalTo: pullView.bottomAnchor
            ).isActive = true
        
        scrollView.bottomAnchor.constraint(
            equalTo: view.bottomAnchor
            ).isActive = true
        
        scrollView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor
            ).isActive = true
        
        scrollView.trailingAnchor.constraint(
            equalTo: view.trailingAnchor
            ).isActive = true
    }
    
    func configurateTopConstraint() {
        guard let view = view, let superview = view.superview else { return }
        
        if view.outerTopConstraint == nil {
            view.translatesAutoresizingMaskIntoConstraints = false
            view.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            view.superview?.layoutIfNeeded()
        }
        
        guard let topConstraint = view.outerTopConstraint else { return }
        topConstraint.constant = view.initialYValueBoardPosition
        view.superview?.layoutIfNeeded()
    }
    
}

//MARK: - UIScrollViewDelegate
extension AYPullBoardViewConfigurator: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
}

//MARK: - AYPullBoardViewConfigurator fileprivate extension
fileprivate extension AYPullBoardViewConfigurator {
    @objc func wasDragged(gestureRecognizer: UIPanGestureRecognizer) {
        guard let view = view,
            let constraint = view.outerTopConstraint,
            let containerView = gestureRecognizer.view as? AYPullControlView else { return }
        
        let translation = gestureRecognizer.translation(in: containerView)
        
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            containerView.arrow?.update(direction: .straight)
            UIView.animate(withDuration: draggingAnimationDuration) {
                constraint.constant += translation.y
                view.superview?.layoutIfNeeded()
            }
        } else if gestureRecognizer.state == .ended || gestureRecognizer.state == .cancelled {
            let centerY = (view.finalYValueBoardPosition + view.initialYValueBoardPosition) / 2
            if constraint.constant < view.finalYValueBoardPosition ||
                constraint.constant < centerY {
                delegate?.didChangeState(isExpanded: true)
                containerView.arrow?.update(direction: .down)
                UIView.animate(withDuration: movingAnimationDuration) {
                    constraint.constant = view.finalYValueBoardPosition
                    view.superview?.layoutIfNeeded()
                }
            } else if constraint.constant > view.initialYValueBoardPosition ||
                constraint.constant > centerY {
                delegate?.didChangeState(isExpanded: false)
                containerView.arrow?.update(direction: .up)
                UIView.animate(withDuration: movingAnimationDuration) {
                    constraint.constant = view.initialYValueBoardPosition
                    view.superview?.layoutIfNeeded()
                }
            }
        }
        gestureRecognizer.setTranslation(.zero, in: containerView)
    }
    
    @objc func pullViewTouchUpInside(gestureRecognizer: UITapGestureRecognizer) {
        guard let view = view,
            let constraint = view.outerTopConstraint,
            let containerView = gestureRecognizer.view as? AYPullControlView else { return }
        
        if constraint.constant == view.initialYValueBoardPosition {
            delegate?.didChangeState(isExpanded: true)
            containerView.arrow?.update(direction: .down)
            UIView.animate(withDuration: movingAnimationDuration) {
                constraint.constant = view.finalYValueBoardPosition
                view.superview?.layoutIfNeeded()
            }
        } else {
            delegate?.didChangeState(isExpanded: false)
            containerView.arrow?.update(direction: .up)
            UIView.animate(withDuration: movingAnimationDuration) {
                constraint.constant = view.initialYValueBoardPosition
                view.superview?.layoutIfNeeded()
            }
        }
    }
}

