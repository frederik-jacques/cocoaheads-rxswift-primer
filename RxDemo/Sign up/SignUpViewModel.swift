//
//  SignUpViewModel.swift
//  RxDemo
//
//  Created by Frederik Jacques on 21/11/2017.
//  Copyright © 2017 the-nerd. All rights reserved.
//

import Foundation

import RxSwift

protocol SignUpViewModelInputs {
    
    func changed( username:String? )
    func changed( password:String? )
    
}

protocol SignUpViewModelOutputs {
    
    var isSignUpButtonEnabled:Observable<Bool> { get }
    
}

protocol SignUpViewModelType {
    
    var inputs:SignUpViewModelInputs { get }
    var outputs:SignUpViewModelOutputs { get }
    
}

class SignUpViewModel:SignUpViewModelType, SignUpViewModelInputs, SignUpViewModelOutputs{
    
    // MARK: - Properties
    // MARK: Public Properties
    var inputs: SignUpViewModelInputs { return self }
    var outputs: SignUpViewModelOutputs { return self }
    
    var isSignUpButtonEnabled: Observable<Bool>
    
    // MARK: Private Properties
    private var usernameSubject = PublishSubject<String>()
    private var passwordSubject = PublishSubject<String>()
    
    // MARK: - Life-cycle methods
    init() {
        
        let credentialsObservable = Observable.combineLatest( usernameSubject.startWith(""), passwordSubject.startWith("")) { (username, password) -> (username:String, password:String) in
            return (username:username, password:password)
        }.share().debug()
        
        isSignUpButtonEnabled = credentialsObservable.map({ (username, password) -> Bool in
            
            return !username.isEmpty && !password.isEmpty
            
        })
        
        
    }
    
    // MARK: - Public methods
    func changed(username: String?) {
        
        guard let username = username else { return }
        usernameSubject.onNext( username )
        
    }
    
    func changed(password: String?) {
        
        guard let password = password else { return }
        passwordSubject.onNext( password )
        
    }
    
    // MARK: - Private methods
    
}

