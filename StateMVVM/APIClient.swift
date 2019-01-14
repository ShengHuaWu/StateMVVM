//
//  APIClient.swift
//  StateMVVM
//
//  Created by ShengHua Wu on 14.01.19.
//  Copyright © 2019 ShengHua Wu. All rights reserved.
//

import Foundation

struct APIClient {
    var fetchUserProfile = fetchUserProfile(with:)
    var updateUserProfile = updateUserProfile(with:)
}

private func fetchUserProfile(with completion: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        completion()
    }
}

private func updateUserProfile(with completion: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        completion()
    }
}
