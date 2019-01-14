//
//  MockEnvironment.swift
//  StateMVVMTests
//
//  Created by ShengHua Wu on 14.01.19.
//  Copyright © 2019 ShengHua Wu. All rights reserved.
//

@testable import StateMVVM

extension APIClient {
    static let mock = APIClient(
        fetchUserProfile: { _ in },
        updateUserProfile: { _ in }
    )
}

extension Environment {
    static let mock = Environment(apiClient: .mock)
}
