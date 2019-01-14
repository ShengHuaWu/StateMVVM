//
//  UserProfileViewModel.swift
//  StateMVVM
//
//  Created by ShengHua Wu on 14.01.19.
//  Copyright © 2019 ShengHua Wu. All rights reserved.
//

import UIKit

func viewingUserProfileViewModel(event: UserProfileViewController.Event, update: @escaping (UserProfileViewController.State) -> Void) {
    switch event {
    case .viewDidLoad:
        fetchUserProfileForViewing(with: update)
    case .nameDidChange:
        break
    case .confirmDidPress:
        break
    }
}

func editingUserProfileViewModel(event: UserProfileViewController.Event, update: @escaping (UserProfileViewController.State) -> Void) {
    switch event {
    case .viewDidLoad:
        fetchUserProfileForEditing(with: update)
    case .nameDidChange(let name):
        nameDidChangeForEditing(with: name, update: update)
    case .confirmDidPress:
        updateUserProfile(with: update)
    }
}

private func fetchUserProfileForViewing(with update: @escaping (UserProfileViewController.State) -> Void) {
    update(.initial(avatar: UIImage(named: "Wayfair"), name: "Wayfair", confirmEnabled: false, confirmHidden: true))
}

private func fetchUserProfileForEditing(with update: @escaping (UserProfileViewController.State) -> Void) {
    update(.loading)
    
    GlobalEnvironment.apiClient.fetchUserProfile {
        update(.initial(avatar: UIImage(named: "Wayfair"), name: "Wayfair", confirmEnabled: true, confirmHidden: false))
    }
}

private func nameDidChangeForEditing(with name: String?, update: @escaping (UserProfileViewController.State) -> Void) {
    guard let unwrappedName = name else {
        update(.confirmEnabled(false))
        return
    }
    
    update(.confirmEnabled(!unwrappedName.isEmpty))
}

private func updateUserProfile(with update: @escaping (UserProfileViewController.State) -> Void) {
    update(.loading)
    
    GlobalEnvironment.apiClient.updateUserProfile {
        update(.success)
    }
}
