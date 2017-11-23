//
//  SignUpViewController.swift
//  RxDemo
//
//  Created by Frederik Jacques on 21/11/2017.
//  Copyright © 2017 the-nerd. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class SignUpViewController: UIViewController {

    // MARK: - Properties
    // MARK: Public Properties
    
    // MARK: Private Properties
    private let viewModel = SignUpViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: UI Properties
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    // MARK: - Life-cycle methods
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupRx()
        setupActions()
        
    }
    
    // MARK: - Public methods
    
    // MARK: - Private methods
    private func setupRx() {
        
        viewModel.outputs.isSignUpButtonEnabled
            .debug()
            .bind(to: signupButton.rx.isEnabled )
            .disposed( by: disposeBag )
        
    }
    
    private func setupActions() {
        
        usernameTextField.addTarget( self, action: #selector(usernameValueChanged(textField:)), for: .editingChanged )
        passwordTextField.addTarget( self, action: #selector(passwordValueChanged(textField:)), for: .editingChanged )
        
        // You could also use the rx bindings to achieve the same
        /*
         usernameTextField.rx.value
            .subscribe(onNext:{ [weak self] value in
         
                print("Username textfield changed")
                self?.viewModel.inputs.changed( username: textField.text)
         
            }).disposed(by: disposeBag )
         */
        
    }
    
    @objc func usernameValueChanged( textField:UITextField ) {
    
        viewModel.inputs.changed( username: textField.text)
        
    }
    
    @objc func passwordValueChanged( textField:UITextField ) {
        
        viewModel.inputs.changed( password: textField.text )
        
    }
    
}
