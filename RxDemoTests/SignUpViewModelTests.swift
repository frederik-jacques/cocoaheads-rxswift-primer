//
//  SignUpViewModelTests.swift
//  RxDemoTests
//
//  Created by Frederik Jacques on 22/11/2017.
//  Copyright © 2017 the-nerd. All rights reserved.
//

import XCTest

@testable import RxDemo

import RxSwift
import RxCocoa
import RxTest

class SignUpViewModelTests: XCTestCase {
    
    var scheduler:TestScheduler!
    var disposeBag = DisposeBag()
    
    override func setUp() {
    
        super.setUp()
        
        scheduler = TestScheduler(initialClock: 0)
        
    }
    
    override func tearDown() {
        
        disposeBag = DisposeBag()
        super.tearDown()
        
    }
    
    func testInitialLoginButtonStateIsFalse() {
        
        let viewModel = SignUpViewModel()
        let observer = scheduler.createObserver(Bool.self)
        
        viewModel.outputs.isSignUpButtonEnabled.bind(to: observer).disposed(by: disposeBag )
        
        scheduler.start()
        
        let expectedValues = [
            next(0, false)
        ]
        
        XCTAssertEqual( observer.events, expectedValues)
        
    }
    
    func testLoginButtonStateIsFalseIfOnlyUsernameIsFilledIn() {
        
        let viewModel = SignUpViewModel()
        let observer = scheduler.createObserver(Bool.self)
        
        viewModel.outputs.isSignUpButtonEnabled.bind(to: observer).disposed(by: disposeBag )
        
        scheduler.start()
        
        viewModel.inputs.changed(username: "frederik")
        
        let expectedValues = [
            next(0, false),
            next(0, false)
        ]
        
        XCTAssertEqual( observer.events, expectedValues)
        
    }

    func testLoginButtonStateIsFalseIfOnlyPasswordIsFilledIn() {
        
        let viewModel = SignUpViewModel()
        let observer = scheduler.createObserver(Bool.self)
        
        viewModel.outputs.isSignUpButtonEnabled.bind(to: observer).disposed(by: disposeBag )
        
        scheduler.start()
        
        viewModel.inputs.changed(password: "s0s3cr3t")
        
        let expectedValues = [
            next(0, false),
            next(0, false)
        ]
        
        XCTAssertEqual( observer.events, expectedValues)
        
    }
    
    func testLoginButtonStateIsTrueIfCredentialsAreFilledIn() {
        
        let viewModel = SignUpViewModel()
        let observer = scheduler.createObserver(Bool.self)
        
        viewModel.outputs.isSignUpButtonEnabled.bind(to: observer).disposed(by: disposeBag )
        
        scheduler.start()
        
        viewModel.inputs.changed(username: "frederik")
        viewModel.inputs.changed(password: "s0s3cr3t")
        
        let expectedValues = [
            next(0, false),
            next(0, false),
            next(0, true)
        ]
        
        XCTAssertEqual( observer.events, expectedValues)
        
    }
    
}
