//
//  UsersViewController.swift
//  RxDemo
//
//  Created by Frederik Jacques on 21/11/2017.
//  Copyright © 2017 the-nerd. All rights reserved.
//

import UIKit

import RxSwift
import RxDataSources

class UsersViewController: UIViewController {

    // MARK: - Properties
    // MARK: Public Properties
    
    // MARK: Private Properties
    private let viewModel = UsersViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: UI Properties
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life-cycle methods
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "Networking"
        
        setupRx()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear( animated )
        
        viewModel.inputs.getUsers()
        
    }
    
    // MARK: - Public methods
    
    // MARK: - Private methods
    private func setupRx() {
        
        viewModel.outputs.dataSource.asObservable()
            .bind( to: tableView.rx.items(cellIdentifier: "UserCell") ) { index, model, cell in
            
                cell.textLabel?.text = "\(model.firstName) \(model.lastName)"
            
            }.disposed(by: disposeBag )
        
        tableView.rx.modelSelected( User.self ).subscribe(onNext: { (user) in
            
            print("Selected \(user.firstName)")
            
        }).disposed( by: disposeBag )
        
    }

}
