//
//  UserProfileReducerTests.swift
//  StateMVVMTests
//
//  Created by ShengHua Wu on 14.01.19.
//  Copyright © 2019 ShengHua Wu. All rights reserved.
//

import XCTest
@testable import StateMVVM

class UserProfileReducerTests: XCTestCase {
    var stateHistory: [UserProfileViewController.State] = []

    override func setUp() {
        super.setUp()
        
        GlobalEnvironment = .mock
    }

    override func tearDown() {
        super.tearDown()
        
        stateHistory = []
    }
    
    func testThatViewDidLoadForViewing() {
        GlobalEnvironment.apiClient.fetchUserProfile = { callback in
            callback()
        }
        
        let reducer = makeViewingUserProfileReducer(with: 0)
        reducer.run(.viewDidLoad) { [unowned self] state in
            self.stateHistory.append(state)
        }
        
        let viewModel = UserProfileViewController.ViewModel(avatar: UIImage(named: "Wayfair"), name: "Wayfair", confirmEnabled: false, confirmHidden: true)
        XCTAssertEqual(stateHistory, [.loading, .initial(viewModel)])
    }
    
    func testThatNameDidChangeForViewing() {
        let reducer = makeViewingUserProfileReducer(with: 0)
        reducer.run(.nameDidChange(name: "Wayfair")) { [unowned self] state in
            self.stateHistory.append(state)
        }
        
        XCTAssert(stateHistory.isEmpty)
    }
    
    func testThatConfirmDidPressForViewing() {
        let reducer = makeViewingUserProfileReducer(with: 0)
        reducer.run(.confirmDidPress(name: "Wayfair")) { [unowned self] state in
            self.stateHistory.append(state)
        }
        
        XCTAssert(stateHistory.isEmpty)
    }
    
    func testThatViewDidLoadForEditing() {
        GlobalEnvironment.apiClient.fetchUserProfile = { callback in
            callback()
        }
        
        let reducer = makeEditingUserProfileReducer(with: 0)
        reducer.run(.viewDidLoad) { state in
            self.stateHistory.append(state)
        }
        
        let viewModel = UserProfileViewController.ViewModel(avatar: UIImage(named: "Wayfair"), name: "Wayfair", confirmEnabled: true, confirmHidden: false)
        XCTAssertEqual(stateHistory, [.loading, .initial(viewModel)])
    }
    
    func testThatNameDidChangeForEditingWithEmptyName() {
        let reducer = makeEditingUserProfileReducer(with: 0)
        reducer.run(.nameDidChange(name: nil)) { state in
            self.stateHistory.append(state)
        }
        
        XCTAssertEqual(stateHistory, [.confirmEnabled(false)])
    }
    
    func testThatNameDidChangeForEditingWithNonemptyName() {
        let reducer = makeEditingUserProfileReducer(with: 0)
        reducer.run(.nameDidChange(name: "Wayfair")) { state in
            self.stateHistory.append(state)
        }
        
        XCTAssertEqual(stateHistory, [.confirmEnabled(true)])
    }
    
    func testThatConfirmDidPressForEditing() {
        GlobalEnvironment.apiClient.updateUserProfile = { callback in
            callback()
        }
        
        let reducer = makeEditingUserProfileReducer(with: 0)
        reducer.run(.confirmDidPress(name: "Wayfair")) { state in
            self.stateHistory.append(state)
        }
        
        XCTAssertEqual(stateHistory, [.loading, .success])
    }
}
