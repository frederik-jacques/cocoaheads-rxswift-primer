//
//  SharingViewController.swift
//  RxDemo
//
//  Created by Frederik Jacques on 22/11/2017.
//  Copyright © 2017 the-nerd. All rights reserved.
//

import UIKit
import RxSwift

class SharingViewController: UIViewController {

    // MARK: - Properties
    // MARK: Public Properties
    
    // MARK: Private Properties
    private let disposeBag = DisposeBag()
    private var observableToShare:Observable<String>!
    
    // MARK: - Life-cycle methods
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "Sharing is caring"
        
        // Remove the .share() call to see what will happen
        observableToShare = Observable.just("Hello world")
            .map({ (s) -> String in
            
                return s + " -> Mapped"
            
            }).share()
        
        observableToShare.subscribe(onNext: { (s) in
            
            print("First observable = \(s)")
            
        }).disposed(by: disposeBag)
        
        observableToShare.subscribe(onNext: { (s) in
            
            print("Second observable = \(s)")
            
        }).disposed(by: disposeBag)
        
        
    }
    
    // MARK: - Public methods
    
    // MARK: - Private methods
    
}
