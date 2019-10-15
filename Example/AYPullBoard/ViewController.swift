//
//  ViewController.swift
//  AYPullBoard
//
//  Created by antonyereshchenko@gmail.com on 09/27/2019.
//  Copyright (c) 2019 antonyereshchenko@gmail.com. All rights reserved.
//

import UIKit
import AYPullBoard

class ViewController: UIViewController {

    @IBOutlet weak var pullContentView: AYPullBoardView!
    
    private let heightConstant: CGFloat = 64
    
    private var colors: [UIColor] {
        return [
            UIColor(red: 245.0/255.0, green: 124.0/255.0, blue: 124.0/255.0, alpha: 1.0),
            UIColor(red: 245.0/255.0, green: 189.0/255.0, blue: 124.0/255.0, alpha: 1.0),
            UIColor(red: 243.0/255.0, green: 245.0/255.0, blue: 124.0/255.0, alpha: 1.0),
            UIColor(red: 170.0/255.0, green: 245.0/255.0, blue: 124.0/255.0, alpha: 1.0),
            UIColor(red: 124.0/255.0, green: 223.0/255.0, blue: 245.0/255.0, alpha: 1.0),
            UIColor(red: 124.0/255.0, green: 172.0/255.0, blue: 245.0/255.0, alpha: 1.0),
            UIColor(red: 177.0/255.0, green: 124.0/255.0, blue: 245.0/255.0, alpha: 1.0),
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        pullContentView.delegate = self
      
        colors.forEach { [weak self] color in
            let itemView = UIView(frame: .zero)
            itemView.backgroundColor = color
            
            self?.pullContentView.add(view: itemView)
            
            itemView.translatesAutoresizingMaskIntoConstraints = false
            itemView.heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
        }
        
    }

}

extension ViewController: AYPullBoardViewDelegate {
    func didChangeState(isExpanded: Bool) {
        print("State did change: board is \(isExpanded ? "expanded" : "collapsed")")
    }
}

