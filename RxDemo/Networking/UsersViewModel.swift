//
//  UsersViewModel.swift
//  RxDemo
//
//  Created by Frederik Jacques on 21/11/2017.
//  Copyright © 2017 the-nerd. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa
import Moya

protocol UsersViewModelInputs {
    
    func getUsers()
    
}

protocol UsersViewModelOutputs {
 
    var dataSource:Driver<[User]> { get }
    
}

protocol UsersViewModelType {
    
    var inputs:UsersViewModelInputs { get }
    var outputs:UsersViewModelOutputs { get }
    
}

class UsersViewModel:UsersViewModelType, UsersViewModelInputs, UsersViewModelOutputs{
    
    // MARK: - Properties
    // MARK: Public Properties
    var inputs: UsersViewModelInputs { return self }
    var outputs: UsersViewModelOutputs { return self }
    
    let dataSource: Driver<[User]>
    
    // MARK: Private Properties
    private var provider = MoyaProvider<UserApi>()
    private let disposeBag = DisposeBag()
    
    private var usersSubject = BehaviorSubject<[User]>(value: [])
    
    // MARK: - Life-cycle methods
    init() {
        
        // Driver is a Trait from RxCocoa which ensures the following
        // 1. Always on Main Thread
        // 2. Share the subscription with a replay of 1
        // 3. Never errors out
        dataSource = usersSubject.asDriver(onErrorJustReturn: [])
        
    }
    
    // MARK: - Public methods
    func getUsers() {
        
        let jsonDecoder = JSONDecoder()
        
        // 1. Do a network request to get all the users
        // 2. Map them to an array of User objects
        // 3. Add the received users as a new value on the stream
        provider.rx
            .request( .getUsers )
            .map( [User].self, atKeyPath: nil, using: jsonDecoder )
            .subscribe(onSuccess: { [weak self] (users) in
                
                self?.usersSubject.onNext( users )
                
            }) { (error) in
                
                print("Error \(error.localizedDescription)")
                
            }.disposed( by: disposeBag )
        
    }
    
    // MARK: - Private methods
    
}

