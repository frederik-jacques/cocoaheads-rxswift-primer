//
//  AdvancedViewModel.swift
//  RxDemo
//
//  Created by Frederik Jacques on 21/11/2017.
//  Copyright © 2017 the-nerd. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa
import Moya

protocol GitHubViewModelInputs {
    
    func changed( searchQuery:String )
    func getRepositories()
    
}

protocol GitHubViewModelOutputs {
    
    var repositoriesObservable:Driver<[Repository]> { get }
    
}

protocol GitHubViewModelType {
    
    var inputs:GitHubViewModelInputs { get }
    var outputs:GitHubViewModelOutputs { get }
    
}

class GitHubViewModel:GitHubViewModelType, GitHubViewModelInputs, GitHubViewModelOutputs{
    
    // MARK: - Properties
    // MARK: Public Properties
    var inputs: GitHubViewModelInputs { return self }
    var outputs: GitHubViewModelOutputs { return self }
    
    let repositoriesObservable: SharedSequence<DriverSharingStrategy, [Repository]>
    
    // MARK: Private Properties
    private var provider = MoyaProvider<GitHubApi>()
    private let disposeBag = DisposeBag()
    
    private var repositoriesSubject = BehaviorSubject<[Repository]>(value: [])
    
    // MARK: - Life-cycle methods
    init() {
        
        repositoriesObservable = repositoriesSubject.asDriver( onErrorJustReturn: [] )
        
    }
    
    // MARK: - Public methods
    func changed( searchQuery: String ) {
    
        let jsonDecoder = JSONDecoder()
        
        provider.rx
            .request( .search( query: searchQuery ) )
            .debug()
            .observeOn( ConcurrentDispatchQueueScheduler(qos: .background) )
            .map( [Repository].self, atKeyPath: "items", using: jsonDecoder )
            .subscribe(onSuccess: { [weak self] (repositories) in

                self?.repositoriesSubject.onNext( repositories )

            }) { (error) in
                print("Error searching for repos: \(error.localizedDescription)")
            }.disposed( by: disposeBag )
        
    }
    
    func getRepositories() {
        
        let jsonDecoder = JSONDecoder()
        
        provider.rx
            .request(.getRepositories)
            .observeOn( ConcurrentDispatchQueueScheduler(qos: .background) )
            .map( [Repository].self, atKeyPath: nil, using: jsonDecoder )
            .subscribe(onSuccess: { [weak self] (repositories) in
                
                self?.repositoriesSubject.onNext( repositories )
                
            }) { (error) in
                
                print("Error \(error)")
                
            }.disposed( by: disposeBag )
        
    }
    
    // MARK: - Private methods
    
}

