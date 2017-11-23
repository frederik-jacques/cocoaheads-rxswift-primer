//
//  SkipTakeViewController.swift
//  RxDemo
//
//  Created by Frederik Jacques on 22/11/2017.
//  Copyright © 2017 the-nerd. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SkipTakeViewController: UIViewController {

    // MARK: - Properties
    // MARK: Public Properties
    
    // MARK: Private Properties
    private var namesSubject = PublishSubject<String>()
    private let disposeBag = DisposeBag()
    
    // MARK: UI Properties
    @IBOutlet weak var tapButton: UIButton!
    
    // MARK: - Life-cycle methods
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupRx()
        
    }
    
    // MARK: - Public methods
    
    // MARK: - Private methods
    private func setupRx() {
     
        // Everytime the button gets tapped:
        //  1.Use the scan operator to add state
        //    and remember how many times the button was tapped
        //  2.1. Take: take the first 5 elements, and then complete the stream
        //  2.2. Skip: wait until the button was tapped 5 times, then start emitting elements
        tapButton.rx.tap
            .scan(0) { lastValue, _ in
                
                return lastValue + 1
                
            }
            .take(5)
            //.skip(5)
            .subscribe(onNext: { (number) in
                
                print("The number is \(number)")
                
            }).disposed( by: disposeBag )
        
        
    }

}
