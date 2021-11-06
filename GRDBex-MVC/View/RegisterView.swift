//
//  RegisterView.swift
//  GRDBex-MVC
//
//  Created by Nathan Reilly on 11/2/21.
//

import UIKit

class RegisterView: UIView, RegisterViewProtocol, UITextFieldDelegate {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "GRDBex"
        label.font = .boldSystemFont(ofSize: 25)
        label.preferredMaxLayoutWidth = label.frame.width
        label.textAlignment = .center
        
        return label
    }()
    
    let promptLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Enter your full name"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 1
        label.preferredMaxLayoutWidth = label.frame.width
        label.textAlignment = .center
        
        return label
    }()
    
    let firstNameField: UITextField = {
        let textField = UITextField()
    
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "first name"
        textField.autocorrectionType = .no
        textField.borderStyle = .roundedRect
        textField.textAlignment = .left
    
        return textField
    }()
    
    let lastNameField: UITextField = {
        let textField = UITextField()
    
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "last name"
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.textAlignment = .left
    
        return textField
    }()
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Save To Database", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Next", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true // Consider unenabling button and making grey until needed instead
        
        return button
    }()
    
    var controller: RegisterViewController?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    func commonInit() {
        self.backgroundColor = .white
        
        firstNameField.delegate = self
        lastNameField.delegate = self
        
        let views = [titleLabel, promptLabel, firstNameField, lastNameField, registerButton, nextButton]
        
        for view in views {
            addSubview(view)
        }
        
        addTargetsToButtons()
        activateConstraints()
    }
    
    func getFirstName() -> String? {
        if let firstName = firstNameField.text {
            return firstName
        } else {
            return nil
        }
    }
    
    func getLastName() -> String? {
        if let lastName = lastNameField.text {
            return lastName
        } else {
            return nil
        }
    }
    
    func addTargetsToButtons() {
        registerButton.addTarget(self, action: #selector(registerTouchUpInside), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextTouchUpInside), for: .touchUpInside)
    }
    
    func activateConstraints() {
        let constraintsArray: [NSLayoutConstraint] = [titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8), titleLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor), promptLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 37), promptLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor), firstNameField.topAnchor.constraint(equalTo: promptLabel.bottomAnchor, constant: 47), firstNameField.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor), firstNameField.widthAnchor.constraint(equalToConstant: 265), lastNameField.topAnchor.constraint(equalTo: firstNameField.bottomAnchor, constant: 6), lastNameField.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor), lastNameField.widthAnchor.constraint(equalToConstant: 265), registerButton.topAnchor.constraint(equalTo: lastNameField.bottomAnchor, constant: 42), registerButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor), nextButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 7), nextButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)]
        
        NSLayoutConstraint.activate(constraintsArray)
    }
    
    func setController(controller: RegisterViewController) {
        self.controller = controller
    }
    
    @objc func registerTouchUpInside() {
        self.controller?.registerPerson()
        nextButton.isHidden = false
    }
    
    @objc func nextTouchUpInside() {
        self.controller?.pushToDisplayVC()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == " ") {
            return false
        } else {
            return true
        }
    }

}
