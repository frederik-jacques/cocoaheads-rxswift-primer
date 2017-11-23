//
//  DisposableViewController.swift
//  RxDemo
//
//  Created by Frederik Jacques on 22/11/2017.
//  Copyright © 2017 the-nerd. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DisposableViewController: UIViewController {

    // MARK: - Properties
    // MARK: Public Properties
    
    // MARK: Private Properties
    private var disposeBag = DisposeBag()
    
    // MARK: UI Properties
    @IBOutlet weak var tapButton: UIButton!
    @IBOutlet weak var resultsLabel: UILabel!
    
    private var nameSubject = PublishSubject<String>()
    
    // MARK: - Life-cycle methods
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "Disposables"
        
        setupRx()
        
    }
    
    // MARK: - Public methods
    
    // MARK: - Private methods
    private func setupRx() {
        
        // Everytime the button was tapped
        // add a string on the stream of values
        // of the `nameSubject`
        tapButton.rx.tap.subscribe( onNext:{ [weak self] in
            
            self?.nameSubject.onNext("CocoaHeads")
            
        } ).disposed(by: disposeBag )
        
        // Everytime the nameSubject received a new event (because you tapped the button)
        // Map the received value to a new string and store it in
        // `mapToKingNameObservable` observable
        let mapToKingNameObservable = nameSubject.map { (name) -> String in
            
            return "King \(name)"
            
        }
        
        // Subscribe to the events that the `mapToKingNameObservable` emits        
        mapToKingNameObservable
            .debug()
            .subscribe(onNext: { [weak self] (s) in

                self?.resultsLabel.text = s

            }).disposed(by: disposeBag )
        
        // You could also use the RxCocoa binding
        // To bind the emitted string straight to the UILabel
        /*
        mapToKingNameObservable
            .bind(to: resultsLabel.rx.text )
            .disposed(by: disposeBag )
        */
    }


}
