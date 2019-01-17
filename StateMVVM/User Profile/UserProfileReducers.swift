//
//  UserProfileViewModel.swift
//  StateMVVM
//
//  Created by ShengHua Wu on 14.01.19.
//  Copyright © 2019 ShengHua Wu. All rights reserved.
//

import UIKit

func makeViewingUserProfileReducer(with userID: Int) -> Reducer<UserProfileViewController.Event, UserProfileViewController.State> {
    return Reducer { event, update in
        switch event {
        case .viewDidLoad:
            fetchUserProfileForViewing(with: userID, update: update)
        case .nameDidChange:
            break
        case .confirmDidPress:
            break
        }
    }
}

func makeEditingUserProfileReducer(with userID: Int) -> Reducer<UserProfileViewController.Event, UserProfileViewController.State> {
    return Reducer { event, update in
        switch event {
        case .viewDidLoad:
            fetchUserProfileForEditing(with: userID, update: update)
        case .nameDidChange(let name):
            nameDidChangeForEditing(with: name, update: update)
        case .confirmDidPress:
            updateUserProfileForEditing(with: update)
        }
    }
}

private func fetchUserProfileForViewing(with userID: Int, update: @escaping (UserProfileViewController.State) -> Void) {
    update(.loading)
    
    GlobalEnvironment.apiClient.fetchUserProfile {
        let viewModel = UserProfileViewController.ViewModel(
            avatar: UIImage(named: "Wayfair"),
            name: "Wayfair",
            confirmEnabled: false,
            confirmHidden: true
        )
        update(.initial(viewModel))
    }
}

private func fetchUserProfileForEditing(with userID: Int, update: @escaping (UserProfileViewController.State) -> Void) {
    update(.loading)
    
    GlobalEnvironment.apiClient.fetchUserProfile {
        let viewModel = UserProfileViewController.ViewModel(
            avatar: UIImage(named: "Wayfair"),
            name: "Wayfair",
            confirmEnabled: true,
            confirmHidden: false
        )
        update(.initial(viewModel))
    }
}

private func nameDidChangeForEditing(with name: String?, update: @escaping (UserProfileViewController.State) -> Void) {
    guard let unwrappedName = name else {
        update(.confirmEnabled(false))
        return
    }
    
    update(.confirmEnabled(!unwrappedName.isEmpty))
}

private func updateUserProfileForEditing(with update: @escaping (UserProfileViewController.State) -> Void) {
    update(.loading)
    
    GlobalEnvironment.apiClient.updateUserProfile {
        update(.success)
    }
}
