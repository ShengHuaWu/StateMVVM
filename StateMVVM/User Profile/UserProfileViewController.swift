//
//  UserProfileViewController.swift
//  StateMVVM
//
//  Created by ShengHua Wu on 14.01.19.
//  Copyright © 2019 ShengHua Wu. All rights reserved.
//

import UIKit

final class UserProfileViewController: UIViewController {
    struct ViewModel: Equatable {
        let avatar: UIImage?
        let name: String?
        let confirmEnabled: Bool
        let confirmHidden: Bool
    }
    
    enum State: Equatable {
        case initial(ViewModel)
        case confirmEnabled(Bool)
        case loading
        case success
    }
    
    enum Event {
        case viewDidLoad
        case nameDidChange(name: String?)
        case confirmDidPress(name: String?)
    }
    
    var reducer: Reducer<Event, State>?
    weak var coordinator: CoordinatorInterface?
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .yellow
        
        return imageView
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(nameDidChange), for: .editingChanged)
        
        return textField
    }()
    
    private let confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        button.backgroundColor = .lightGray
        button.setTitle("Confirm", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(confirmDidPress), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        
        view.addSubview(avatarImageView)
        view.addSubview(nameTextField)
        view.addSubview(confirmButton)
        
        configureSubviewsLayout()
        
        reducer?.run(.viewDidLoad, update)
    }
    
    @objc func nameDidChange() {
        reducer?.run(.nameDidChange(name: nameTextField.text), update)
    }
    
    @objc func confirmDidPress() {
        reducer?.run(.confirmDidPress(name: nameTextField.text), update)
    }
}

private extension UserProfileViewController {
    func configureSubviewsLayout() {
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 80),
            avatarImageView.heightAnchor.constraint(equalToConstant: 80),
            nameTextField.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 20),
            nameTextField.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor),
            nameTextField.widthAnchor.constraint(equalToConstant: 300),
            nameTextField.heightAnchor.constraint(equalToConstant: 44),
            confirmButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            confirmButton.centerXAnchor.constraint(equalTo: nameTextField.centerXAnchor),
            confirmButton.widthAnchor.constraint(equalTo: nameTextField.widthAnchor),
            confirmButton.heightAnchor.constraint(equalTo: nameTextField.heightAnchor)
            ])
    }
    
    func update(on state: State) {
        switch state {
        case .initial(let viewModel):
            avatarImageView.image = viewModel.avatar
            nameTextField.text = viewModel.name
            confirmButton.isEnabled = viewModel.confirmEnabled
            confirmButton.isHidden = viewModel.confirmHidden
        case .confirmEnabled(let enabled):
            confirmButton.isEnabled = enabled
        case .loading:
            print("Loading ...")
        case .success:
            print("Succeeded to update user profile")
            coordinator?.finishUpdatingUserProfile()
        }
    }
}
