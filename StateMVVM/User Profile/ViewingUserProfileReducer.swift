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
            break // Viewing mode shouldn't change the name
        case .confirmDidPress:
            break // Viewing mode shouldn't update the profile
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
