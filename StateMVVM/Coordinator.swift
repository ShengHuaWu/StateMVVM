//
//  Coordinator.swift
//  StateMVVM
//
//  Created by ShengHua Wu on 14.01.19.
//  Copyright © 2019 ShengHua Wu. All rights reserved.
//

import UIKit

protocol CoordinatorInterface: class {
    func finishUpdatingUserProfile()
}

final class Coordinator {
    func start(on window: UIWindow) {
        let vc = UserProfileViewController()
        vc.viewModel = editingUserProfileViewModel(event:update:)
        vc.coordinator = self
        window.rootViewController = vc
        window.makeKeyAndVisible()
    }
}

extension Coordinator: CoordinatorInterface {
    func finishUpdatingUserProfile() {
        print("Go to next screen")
    }
}
