//
//  DisplayView.swift
//  GRDBex-MVC
//
//  Created by Nathan Reilly on 11/3/21.
//

import UIKit

class DisplayView: UIView, DisplayViewProtocol {
    
    let displayLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 2
        label.preferredMaxLayoutWidth = label.frame.width
        label.textAlignment = .center
        
        return label
    }()
    
    let showButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Show All People", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let returnButton: UIButton = { 
        let button = UIButton(type: .system)
        
        button.setTitle("Return", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var controller: DisplayViewController?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    func commonInit() {
        backgroundColor = .white
        
        let views = [displayLabel, showButton, returnButton]
        
        for view in views {
            addSubview(view)
        }
        
        showButton.addTarget(self, action: #selector(showTouchUpInside), for: .touchUpInside)
        returnButton.addTarget(self, action: #selector(returnTouchUpInside), for: .touchUpInside)
        
        activateConstraints()
    }
    
    func setController(controller: DisplayViewController) {
        self.controller = controller
    }
    
    func activateConstraints() {
        let constraintsArray: [NSLayoutConstraint] = [displayLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor), displayLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 260), showButton.topAnchor.constraint(equalTo: displayLabel.bottomAnchor, constant: 20), showButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor), returnButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor), returnButton.topAnchor.constraint(equalTo: showButton.bottomAnchor, constant: 7)]
        
        NSLayoutConstraint.activate(constraintsArray)
    }
    
    @objc func showTouchUpInside() {
        self.controller?.presentPersonTableVC()
    }
    
    @objc func returnTouchUpInside() {
        self.controller?.returnToRegisterVC()
    }

}
