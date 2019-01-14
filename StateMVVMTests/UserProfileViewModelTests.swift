//
//  UserProfileViewModelTests.swift
//  StateMVVMTests
//
//  Created by ShengHua Wu on 14.01.19.
//  Copyright © 2019 ShengHua Wu. All rights reserved.
//

import XCTest
@testable import StateMVVM

class UserProfileViewModelTests: XCTestCase {
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
        viewingUserProfileViewModel(event: .viewDidLoad) { [unowned self] state in
            self.stateHistory.append(state)
        }
        
        XCTAssertEqual(stateHistory, [.initial(avatar: UIImage(named: "Wayfair"), name: "Wayfair", confirmEnabled: false, confirmHidden: true)])
    }
    
    func testThatNameDidChangeForViewing() {
        viewingUserProfileViewModel(event: .nameDidChange(name: "Wayfair")) { [unowned self] state in
            self.stateHistory.append(state)
        }
        
        XCTAssert(stateHistory.isEmpty)
    }
    
    func testThatConfirmDidPressForViewing() {
        viewingUserProfileViewModel(event: .confirmDidPress(name: "Wayfair")) { [unowned self] state in
            self.stateHistory.append(state)
        }
        
        XCTAssert(stateHistory.isEmpty)
    }
    
    func testThatViewDidLoadForEditing() {
        GlobalEnvironment.apiClient.fetchUserProfile = { callback in
            callback()
        }
        
        editingUserProfileViewModel(event: .viewDidLoad) { state in
            self.stateHistory.append(state)
        }
        
        XCTAssertEqual(stateHistory, [.loading, .initial(avatar: UIImage(named: "Wayfair"), name: "Wayfair", confirmEnabled: true, confirmHidden: false)])
    }
    
    func testThatNameDidChangeForEditingWithEmptyName() {
        editingUserProfileViewModel(event: .nameDidChange(name: nil)) { state in
            self.stateHistory.append(state)
        }
        
        XCTAssertEqual(stateHistory, [.confirmEnabled(false)])
    }
    
    func testThatNameDidChangeForEditingWithNonemptyName() {
        editingUserProfileViewModel(event: .nameDidChange(name: "Wayfair")) { state in
            self.stateHistory.append(state)
        }
        
        XCTAssertEqual(stateHistory, [.confirmEnabled(true)])
    }
    
    func testThatConfirmDidPressForEditing() {
        GlobalEnvironment.apiClient.updateUserProfile = { callback in
            callback()
        }
        
        editingUserProfileViewModel(event: .confirmDidPress(name: nil)) { state in
            self.stateHistory.append(state)
        }
        
        XCTAssertEqual(stateHistory, [.loading, .success])
    }
}
